part of 'status_bloc.dart';

class StatusEvent extends Equatable {
  const StatusEvent();

  @override
  List<Object?> get props => [];
}

class WaitStatusEvent extends StatusEvent {}

class ActivateStatusEvent extends StatusEvent {}

class PauseStatusEvent extends StatusEvent {}
