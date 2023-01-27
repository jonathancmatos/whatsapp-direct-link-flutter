import 'package:flutter/material.dart';

class LoadButtonWidget extends StatelessWidget {
  const LoadButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16, width: 16,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }
}