import 'package:flutter/material.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/whatsapp_link/widgets/form_widget.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/whatsapp_link/widgets/title_widget.dart';

class WhatsappLinkPage extends StatelessWidget {
  const WhatsappLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Link"),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            children: const [
              TitleWidget(),
              SizedBox(height: 69),
              FormWidget()
            ]
          ),
        )
      ),
    );
  }
}
