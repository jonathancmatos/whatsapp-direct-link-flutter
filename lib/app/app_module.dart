import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/datasources/whatsapp_link_local_datasource.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/data/repositories/whatsapp_link_repository_impl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_whatsapp_direct_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/guards/whatsapp_link_guard.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/result_url/result_url_page.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/whatsapp_link/whatsapp_link_page.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_store.dart';

class AppModule extends Module{
  
  @override
  List<Bind> get binds => [
    Bind((i) => WhatsappLinkStore(i())),
    Bind((i) => GetWhatsappDirectLink(i())),
    Bind((i) => WhatsappLinkRepositoryImpl(i())),
    Bind((i) => WhatsappLinkLocalDataSourceImpl(i())),
    AsyncBind<SharedPreferences>((i) => SharedPreferences.getInstance())
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const WhatsappLinkPage(), guards: [WhatsappLinkGuard()]),
    ChildRoute('/result/', child: (context, args) => ResultUrlPage(url: args.data))
  ];

}

