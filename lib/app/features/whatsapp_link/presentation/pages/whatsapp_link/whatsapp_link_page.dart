import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class WhatsappLinkPage extends StatelessWidget {
  const WhatsappLinkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WhatsApp Link"),
        actions: const [
          // IconButton(
          //   onPressed: () {}, 
          //   icon: const Icon(Icons.restore),
          // )
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
