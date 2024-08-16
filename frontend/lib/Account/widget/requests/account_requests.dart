import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:charles_warburton/Account/widget/models/game_selection.dart';
import 'package:charles_warburton/Account/widget/models/pro_model.dart';
import 'package:charles_warburton/Account/widget/models/user_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../DashBoard/models/token_storage.dart';
import '../../../DashBoard/requests/dashboard_requests.dart';
import '../../../utils/requests.dart';
import '../../../utils/urls.dart';

typedef UserModelValue = void Function(UserModel);
class GetUser {
  final UserModelValue callBackUser;
  final IntValue callBackError;

  GetUser({
    required this.callBackUser,
    required this.callBackError,
  }) {
    getUserAccountInfo();
  }

  Future<String> getUserAccountInfo() async {
    try{
      final request = http.MultipartRequest(
          AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.account}"));
      String? token = await TokenStorage().extractToken();
      String? email = await TokenStorage().extractEmail();
      request.headers['Content-type'] =
      'application/x-www-form-urlencoded; charset=UTF-8';
      request.headers['Authorization'] = token!;
      request.fields['email'] = email!;
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      UserModel userModel = UserModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        callBackUser(userModel);
        return response.body;
      }
    } catch(error){
      return "Failed";
    }
    return "Failed";
  }
}

typedef ProModelValue = void Function(ProModel);
class GetPro {
  late int proProfilePk;
  final ProModelValue callBackProProfile;
  final IntValue callBackError;

  GetPro({
    required this.proProfilePk,
    required this.callBackProProfile,
    required this.callBackError,
  }) {
    GetProProfile();
  }

  Future<String> GetProProfile() async {
    try{
      final request = http.MultipartRequest(
          AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.getProAccount}${proProfilePk}"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      ProModel proModel = ProModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        callBackProProfile(proModel);
        return response.body;
      }
    } catch(error){
      return "Failed";
    }
    return "Failed";
  }
}

typedef GameModelValue = void Function(GameSelectionModel);
class GetAllGames {
  final GameModelValue callBackAllGamesSelection;
  final IntValue callBackError;

  GetAllGames({
    required this.callBackAllGamesSelection,
    required this.callBackError,
  }) {
    getGames();
  }

  Future<String> getGames() async {
    try{
      final request = http.MultipartRequest(
          AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.getAllGames}"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      GameSelectionModel userModel = GameSelectionModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        callBackAllGamesSelection(userModel);
        return response.body;
      }
    } catch(error){
      return "Failed";
    }
    return "Failed";
  }
}

class AccountRequests{

  static Future<String> getUserAccountImage() async {
    try {
      final request = http.MultipartRequest(
          AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.userImage}"));
      String? token = await TokenStorage().extractToken();
      String? email = await TokenStorage().extractEmail();
      request.headers['Content-type'] =
      'application/x-www-form-urlencoded; charset=UTF-8';
      request.headers['Authorization'] = token!;
      request.fields['email'] = email!;
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      }else{
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }

  static Future<String?> addUserImage(ImageSource media) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? pickedFile = await _picker.pickImage(source: media);
      Uint8List imageBytes = await pickedFile!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      var request = http.MultipartRequest(
          'PATCH', Uri.parse("${AppUrls.base}${AppUrls.addImage}"));
      String? token = await TokenStorage().extractToken();
      String? email = await TokenStorage().extractEmail();
      request.headers['Authorization'] = token!;
      request.fields['email'] = email!;
      request.files.add(
        http.MultipartFile.fromBytes('file', imageBytes,
            filename: "${pickedFile.path.split('/').last}.png"),
      );
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
      return "Failed!";
    }
  }

  static Future<String> becomeAPro() async {
    try {
      final request = http.MultipartRequest(
          AppRequests.patch, Uri.parse("${AppUrls.base}${AppUrls.becomePro}"));
      String? token = await TokenStorage().extractToken();
      String? email = await TokenStorage().extractEmail();
      request.headers['Content-type'] =
      'application/x-www-form-urlencoded; charset=UTF-8';
      request.headers['Authorization'] = token!;
      request.fields['email'] = email!;
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return "Became a pro!";
      }else{
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }

  static String getRelativePath(String url) {
    if (url.contains('/')) {
      int index = url.indexOf('assets/');
      if (index != -1) {
        return url.substring(index);
      } else {
        return "";
      }
    } else {
      List<String> pathSegments = url.split(RegExp(r"\\+"));
      int index = pathSegments.indexOf("assets");
      if (index != -1) {
        List<String> relativeSegments = pathSegments.sublist(index);
        return relativeSegments.join("/");
      } else {
        return "";
      }
    }
  }

  static Future<String> editBio(String text) async {
    try{
      final request = http.MultipartRequest(
          AppRequests.patch, Uri.parse("${AppUrls.base}${AppUrls.userDesc}"));
      String? token = await TokenStorage().extractToken();
      String? email = await TokenStorage().extractEmail();
      request.headers['Content-type'] =
      'application/x-www-form-urlencoded; charset=UTF-8';
      request.headers['Authorization'] = token!;
      request.fields['email'] = email!;
      request.fields['description'] = text;
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch(error){
      return "Failed";
    }
    return "Failed";
  }

  static Future<String> putGame({required gamePk, required callBackGameAdded, required callBackError, required gameName}) async {
    try {
      final url = Uri.parse("${AppUrls.base}${AppUrls.putProGame}");
      final headers = {'Content-Type': 'application/json'};
      String? email = await TokenStorage().extractEmail();
      Map<String, dynamic> requestBody = {
        "gameName": gameName,
        "userEmails": ["$email"],
      };

      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (error) {
      return "Failed";
    }
    return "Failed";
  }

}
