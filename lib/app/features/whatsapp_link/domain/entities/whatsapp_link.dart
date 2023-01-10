import 'package:equatable/equatable.dart';

class WhatsappLink extends Equatable {

  final String phone;
  final String message;

  const WhatsappLink({required this.phone, required this.message});

  @override
  // TODO: implement props
  List<Object?> get props =>[phone, message];
}
