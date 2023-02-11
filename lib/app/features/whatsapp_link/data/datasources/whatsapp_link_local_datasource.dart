import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';

abstract class WhatsappLinkLocalDataSource {
  Future<void> save(String url);
  Future<List<LinkHistoricModel>>? all();
}

const CACHE_LINK_HISTORIC = "CACHE_LINK_HISTORIC";

class WhatsappLinkLocalDataSourceImpl implements WhatsappLinkLocalDataSource {
  final SharedPreferences sharedPreferences;
  WhatsappLinkLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> save(String url) async {
    try {
      final model = LinkHistoricModel(url: url, createdAt: DateTime.now());
      final values = sharedPreferences.getString(CACHE_LINK_HISTORIC);
      List<LinkHistoricModel> historicList = [];

      if (values == null || values.isEmpty) {
        historicList.add(model);
        await sharedPreferences.setString(
            CACHE_LINK_HISTORIC, json.encode(historicList));
      } else {
        historicList = (json.decode(values) as List)
            .map((v) => LinkHistoricModel.fromJson(v))
            .toList()
          ..add(model);
        await sharedPreferences.setString(
            CACHE_LINK_HISTORIC, json.encode(historicList));
      }
    } catch (e) {
      print(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<List<LinkHistoricModel>> all() async {
    try {
      if (sharedPreferences.containsKey(CACHE_LINK_HISTORIC)) {
        final data = sharedPreferences.getString(CACHE_LINK_HISTORIC);
        final result = (json.decode(data!) as List);
        return result.map((e) => LinkHistoricModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }
}
