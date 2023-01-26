import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
          Text("GERAR LINK DIRETO", style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 16),
          const Text("Crie grátis seu link de WhatsApp em apenas um clique.", 
          style: TextStyle(
            height: 1.5,
          ), 
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}