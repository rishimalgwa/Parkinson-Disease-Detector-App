part of 'exercise_cubit.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseError extends ExerciseState {
  final String error;

  const ExerciseError(this.error);
}

class ExerciseSuccess extends ExerciseState {
  final ExerciseResponse res;

  const ExerciseSuccess(this.res);
}
