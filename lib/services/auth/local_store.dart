import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_ce/hive.dart';

/// Offline database for user data (profile, lab results, recommendation
/// history and notifications). Each collection stores one JSON document per
/// user, so everything stays available without network.
abstract class LocalStore {
  static const profiles = 'profiles';
  static const labResults = 'lab_results';
  static const recommendations = 'recommendations';
  static const notifications = 'notifications';
  static const transactions = 'transactions';
  static const courses = 'courses';
  static const collections = [
    profiles,
    labResults,
    recommendations,
    notifications,
    transactions,
    courses,
  ];

  /// Decoded JSON document of [owner] in [collection], or null.
  Object? read(String collection, String owner);

  Future<void> write(String collection, String owner, Object? json);

  Future<void> delete(String collection, String owner);
}

class HiveLocalStore implements LocalStore {
  HiveLocalStore._(this._boxes);

  final Map<String, Box<String>> _boxes;

  /// Opens the boxes stored in [directory]. With [inMemory], nothing is
  /// written to disk (used by tests).
  static Future<HiveLocalStore> open({
    String? directory,
    bool inMemory = false,
  }) async {
    if (directory != null) Hive.init(directory);
    return HiveLocalStore._({
      for (final name in LocalStore.collections)
        name: await Hive.openBox<String>(
          name,
          bytes: inMemory ? Uint8List(0) : null,
        ),
    });
  }

  @override
  Object? read(String collection, String owner) {
    final raw = _boxes[collection]!.get(owner);
    return raw == null ? null : jsonDecode(raw);
  }

  @override
  Future<void> write(String collection, String owner, Object? json) =>
      _boxes[collection]!.put(owner, jsonEncode(json));

  @override
  Future<void> delete(String collection, String owner) =>
      _boxes[collection]!.delete(owner);

  Future<void> close() async {
    for (final box in _boxes.values) {
      await box.close();
    }
  }
}

class MemoryLocalStore implements LocalStore {
  final _data = <String, String>{};

  @override
  Object? read(String collection, String owner) {
    final raw = _data['$collection/$owner'];
    return raw == null ? null : jsonDecode(raw);
  }

  @override
  Future<void> write(String collection, String owner, Object? json) async =>
      _data['$collection/$owner'] = jsonEncode(json);

  @override
  Future<void> delete(String collection, String owner) async =>
      _data.remove('$collection/$owner');
}
