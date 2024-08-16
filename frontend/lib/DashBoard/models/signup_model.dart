import 'token_storage.dart';

class SignUpModel{
  String? _token;

  SignUpModel({String? token}) {
    if (token != null) {
      _token = token;
      _storeToken(token);
    }
  }

  String? get token => _token;

  Future<void> setToken(String token) async {
    _token = token;
    await _storeToken(token);
  }

  Future<void> _storeToken(String token) async {
    // await TokenStorage().storeToken(token);
  }

  SignUpModel.fromJson(Map<String, dynamic> json) {
    _token = json["Set-Cookie"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Authorisation'] = _token;
    return data;
  }

}