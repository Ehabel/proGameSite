import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:charles_warburton/utils/api.dart';
import 'package:charles_warburton/utils/requests.dart';
import 'package:charles_warburton/utils/urls.dart';
import 'package:http/http.dart' as http;

import '../../DashBoard/models/token_storage.dart';
import '../../DashBoard/requests/dashboard_requests.dart';
import '../models/cart_model.dart';

typedef CartModelValue = void Function(CartModel);
class GetCart{
  final CartModelValue callBackCart;
  final IntValue callBackError;

  GetCart({
    required this.callBackCart,
    required this.callBackError,
  }) {
    getUserCart();
  }
  Future<String> getUserCart() async{
    try {
      String? email = await TokenStorage().extractEmail();
      final request = http.MultipartRequest(AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.getCart}$email"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        CartModel cartModel = CartModel.fromJson(json.decode(response.body));
        callBackCart(cartModel);
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }
}

class GetCartPro{
  final CartModelValue callBackCart;
  final IntValue callBackError;

  GetCartPro({
    required this.callBackCart,
    required this.callBackError,
  }) {
    getProCart();
  }
  Future<String> getProCart() async{
    try {
      String? email = await TokenStorage().extractEmail();
      final request = http.MultipartRequest(AppRequests.get, Uri.parse("${AppUrls.base}${AppUrls.getProCart}$email"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        CartModel cartModel = CartModel.fromJson(json.decode(response.body));
        callBackCart(cartModel);
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }
}

class CartRequests{
  static Future<String> addToCart(int proUserId) async{
    try {
      String? email = await TokenStorage().extractEmail();
      final request = http.MultipartRequest(AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.addOrder}$email/$proUserId"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }

  static Future<String> deleteOrder(int orderId) async{
    try {
      String? email = await TokenStorage().extractEmail();
      final request = http.MultipartRequest(AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.deleteOrder}$orderId"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }

  static Future<String> acceptOrder(int orderId) async{
    try {
      final request = http.MultipartRequest(AppRequests.post, Uri.parse("${AppUrls.base}${AppUrls.acceptOrder}$orderId"));
      final streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Failed!";
      }
    } catch (error) {
      print(error);
    }
    return "Failed!";
  }
}