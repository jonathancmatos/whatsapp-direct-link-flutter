import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

class GetHistoricWhatsAppLink extends UserCase<List<LinkHistoric>, NoParams> {
  final WhatsappLinkRepository repository;
  GetHistoricWhatsAppLink(this.repository);
  
  @override
  Future<Either<Failure, List<LinkHistoric>>?> call(NoParams params) async{
    return await repository.getHistoric();
  }


}
