import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:careerverseapp/widgets/career_ui.dart';

void main() {
  testWidgets('Render the Sign Up CareerLogo as launcher artwork', (
    tester,
  ) async {
    final fonts = Platform.environment['CAREERVERSE_ICON_FONTS'];
    if (fonts == null) {
      throw StateError(
        'Run tool\\generate_app_icon.ps1 to supply Flutter fonts.',
      );
    }
    await tester.runAsync(() async {
      final loader = FontLoader('Roboto');
      for (final name in [
        'roboto-regular.ttf',
        'roboto-bold.ttf',
        'roboto-black.ttf',
      ]) {
        loader.addFont(
          Future.value(
            ByteData.sublistView(
              File('$fonts${Platform.pathSeparator}$name').readAsBytesSync(),
            ),
          ),
        );
      }
      await loader.load();
      final icons = FontLoader('MaterialIcons');
      icons.addFont(
        Future.value(
          ByteData.sublistView(
            File('$fonts${Platform.pathSeparator}materialicons-regular.otf')
                .readAsBytesSync(),
          ),
        ),
      );
      await icons.load();
    });
    debugPrint('Logo fonts loaded.');
    tester.view.reset();
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1024, 1024);
    addTearDown(tester.view.reset);
    final directory = Directory('assets${Platform.pathSeparator}branding');
    directory.createSync(recursive: true);
    for (final entry in {
      'careerverse_icon.png': Colors.white,
      'careerverse_foreground.png': Colors.transparent,
    }.entries) {
      final key = GlobalKey();
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: RepaintBoundary(
            key: key,
            child: ColoredBox(
              color: entry.value,
              child: Center(
                child: SizedBox(
                  width: 600,
                  height: 600,
                  child: const FittedBox(
                    child: CareerLogo(fontFamily: 'Roboto'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      debugPrint('Logo widget painted: ${entry.key}.');
      expect(find.byType(CareerLogo), findsOneWidget);
      expect(tester.takeException(), isNull);
      final boundary =
          key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        debugPrint('Logo image captured: ${entry.key}.');
        try {
          expect(image.width, 1024);
          expect(image.height, 1024);
          final data = await image.toByteData(format: ui.ImageByteFormat.png);
          if (data == null) {
            throw StateError('PNG encoding failed for ${entry.key}.');
          }
          await File('${directory.path}${Platform.pathSeparator}${entry.key}')
              .writeAsBytes(data.buffer.asUint8List());
        } finally {
          image.dispose();
        }
      });
    }
  });
}
