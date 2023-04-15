import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pkd_app/src/features/Exercise/domain/repositories/perdict_repo.dart';

part 'predict_state.dart';

class PredictCubit extends Cubit<PredictState> {
  PredictCubit() : super(PredictInitial());
  final PredictRepo _predictRepo = PredictRepo();
  void predict(
      String sampleID, String filePath, String fileName, File file) async {
    emit(PredictLoading());
    var res = await _predictRepo.predict(sampleID, filePath, fileName, file);
    res.fold((l) => emit(PredictError(l.message)), (r) async {
      emit(PredictSuccess(r));
    });
  }
}
