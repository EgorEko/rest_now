import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../status_bloc/status_bloc.dart';

part 'switch_power_state.dart';

class SwitchPowerCubit extends Cubit<SwitchPowerState> {
  SwitchPowerCubit() : super(const SwitchPowerState(isPowerOn: false));

  StatusBloc bloc = StatusBloc();
  final timer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final AdvertiseData advertiseData = AdvertiseData(
    serviceUuid: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
    localName: 'RestNow_BLE',
  );

  final AdvertiseSetParameters advertiseSetParameters =
      AdvertiseSetParameters(scannable: true);

  Future<void> switchPower(bool value) async {
    if (value) {
      bloc.wait();
      await _powerDeviceOn();
    } else {
      await _powerDeviceOff();
    }
    emit(state.copyWith(isPowerOn: value));
  }

  void start({
    required String id,
    required num timeOut,
    required num timePause,
  }) {
    if (bloc.state.status == Statuses.wait) {
      bloc.deviceActivate(id: id, timeOut: timeOut, timePause: timePause);
    } else {
      return;
    }
  }

  void alive({required String id}) {
    if (bloc.state.id == id) {
      _timerHandle(timer);
    } else {
      return;
    }
  }

  void pause({required String id}) {
    if (bloc.state.id == id) {
      bloc.devicePause();
      _timerHandle(timer);
      _powerDeviceOff();
    } else {
      return;
    }
  }

  void continuation({required String id}) {
    if (bloc.state.status == Statuses.wait) {
      bloc.deviceActivate(
        id: id,
        timeOut: bloc.state.timeOut,
        timePause: bloc.state.timePause,
      );
    } else {
      return;
    }
  }

  void stop({required String id}) {
    if (bloc.state.id == id) {
      if (bloc.state.status == Statuses.pause ||
          bloc.state.status == Statuses.activated) {
        bloc.wait();
        _powerDeviceOff();
      } else if (bloc.state.status == Statuses.wait) {
        return;
      }
    } else {
      return;
    }
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

  _timerHandle(StopWatchTimer timer) {
    timer.onStartTimer();
    timer.secondTime.listen((value) {
      if (value > bloc.state.timeOut) {
        bloc.wait();
        timer.onStopTimer();
        _powerDeviceOff();
      }
    });
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
