import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class SearchImageClient {
  Future searchImage(String image);
}

class SearchImageApi extends SearchImageClient{
  static const searchEndpoint = "/predict";
  static final _client = http.Client();
  static var _loginUrl = Uri.parse('http://192.168.3.12:5000/predict');
  @override
  Future searchImage(String image) async{
    http.Response response = await _client.post(_loginUrl,headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode(image));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      String result = jsonDecode(response.body)['result'];
      print(result);
      return result;

    } else {
      // await EasyLoading.showError(
      //     "Error Code : ${response.statusCode.toString()}");
    }


  }
}