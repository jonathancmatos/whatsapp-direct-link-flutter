import 'package:fpdart/fpdart.dart';
import 'package:whatsapp_direct_link/app/core/error/exception.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/core/error/failure.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';

const String URL_BASE_WHATSAPP = "https://wa.me";

class WhatsappLinkRepositoryImpl extends WhatsappLinkRepository {
  final WhatsappLinkLocalDataSource dataSource;
  WhatsappLinkRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> getLinkDirect({required WhatsappLink whatsappLink}) async {
    try {
      final url = "$URL_BASE_WHATSAPP/phone=55${whatsappLink.phone.getValue}&text=${whatsappLink.message.getValue}";
      await dataSource.save(url);
      return Right(url);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<LinkHistoric>>> getHistoric() async {
    try {
      return Right(await dataSource.all()!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

 @override
  Future<Either<Failure, bool>>? remove({required int index}) async{
    try {
      return Right(await dataSource.remove(index)!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>>? removeAll() async {
    try {
      return Right(await dataSource.removeAll()!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}
