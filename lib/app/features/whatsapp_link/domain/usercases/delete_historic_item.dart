import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

class DeleteHistoricItem extends UserCase<bool, int> {
  final WhatsappLinkRepository repository;
  DeleteHistoricItem(this.repository);

  @override
  Future<Either<Failure, bool?>?> call(int params) async {
    return await repository.remove(index: params);
  }
}
