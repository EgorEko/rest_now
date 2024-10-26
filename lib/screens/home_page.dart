import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/status_bloc/status_bloc.dart';
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
                      color: Colors.deepPurple.withOpacity(0.6),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<StatusBloc, StatusState>(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
