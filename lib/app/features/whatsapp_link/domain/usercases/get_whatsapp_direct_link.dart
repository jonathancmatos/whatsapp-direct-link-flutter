import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

class GetWhatsappDirectLink extends UserCase<String, WhatsappLink> {
  final WhatsappLinkRepository repository;
  GetWhatsappDirectLink(this.repository);

  @override
  Future<Either<Failure, String>> call(WhatsappLink params) async {
    return await repository.getLinkDirect(whatsappLink: params);
  }
}
