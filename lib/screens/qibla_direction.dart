
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prayer/screens/home.dart';
import 'package:prayer/sizes/size1.dart';
import 'package:prayer/widgets/widgets.dart';

class QiblaDirection extends StatefulWidget {
  const QiblaDirection({super.key});

  @override
  State<StatefulWidget> createState() => QiblaDirectionState();
}

class QiblaDirectionState extends State<QiblaDirection> {
bool _isequal = false;
late Size1  size ;
final Widgets _wdgt=Widgets();
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    size = Size1( screenwidth,screenheight);
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
        child: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
        
            final qiblahDirection = snapshot.data;

            if (qiblahDirection == null) {
              return Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Unable to fetch Qibla direction",style: GoogleFonts.montserrat(color: Colors.black,fontSize: size.std_font_size!*0.6),),
                  Text("Please make sure you have enabled location services and try again",style:GoogleFonts.montserrat(color: Colors.black,fontSize: size.std_font_size!*0.6)),
                  SizedBox(height: size.std_padding_top,),
                ],
              ));
            }
            if(qiblahDirection.direction>(qiblahDirection.offset-4) && qiblahDirection.direction<(qiblahDirection.offset+4)){
                _isequal = true;
            }else{
                _isequal = false;

            }
        
            return  Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(195)),
              color: Color.fromRGBO(72, 50, 50, 0.7),
              border :(_isequal)?Border.all(width: 3, color: Colors.green):Border()
              ),
              width: 0.95*screenwidth,
              height: 0.95*screenwidth,
              child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(top:-20 , left:screenwidth/2.6, child:
                    Transform.scale(
  scale: screenwidth/768,
  child: SvgPicture.asset(
    'assets/images/kabba.svg',
  ),
)
                    ),
                    Transform.rotate(
                      angle: (qiblahDirection.direction * (pi / 180) * -1),
                      child: SizedBox(
    width:0.6510 *screenwidth,
    child: SvgPicture.asset('assets/images/Star 1.svg',width: 400,)),
                    ),
                    (_isequal)?Positioned(
                      top:  0.1302*screenwidth,
                      left: 0.4479*screenwidth,
                      child:Transform.rotate(angle:0+pi/30 ,child:
                      Transform.scale(
  scale: 576/screenwidth,
  child: SvgPicture.asset(
    'assets/images/arrow.svg',
  ),
)
                      ),
                    ):Container(),
                    Center(child:Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: Color.fromRGBO(15, 42, 88, 1)),
                    )
                    ,),
                  ],
                ),
            );
          },
        ),
      ),
    );
  }
}
