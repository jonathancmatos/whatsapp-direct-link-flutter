import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';

abstract class WhatsappLinkLocalDataSource {
  Future<void> save(String url);
  Future<List<LinkHistoricModel>>? all();
  Future<bool>? remove(int index);
  Future<bool>? removeAll();
}

const CACHE_LINK_HISTORIC = "CACHE_LINK_HISTORIC";

class WhatsappLinkLocalDataSourceImpl implements WhatsappLinkLocalDataSource {
  final SharedPreferences sharedPreferences;
  WhatsappLinkLocalDataSourceImpl(this.sharedPreferences);

  List<LinkHistoricModel> getHistorics() {
    final values = sharedPreferences.getString(CACHE_LINK_HISTORIC);
    if (values == null || values.isEmpty) return [];

    return (json.decode(values) as List)
        .map((v) => LinkHistoricModel.fromJson(v))
        .toList();
  }

  @override
  Future<void> save(String url) async {
    try {
      final model = LinkHistoricModel(url: url, createdAt: DateTime.now());
      final historics = getHistorics();

      historics.add(model);
      await sharedPreferences.setString(CACHE_LINK_HISTORIC, json.encode(historics));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<LinkHistoricModel>> all() async {
    try {
      if (sharedPreferences.containsKey(CACHE_LINK_HISTORIC)) {
        return getHistorics();
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool>? remove(int index) async {
    try {
      if (!sharedPreferences.containsKey(CACHE_LINK_HISTORIC)) {
        throw CacheException();
      }
      
      final data = getHistorics();
      data.removeAt(index);

      return await sharedPreferences.setString(CACHE_LINK_HISTORIC, json.encode(data));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool>? removeAll() async {
    try {
      if (!sharedPreferences.containsKey(CACHE_LINK_HISTORIC)) {
        return false;
      }
      return await sharedPreferences.remove(CACHE_LINK_HISTORIC);
    } catch (e) {
      throw CacheException();
    }
  }
}
