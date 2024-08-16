import 'token_storage.dart';

class LoginModel{
  String? _token;
  String? _email;

  LoginModel({String? token, String? email}) {
    if (token != null && email != null) {
      _token = token;
      _email = email;
      _storeToken(token, email);
    }
  }

  String? get token => _token;

  Future<void> setToken(String token, String email) async {
    _token = token;
    _email = email;
    await _storeToken(token, email);
  }

  String? get email => _email;
  set email(String? value) => _email = value;

  Future<void> _storeToken(String token, String email) async {
    await TokenStorage().storeTokenAndEmail(token, email);
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    _token = json["Authorisation"];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Authorisation'] = _token;
    data['email'] = _email;
    return data;
  }

}