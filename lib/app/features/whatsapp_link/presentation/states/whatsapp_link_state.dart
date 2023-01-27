abstract class WhatsappLinkState {}

class InitialWhatsappLinkState implements WhatsappLinkState {}

class SuccessWhatsappLinkState implements WhatsappLinkState {
  final String url;
  SuccessWhatsappLinkState(this.url);
}

class LoadingWhatsappLinkState implements WhatsappLinkState {}

class ErrorWhatsappLinkState implements WhatsappLinkState {
  final String message;
  ErrorWhatsappLinkState(this.message);
}
