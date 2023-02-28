import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import '../../../../../helpers/test_helpers.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late WhatsappLinkLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  List<LinkHistoricModel> historics = [];

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = WhatsappLinkLocalDataSourceImpl(mockSharedPreferences);
  });

  String strJsonConverted() => fixture("whatsapp_link.json");

  void convertedJsonToListModel() {
    final data = json.decode(strJsonConverted());
    historics =
        (data as List).map((v) => LinkHistoricModel.fromJson(v)).toList();
  }

  group("cacheWhatsappLink", () {
    const String url = "https://wa.me/phone=61969771824&text=test+params";
    final json = strJsonConverted();

    test(
        "should return success even if no data was registered in SharedPreferences",
        () async {
      //arrange
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC)).thenReturn("");
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any))
          .thenAnswer((_) async => true);
      //act
      await dataSource.save(url);
      //assert
      verify(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any));
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
    });

    test("should return success when registering new data", () async {
      //arrange
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenReturn(json);
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
          .thenReturn(json);
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
      convertedJsonToListModel();
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => strJsonConverted());
      //act
      final result = await dataSource.all();
      //assert
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
      expect(result, equals(historics));
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

  group('deleteItemWhatsAppLink', () {
    const index = 1;

    test(
        'should return true if the key exists and the removal item is successfull',
        () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => strJsonConverted());
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any))
          .thenAnswer((_) async => true);
      //act
      final result = await dataSource.remove(index);
      //assert
      verify(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC));
      verify(mockSharedPreferences.getString(CACHE_LINK_HISTORIC));
      verify(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any));
      expect(result, equals(true));
    });

    test('should return failure if key does not exist.', () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenThrow((_) => CacheException());
      //act
      function() async => await dataSource.remove(index);
      //assert
      expect(function, throwsA(isInstanceOf<CacheException>()));
    });

    test(
        'should return a failure if there was an error removing a specific item',
        () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.getString(CACHE_LINK_HISTORIC))
          .thenReturn(strJsonConverted());
      when(mockSharedPreferences.setString(CACHE_LINK_HISTORIC, any))
          .thenThrow(CacheException());
      //act
      function() async => await dataSource.remove(index);
      //assert
      expect(function, throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('deleteAllWhatsAppLink', () {
    test('should return true if the key exists and the removal is successful.',
        () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => true);
      when(mockSharedPreferences.remove(CACHE_LINK_HISTORIC))
          .thenAnswer((_) async => true);
      //act
      final result = await dataSource.removeAll();
      //assert
      verify(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC));
      verify(mockSharedPreferences.remove(CACHE_LINK_HISTORIC));
      expect(result, equals(true));
    });

    test('should return false if key does not exist.', () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenAnswer((_) => false);
      //act
      final result = await dataSource.removeAll();
      //assert
      verify(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC));
      expect(result, equals(false));
    });

    test('should return a failure if there was an error removing everything',
        () async {
      //arrange
      when(mockSharedPreferences.containsKey(CACHE_LINK_HISTORIC))
          .thenThrow((_) => CacheException());
      //act
      function() async => await dataSource.removeAll();
      //assert
      expect(function, throwsA(isInstanceOf<CacheException>()));
    });
  });
}
