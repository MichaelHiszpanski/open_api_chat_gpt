import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/bloc/chat_gpt_bloc.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/data/repository/chat_gpt_repository.dart';
import 'package:open_api_chat_gpt/feature/main/bloc/main_bloc.dart';
import 'package:open_api_chat_gpt/core/api/open_api_services.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/data/data_provider/data_provider.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) => MainBloc(),
        ),
        BlocProvider<ChatGptBloc>(
          create: (context) {
            final mainBloc = context.read<MainBloc>();
            final dataProvider = DataProvider();
            final apiService = ChatGptRepository(dataProvider: dataProvider);
            return ChatGptBloc(
                chatGptRepository: apiService, mainBloc: mainBloc);
          },
        ),
      ],
      child: child,
    );
  }
}
