import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
