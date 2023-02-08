import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/request/signin_request_model.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/utils/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> getUserById(int? id) async {
    try {
      print("Calling service getUserById...");
      var url = Uri.parse(Path.path + "/users/" + id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        User _user = User.fromJson(jsonDecode(response.body));
        saveUser(_user);
        return _user;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toJson()));
  }

  Future<User?> getUser() async {
    print("Calling service getUser...");
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user');
    if (string != null) {
      print("Calling service getUser success");
      return User.fromJson(json.decode(string));
    }
    return null;
  }

  Future<bool> signIn(SignInRequestModel model) async {
    var isSuccess = false;
    var requestData = {
      "email": model.email,
      "password": model.password,
    };
    print('Signing...');
    var url = Uri.parse(Path.path + "/users/signin");
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utf8.encode(json.encode(requestData)),
    );

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      await saveUser(user);
      isSuccess = true;
    } else {
      isSuccess = false;
      print('Signin failed');
    }
    return isSuccess;
  }
}
