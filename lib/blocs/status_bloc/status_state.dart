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
  const StatusState({
    required this.status,
    required this.id,
    required this.timeOut,
    required this.timePause,
  });

  final Statuses status;
  final String id;
  final num timeOut;
  final num timePause;

  @override
  List<Object?> get props => [status, id, timeOut, timePause];

  StatusState copyWith({
    Statuses? status,
    String? id,
    num? timeOut,
    num? timePause,
  }) {
    return StatusState(
      status: status ?? this.status,
      id: id ?? this.id,
      timeOut: timeOut ?? this.timeOut,
      timePause: timePause ?? this.timePause,
    );
  }
}
