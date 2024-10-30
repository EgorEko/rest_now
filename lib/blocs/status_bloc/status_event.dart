part of 'status_bloc.dart';

class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object?> get props => [];
}

class WaitStatusEvent extends StatusEvent {}

class ActivateStatusEvent extends StatusEvent {
  const ActivateStatusEvent(
      {required this.id, required this.timeOut, required this.timePause});

  final String id;
  final num timeOut;
  final num timePause;

  @override
  List<Object?> get props => [id, timeOut, timePause];
}

class PauseStatusEvent extends StatusEvent {}
