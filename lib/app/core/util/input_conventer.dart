import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';

class InputConveter {
  Either<Failure, int> stringPhoneToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      return Right(integer);
    } on FormatException {
      return left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
