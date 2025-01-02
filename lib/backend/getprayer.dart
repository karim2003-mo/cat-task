// https://api.aladhan.com/v1/timings/23-12-2024?latitude=30.766942&longitude=31.3451589
// https://api.aladhan.com/v1/timings/23-12-2024?latitude=30.766942&longitude=31.3451589&method=5
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
class GetPrayerTime{
    Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  }
  return false;
}
    Future<String> gettime(String date,String latitude,String longitude,String method) async{
        var url = Uri.parse('https://api.aladhan.com/v1/timings/$date?latitude=$latitude&longitude=$longitude&method=$method');
        var connection=await checkInternetConnection();
        if(connection==false){
          return "error";
        }
        var response = await http.get(url);
        if (response.statusCode == 200) {
        return response.body;
        } else {
        return "error";
        }
    }
}