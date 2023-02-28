import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';

void main() {
  late PhoneVO phoneVO;

  setUp(() {
    phoneVO = PhoneVO();
  });

  test('shout return me a phone number without special characters', () {
    //arrange
    const str = '(61) 9.6977-1824';
    //act
    phoneVO.setValue = str;
    //assert
    expect(phoneVO.getValue, equals("61969771824"));
  });

  test('should return null if my phone number is valid.', () {
    //arrange
    const str = '(61) 9.6977-1824';
    //act
    phoneVO.setValue = str;
    //assert
    expect(phoneVO.validate(),equals(isA<Right>()));
  });

  test('should return me a string if my phone is not valid.', () {
    //arrange
    const str = '(61) 6977-1824';
    //act
    phoneVO.setValue = str;
    //assert
    expect(phoneVO.validate(), equals(isA<Left>()));
  });
}
