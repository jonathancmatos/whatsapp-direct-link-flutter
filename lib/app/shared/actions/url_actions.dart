import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

const MESSAGE_COPY = "Url copiada.";
const MESSAGE_ERROR_OPEN_LINK = "Não foi possível abrir o link.";

void copyUrl(String url) {
  FlutterClipboard.copy(url)
      .then((value) => Fluttertoast.showToast(msg: MESSAGE_COPY));
}

void openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Fluttertoast.showToast(msg: MESSAGE_ERROR_OPEN_LINK);
  }
}
