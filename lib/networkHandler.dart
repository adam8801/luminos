import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NetworkHandler{
  String baseurl = "https://luceroset.me";

  FlutterSecureStorage storage = FlutterSecureStorage();

  Future get(String url) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    //end point url
    var response = await http.get(url,
        headers: {"Authorization" : "Bearer $token"}
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      return json.decode(response.body);
    }else{
      return null;
    }
  }

  Future<http.Response> post(String url, Map<String,String> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.post(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> post1(String url, Map<String,String> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.post(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token", "sget" : "Marked/relative"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> postRegister(String url, Map<String,dynamic> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.post(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> postRegister1(String url, Map<String,dynamic> body, String token) async{
    url = formater(url);
    var response = await http.post(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> patch(String url, Map<String,String> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.patch(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> patchD(String url, Map<String,dynamic> body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.patch(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> patchD1(String url, Map<String,dynamic> body, String token) async{
    url = formater(url);
    var response = await http.patch(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> patchV(String url, var body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.patch(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.Response> postBlog(String url, var body) async{
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.post(
        url,
        headers: {"Content-type": "application/json", "Authorization" : "Bearer $token"},
        body: json.encode(body));
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath, contentType: MediaType('image','jpeg')));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization" : "Bearer $token"
    });
    var response = await request.send(); //may be await is not putted
    return response;
  }

  Future<http.StreamedResponse> patchImageWC(String url, String filepath, String name) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath, contentType: MediaType('image','jpeg')));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization" : "Bearer $token",
      "name" : name
    });
    var response = await request.send(); //may be await is not putted
    return response;
  }

  String formater(String url){
    return baseurl+url;
  }

  String getImageUrlPr(String name) {
    String url = formater("/profiles/$name.jpg");
    return url;
  }

  String getImageUrlPa(String name) {
    String url = formater("/pages/$name.jpg");
    return url;
  }

  String getImageUrlB(String name) {
    String url = formater("/blogs/$name.jpg");
    return url;
  }

}