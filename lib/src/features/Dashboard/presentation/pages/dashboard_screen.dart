import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkd_app/src/common/theme/themes.dart';
import 'package:pkd_app/src/features/Dashboard/presentation/widgets/dashboard_card.dart';
import 'package:pkd_app/src/features/Exercise/presentation/cubit/exercise_cubit/exercise_cubit.dart';
import 'package:pkd_app/src/features/Exercise/presentation/pages/exercise_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    // BlocProvider.of<ExerciseCubit>(context).fetch("10");
    // BlocProvider.of<ExerciseCubit>(context).fetch("10");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Hey Rishi',
              style: bigHeadingText,
            ),
            const CircleAvatar(
              radius: 50,
            ),
            Text(
              'Levels to complete',
              style: regularText,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ExerciseCubit>(context).fetch("10");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExercisePage(),
                    ));
                  },
                  child: const DashboardCard(
                    level: "Level 1",
                    title: "Basic",
                    percent: .5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ExerciseCubit>(context).fetch("20");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExercisePage(),
                    ));
                  },
                  child: const DashboardCard(
                    level: "Level 2",
                    title: "Intermediate",
                    percent: .5,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<ExerciseCubit>(context).fetch("30");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExercisePage(),
                    ));
                  },
                  child: const DashboardCard(
                    level: "Level 3",
                    title: "Hard",
                    percent: .5,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
