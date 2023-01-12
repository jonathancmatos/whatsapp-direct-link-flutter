import 'package:fpdart/fpdart.dart';

abstract class ValueObject<T> {
  late T _value;

  set setValue(T value) => _value = value;

  String get getValue => _value.toString();

  Either<ValueObject<T>, String> validate();

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other._value == _value;
  }

  @override
  String toString() {
    return "$runtimeType: $_value";
  }
}
