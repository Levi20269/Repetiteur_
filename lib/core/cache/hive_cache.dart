import 'package:hive_flutter/hive_flutter.dart';

abstract interface class JsonCache {
  Future<List<Map<String, dynamic>>?> readList(String key);
  Future<void> writeList(String key, List<Map<String, dynamic>> value);
}

class HiveJsonCache implements JsonCache {
  HiveJsonCache(this._box);

  final Box<dynamic> _box;

  static Future<HiveJsonCache> initialize() async {
    await Hive.initFlutter();
    final box = await Hive.openBox<dynamic>('mon_repetiteur_cache');
    return HiveJsonCache(box);
  }

  @override
  Future<List<Map<String, dynamic>>?> readList(String key) async {
    final value = _box.get(key);
    if (value is! List) return null;
    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  @override
  Future<void> writeList(String key, List<Map<String, dynamic>> value) =>
      _box.put(key, value);
}

/// Solution de repli : permet à l'interface de démarrer même si le stockage
/// natif n'est pas encore disponible (par exemple durant une première config Web).
class MemoryJsonCache implements JsonCache {
  final Map<String, List<Map<String, dynamic>>> _values = {};

  @override
  Future<List<Map<String, dynamic>>?> readList(String key) async =>
      _values[key];

  @override
  Future<void> writeList(String key, List<Map<String, dynamic>> value) async {
    _values[key] = value;
  }
}
