import 'package:location/location.dart';
class UserLocation {
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  Future<LocationData?> getUserLocation() async{
    Location loc=Location();
    _serviceEnabled = await loc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await loc.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
      _permissionGranted = await loc.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await loc.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    final LocationData locationData = await loc.getLocation();
    return locationData;
  }
  
}