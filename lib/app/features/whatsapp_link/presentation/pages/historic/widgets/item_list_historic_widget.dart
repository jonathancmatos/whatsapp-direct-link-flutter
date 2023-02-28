import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';
import 'widgets.dart';

class ItemListHistoricWidget extends StatelessWidget {
  final LinkHistoric linkHistoric;
  final int index;
  const ItemListHistoricWidget({super.key, required this.linkHistoric, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(.3), width: 2),
            borderRadius: BorderRadius.circular(3)),
        title: Text(linkHistoric.url,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            softWrap: false),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text("Criado em: ${dateFormatted()}"),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showModalOptions(context: context),
        ),
      ),
    );
  }

  String dateFormatted() {
    return DateFormat("dd/MM/yyyy").format(linkHistoric.createdAt);
  }

  void _showModalOptions({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20),
            ),
        ),
        builder: (BuildContext ctx) => ModalOptionsListWidget(
          historic: linkHistoric, 
          index: index
        ),
    );
  }
}
