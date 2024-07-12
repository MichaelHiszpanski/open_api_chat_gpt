part of 'chat_gpt_bloc.dart';

@immutable
sealed class ChatGptEvent {}

class SendMessageEvent extends ChatGptEvent {
  final String prompt;

  SendMessageEvent(this.prompt);
}
