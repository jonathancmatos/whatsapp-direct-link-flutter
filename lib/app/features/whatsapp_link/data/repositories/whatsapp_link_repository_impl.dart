import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

const String URL_BASE_WHATSAPP = "https://api.whatsapp.com/send";

class WhatsappLinkRepositoryImpl extends WhatsappLinkRepository {
  final WhatsappLinkLocalDataSource dataSource;
  WhatsappLinkRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> getLinkDirect({required WhatsappLink whatsappLink}) async {
    try {
      final url = "$URL_BASE_WHATSAPP?phone=${whatsappLink.phone.getValue}&text=${whatsappLink.message.getValue}";
      await dataSource.save(link: url);
      return Right(url);
    } on CacheException {
      return left(CacheFailure());
    }
  }
}
