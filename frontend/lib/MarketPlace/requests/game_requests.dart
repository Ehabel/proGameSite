


import 'dart:convert';

import '../../Account/widget/rating_star.dart';
import '../../DashBoard/models/token_storage.dart';
import '../../utils/requests.dart';
import '../../utils/urls.dart';
import '../models/gamepro_model.dart';
import 'package:http/http.dart' as http;

typedef GameModelValue = void Function(GameModel);
class GetGamePro {
  String gameName;
  final GameModelValue callBackGamePro;
  final IntValue callBackError;

  GetGamePro({
    required this.gameName,
    required this.callBackGamePro,
    required this.callBackError,
  }) {
    getUserAccountInfo();
  }

  Future<String> getUserAccountInfo() async {
    try{
      final request = http.MultipartRequest(
          AppRequests.get, Uri.parse("${AppUrls.base}${"pwf/$gameName/Details"}"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      GameModel gameModel = GameModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        callBackGamePro(gameModel);
        return response.body;
      }
    } catch(error){
      callBackError(404);
      return "Failed";
    }
    return "Failed";
  }
}