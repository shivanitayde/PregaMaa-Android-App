import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String apiKey = "AIzaSyApHL1qd4xc1yNoYOOW6-1lbyfqK5r1Mq0";

  static Future<String> getResponse(String message) async {
    try {
      final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey",
      );

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text":
                      "You are a helpful healthcare assistant. Give safe advice only. Add disclaimer.\n\n$message",
                },
              ],
            },
          ],
        }),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data["candidates"][0]["content"]["parts"][0]["text"] ??
            "No response";
      } else {
        return "⚠️ API Error ${response.statusCode}\n${response.body}";
      }
    } catch (e) {
      return "⚠️ Error: $e";
    }
  }
}
