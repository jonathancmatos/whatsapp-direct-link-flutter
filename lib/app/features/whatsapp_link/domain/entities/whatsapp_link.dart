import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/interfaces/entity.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';

class WhatsappLink extends Equatable with Entity {
  final PhoneVO phone;
  final MessageVO message;

  WhatsappLink({required this.phone, required this.message});

  @override
  List<Object?> get props => [phone, message];

  @override
  Either<WhatsappLink, String> validate() {
    if (phone.validate().isRight() || message.validate().isRight()) {
      return const Right("Por favor, informe os dados obrigatórios.");
    } else {
      return Left(this);
    }
  }
}
