part of 'status_bloc.dart';

enum Statuses {
  wait('Wait'),
  activated('Activated'),
  pause('Pause');

  const Statuses(this.value);
  final String value;

  factory Statuses.fromString(String status) {
    return values.firstWhere((e) => e.value == status);
  }
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
