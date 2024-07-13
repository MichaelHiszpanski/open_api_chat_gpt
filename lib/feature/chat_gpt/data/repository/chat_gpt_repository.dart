import 'dart:convert';
import 'package:open_api_chat_gpt/feature/chat_gpt/data/data_provider/data_provider.dart';

class ChatGptRepository {
  final DataProvider dataProvider;

  ChatGptRepository({
    required this.dataProvider,
  });

  Future<String> getArtPromptApi(
      String prompt, List<Map<String, String>> messages) async {
    try {
      final chatGptData = await dataProvider.isArtPromptApi(prompt);
      final data = jsonDecode(chatGptData);
      if (data.containsKey('error')) {
        throw Exception(data['error']);
      }

      String response = data['choices'][0]['message']['content'].trim();

      switch (response) {
        case "Yes":
        case "Yes.":
        case "yes":
        case "yes.":
          final dallERes = await getDallEAPI(prompt);
          return dallERes;
        default:
          return response;
      }
    } catch (e) {
      print("Error in getArtPromptApi: $e");
      throw Exception("Error in getArtPromptApi: $e");
    }
  }

  Future<String> getchatGPTAPI(
      String prompt, List<Map<String, String>> messages) async {
    print("CHEK This getchatGPTAPI  1 ${prompt}");
    try {
      final chatGptData = await dataProvider.chatGPTAPI(prompt, messages);
      final data = jsonDecode(chatGptData);

      if (data.containsKey('error')) {
        throw Exception(data['error']);
      }
      print("CHEK This getchatGPTAPI  2 ${prompt}");
      if (data['choices'] != null && data['choices'].isNotEmpty) {
        String response = data['choices'][0]['message']['content'].trim();
        messages.add({'role': 'assistant', 'content': response});
        print("ChatGPT response: $response");
        return response;
      } else {
        throw Exception("Invalid response from API: No choices found.");
      }
    } catch (e) {
      print("Error in getchatGPTAPI: $e");
      throw Exception("Error in getchatGPTAPI: $e");
    }
  }

  Future<String> getDallEAPI(String prompt) async {
    return "dalle";
  }
}
