import 'package:flutter/cupertino.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_all.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_item.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_historic_whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_state.dart';
import 'package:whatsapp_direct_link/app/shared/confirmations/confirmation_dialog.dart';
import 'package:whatsapp_direct_link/main.dart';

class HistoricStore extends ValueNotifier<HistoricState> {
  final ConfirmationDialog confirmationDialog;
  final GetHistoricWhatsAppLink getHistoricWhatsAppLink;
  final DeleteHistoricAll deleteHistoricAll;
  final DeleteHistoricItem deleteHistoricItem;

  HistoricStore(
      {required this.confirmationDialog,
      required this.getHistoricWhatsAppLink,
      required this.deleteHistoricAll,
      required this.deleteHistoricItem
  }) : super(InitialHistoricState());

  Future<void> getHistoric() async {
    value = LoadingHistoricState();
    final failureOrHistoric = await getHistoricWhatsAppLink(NoParams());
    failureOrHistoric?.fold(
        (failure) =>
            value = ErrorHistoricState("Não foi possível listar o histórico."),
        (success) => value = SuccessHistoricState(success));
  }

  Future<void> removeAll() async {
    final shouldDelete = await confirmationDialog.show();

    if (shouldDelete != null && shouldDelete) {
      final failureOrRemovedAll = await deleteHistoricAll(NoParams());
      failureOrRemovedAll?.fold(
        (failure) => value = ErrorHistoricState("Não foi possível limpar o histórico."),
        (success) => value = SuccessHistoricState([])
      );
    }
  }
}
