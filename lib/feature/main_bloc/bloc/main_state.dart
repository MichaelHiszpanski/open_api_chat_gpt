part of 'main_bloc.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class MessagesUpdated extends MainState {
  final List<Map<String, String>> messages;

  MessagesUpdated({required this.messages});
}
