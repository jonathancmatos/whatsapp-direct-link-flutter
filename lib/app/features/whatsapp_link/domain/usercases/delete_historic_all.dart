import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

class DeleteHistoricAll implements UserCase<bool, NoParams> {
  final WhatsappLinkRepository repository;
  DeleteHistoricAll(this.repository);

  @override
  Future<Either<Failure, bool?>?> call(NoParams params) async {
    return await repository.removeAll();
  }
}
