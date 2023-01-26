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
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          initialValue: url,
          enabled: false,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: const InputDecoration(
            fillColor: Colors.grey,
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.link),
          ),
        ),
        const SizedBox(height: 42),
        SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
            onPressed: copyUrl,
            child: const Text("COPIAR LINK"),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: openUrl,
            child: const Text("ABRIR WHATSAPP"),
          ),
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
