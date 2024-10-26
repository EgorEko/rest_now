import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/status_bloc/status_bloc.dart';
import 'blocs/switch_power_cubit/switch_power_cubit.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const RestNowApp());
}

class RestNowApp extends StatelessWidget {
  const RestNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest now',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: SwitchPowerCubit()),
          BlocProvider.value(value: StatusBloc()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
