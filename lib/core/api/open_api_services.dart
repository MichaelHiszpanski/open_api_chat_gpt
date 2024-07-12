import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenApiServices {
  final String _apiKey = dotenv.env['CHAT_GPT'] ?? '';
  Future<String> isArtPromptApi(
      String prompt, List<Map<String, String>> messages) async {
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
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI picture, image, art or anything simliar? $prompt . Simply answer yes or no."
              }
            ]
          }));
      print("Send");
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
            print(prompt);
            return chatGPTAPI(prompt, messages);
        }
      }
      return "Body";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(
      String prompt, List<Map<String, String>> messages) async {
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
            "messages": messages,
          }));
      print("Response 1");
      print(res.body.toString());
      if (res.statusCode == 200) {
        String response =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        response = response.trim();
        messages.add({
          'role': 'assistant',
          'content': response,
        });
        print("Response 2");
        print(response);
        return response;
      }

      return "Error";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    return "dalle";
  }
}
