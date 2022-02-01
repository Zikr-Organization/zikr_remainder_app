import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/custom_zikr.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomZikrScreen extends StatefulWidget {
   CustomZikrScreen({Key? key}) : super(key: key);

  final Color pickerColor = Color(0xff123456) ;
 // final ValueChanged<Color> onColorChanged = ;

  @override
  _CustomZikrScreenState createState() => _CustomZikrScreenState();
}

class _CustomZikrScreenState extends State<CustomZikrScreen> {

  List<CustomZikr> azkar = [CustomZikr(id:0, title: 'test', colorHex: ''),CustomZikr(id:0, title: 'test', colorHex: '')]; //TODO must be put in core data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom Zikr", textAlign: TextAlign.center,),
        ),
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/vector-2-background.jpg"),
    fit: BoxFit.cover),
        ),

    child:ListView.builder(
      itemBuilder: (_, i) => InkWell(
        child: CustomZikrRow(title: azkar[i].title, onDeletePressed: (){
          //TODO delete from core data
          //TODO delete from notification
        }, onColorPressed: (){
          print("onColor");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    pickerColor: widget.pickerColor,
                    onColorChanged: (color){
                      print("color = ${color.toString()}");
                      setState(() {
                        azkar[i].colorHex = color.toString();
                      });
                    },
                    enableLabel: true,
                    portraitOnly: false,
                  ),
                ),
              );
            },
          );
        }),
      ),
      itemCount: azkar.length,
    ),
        ),
    );
  }
}

class CustomZikrRow extends StatelessWidget {
  const CustomZikrRow({required this.title, required this.onDeletePressed, required this.onColorPressed});
  final String title;
  final VoidCallback onDeletePressed;
  final VoidCallback onColorPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0x20ffffff),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                          border: Border.all(
                            color: Theme.of(context).primaryColorDark,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))

                      ),
                      //color: Theme.of(context).primaryColorDark,
                      child: Text("  ${title}  ",),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                  child :Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      IconButton(onPressed: onColorPressed, icon: Image.asset("images/icons8-color-wheel-96.png"), iconSize: 30,),
                      IconButton(onPressed: onDeletePressed, icon: Image.asset("images/icons8-cancel-90.png"), iconSize: 30,),
                    ],
                  ),
              ),
                ],
              ),

      ),
    );
  }
}
