import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_state.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/states/historic_store.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/historic/widgets/item_list_historic_widget.dart';

class HistoricLinkPage extends StatefulWidget {
  const HistoricLinkPage({super.key});

  @override
  State<HistoricLinkPage> createState() => _HistoricLinkPageState();
}

class _HistoricLinkPageState extends State<HistoricLinkPage> {
  final controller = Modular.get<HistoricStore>();

  @override
  void initState() {
    super.initState();
    controller.getHistoric();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
        actions: [
          IconButton(
            onPressed: () => controller.removeAll(), 
            icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, state, child) {
          if (state is LoadingHistoricState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessHistoricState) {
            final list = state.historics;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return ItemListHistoricWidget(linkHistoric: list[index]);
                  }),
            );
          }
          return Container();
        },
      ),
    );
  }
}
