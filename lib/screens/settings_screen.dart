import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer/screens/home.dart';
import 'package:prayer/sizes/size1.dart';
import 'package:prayer/widgets/widgets.dart';

class Settings extends StatelessWidget{
   Settings({super.key});
  final Widgets _wdgt=Widgets();
  late final  Size1 size1;

  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    size1=Size1(screenwidth,screenheight);
    return Scaffold(
      endDrawer: _wdgt.RightSlider(context,screenwidth,screenheight),
      appBar: AppBar(
      
        backgroundColor: Colors.grey[100],
      title: Text((HomeState.loc==null)?"loading...":"${HomeState.loc}",style: GoogleFonts.montserrat(fontSize: 30,fontWeight: FontWeight.w700),),
       actions: [Padding(
         padding: const EdgeInsets.all(8.0),
         child:Builder(
           builder: (context) {
             return InkWell(onTap: (){
                Scaffold.of(context).openEndDrawer();
             },child: Icon(Icons.menu,size: 40,));
           }
         ),
       ),]
      
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!,horizontal: size1.std_padding_horizontal!*0.25),
              title: Row(
                children: [
                  Icon(Icons.integration_instructions,size: size1.std_container_height!*0.35,),
                  Expanded(child: Text("Instructions",style: GoogleFonts.montserrat(fontSize: 1.5 *size1.std_font_size!,fontWeight: FontWeight.w700),)),
                ],
              ),
              onTap: (){
                dialouge(context);
              },
            ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!,horizontal: size1.std_padding_horizontal!*0.25),
            title: Row(
              children: [
               Icon(Icons.exit_to_app,size: size1.std_container_height!*0.35,),
                Expanded(child: Text("Exit",style: GoogleFonts.montserrat(fontSize:1.5*size1.std_font_size!,fontWeight: FontWeight.w700),)),
              ],
            ),
            onTap: (){
              SystemNavigator.pop();
            },
          ),
          ],
        ),
      ),
    );
  }
dialouge(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Instructions",style: GoogleFonts.montserrat(fontSize: 0.8*size1.std_font_size!,fontWeight: FontWeight.w700),),
      content: Text("""when you determine qibla direction , you shoud make phone horizontal and change your direction slowly until the arrow refer to kaaba""",style: GoogleFonts.montserrat(fontSize: 0.5*size1.std_font_size!,fontWeight: FontWeight.w500),),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("OK",style: GoogleFonts.montserrat(fontSize: 0.6*size1.std_font_size!,fontWeight: FontWeight.w700),))
      ],
    );
  });
} 
}