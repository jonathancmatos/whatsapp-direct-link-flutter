import 'package:flutter/material.dart';

class TitleResultWidget extends StatelessWidget {
  const TitleResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.check_circle, size: 80, color: Theme.of(context).primaryColor),
        const SizedBox(height: 24),
        Text("Seu link de WhatsApp foi \n gerado.", 
          style: Theme.of(context).textTheme.headline5?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            height: 1.5
          ),
          textAlign: TextAlign.center,  
        )
      ],
    );
  }
}