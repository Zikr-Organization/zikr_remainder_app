import 'dart:convert';

class ZikrHadeeth {
  int id;
  String arabicText;
  String francoArabic;
  String translation;
  int repeat;
  String audio;

  ZikrHadeeth.fromJson(Map<String, dynamic> data)
      : id = data['ID'],
        arabicText = data['ARABIC_TEXT'],//utf8.decode(data['ARABIC_TEXT']),
        francoArabic = data['LANGUAGE_ARABIC_TRANSLATED_TEXT'],
        translation = data['TRANSLATED_TEXT'],
        repeat = data['REPEAT'],
        audio = data['AUDIO'];

  @override
  String toString() {
    return 'ZikrHadeeth{id: $id, arabicText: $arabicText, francoArabic: $francoArabic, translation: $translation, repeat: $repeat, audio:$audio}';
  }
}
