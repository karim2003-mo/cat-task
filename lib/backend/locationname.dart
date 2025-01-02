import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:prayer/backend/location.dart';
import 'package:prayer/local%20storage/local_data.dart';
class LocationName{
      Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi))  {
    return true;
  }
  return false;
}
  final UserLocation lat_long=UserLocation();
  Future<String> getLocationName() async{
    var connection=await checkInternetConnection();
    if(connection==false){
      LocalData localData=LocalData();
      final loc = await localData.get_data("country");
      return  loc! ;
    }
    LocationData? locationData=await lat_long.getUserLocation();
    List<Placemark> placemarks = await placemarkFromCoordinates(locationData!.latitude!, locationData.longitude!);
    Placemark placeMark = placemarks[0];
    String name=placeMark.country!;
    return name;
  }
}