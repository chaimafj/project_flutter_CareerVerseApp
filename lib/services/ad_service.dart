import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob integration using Google's official **test** ad units only.
/// Ads are disabled on unsupported platforms (web, desktop, unit tests).
class AdService {
  AdService({bool? enabled}) : enabled = enabled ?? _isMobile;

  static bool get _isMobile =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  final bool enabled;
  InterstitialAd? _interstitial;
  bool _initialized = false;

  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  static String get bannerUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9214589741'
      : 'ca-app-pub-3940256099942544/2435281174';

  static String get interstitialUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  Future<void> initialize() async {
    if (!enabled || _initialized) return;
    _initialized = true;
    try {
      await MobileAds.instance.initialize();
      _loadInterstitial();
    } catch (error) {
      debugPrint('AdMob initialization failed: $error');
    }
  }

  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial failed to load: $error');
          _interstitial = null;
        },
      ),
    );
  }

  /// Shows the interstitial if one is ready, then calls [onDone] once it is
  /// closed. [onDone] is called immediately when no ad is available.
  void showInterstitial({required VoidCallback onDone}) {
    final ad = _interstitial;
    if (!enabled || ad == null) {
      onDone();
      return;
    }
    _interstitial = null;
    var done = false;
    void finish() {
      if (done) return;
      done = true;
      onDone();
      _loadInterstitial();
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        finish();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        finish();
      },
    );
    ad.show();
  }

  BannerAd createBanner({
    required AdSize size,
    required VoidCallback onLoaded,
  }) => BannerAd(
    adUnitId: bannerUnitId,
    size: size,
    request: const AdRequest(),
    listener: BannerAdListener(
      onAdLoaded: (_) => onLoaded(),
      onAdFailedToLoad: (ad, error) {
        debugPrint('Banner failed to load: $error');
        ad.dispose();
      },
    ),
  );
}
