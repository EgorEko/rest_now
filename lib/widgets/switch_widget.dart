import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../blocs/switch_power_cubit/switch_power_cubit.dart';
import '../common/app_colors.dart';

class SwitchWidget extends StatelessWidget {
  const SwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.inactiveSwitchColor,
            spreadRadius: 8,
            blurRadius: 6,
          ),
        ],
      ),
      child: BlocBuilder<SwitchPowerCubit, SwitchPowerState>(
        builder: (context, state) {
          return Center(
            child: FlutterSwitch(
              value: state.isPowerOn,
              activeColor: AppColors.activeSwitchColor,
              showOnOff: true,
              onToggle: (value) {
                context.read<SwitchPowerCubit>().switchPower(value);
              },
              activeTextColor: AppColors.activeSwitchTextColor,
              inactiveColor: AppColors.inactiveSwitchColor,
              toggleBorder: Border.all(
                color: AppColors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
