import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
          onPressed: copyUrl,
          child: const Text("COPIAR LINK"),
        ),
        const SizedBox(height: 24),
        /** Button Open **/
        ElevatedButton(
          onPressed: openUrl,
          child: const Text("ABRIR WHATSAPP"),
        ),
      ],
    );
  }

  void copyUrl() {
    FlutterClipboard.copy(url)
        .then((value) => Fluttertoast.showToast(msg: "Url copiada."));
  }

  void openUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      Fluttertoast.showToast(msg: "Não foi possível abrir o link.");
    }
  }
}
