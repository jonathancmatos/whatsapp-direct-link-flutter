import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  const String url = "https://api.whatsapp.com/send?phone=61969771824&text=test+params";
  late WhatsappLinkLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = WhatsappLinkLocalDataSourceImpl(mockSharedPreferences);
  });

  group("cacheWhatsappLink", () {
    final model = LinkHistoricModel(url: url, createdAt: DateTime.now());
    final jsonConverted = json.encode(model.toJson());

    test("should call SharedPreferences to cache the data", () async {
      //arrange
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, jsonConverted))
          .thenAnswer((_) async => true);
      //act
      await dataSource.save(url);
      //assert
      verify(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, jsonConverted));
    });
  });
}
