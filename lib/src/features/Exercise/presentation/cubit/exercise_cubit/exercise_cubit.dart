import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pkd_app/src/features/Exercise/data/models/exercise_res.dart';
import 'package:pkd_app/src/features/Exercise/domain/repositories/get_exercies_repo.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
  final ExerciseRepo _exerciseRepo = ExerciseRepo();
  void fetch(String score) async {
    emit(ExerciseLoading());
    var res = await _exerciseRepo.fetch(score);
    res.fold((l) => emit(ExerciseError(l.message)), (r) async {
      emit(ExerciseSuccess(r));
    });
  }
}
