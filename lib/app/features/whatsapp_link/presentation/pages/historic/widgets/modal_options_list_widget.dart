import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'package:whatsapp_direct_link/app/shared/actions/url_actions.dart';
import '../states/historic_store.dart';

class ModalOptionsListWidget extends StatelessWidget {
  ModalOptionsListWidget({super.key, required this.historic, required this.index});

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
            style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            textColor: Colors.black,
            iconColor: Colors.black,
            onTap: () {
              Navigator.of(context).pop();
              copyUrl(historic.url);
            },
            leading: const Icon(Icons.copy),
            title: const Text("Copiar Link"),
          ),
          const Divider(height: 2),
          ListTile(
            textColor: Colors.black,
            iconColor: Colors.black,
            onTap: () => openUrl(historic.url),
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
}
