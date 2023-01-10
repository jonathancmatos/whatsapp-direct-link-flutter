import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/util/input_conventer.dart';

void main() {
  late InputConveter inputConveter;

  setUp(() {
    inputConveter = InputConveter();
  });

  group('stringPhoneToUnsignedInteger', () {
    test('should return an intire phone number without special characters', () {
      //arrange
      const str = "61969771824";
      //act
      final result = inputConveter.stringPhoneToUnsignedInteger(str);
      //assert
      expect(result, const Right(61969771824));
    });

    test(
        'should return a failuire if the string contains characters other than numbers',
        () {
      //arrange
      const str = '(61) 9.6977-1824';
      //act
      final result = inputConveter.stringPhoneToUnsignedInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
