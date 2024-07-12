import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

class ChatGptBloc extends Bloc<ChatGptEvent, ChatGptState> {
  ChatGptBloc() : super(ChatGptInitial()) {
    on<ChatGptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
