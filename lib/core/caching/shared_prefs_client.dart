import 'package:lo2tah/core/caching/caching_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClient implements CachingClient {
  final SharedPreferences? client;

  SharedPreferenceClient({required this.client});

  @override
  Future<bool> set({required String key, required value}) async {
    if (value is String) {
      return await client!.setString(key, value);
    } else if (value is int) {
      return await client!.setInt(key, value);
    } else if (value is double) {
      return await client!.setDouble(key, value);
    } else if (value is bool) {
      return await client!.setBool(key, value);
    } else if (value is List<String>) {
      return await client!.setStringList(key, value);
    } else {
      return await client!.setString(key, value.toString());
    }
  }

  @override
  get({required String key}) {
    return client!.get(key);
  }

  @override
  Future<bool> remove({required String key}) async {
    return await client!.remove(key);
  }

  @override
  void clear() {
    client!.clear();
  }
}
