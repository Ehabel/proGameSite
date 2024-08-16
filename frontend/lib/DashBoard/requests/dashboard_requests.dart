


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:charles_warburton/utils/api.dart';
import 'package:charles_warburton/utils/requests.dart';
import 'package:charles_warburton/utils/urls.dart';
import 'package:http/http.dart' as http;

import '../models/login_model.dart';
import '../models/popular_games_model.dart';
import '../models/signup_model.dart';

typedef VoidValue = void Function();
typedef IntValue = void Function(int);
typedef PopularGamesModelValue = void Function(PopularGamesModel);
typedef LoginModelValue = void Function(LoginModel);

class GetPopularGames{
  final PopularGamesModelValue callBackPopularGames;
  final IntValue callBackError;
  GetPopularGames({
    required this.callBackPopularGames,
    required this.callBackError,
  }){
    getPopularGames();
  }
  Future<void> getPopularGames() async{
    try{
      final request = http.MultipartRequest(AppRequests.get, Uri.parse("${AppApi.rawgApiBase}${AppApi.rawgDates2023}${AppApi.rawgOderByRating}&key=${AppApi.rawgApiKey}&page_size=10"));
      request.headers['Content-type'] = 'application/json; charset=UTF-8';

      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      PopularGamesModel popularGamesModel = PopularGamesModel.fromJson(json.decode(response.body));
      if(response.statusCode == 200){
        callBackPopularGames(popularGamesModel);
        return;
      }
      else{
        callBackError(response.statusCode);
        return;
      }
    }
    catch(err){
      // if (kDebugMode) {
      //   print(err);
      // }
    }
  }
}


typedef SignupModelValue = void Function(SignUpModel);
class GetSignUp{
  final SignupModelValue callBackSignUp;
  final IntValue callBackError;
  final String email;
  final String fName;
  final String lName;
  final String password;
  final String matchPassword;

  GetSignUp({
    required this.callBackSignUp,
    required this.callBackError,
    required this.email,
    required this.fName,
    required this.lName,
    required this.password,
    required this.matchPassword,
  }) {
    getSignUp();
  }
  Future<void> getSignUp() async{
    final request = http.MultipartRequest(AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.signUp}"));
    request.headers['Content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
    request.fields['email'] = email;
    request.fields['fName'] = fName;
    request.fields['lName'] = lName;
    request.fields['password'] = password;
    request.fields['match_password'] = matchPassword;

    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if(response.statusCode == 201){
      final token = response.headers['authorization'];
      SignUpModel signUpModel = SignUpModel(token: token);
      callBackSignUp(signUpModel);
      return;
    }
    else{
      callBackError(response.statusCode);
      return;
    }
  }
}

// typedef SignupModelValue = void Function(SignUpModel);
// class GetSignUp{
//   final SignupModelValue callBackSignUp;
//   final IntValue callBackError;
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String password;
//   final String password2;
//   GetSignUp({
//     required this.callBackSignUp,
//     required this.callBackError,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.password,
//     required this.password2,
//   }){
//     getSignUp();
//   }
//   Future<void> getSignUp() async{
//     try{
//       //Multipartrequest cannot be processed by spring unless @ModelAttribute annotation is used (workaround).
//       final request = http.MultipartRequest(AppRequests.post, Uri.parse(AppUrls.base + AppUrls.signUp));
//       request.headers['Content-type'] = 'application/json; charset=UTF-8';
//       request.fields['email'] = email;
//       request.fields['firstName'] = firstName;
//       request.fields['lastName'] = lastName;
//       request.fields['password'] = password;
//       request.fields['match_password'] = password2;
//
//       final streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       SignUpModel signUpModel = SignUpModel.fromJson(json.decode(response.body));
//       if(response.statusCode == 201){
//         callBackSignUp(signUpModel);
//         return;
//       }
//       else{
//         callBackError(response.statusCode);
//         return;
//       }
//     }catch(error){
//       if (kDebugMode) {
//         print(error);
//       }
//     }
//   }
// }


class CreateGame {
  final String name;
  final String tag;
  final String details;
  final Uint8List imageDark;
  final Uint8List imageLight;
  final VoidValue callBackGameCreated;
  final IntValue callBackError;

  CreateGame({
    required this.name,
    required this.tag,
    required this.details,
    required this.imageDark,
    required this.imageLight,
    required this.callBackGameCreated,
    required this.callBackError,
  }) {
createGame();
  }

  Future<void> createGame() async {
    final request = http.MultipartRequest(
        AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.createGame}"));
    request.headers['Content-type'] =
    'multipart/form-data; charset=UTF-8';
    request.fields['game_name'] = name;
    request.fields['game_tag'] = tag.toString();
    request.fields['game_details'] = details;
    request.fields['game_icon_dark'] = 'http://localhost:8080/images/$name-white.png';
    request.fields['game_icon_light'] = 'http://localhost:8080/images/$name-black.png';

    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {
      callBackGameCreated();
      return;
    }
    else {
      callBackError(response.statusCode);
      return;
    }
  }
}
class GetLogin {
  final LoginModelValue callBackLogin;
  final IntValue callBackError;
  final String email;
  final String password;

  GetLogin({
    required this.callBackLogin,
    required this.callBackError,
    required this.email,
    required this.password,
  }) {
    getLogin();
  }

  Future<void> getLogin() async {
    final request = http.MultipartRequest(
        AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.signIn}"));
    request.headers['Content-type'] =
    'application/x-www-form-urlencoded; charset=UTF-8';
    request.fields['email'] = email;
    request.fields['password'] = password;


    final streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 200) {
      final token = response.headers['authorization'];
      LoginModel loginModel = LoginModel(token: token, email: email);
      callBackLogin(loginModel);
      return;
    }
    else {
      callBackError(response.statusCode);
      return;
    }
  }
}