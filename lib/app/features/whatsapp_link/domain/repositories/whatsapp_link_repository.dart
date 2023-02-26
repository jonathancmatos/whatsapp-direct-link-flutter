import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';

abstract class WhatsappLinkRepository {
  Future<Either<Failure, String>>? getLinkDirect(
      {required WhatsappLink whatsappLink});
  Future<Either<Failure, List<LinkHistoric>>>? getHistoric();
  Future<Either<Failure, bool>>? remove({required int index});
  Future<Either<Failure, bool>>? removeAll();
}
