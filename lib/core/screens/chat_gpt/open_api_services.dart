import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenApiServices {
  final String _apiKey = dotenv.env['CHAT_GPT'] ?? '';
  Future<String> isArtPromptApi(String prompr) async {
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
        //do something
      }
      return "Body";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompr) async {
    return "GPT";
  }

  Future<String> dallEAPI(String prompr) async {
    return "dalle";
  }
}
