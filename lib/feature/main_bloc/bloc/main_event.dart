part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class AddMessageEvent extends MainEvent {
  final String role;
  final String content;

  AddMessageEvent({required this.role, required this.content});
}
