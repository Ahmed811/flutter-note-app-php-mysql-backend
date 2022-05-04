import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Connect {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        print("${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      print(url);
      var response = await http.post(Uri.parse(url), body: data);
      //    print(response.body);
      // print("response.statusCode is${response.statusCode})");

      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);
        //  print(result);
        return result;
      } else {
        //  print("${response.statusCode}");
      }
    } catch (e) {
      print("error catch $e");
    }
    return "";
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error upload note with image with ${myrequest.statusCode}');
    }
  }
}
