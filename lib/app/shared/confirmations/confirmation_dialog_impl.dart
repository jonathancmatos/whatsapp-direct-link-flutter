import 'package:flutter/material.dart';
import 'package:whatsapp_direct_link/app/shared/confirmations/confirmation_dialog.dart';

const ALERT_DIALOG_TITLE = "Deseja realmente remover ?";
const ALERT_DIALOG_MESSAGE = "Ao remover, essa ação não poderá ser desfeita.";

class ConfirmationDialogImpl implements ConfirmationDialog {
  ConfirmationDialogImpl(this.context);
  final BuildContext context;

  @override
  Future<bool?> show() async {
    return await showDialog<bool>(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ALERT_DIALOG_TITLE, style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Colors.black,
                )),
                const SizedBox(height: 16),
                const Text(ALERT_DIALOG_MESSAGE, style: TextStyle(height: 1.5))
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancelar",style: TextStyle(
                    color: Colors.grey
                  ))
              ),
              
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Confirmar", style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.redAccent
                  ))
              ),
            ],
          );
        });
  }
}
