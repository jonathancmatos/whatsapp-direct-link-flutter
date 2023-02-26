import 'package:flutter/material.dart';
import 'package:whatsapp_direct_link/app/shared/actions/url_actions.dart';

class FormResultWidget extends StatelessWidget {
  const FormResultWidget({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /** Input Result **/
        SizedBox(
          height: 90,
          child: TextFormField(
            initialValue: url,
            enabled: false,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 235, 235, 235),
              prefixIcon: Icon(Icons.link, color: Colors.black),
            ),
            style: const TextStyle(
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 42),
        /** Button Copy **/
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xff9C9C9C))),
          onPressed: () => copyUrl(url),
          child: const Text("COPIAR LINK"),
        ),
        const SizedBox(height: 24),
        /** Button Open **/
        ElevatedButton(
          onPressed: () => openUrl(url),
          child: const Text("ABRIR WHATSAPP"),
        ),
      ],
    );
  }
}
