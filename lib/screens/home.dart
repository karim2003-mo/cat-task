import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:prayer/backend/getprayer.dart';
import 'package:prayer/backend/location.dart';
import 'package:prayer/backend/locationname.dart';
import 'package:prayer/local%20storage/local_data.dart';
import 'package:prayer/sizes/size1.dart';
import 'package:prayer/widgets/widgets.dart';
class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}
class HomeState extends State<StatefulWidget>{ 
  // define the class of all sizes from type 1
  late Size1 size1;
  // get object from the class of location of latitude and longitude
  final LocationName loc_name=LocationName();
  // get object from the class which contains the function to get the prayer time
  final GetPrayerTime get_prayer=GetPrayerTime();
  // define the current time object
  late DateTime currentTime;
  // define the object of the class of longitude and latitude
  UserLocation location_point=UserLocation();
  static String ? loc ;
  LocationData ? location_data ;
  // define the map of the prayer times
  Map<String,dynamic> ? prayer_data;
  // define the map of the remaining time to the prayer (hours,minutes,prayer)
  Map<String,dynamic> remain_time={};
  late Timer _timer ;
  final Widgets _wdgt=Widgets();
  //define the class of shared preferences
  LocalData localData=LocalData();
  void fetch_data() async{
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (!locationStatus.enabled) {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enable location services to proceed."),
        ),
      );
    }
     await loc_name.getLocationName().then((value){
      setState(() {
        loc=value;
      });
    });
    await location_point.getUserLocation().then((value){
        location_data=value;
    });
    await get_prayer.gettime("${currentTime.day}-${currentTime.month}-${currentTime.year}",location_data!.latitude.toString(),location_data!.longitude.toString(),"5").then((value){
      if(value!="error"){
        Map<String,dynamic> mp=jsonDecode(value);
      setState(() {
        prayer_data=mp['data']['timings'];
        for(String key in prayer_data!.keys){
          remain_time= remain_time_to_prayer(currentTime.hour, currentTime.minute, int.parse(convert_to_int()['hours']![key].toString()), int.parse(convert_to_int()['minutes']![key].toString()),key);
          if(remain_time.isNotEmpty){
            break;
          }
        }
    });
    localData.add_data("prayersdata",value);
    localData.add_data("country",loc!);
    print("data added successfully!");
      }else{
        if(localData.is_key_exist("prayersdata")==false){
          localData.get_data("prayersdata").then((value){
            Map<String,dynamic> mp=jsonDecode(value!);
            setState(() {
              prayer_data=mp['data']['timings'];
              for(String key in prayer_data!.keys){
                remain_time= remain_time_to_prayer(currentTime.hour, currentTime.minute, int.parse(convert_to_int()['hours']![key].toString()), int.parse(convert_to_int()['minutes']![key].toString()),key);
                if(remain_time.isNotEmpty){
                  break;
                }
              }
          });
          });
        }
      }
    });
  }
  @override
  void initState(){
    super.initState();
    currentTime = DateTime.now();
    fetch_data();
    update_time();
  }
  @override
  Widget build(BuildContext context) {
    
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    size1=Size1(screenwidth,screenheight);
    return Scaffold(
      
      appBar: AppBar(
      
      backgroundColor: Colors.grey[100],
      title: Text((loc==null)?"loading...":"$loc",style: GoogleFonts.montserrat(fontSize: 30,fontWeight: FontWeight.w700),),
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
        child:(prayer_data!=null)?
Column(
  children: [
    Padding(
      padding: EdgeInsets.fromLTRB(size1.std_padding_left!, size1.std_padding_top!,size1.std_padding_right!, size1.std_padding_bottom!),
      child: Container(
        height: size1.std_container_height,
        width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(20),
      ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size1.std_padding_horizontal!*0.8),
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${remain_time['pryer'].toString()} in", style: GoogleFonts.montserrat(fontSize: (0.9* size1.std_font_size!),fontWeight: FontWeight.w500),),
              Text("${remain_time['hours'].toString()}Hours ${remain_time['minutes'].toString()}Minutes", style: GoogleFonts.montserrat(fontSize: (0.9* size1.std_font_size!),fontWeight: FontWeight.w700),),
            ],
          )),
        ),
    )),
    Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0.2*size1.std_padding_top!, 0, 0),
        child: ListView.builder(
          itemCount: (prayer_data!=null)?prayer_data!.length:0,
          itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: size1.std_padding_vertical!*0.3,horizontal: size1.std_padding_horizontal!*2),
            child: container(prayer_data!.keys.toList()[index],prayer_data!.values.toList()[index],size1.std_font_size!,remain_time['pryer'].toString()),
          );
        }),
      ),
    ),
  ],
):CircularProgressIndicator()
      ),
      endDrawer: _wdgt.RightSlider(context,screenwidth,screenheight),
    );
  }
/// it returns the container of the prayer time
Widget container(String prayer ,String time,double fontsize,String current){
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color:(current==prayer)? Colors.grey[500]:Colors.grey[300],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prayer,style: GoogleFonts.montserrat(fontSize: fontsize,fontWeight: FontWeight.w700),),
          Text(time,style: GoogleFonts.montserrat(fontSize: fontsize,fontWeight: FontWeight.w700),),
        ],
      ),
    ),
  );
}
/// it updates the time which remains for prayer every minute
void update_time(){
   _timer=Timer.periodic(Duration(minutes: 1), (timer) {
      currentTime=DateTime.now();
      for(String key in prayer_data!.keys){
          remain_time= remain_time_to_prayer(currentTime.hour, currentTime.minute, int.parse(convert_to_int()['hours']![key].toString()), int.parse(convert_to_int()['minutes']![key].toString()),key);
          if(remain_time.isNotEmpty){
            break;
          }
        }
    if (mounted){
      setState(() {
        
      });
    }
  });
}
/// it converts time to int(hour) and int(minute)
Map<String , Map<String,int>> convert_to_int(){
  Map<String,int> mpHours={};
  Map<String,int> mpMinutes={};
  for(String key in prayer_data!.keys){
    List<String> time=prayer_data![key].split(":");
    mpHours[key]=int.parse(time[0]);
    mpMinutes[key]=int.parse(time[1]);
  }
  return {"hours":mpHours,"minutes":mpMinutes};
}
/// it returns the remaining time to the prayer as Map<String,dynamic>=
/// {hours:hour,minutes:minute,prayer:prayer}
Map<String,dynamic> remain_time_to_prayer(int currenthour,int currentminute,int prayerhour,int prayerminute,String prayer){
  if(currenthour<prayerhour){
    if(currentminute<prayerminute){
    return {
      "pryer":prayer,
      "hours":prayerhour-currenthour,
      "minutes":prayerminute-currentminute
    };
    }
    else{
          return {
      "pryer":prayer,
      "hours":prayerhour-currenthour-1,
      "minutes":prayerminute-currentminute+60
    };
    }
  }
  else if(currenthour==prayerhour){
    if(currentminute<prayerminute){
      return {
      "pryer":prayer,
      "hours":prayerhour-currenthour,
      "minutes":prayerminute - currentminute
    };
    }
    else{
      return {};
    }
  }
  else{
  return {};
}
}
@override
  void dispose(){
  super.dispose();
  _timer.cancel();
}
}
