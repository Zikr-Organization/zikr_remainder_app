import 'dart:convert';

import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:http/http.dart' as http;
import 'package:zikr_remainder_app/models/zikr_model.dart';

const HISNAL_MUSLIM_API_BASE = 'http://www.hisnmuslim.com/api/en/';

main() async {
  final val = await getZikrList(27);
  val.forEach((element) {
    print(element);
  });
}

Future<List<ZikrCategory>> get allZikrCategories async {
  final data = await getDataFromAPI(HISNAL_MUSLIM_API_BASE + 'husn_en.json');
  var tempZikrCategory = (data['English'] as List<dynamic>)
      .map((e) => ZikrCategory.fromJson(e))
      .toList();

  tempZikrCategory.insert(0, ZikrCategory(270,"Words of remembrance for morning","http://www.hisnmuslim.com/api/en/27.json"));

  tempZikrCategory[1].id = 271;
  tempZikrCategory[1].title = "Words of remembrance for evening";
  print(tempZikrCategory[0]);
  print(tempZikrCategory[1]);
  return tempZikrCategory;
}

Future<List<ZikrHadeeth>> getZikrList(int id) async {
  final newId = (id != 270 && id != 271) ? id : 27;
  final data = await getDataFromAPI(HISNAL_MUSLIM_API_BASE + '$newId.json');
  List<ZikrHadeeth> zikrList = ((data.values.first as List<dynamic>).map((e) => ZikrHadeeth.fromJson(e)).toList());

  return ((id != 270 && id != 271) ? zikrList : getMorningOrEvening(zikrList, id));
}

Future<Map<String, dynamic>> getDataFromAPI(String url) async {
  if (url == HISNAL_MUSLIM_API_BASE + 'husn_en.json'){
    final res = await http.Client().get(Uri.parse(url));

    return jsonDecode(res.body.replaceAll('ï»¿', ''));
  }
  else{
    final res = await http.Client().get(Uri.parse(url));
    ///first decode the response to utf-8 string
    var myDataString = utf8.decode(res.bodyBytes);
    ///obtain json from string
    var myDataJson = jsonDecode(myDataString);
    return myDataJson;
  }
}
List<ZikrHadeeth> getMorningOrEvening(List<ZikrHadeeth> both, int id){
  List<ZikrHadeeth> returnedZikr = both;
  if (id == 270){
    returnedZikr[2].arabicText = "((أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ ، وَالْحَمْدُ لِلَّهِ، لاَ إِلَهَ إلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيرَ مَا بَعْدَهُ ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي  هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ)).";
    returnedZikr[2].francoArabic = "(Asbahna wa-asbahal-mulku lillah walhamdu lillah la ilaha illal-lah, wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shayin qadeer, rabbi as-aluka khayra ma fee hathal-yawmee, wakhayra ma baAAdahoo, wa-aAAoothu bika min sharri ma fee hathal-yawmee, washarri ma baAAdahoo, rabbi aAAoothu bika minal-kasal, wasoo-il kibar, rabbi aAAoothu bika min AAathabin fin-nar, waAAathabin fil-qabr).";
    returnedZikr[2].translation = "‘We have reached the morning and at this very time unto Allaah, belongs all sovereignty , and all praise is for Allaah. None has the right to be worshipped except Allaah, alone, without any partner, to Him belong all sovereignty and praise and He is over all things omnipotent. My Lord, I ask You for the good of this day and the good of what follows it and I take refuge in You from the evil of this day and the evil of what follows it . My Lord, I take refuge in You from laziness and senility. My Lord, I take refuge in You from torment in the Fire and punishment in the grave.’";

    returnedZikr[3].arabicText = "((اللَّهُمَّ بِكَ أَصْبَحْنَا، وَبِكَ أَمْسَيْنَا ، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ النُّشُورُ.))";
    returnedZikr[3].francoArabic = "(Allahumma bika asbahna wabika amsayna, wabika nahya ,wabika namootu wa-ilaykan-nushoor.)";
    returnedZikr[3].translation = "(O Allah, by your leave we have reached the morning and by Your leave we have reached the evening, by Your leave we live and die and unto You is our resurrection.)";

    returnedZikr[5].arabicText = "((اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلاَئِكَتِكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ))";
    returnedZikr[5].francoArabic = "(Allahumma innee asbahtu oshhiduk, wa-oshhidu hamalata AAarshik, wamala-ikatak, wajameeAAa khalqik, annaka antal-lahu la ilaha illa ant, wahdaka la shareeka lak, wa-anna Muhammadan AAabduka warasooluk .)";
    returnedZikr[5].translation = "(O Allah, verily I have reached the morning and call on You, the bearers of Your throne, Your angles, and all of Your creation to witness that You are Allah, none has the right to be worshipped except You, alone, without partner and that Muhammad is Your Servant and Messenger.)";

    returnedZikr[6].arabicText = "((اللَّهُمَّ مَا أَصْبَحَ بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ)).";
    returnedZikr[6].francoArabic = "(Allahumma ma asbaha bee min niAAmatin, aw bi-ahadin min khalqik, faminka wahdaka la shareeka lak, falakal-hamdu walakash-shukr.)";
    returnedZikr[6].translation = "(O Allah, what blessing I or any of Your creation have risen upon, is from You alone, without partner, so for You is all praise and unto You all thanks.)";

    returnedZikr[14].arabicText = "((أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُـمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذَا الْيَوْمِ:فَتْحَهُ، وَنَصْرَهُ، وَنورَهُ، وَبَرَكَتَهُ، وَهُدَاهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيهِ وَشَرِّ مَا بَعْدَهُ)).";
    returnedZikr[14].francoArabic = "(Asbahna wa-asbahal-mulku lillahi rabbil-AAalameen, allahumma innee as-aluka khayra hathal-yawm, fat-hahu, wanasrahu, wanoorahu, wabarakatahu, wahudahu, wa-aAAoothu bika min sharri ma feehi, washarri ma baAAdah.)";
    returnedZikr[14].translation = "(We have reached the morning and at this very time all sovereignty belongs to Allah, Lord of the worlds. O Allah, I ask You for the good of this day, its triumphs and its victories, its light and its blessings and its guidance, and I take refuge in You from the evil of this day and the evil that follows it.)";

    returnedZikr[15].arabicText = "((أَصْبَحْنا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صلى الله عليه وسلم، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشرِكِينَ.))";
    returnedZikr[15].francoArabic = "(Asbahna AAala fitratil-islam, waAAala kalimatil-ikhlas, waAAala deeni nabiyyina Muhammad  waAAala millati abeena Ibraheem, haneefan musliman wama kana minal-mushrikeen.)";
    returnedZikr[15].translation = "(We rise upon the fitrah of Islam, and the word of pure faith, and upon the religion of our Prophet Muhammad  and the religion of our forefather Ibraheem, who was a Muslim and of true faith and was not of those who associate others with Allah.)(fitrah: the religion of Islam, the way of Ibraheem u.)";

    returnedZikr.removeAt(22);
  }
  else{
    returnedZikr[2].arabicText = "((أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ لَا إِلَهَ إِلَّا اللهُ، وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذِهِ اللَّيْلَةِ وَخَيْرَ مَا بَعْدَهَا، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذِهِ اللَّيْلَةِ وَشَرِّ مَا بَعْدَهَا، رَبِّ أَعُوذُ بِكَ مِنَ الْكَسَلِ وَسُوءِ الْكِبَرِ، رَبِّ أَعُوذُ بِكَ مِنْ عَذَابٍ فِي النَّارِ وَعَذَابٍ فِي الْقَبْرِ))";
    returnedZikr[2].francoArabic = "Amsayna wa-amsal-mulku lillah walhamdu lillah la ilaha illal-lah, wahdahu la shareeka lah, lahul-mulku walahul-hamd, wahuwa AAala kulli shayin qadeer, rabbi as-aluka khayra ma fee hathihil-laylah, wakhayra ma baAAdaha, wa-aAAoothu bika min sharri ma fee hathihil-laylah, washarri ma baAAdaha, rabbi aAAoothu bika minal-kasal, wasoo-il kibar, rabbi aAAoothu bika min AAathabin fin-nar, waAAathabin fil-qabr.";
    returnedZikr[2].translation = "‘We have reached the night and at this very time unto Allaah, belongs all sovereignty , and all praise is for Allaah. None has the right to be worshipped except Allaah, alone, without any partner, to Him belong all sovereignty and praise and He is over all things omnipotent. My Lord, I ask You for the good of this night and the good of what follows it and I take refuge in You from the evil of this night and the evil of what follows it . My Lord, I take refuge in You from laziness and senility. My Lord, I take refuge in You from torment in the Fire and punishment in the grave.’";

    returnedZikr[3].arabicText = "((اللَّهُمَّ بِكَ أَمْسَيْنَا، وَبِكَ أَصْبَحْنَا ، وَبِكَ نَحْيَا، وَبِكَ نَمُوتُ وَإِلَيْكَ المَصيرُ.))";
    returnedZikr[3].francoArabic = "(Allahumma bika amsayna, wabika asbahna, wabika nahya wabika namootu wa-ilaykal-maseer.)";
    returnedZikr[3].translation = "(O Allah, by Your leave we have reached the evening and by Your leave we have reached the morning, by Your leave we live and die and unto You is our return.)";

    returnedZikr[5].arabicText = "((اللَّهُمَّ إِنِّي أَمْسَيْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلاَئِكَتِكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلاَّ أَنْتَ وَحْدَكَ لاَ شَرِيكَ لَكَ، وَأَنَّ مُحَمَّداً عَبْدُكَ وَرَسُولُكَ))";
    returnedZikr[5].francoArabic = "(Allahumma innee amsaytu oshhiduk, wa-oshhidu hamalata AAarshik, wamala-ikatak, wajameeAAa khalqik, annaka antal-lahu la ilaha illa ant, wahdaka la shareeka lak, wa-anna Muhammadan AAabduka warasooluk .)";
    returnedZikr[5].translation = "(O Allah, verily I have reached the evening and call on You, the bearers of Your throne, Your angles, and all of Your creation to witness that You are Allah, none has the right to be worshipped except You, alone, without partner and that Muhammad is Your Servant and Messenger.)";

    returnedZikr[6].arabicText = "((اللَّهُمَّ مَا أَمْسَى بِي مِنْ نِعْمَةٍ أَوْ بِأَحَدٍ مِنْ خَلْقِكَ فَمِنْكَ وَحْدَكَ لاَ شَرِيكَ لَكَ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ)).";
    returnedZikr[6].francoArabic = "(Allahumma ma amsa bee min niAAmatin, aw bi-ahadin min khalqik, faminka wahdaka la shareeka lak, falakal-hamdu walakash-shukr.)";
    returnedZikr[6].translation = "(O Allah, what blessing I or any of Your creation have risen upon, is from You alone, without partner, so for You is all praise and unto You all thanks.)";

    returnedZikr[14].arabicText = "((أَمْسَيْنَا وَأَمْسَى الْمُلْكُ لِلَّهِ رَبِّ الْعَالَمِينَ، اللَّهُـمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذِهِ اللَّيْلَةِ:فَتْحَها، وَنَصْرَها، وَنورَها، وَبَرَكَتَها، وَهُدَاها، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِيها وَشَرِّ مَا بَعْدَها.))";
    returnedZikr[14].francoArabic = "(Amsayna wa-amsal-mulku lillahi rabbil-AAalameen, allahumma innee as-aluka khayra hathihil-laylah, fat-haha, wanasraha, wanooraha, wabarakataha, wahudaha, wa-aAAoothu bika min sharri ma feeha washarri ma baAAdaha.)";
    returnedZikr[14].translation = "(We have reached the evening and at this very time all sovereignty belongs to Allah, Lord of the worlds. O Allah, I ask You for the good of tonight, its triumphs and its victories, its light and its blessings and its guidance, and I take refuge in You from the evil of tonight and the evil that follows it.)";

    returnedZikr[15].arabicText = "((أَمْسَيْنا عَلَى فِطْرَةِ الْإِسْلاَمِ، وَعَلَى كَلِمَةِ الْإِخْلاَصِ، وَعَلَى دِينِ نَبِيِّنَا مُحَمَّدٍ صلى الله عليه وسلم، وَعَلَى مِلَّةِ أَبِينَا إِبْرَاهِيمَ، حَنِيفاً مُسْلِماً وَمَا كَانَ مِنَ الْمُشرِكِينَ.))";;
    returnedZikr[15].francoArabic = "(Amsayna AAala fitratil-islam, waAAala kalimatil-ikhlas, waAAala deeni nabiyyina Muhammad  waAAala millati abeena Ibraheem, haneefan musliman wama kana minal-mushrikeen.)";
    returnedZikr[15].translation = "(We have reached the evening upon the fitrah of Islam, and the word of pure faith, and upon the religion of our Prophet Muhammad  and the religion of our forefather Ibraheem, who was a Muslim and of true faith and was not of those who associate others with Allah.)(fitrah: the religion of Islam, the way of Ibraheem u.)";

    returnedZikr.removeAt(19);
    returnedZikr.removeAt(19);
  }

  return returnedZikr;
}
