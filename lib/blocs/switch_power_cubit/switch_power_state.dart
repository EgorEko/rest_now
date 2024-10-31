part of 'switch_power_cubit.dart';

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

class SwitchPowerState extends Equatable {
  const SwitchPowerState({
    required this.status,
    required this.id,
    required this.timeStartOut,
    required this.timeStartPause,
    required this.isPowerOn,
    required this.timerOut,
    required this.timerPause,
  });

  final bool isPowerOn;
  final Statuses status;
  final String id;
  final int timeStartOut;
  final int timeStartPause;
  final int timerOut;
  final int timerPause;

  @override
  List<Object?> get props => [
        isPowerOn,
        status,
        id,
        timeStartOut,
        timerOut,
        timeStartPause,
        timerPause
      ];

  SwitchPowerState copyWith({
    bool? isPowerOn,
    Statuses? status,
    String? id,
    int? timeStartOut,
    int? timeStartPause,
    int? timerOut,
    int? timerPause,
  }) {
    return SwitchPowerState(
      isPowerOn: isPowerOn ?? this.isPowerOn,
      status: status ?? this.status,
      id: id ?? this.id,
      timeStartOut: timeStartOut ?? this.timeStartOut,
      timeStartPause: timeStartPause ?? this.timeStartPause,
      timerOut: timerOut ?? this.timerOut,
      timerPause: timerPause ?? this.timerPause,
    );
  }
}
