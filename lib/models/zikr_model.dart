class Zikr {
  int id;
  String arabicText;
  String translation;
  int repeat;

  Zikr.fromJson(Map<String, dynamic> data)
      : id = data['ID'],
        arabicText = data['ARABIC_TEXT'],
        translation = data['TRANSLATED_TEXT'],
        repeat = data['REPEAT'];

  @override
  String toString() {
    return 'Zikr{id: $id, arabicText: $arabicText, translation: $translation, repeat: $repeat}';
  }
}
