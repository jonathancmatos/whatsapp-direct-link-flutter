import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/interfaces/value_object.dart';

class PhoneVO extends ValueObject<String> {

  @override
  String get getValue => super.getValue;

  @override
  set setValue(String value) => super.setValue = value.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  Either<String, PhoneVO> validate() {
    if (super.getValue.isEmpty) {
      return const Left('Por favor, informe o número de telefone.');
    } else if (super.getValue.length != 11) {
      return const Left('Por favor, informe o número de telefone válido.');
    }
    return Right(this);
  }
}
