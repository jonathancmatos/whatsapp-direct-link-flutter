import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';

class ItemListHistoricWidget extends StatelessWidget {
  final LinkHistoric linkHistoric;
  const ItemListHistoricWidget({super.key, required this.linkHistoric});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.withOpacity(.3), width: 2),
            borderRadius: BorderRadius.circular(3)
        ),
        title: Text(linkHistoric.url,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            softWrap: false
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text("Criado em: ${dateFormatted()}"),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ),
    );
  }

  String dateFormatted() {
    return DateFormat("dd/MM/yyyy").format(linkHistoric.createdAt);
  }
}
