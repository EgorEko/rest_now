part of 'switch_power_cubit.dart';

class SwitchPowerState extends Equatable {
  const SwitchPowerState({required this.isPowerOn});

  final bool isPowerOn;

  @override
  List<Object> get props => [isPowerOn];

  SwitchPowerState copyWith({bool? isPowerOn}) {
    return SwitchPowerState(isPowerOn: isPowerOn ?? this.isPowerOn);
  }
}
