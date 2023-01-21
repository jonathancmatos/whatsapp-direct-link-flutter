import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:value_listenable_test/value_listenable_test.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_state.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_store.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

void main() {
  const String url = "https://api.whatsapp.com/send?phone=61969771824&text=test+params";

  late WhatsappLinkStore store;
  late MockGetWhatsappDirectLink mockGetWhatsappDirectLink;
  late WhatsappLink whatsappLink;

  setUp(() {
    mockGetWhatsappDirectLink = MockGetWhatsappDirectLink();
    store = WhatsappLinkStore(getWhatsappDirectLink: mockGetWhatsappDirectLink);
    whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 9.6977-1824",
        message: MessageVO()..setValue = "test params"
    );
  });

  test('initialState should be Initial', () {
    //assert
    expect(store.value, isA<InitialWhatsappLinkState>());
  });

  test('should get data from the user case', () async {
    //arrange
    when(mockGetWhatsappDirectLink(any))
        .thenAnswer((_) async => const Right(url));
    //act
    await store.getUrlGenerate(whatsappLink: whatsappLink);
    //assert
    expect(store.value, isA<SuccessWhatsappLinkState>());
  });

  test('should emit [loading, success] when data is gotten success', () async {
    //arrange
    when(mockGetWhatsappDirectLink(any))
        .thenAnswer((_) async => const Right(url));

    //assert Later
    final expected = [
      isA<LoadingWhatsappLinkState>(),
      isA<SuccessWhatsappLinkState>(),
    ];
    expect(store, emitValues(expected));

    //act
    await store.getUrlGenerate(whatsappLink: whatsappLink);
  });

  test('should emit [loading, error] when cache data fails', () async {
    //arrange
    when(mockGetWhatsappDirectLink(any))
        .thenAnswer((_) async => Left(CacheFailure()));

    //assert Later
    final expected = [
      isA<LoadingWhatsappLinkState>(),
      isA<ErrorWhatsappLinkState>(),
    ];
    expect(store, emitValues(expected));

    //act
    await store.getUrlGenerate(whatsappLink: whatsappLink);
  });
}
