import 'package:flutter/material.dart';
import 'widgets/widget.dart';

class ResultUrlPage extends StatelessWidget {
  const ResultUrlPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RESULTADO"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TitleResultWidget(),
              const SizedBox(height: 42),
              FormResultWidget(url: url)
            ],
          ),
        ),
      ),
    );
  }
}
