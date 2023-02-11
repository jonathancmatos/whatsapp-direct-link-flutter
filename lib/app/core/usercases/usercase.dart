import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Failure, Type?>?> call(Params params);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}