import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import '../states/historic_store.dart';

class ModalOptionsListWidget extends StatelessWidget {
  ModalOptionsListWidget({
    super.key, required 
    this.historic, required this.index
  });
  
  final LinkHistoric historic;
  final int index;

  final controller = Modular.get<HistoricStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text("Escolha uma opção",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          ListTile(
            textColor: Colors.black,
            iconColor: Colors.black,
            onTap: copyUrl,
            leading: const Icon(Icons.copy),
            title: const Text("Copiar Link"),
          ),
          const Divider(height: 2),

          ListTile(
            textColor: Colors.black,
            iconColor: Colors.black,
            onTap: openUrl,
            leading: const Icon(Icons.whatsapp),
            title: const Text("Abrir no WhatsApp"),
          ),
          const Divider(height: 2),

          ListTile(
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              Navigator.of(context).pop();
              controller.removeItem(index: index);
            },
            leading: const Icon(Icons.delete),
            title: const Text("Remover"),
          ),
        ],
      ),
    );
  }

  void copyUrl() {
    FlutterClipboard.copy(historic.url)
        .then((value) => Fluttertoast.showToast(msg: "Url copiada."));
  }

  void openUrl() async {
    //whatsapp://send?phone=61969771824&text=test+params
    if (await canLaunch(historic.url)) {
      await launch(historic.url);
    } else {
      Fluttertoast.showToast(msg: "Não foi possível abrir o link.");
    }
  }
}
