import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/repositories/whatsapp_link_repository_impl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  const String url = "https://api.whatsapp.com/send?phone=61969771824&text=test+params";
  late MockWhatsappLinkLocalDataSource mockLocalDataSource;
  late WhatsappLinkRepositoryImpl repositoryImpl;
  late WhatsappLink whatsappLink;

  setUp(() {
    whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 9.6977-1824",
        message: MessageVO()..setValue = "test params");
    mockLocalDataSource = MockWhatsappLinkLocalDataSource();
    repositoryImpl = WhatsappLinkRepositoryImpl(mockLocalDataSource);
  });

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
    final result = await repositoryImpl.getLinkDirect(whatsappLink: whatsappLink);
    //assert
    verify(mockLocalDataSource.save(url));
    expect(result, Left(CacheFailure()));
  });
}
