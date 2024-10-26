import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_power_state.dart';

class SwitchPowerCubit extends Cubit<SwitchPowerState> {
  SwitchPowerCubit() : super(const SwitchPowerState(isPowerOn: false));

  void switchPower(bool value) {
    if (value) {
      _powerDeviceOn();
    } else {
      _powerDeviceOff();
    }
    emit(state.copyWith(isPowerOn: value));
  }

  void _powerDeviceOn() {}

  void _powerDeviceOff() {}
}
