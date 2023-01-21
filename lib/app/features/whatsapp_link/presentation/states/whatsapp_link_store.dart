import 'package:flutter/cupertino.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_whatsapp_direct_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_state.dart';

class WhatsappLinkStore extends ValueNotifier<WhatsappLinkState> {
  final GetWhatsappDirectLink getWhatsappDirectLink;
  WhatsappLinkStore({required this.getWhatsappDirectLink})
      : super(InitialWhatsappLinkState());


  Future<void> getUrlGenerate({required WhatsappLink whatsappLink}) async {
    value = LoadingWhatsappLinkState();
    final failureOrUrl = await getWhatsappDirectLink(whatsappLink);
    failureOrUrl.fold(
      (f) => value = ErrorWhatsappLinkState("Não foi possivel guardar os dados localmente."), 
      (s) => value = SuccessWhatsappLinkState(s)
    );
  }
}
