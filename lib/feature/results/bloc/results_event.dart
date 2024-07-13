part of 'results_bloc.dart';

@immutable
sealed class ResultsEvent {}

class ReciveMessageEvent extends ResultsEvent {}

class SaveImageEvent extends ResultsEvent {}
