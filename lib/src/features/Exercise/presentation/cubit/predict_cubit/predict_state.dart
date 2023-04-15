part of 'predict_cubit.dart';

abstract class PredictState extends Equatable {
  const PredictState();

  @override
  List<Object> get props => [];
}

class PredictInitial extends PredictState {}

class PredictLoading extends PredictState {}

class PredictError extends PredictState {
  final String error;

  const PredictError(this.error);
}

class PredictSuccess extends PredictState {
  final Map<String, dynamic> res;

  const PredictSuccess(this.res);
}
