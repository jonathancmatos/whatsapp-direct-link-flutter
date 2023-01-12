import 'package:fpdart/fpdart.dart';
import '../../../../core/interfaces/value_object.dart';

class MessageVO extends ValueObject<String?> {

  @override
  String get getValue => super.getValue;

  @override
  set setValue(String? value) => super.setValue = value?.replaceAll(' ', '+');

  @override
  Either<MessageVO, String> validate() => Left(this);
}
