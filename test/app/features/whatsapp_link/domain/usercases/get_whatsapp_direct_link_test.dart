import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_whatsapp_direct_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import '../../../../../helpers/test_helpers.mocks.dart';

const String URL_BASE_WHATSAPP = "https://wa.me";

void main() {
  late GetWhatsappDirectLink usercase;
  late MockWhatsappLinkRepository repository;
  late WhatsappLink whatsappLink;

  setUp(() {
    repository = MockWhatsappLinkRepository();
    usercase = GetWhatsappDirectLink(repository);
    whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 9.6977-1824",
        message: MessageVO()..setValue = "test params");
  });

  test('should return a string straight from the repository.', () async {
    //arrange
    final url = "$URL_BASE_WHATSAPP/phone=55${whatsappLink.phone.getValue}&text=${whatsappLink.message.getValue}";
    when(repository.getLinkDirect(whatsappLink: whatsappLink))
        .thenAnswer((_) async => Right(url));
    //act
    var result = await usercase(whatsappLink);
    //assert
    expect(result, equals(isA<Right>()));
    verify(repository.getLinkDirect(whatsappLink: whatsappLink));
    verifyNoMoreInteractions(repository);
  });
}
