import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/repositories/whatsapp_link_repository.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_whatsapp_direct_link.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
 WhatsappLinkLocalDataSource,
 WhatsappLinkRepository,
 GetWhatsappDirectLink
])

void  main() {}