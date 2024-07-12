import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_api_chat_gpt/core/api/open_api_services.dart';
import 'package:open_api_chat_gpt/feature/main/bloc/main_bloc.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

class ChatGptBloc extends Bloc<ChatGptEvent, ChatGptState> {
  final OpenApiServices apiService;
  final MainBloc mainBloc;

  ChatGptBloc({required this.apiService, required this.mainBloc})
      : super(ChatGptInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatGptState> emit) async {
    emit(ChatGptLoading());
    try {
      final response =
          await apiService.isArtPromptApi(event.prompt, mainBloc.messages);
      mainBloc.add(AddMessageEvent(role: 'assistant', content: response));
      emit(ChatGptSuccess(response));
    } catch (e) {
      emit(ChatGptFailure(e.toString()));
    }
  }
}
