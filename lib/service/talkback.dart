import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts tts = FlutterTts();

void speak(String text) async {
  await tts.setLanguage("en-US");
  await tts.setPitch(1.0);
  await tts.speak(text);
}
