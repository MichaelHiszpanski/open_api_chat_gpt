part of 'results_bloc.dart';

@immutable
sealed class ResultsState {}

final class ResultsInitial extends ResultsState {}

final class ResultsLoading extends ResultsState {}

final class ResultsSuccess extends ResultsState {}

final class ResultsFailure extends ResultsState {}
