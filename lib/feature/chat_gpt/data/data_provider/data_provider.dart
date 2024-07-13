import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final String _apiKey = dotenv.env['CHAT_GPT'] ?? '';

  Future<String> isArtPromptApi(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo-1106",
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ]
        }),
      );
      if (res.statusCode == 200) {
        print("CHEK This provider  200 ${res.body}");
        return res.body;
      } else {
        print("CHEK This provider  3 ${res.body}");
        return jsonEncode(
            {"error": "Error!: ${res.statusCode} ${res.reasonPhrase}"});
      }
    } catch (e) {
      return jsonEncode({"error": "Error: $e"});
    }
  }

  Future<String> chatGPTAPI(
      String prompt, List<Map<String, String>> messages) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo-1106",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        return res.body;
      } else {
        return jsonEncode(
            {"error": "Error: ${res.statusCode} ${res.reasonPhrase}"});
      }
    } catch (e) {
      return jsonEncode({"error": "Error: $e"});
    }
  }

  Future<String> dallEAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey",
        },
        body: jsonEncode({
          "model": "dall-e-3",
          "messages": prompt,
          "n": 1,
          "size": "1024x1024"
        }),
      );
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return jsonEncode(
            {"error": "Error: ${res.statusCode} ${res.reasonPhrase}"});
      }
    } catch (e) {
      return jsonEncode({"error": "Error: $e"});
    }
  }
}
