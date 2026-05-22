import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final FlutterTts _tts = FlutterTts();

  static bool isSpeaking = false;

  static Future speak(String text, String lang) async {
    String languageCode = "en-IN";

    if (lang == "hi") languageCode = "hi-IN";
    if (lang == "mr") languageCode = "mr-IN";

    await _tts.setLanguage(languageCode);
    await _tts.setSpeechRate(0.45);

    isSpeaking = true;

    await _tts.speak(text);
  }

  static Future stop() async {
    isSpeaking = false;
    await _tts.stop();
  }
}
