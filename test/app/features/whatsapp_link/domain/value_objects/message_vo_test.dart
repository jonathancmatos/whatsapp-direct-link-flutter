import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';

void main() {
  late MessageVO messageVO;

  setUp(() {
    messageVO = MessageVO();
  });

  test('should return a formatted string to pass by url', () {
     //arrange
    const str = 'Isso é um texto com espaço';
    //act
    messageVO.setValue = str;
    //assert
    expect(messageVO.getValue, equals("Isso+é+um+texto+com+espaço"));
  });

  test('should return null in validation even if the value is empty or null', () {
      //arrange
      const str = "Teste";
      //act
      messageVO.setValue = str;
      //assert
      expect(messageVO.validate(), equals(isA<Left>()));
  });

}
