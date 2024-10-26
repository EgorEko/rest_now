import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_power_state.dart';

class SwitchPowerCubit extends Cubit<SwitchPowerState> {
  SwitchPowerCubit() : super(const SwitchPowerState(isPowerOn: false));

  final AdvertiseData advertiseData = AdvertiseData(
    serviceUuid: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
    localName: 'RestNow_BLE',
  );

  final AdvertiseSetParameters advertiseSetParameters =
      AdvertiseSetParameters(scannable: true);

  Future<void> switchPower(bool value) async {
    if (value) {
      await _powerDeviceOn();
    } else {
      await _powerDeviceOff();
    }
    emit(state.copyWith(isPowerOn: value));
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
        FlutterBlePeripheral().openBluetoothSettings;
      }
      _requestPermissions();
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
