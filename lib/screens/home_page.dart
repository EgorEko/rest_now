import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/switch_power_cubit/switch_power_cubit.dart';
import '../common/app_colors.dart';
import '../widgets/background_widget.dart';
import '../widgets/switch_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      gradient: LinearGradient(
        colors: [
          AppColors.backGroundColorStart,
          AppColors.backGroundColorMiddle,
          AppColors.backGroundColorEnd,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Rest now controller',
                    style: TextStyle(
                      color: AppColors.appBarTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SwitchPowerCubit, SwitchPowerState>(
                    builder: (context, state) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backGroundColorEnd,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          state.status.value,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SwitchWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  TextButton(
                    onPressed: () => context.read<SwitchPowerCubit>().start(
                          id: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
                          timeOut: 0,
                          timePause: 0,
                        ),
                    child: const Text('start'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SwitchPowerCubit>()
                        .alive(id: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7'),
                    child: const Text('alive'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<SwitchPowerCubit>()
                        .pause(id: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7'),
                    child: const Text('pause'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<SwitchPowerCubit>().continuation(
                              id: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
                            ),
                    child: const Text('continue'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () => context.read<SwitchPowerCubit>().stop(
                          id: 'bf27730d-860a-4e09-889c-2d8b6a9e0fe7',
                        ),
                    child: const Text('stop'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
