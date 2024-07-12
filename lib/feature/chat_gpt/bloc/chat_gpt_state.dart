part of 'chat_gpt_bloc.dart';

@immutable
abstract class ChatGptState {}

class ChatGptInitial extends ChatGptState {}

class ChatGptLoading extends ChatGptState {}

class ChatGptSuccess extends ChatGptState {
  final String response;

  ChatGptSuccess(this.response);
}

class ChatGptFailure extends ChatGptState {
  final String error;

  ChatGptFailure(this.error);
}
