import 'package:fpdart/fpdart.dart';

abstract class Entity {

  Either<String, Entity> validate();

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
    return other is Entity;
  }
  
  @override
  int get hashCode => super.hashCode;
  
}
