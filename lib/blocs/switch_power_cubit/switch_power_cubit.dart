import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_power_state.dart';

class SwitchPowerCubit extends Cubit<SwitchPowerState> {
  SwitchPowerCubit()
      : super(
          const SwitchPowerState(
            isPowerOn: false,
            status: Statuses.wait,
            id: '',
            timeStartOut: 0,
            timeStartPause: 0,
            timerOut: 0,
            timerPause: 0,
          ),
        );

  final AdvertiseData advertiseData = AdvertiseData(
    serviceUuid: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
    localName: 'RestNow_BLE',
  );

  final AdvertiseSetParameters advertiseSetParameters =
      AdvertiseSetParameters(scannable: true);

  Future<void> switchPower(bool value) async {
    if (value) {
      _switchStatusWait();
      await _powerDeviceOn();
    } else {
      if (state.status == Statuses.activated) {
        await _powerDeviceOff();
      }
    }
    emit(state.copyWith(isPowerOn: value));
  }

  void start({
    required String id,
    required int timeStartOut,
  }) {
    if (state.status == Statuses.wait) {
      if (state.status == Statuses.activated) {
        return;
      }
      emit(
        state.copyWith(
          status: Statuses.activated,
          id: id,
          timeStartOut: timeStartOut,
        ),
      );
    } else {
      return;
    }
  }

  void alive({required String id}) {
    if (state.id == id) {
      var currentTimeInSeconds = 0;
      if (state.status == Statuses.wait) {
        return;
      }
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          currentTimeInSeconds = currentTimeInSeconds + 1;
          if (currentTimeInSeconds == state.timeStartOut + 1) {
            timer.cancel();
            switchPower(false);
            emit(
              state.copyWith(
                status: Statuses.wait,
              ),
            );
          } else {
            emit(state.copyWith(timerOut: currentTimeInSeconds));
          }
        },
      );
    } else {
      return;
    }
  }

  void pause({required String id}) {
    if (state.id == id) {
      _switchStatusPause();
      var currentTimeInSeconds = 0;
      _powerDeviceOff();
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          currentTimeInSeconds = currentTimeInSeconds + 1;
          if (currentTimeInSeconds == state.timerOut) {
            timer.cancel();
            switchPower(false);
            emit(
              state.copyWith(
                status: Statuses.wait,
              ),
            );
          }
        },
      );
    } else {
      return;
    }
  }

  void continuation({required String id}) {
    if (state.status == Statuses.wait) {
      _switchStatusActivate(id);
    } else {
      return;
    }
  }

  void stop({required String id}) {
    if (state.id == id) {
      if (state.status == Statuses.pause ||
          state.status == Statuses.activated) {
        emit(state.copyWith(status: Statuses.wait));
        _powerDeviceOff();
      } else if (state.status == Statuses.wait) {
        return;
      }
    } else {
      return;
    }
  }

  void _switchStatusWait() {
    if (state.status == Statuses.wait) {
      return;
    }
    emit(state.copyWith(status: Statuses.wait));
  }

  void _switchStatusPause() {
    if (state.status == Statuses.pause) {
      return;
    }
    emit(state.copyWith(status: Statuses.pause));
  }

  void _switchStatusActivate(String id) {
    if (state.status == Statuses.activated) {
      return;
    }
    emit(
      state.copyWith(
        status: Statuses.activated,
        id: id,
      ),
    );
  }

  Future<void> _powerDeviceOn() async {
    try {
      final hasPermissions = await _hasPermissions();
      if (hasPermissions) {
        _toggleAdvertise();
      } else {
        await _requestPermissions();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _powerDeviceOff() async {
    try {
      await FlutterBlePeripheral().stop();
    } catch (e) {
      e.toString();
    }
  }

  Future<void> _requestPermissions() async {
    try {
      final hasPermission = await FlutterBlePeripheral().hasPermission();
      if (hasPermission != BluetoothPeripheralState.ready) {
        FlutterBlePeripheral().openBluetoothSettings();
      }
    } catch (e) {
      e.toString();
    }
  }

  Future<bool> _hasPermissions() async {
    try {
      final hasPermissions = await FlutterBlePeripheral().hasPermission();
      return hasPermissions == BluetoothPeripheralState.granted;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> _toggleAdvertise() async {
    try {
      if (await FlutterBlePeripheral().isAdvertising) {
        await FlutterBlePeripheral().stop();
      } else {
        await FlutterBlePeripheral().start(
          advertiseData: advertiseData,
          advertiseSetParameters: advertiseSetParameters,
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
