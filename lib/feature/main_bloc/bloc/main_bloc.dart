import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final List<Map<String, String>> messages = [];

  MainBloc() : super(MainInitial()) {
    on<AddMessageEvent>(_onAddMessage);
  }

  void _onAddMessage(AddMessageEvent event, Emitter<MainState> emit) {
    messages.add({
      'role': event.role,
      'content': event.content,
    });
    emit(MessagesUpdated(messages: List.from(messages)));
  }
}
