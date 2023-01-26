import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';

void main() {
  late WhatsappLink whatsappLink;

  test("should return success on entity validation", () {
    //arrange
    whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 9.6977-1824", 
        message: MessageVO()..setValue = ""
    );
    //act
    final result = whatsappLink.validate();
    //assert
    expect(result, equals(isA<Right>()));
  });

  test("should return failure on entity validation", () {
    //arrange
    whatsappLink = WhatsappLink(
        phone: PhoneVO()..setValue = "(61) 6977-1824", 
        message: MessageVO()..setValue = "test params"
    );
    //act
    final result = whatsappLink.validate();
    //assert
    expect(result, equals(isA<Left>()));
  });
}
