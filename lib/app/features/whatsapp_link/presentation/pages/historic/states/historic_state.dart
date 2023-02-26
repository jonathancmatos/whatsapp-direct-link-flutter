import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/link_historic.dart';

abstract class HistoricState {}

class InitialHistoricState implements HistoricState {}

class LoadingHistoricState implements HistoricState {}

class SuccessHistoricState implements HistoricState {
  final List<LinkHistoric> historics;
  SuccessHistoricState(this.historics);
}

class ErrorHistoricState implements HistoricState {
  final String message;
  ErrorHistoricState(this.message);
}
