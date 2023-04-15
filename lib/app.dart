import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pkd_app/src/core/screens/splash_screen.dart';
import 'package:pkd_app/src/features/Exercise/presentation/cubit/exercise_cubit/exercise_cubit.dart';
import 'package:pkd_app/src/features/Exercise/presentation/cubit/predict_cubit/predict_cubit.dart';
import 'package:pkd_app/src/features/GetStarted/presentation/cubit/login_cubit/login_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => PredictCubit(),
          ),
          BlocProvider(
            create: (context) => ExerciseCubit(),
          ),
        ],
        child: MaterialApp(
            title: 'PKD App',
            theme: ThemeData(
              // is not restarted.
              primarySwatch: Colors.green,
            ),
            home: const SplashScreen()));
  }
}
