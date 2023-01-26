import 'package:flutter/material.dart';

class TitleResultWidget extends StatelessWidget {
  const TitleResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.check_circle, size: 90),
        const SizedBox(height: 32),
        Text("Seu link de WhatsApp foi gerado.", 
          style: Theme.of(context).textTheme.headline5?.copyWith(
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,  
        )
      ],
    );
  }
}