import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/models/link_historic_model.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/repositories/whatsapp_link_repository_impl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import '../../../../../helpers/test_helpers.mocks.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  late MockWhatsappLinkLocalDataSource mockLocalDataSource;
  late WhatsappLinkRepositoryImpl repositoryImpl;
  List<LinkHistoricModel> historics = [];

  setUp(() {
    mockLocalDataSource = MockWhatsappLinkLocalDataSource();
    repositoryImpl = WhatsappLinkRepositoryImpl(mockLocalDataSource);
  });

  void convertedJsonToListModel() {
    final data = json.decode(fixture("whatsapp_link.json"));
    historics =
        (data as List).map((v) => LinkHistoricModel.fromJson(v)).toList();
  }

  group('saveWhatsAppLink', () {
    const String url = "https://wa.me/phone=5561969771824&text=test+params";
    final whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 9.6977-1824",
        message: MessageVO()..setValue = "test params");

    test('should return a string containing the url and its parameters',
        () async {
      //act
      final result =
          await repositoryImpl.getLinkDirect(whatsappLink: whatsappLink);
      //assert
      expect(result, equals(isA<Right>()));
      expect(result, equals(const Right(url)));
    });

    test('should store data locally when formed url is successful', () async {
      //arrange
      when(mockLocalDataSource.save(any)).thenAnswer((_) async => true);
      //act
      await repositoryImpl.getLinkDirect(whatsappLink: whatsappLink);
      //assert
      verify(mockLocalDataSource.save(url));
    });

    test('should return failure if the local data store fails.', () async {
      //arrange
      when(mockLocalDataSource.save(any)).thenThrow(CacheException());
      //act
      final result =
          await repositoryImpl.getLinkDirect(whatsappLink: whatsappLink);
      //assert
      verify(mockLocalDataSource.save(url));
      expect(result, Left(CacheFailure()));
    });
  });

  group('allWhatsAppLink', () {
    test('should return a whatsApp link list', () async {
      //arrange
      convertedJsonToListModel();
      when(mockLocalDataSource.all()).thenAnswer((_) async => historics);
      //act
      final result = await repositoryImpl.getHistoric();
      //assert
      verify(mockLocalDataSource.all());
      expect(result, equals(isA<Right>()));
      expect(result, equals(Right(historics)));
    });

    test('should return a failure when returning list of whatsApp Link',
        () async {
      //arrange
      when(mockLocalDataSource.all()).thenThrow(CacheException());
      //act
      final result = await repositoryImpl.getHistoric();
      //assert
      verify(mockLocalDataSource.all());
      expect(result, left(CacheFailure()));
    });
  });

  group('deleteItemAppLink', () {
    const index = 1;

    test('should return true when removeing the item list', () async {
      //arrange
      when(mockLocalDataSource.remove(index)).thenAnswer((_) async => true);
      //act
      final result = await repositoryImpl.remove(index: index);
      //assert
      verify(mockLocalDataSource.remove(index));
      expect(result, equals(const Right(true)));
    });

    test('should return failure when removeing the item list', () async {
      //arrange
      when(mockLocalDataSource.remove(index)).thenThrow(CacheException());
      //act
      final result = await repositoryImpl.remove(index: index);
      //assert
      verify(mockLocalDataSource.remove(index));
      expect(result, left(CacheFailure()));
    });
  });

  group('deleteAllAppLink', () {
    test('should return true when removing the whole list', () async {
      //arrange
      when(mockLocalDataSource.removeAll())
          .thenAnswer((_) async => await Future.value(true));
      //act
      final result = await repositoryImpl.removeAll();
      //assert
      verify(mockLocalDataSource.removeAll());
      expect(result, equals(const Right(true)));
    });

    test('should return a failure when trying to remove the entire list',
        () async {
      //arrange
      when(mockLocalDataSource.removeAll()).thenThrow(CacheException());
      //act
      final result = await repositoryImpl.removeAll();
      //assert
      verify(mockLocalDataSource.removeAll());
      expect(result, left(CacheFailure()));
    });
  });
}
