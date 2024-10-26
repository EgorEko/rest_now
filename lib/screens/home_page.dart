import 'package:flutter/material.dart';

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
