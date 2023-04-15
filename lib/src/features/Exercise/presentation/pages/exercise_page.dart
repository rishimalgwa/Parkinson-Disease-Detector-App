import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pkd_app/src/common/theme/app_colors.dart';
import 'package:pkd_app/src/common/theme/themes.dart';
import 'package:pkd_app/src/core/widgets/snackbar.dart';
import 'package:pkd_app/src/features/Exercise/presentation/cubit/exercise_cubit/exercise_cubit.dart';
import 'package:pkd_app/src/features/Exercise/presentation/cubit/predict_cubit/predict_cubit.dart';
import 'package:pkd_app/src/utils/save_image.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int sampleNo = 0;
  int progressNo = 1;
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExerciseCubit, ExerciseState>(
        listener: (context, state) {
          if (state is ExerciseError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(errorSnackbar(state.error));
          }
        },
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryButtonColor,
              ),
            );
          } else if (state is ExerciseSuccess) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Basic',
                    style: bigHeadingText,
                  ),
                  LinearPercentIndicator(
                    alignment: MainAxisAlignment.center,
                    padding: const EdgeInsets.all(0),
                    lineHeight: 20,
                    width: 300,
                    progressColor: Colors.green,
                    backgroundColor: AppColors.greyColor,
                    percent: (progressNo /
                        (state.res.count != 0 ? state.res.count : 1)),
                    barRadius: const Radius.circular(15),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: AppColors.goldenYellowColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        state.res.samples[sampleNo].value,
                        style: const TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                  Text(
                    'Draw the given letter',
                    style: regularText,
                  ),
                  BlocConsumer<PredictCubit, PredictState>(
                    listener: (context, state) {
                      if (state is PredictError) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(errorSnackbar(state.error));
                      }
                      if (state is PredictSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            successSnackbar(state.res["message"]));

                        setState(() {
                          sampleNo++;
                          progressNo++;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is PredictLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryButtonColor,
                          ),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 226, 226, 226),
                        ),
                        margin: const EdgeInsets.all(8),
                        height: 250,
                        width: double.infinity,
                        child: SfSignaturePad(
                          key: _signaturePadKey,
                          minimumStrokeWidth: 5,
                          maximumStrokeWidth: 7,
                          backgroundColor: Colors.grey[200],
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (sampleNo < state.res.count - 1) {
                        var status = await Permission.storage.status;
                        if (status.isDenied) {
                          // We didn't ask for permission yet or the permission has been denied before but not permanently.
                        }
                        ui.Image image =
                            await _signaturePadKey.currentState!.toImage();
                        // final result = await ImageGallerySaver.saveImage(
                        //     image.buffer.asUint8List(
                        //         image.offsetInBytes, image.lengthInBytes));

                        var file = await writeToFile((await image.toByteData(
                            format: ui.ImageByteFormat.png))!);
                        BlocProvider.of<PredictCubit>(context).predict(
                            state.res.samples[sampleNo].id,
                            file.path,
                            "",
                            file);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryButtonColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('CHECK',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
