import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import '../../../../../helpers/test_helpers.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const String url = "https://wa.me/phone=61969771824&text=test+params";
  late WhatsappLinkLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = WhatsappLinkLocalDataSourceImpl(mockSharedPreferences);
  });

  group("cacheWhatsappLink", () {
    final model = LinkHistoricModel(url: url, createdAt: DateTime.now());
    final jsonConverted = json.encode([model.toJson()]);
    final storage = fixture("whatsapp_link.json");

    test(
        "should return success even if no data was registered in SharedPreferences",
        () async {
      //arrange
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => "");
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, jsonConverted))
          .thenAnswer((_) async => true);
      //act
      await dataSource.save(url);
      //assert
      verify(
          mockSharedPreferences.setString(CACHE_LINK_HISTORIC, jsonConverted));
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
    });

    test("should return success when registering new data", () async {
      //arrange
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenReturn(storage);
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any))
          .thenAnswer((_) async => true);
      //act
      await dataSource.save(url);
      //assert
      verify(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any));
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
    });

    test("should return failure when registering new data", () async {
      //arrange
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenReturn(storage);
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any))
          .thenThrow(CacheException());
      //act
      function() async => await dataSource.save(url);
      //assert
      expect(function, throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('allWhatsAppLink', () {
    test('should return an empty list when no key exists', () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => false);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => "");
      //act
      final result = await dataSource.all();
      //assert
      verify(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC));
      expect(result, equals([]));
    });

    test('should return a history list when a key exists', () async {
      //arrange
      final response = (json.decode(fixture("whatsapp_link.json")) as List)
          .map((v) => LinkHistoricModel.fromJson(v))
          .toList();

      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => fixture("whatsapp_link.json"));
      //act
      final result = await dataSource.all();
      //assert
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
      expect(result, equals(response));
    });

    test('should return a failure when trying to list the data', () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenThrow(CacheException());
      //act
      function() async => await dataSource.all();
      //assert
      expect(function, throwsA(isInstanceOf<CacheException>()));
    });
  });
}
