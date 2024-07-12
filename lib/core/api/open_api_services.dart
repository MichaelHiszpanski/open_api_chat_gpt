import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenApiServices {
  final String _apiKey = dotenv.env['CHAT_GPT'] ?? '';
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromptApi(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_apiKey"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo-1106",
            "messages": [
              // {
              //   "role": "system", "content": "You are a helpful assistant."
              //   },
              {"role": "user", "content": "Hello!"}
            ]
          }));
      print(res.body);
      if (res.statusCode == 200) {
        String response =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        response = response.trim();

        switch (response) {
          case "yes":
          case "Yes":
          case "Yes.":
          case "yes.":
            final res = await dallEAPI(prompt);
            return res;
          default:
            return chatGPTAPI(prompt);
        }
      }
      return "Body";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_apiKey"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo-1106",
            "messages": "Hello How are you?",
          }));

      if (res.statusCode == 200) {
        String response =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        response = response.trim();
        messages.add({
          'role': 'assistant',
          'content': response,
        });
      }

      return "Error";
    } catch (e) {
      return e.toString();
    }
    // print(messages.toString());
    // return "";
  }

  Future<String> dallEAPI(String prompt) async {
    return "dalle";
  }
}
