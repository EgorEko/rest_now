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
    required this.timeOut,
    required this.timePause,
    required this.isPowerOn,
  });

  final bool isPowerOn;
  final Statuses status;
  final String id;
  final num timeOut;
  final num timePause;

  @override
  List<Object> get props => [isPowerOn, status, id, timeOut, timePause];

  SwitchPowerState copyWith({
    bool? isPowerOn,
    Statuses? status,
    String? id,
    num? timeOut,
    num? timePause,
  }) {
    return SwitchPowerState(
      isPowerOn: isPowerOn ?? this.isPowerOn,
      status: status ?? this.status,
      id: id ?? this.id,
      timeOut: timeOut ?? this.timeOut,
      timePause: timePause ?? this.timePause,
    );
  }
}
