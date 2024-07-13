import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/presentation/chat_gpt_screen.dart';
import 'package:open_api_chat_gpt/feature/main/bloc/main_bloc.dart';
import 'package:open_api_chat_gpt/observer.dart';
import 'package:open_api_chat_gpt/utils/providers/block_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ChatGPTScreen(),
      ),
    );
  }
}
