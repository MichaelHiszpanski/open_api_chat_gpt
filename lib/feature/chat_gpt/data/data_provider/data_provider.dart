import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final String _apiKey = dotenv.env['CHAT_GPT'] ?? '';

  Future<String> isArtPromptApi(String prompt) async {
    print("CHEK This provider 1  ${prompt}");
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
          ] // "Does this message want to generate an AI picture, image, art or anything similar? $prompt. Simply answer yes or no."
        }),
      );
      print("CHEK This provider  2 ${prompt}");
      if (res.statusCode == 200) {
        print("CHEK This provider  200 ${res.body}");
        return res.body;
      } else {
        print("CHEK This provider  3 ${res.body}");
        return jsonEncode(
            {"error": "Error!: ${res.statusCode} ${res.reasonPhrase}"});
      }
    } catch (e) {
      // Return a JSON object indicating an exception
      return jsonEncode({"error": "Error: $e"});
    }
  }

  Future<String> chatGPTAPI(
      String prompt, List<Map<String, String>> messages) async {
    print("CHEK This provider chatGPTAP 1  ${prompt}");
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
      print("CHEK This provider chatGPTAP 2  ${res.body}");
      if (res.statusCode == 200) {
        return res.body;
      } else {
        // Return a JSON object indicating an error
        return jsonEncode(
            {"error": "Error: ${res.statusCode} ${res.reasonPhrase}"});
      }
    } catch (e) {
      // Return a JSON object indicating an exception
      return jsonEncode({"error": "Error: $e"});
    }
  }

  Future<String> dallEAPI(String prompt) async {
    return "dalle";
  }
}
