import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';

abstract class WhatsappLinkLocalDataSource {
  Future<void> save(String url);
}

const CACHE_LINK_HISTORIC = "CACHE_LINK_HISTORIC";

class WhatsappLinkLocalDataSourceImpl implements WhatsappLinkLocalDataSource {
  final SharedPreferences sharedPreferences;
  WhatsappLinkLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> save(String url) async {
    try {
      final model = LinkHistoricModel(url: url, createdAt: DateTime.now());
      final data = json.encode(model.toJson());
      await sharedPreferences.setString(CACHE_LINK_HISTORIC, data);
    } catch (e) {
      throw CacheException();
    }
  }
}
