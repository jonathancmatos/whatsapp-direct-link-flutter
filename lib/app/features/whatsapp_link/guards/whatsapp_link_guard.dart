import 'package:flutter_modular/flutter_modular.dart';
import '../../../app_module.dart';

class WhatsappLinkGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    await Modular.isModuleReady<AppModule>();
    return true;
  }
}