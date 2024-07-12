import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/bloc/chat_gpt_bloc.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/presentation/feature_box.dart';
import 'package:open_api_chat_gpt/core/api/open_api_services.dart';
import 'package:open_api_chat_gpt/core/theme/pallete/pallete.dart';
import 'package:open_api_chat_gpt/feature/chat_gpt/presentation/feature_list.dart';
import 'package:open_api_chat_gpt/feature/main_bloc/bloc/main_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

@RoutePage()
class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({super.key});

  @override
  State<ChatGPTScreen> createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final speechToText = SpeechToText();
  String lastWords = '';
  final flutterTts = FlutterTts();
  OpenApiServices openApiServices = OpenApiServices();
  late ChatGptBloc chatGptBloc;

  @override
  void initState() {
    super.initState();
    chatGptBloc = ChatGptBloc(apiService: openApiServices);
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    // await flutterTts.stop();
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
    chatGptBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatGptBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Allen"),
          leading: const Icon(Icons.menu),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                          color: Pallete.assistantCircleColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                  Container(
                    height: 123,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/virtualAssistant.png"))),
                  )
                ],
              ),
              BlocBuilder<ChatGptBloc, ChatGptState>(
                builder: (context, state) {
                  if (state is ChatGptLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatGptSuccess) {
                    context.read<MainBloc>().add(AddMessageEvent(
                        role: 'assistant', content: state.response));
                    systemSpeak(state.response);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 40)
                          .copyWith(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(color: Pallete.blackColor),
                        borderRadius: BorderRadius.circular(20).copyWith(
                          topLeft: Radius.zero,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          state.response,
                          style: const TextStyle(
                            color: Pallete.mainFontColor,
                            fontFamily: "Cera Pro",
                          ),
                        ),
                      ),
                    );
                  } else if (state is ChatGptFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const Center(
                        child:
                            Text('Good morning, what task can I do for you?'));
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 22),
                child: const Text(
                  "Here are a few features",
                  style: TextStyle(
                      fontFamily: "Cera Pro",
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const FeatureList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              chatGptBloc.add(SendMessageEvent(lastWords));
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: const Icon(Icons.mic),
        ),
      ),
    );
  }
}
