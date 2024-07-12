import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:open_api_chat_gpt/core/api/open_api_services.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

class ChatGptBloc extends Bloc<ChatGptEvent, ChatGptState> {
  final OpenApiServices apiService;

  ChatGptBloc({required this.apiService}) : super(ChatGptInitial()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatGptState> emit) async {
    emit(ChatGptLoading());
    try {
      final response = await apiService.isArtPromptApi(event.prompt);
      emit(ChatGptSuccess(response));
    } catch (e) {
      emit(ChatGptFailure(e.toString()));
    }
  }
}
