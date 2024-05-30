import 'package:translator/translator.dart';

class TranslatorService {
  final translator = GoogleTranslator(); // Create an instance of the Translator class

  /*Future<String> translateText(String text, String toLanguage) async {
    var translation = await translator.translate(text, to: toLanguage);
    return translation.text; // Access the translated text
  }*/
  Future<String> translateContent(String content, String toLanguage) async {
    var translation = await translator.translate(content, to: toLanguage);
    return translation.text;
  }
}
