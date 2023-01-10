import 'package:fpdart/fpdart.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Exception, Type?>?> call(Params params);
}
