import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/data/repository/chat_gpt_repository.dart';
import 'package:open_api_chat_gpt/feature/main/bloc/main_bloc.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

class ChatGptBloc extends Bloc<ChatGptEvent, ChatGptState> {
  final ChatGptRepository chatGptRepository;
  final MainBloc mainBloc;

  ChatGptBloc({required this.chatGptRepository, required this.mainBloc})
      : super(ChatGptInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatGptState> emit) async {
    emit(ChatGptLoading());
    try {
      final response = await chatGptRepository.getArtPromptApi(
          event.prompt, mainBloc.messages);

      mainBloc.add(AddMessageEvent(role: 'assistant', content: response));
      emit(ChatGptSuccess(response));
    } catch (e) {
      print("Error in _onSendMessage: $e");
      emit(ChatGptFailure(e.toString()));
    }
  }
}
