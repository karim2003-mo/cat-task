import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer/local%20storage/local_data.dart';
import 'package:prayer/sizes/size1.dart';

class Widgets extends StatelessWidget {
  const Widgets({super.key});
  /// this function returns the right slider of the drawer
  Widget RightSlider(BuildContext context,double screenwidth,double screenheight){
    Size1 size1=Size1(screenwidth,screenheight);
  return Drawer(backgroundColor:Colors.white,
      child: ListView(

        children: [
          DrawerHeader(
            
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            
            child: Center(child: Text("Prayer Panel",style: GoogleFonts.montserrat(fontSize: size1.std_font_size,fontWeight: FontWeight.w700),)),
          ), 
          ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!,horizontal: size1.std_padding_horizontal!*0.25),
              title: Row(
                children: [
                  SvgPicture.asset("assets/images/direction.svg",height: size1.std_container_height!*0.1,width: size1.std_container_width!*0.2,),
                  Expanded(child: Text("Qibla Direction",style: GoogleFonts.montserrat(fontSize: 2/3 *size1.std_font_size!,fontWeight: FontWeight.w700),)),
                ],
              ),
              onTap: (){
                final route=ModalRoute.of(context)!.settings.name;
                print("we are in ${route}");
                Navigator.of(context).pop();
                if(route=="/qibla"){
                  return ;
                }
                Navigator.of(context).pushNamed("/qibla");
              },
            ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!,horizontal: size1.std_padding_horizontal!*0.25),
            title: Row(
              children: [
                SvgPicture.asset("assets/images/scheduale.svg",height: size1.std_container_height!*0.1,width: size1.std_container_width!*0.2,),
                Expanded(child: Text("Prayer schedule",style: GoogleFonts.montserrat(fontSize: 2/3 *size1.std_font_size!,fontWeight: FontWeight.w700),)),
              ],
            ),
            onTap: (){
              final route=ModalRoute.of(context)!.settings.name;
              print("*we are in ${route}");
              if(route=="/home"){
                Navigator.of(context).pop();
                return ;
              }
              Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (Route<dynamic> route) => false
                );
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!,horizontal: size1.std_padding_horizontal!*0.25),
            title: Row(
              children: [
                Icon(Icons.settings,color: Colors.black,),
                Expanded(child: Text("Setting",style: GoogleFonts.montserrat(fontSize: 2/3 *size1.std_font_size!,fontWeight: FontWeight.w700),)),
              ],
            ),
            onTap: () async{
              LocalData localData=LocalData();
              final data=await localData.get_data("prayersdata");
              print(data);
              final route=ModalRoute.of(context)!.settings.name;
              Navigator.of(context).pop();
              if(route=="/settings"){
                return ;
              }
              Navigator.of(context).pushNamed("/settings");
            },
          ),
        ],)
      );
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}