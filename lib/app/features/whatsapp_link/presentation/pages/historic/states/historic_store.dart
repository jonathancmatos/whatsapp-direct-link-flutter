import 'package:flutter/cupertino.dart';
import 'package:whatsapp_direct_link/app/core/usercases/usercase.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_all.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/delete_historic_item.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/usercases/get_historic_whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_state.dart';
import 'package:whatsapp_direct_link/app/shared/confirmations/confirmation_dialog.dart';

class HistoricStore extends ValueNotifier<HistoricState> {
  final ConfirmationDialog confirmationDialog;
  final GetHistoricWhatsAppLink getHistoricWhatsAppLink;
  final DeleteHistoricAll deleteHistoricAll;
  final DeleteHistoricItem deleteHistoricItem;

  List<LinkHistoric> historics = [];

  HistoricStore(
      {required this.confirmationDialog,
      required this.getHistoricWhatsAppLink,
      required this.deleteHistoricAll,
      required this.deleteHistoricItem})
      : super(InitialHistoricState());

  Future<void> getHistoric() async {
    value = LoadingHistoricState();
    final failureOrHistoric = await getHistoricWhatsAppLink(NoParams());
    failureOrHistoric?.fold(
        (failure) => value = ErrorHistoricState("Não foi possível listar o histórico."),
        (success) {
          historics = success;
          value = SuccessHistoricState(historics);
    });
  }

  Future<void> removeItem({required int index}) async {
    final shouldDelete = await confirmationDialog.show();
    if (shouldDelete != null && shouldDelete) {
      final failureOrRemovedItem = await deleteHistoricItem(index);
      failureOrRemovedItem?.fold(
          (failure) => value = ErrorHistoricState("Não foi possível remover esse item."),
          (success) {
            historics.removeAt(index);
            value = SuccessHistoricState(historics);
      });
    }
  }

  Future<void> removeAll() async {
    final shouldDelete = await confirmationDialog.show();
    if (shouldDelete != null && shouldDelete) {
      final failureOrRemovedAll = await deleteHistoricAll(NoParams());
      failureOrRemovedAll?.fold(
          (failure) => value = ErrorHistoricState("Não foi possível limpar o histórico."),
          (success) {
            historics = [];
            value = SuccessHistoricState(historics);
      });
    }
  }
}
