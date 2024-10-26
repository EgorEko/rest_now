part of 'status_bloc.dart';

enum Statuses {
  wait,
  activated,
  pause,
}

class StatusState extends Equatable {
  const StatusState({required this.status});

  final Statuses status;

  @override
  List<Object?> get props => [status];

  StatusState copyWith({Statuses? status}) {
    return StatusState(status: status ?? this.status);
  }
}
