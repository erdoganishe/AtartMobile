import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> login(String email, String password) async {
  try {
    print(email);
    print(password);
    final url = Uri.parse('http://192.168.0.108:3000/auth/login-mobile');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'pwd': password}),
    );
    print("resp");
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final accessToken = responseData['accessToken'];
      final refreshToken = responseData['refreshToken'];
      final uId = responseData['uId'];
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('accessToken', accessToken);
      await prefs.setString('refreshToken', refreshToken);
      await prefs.setString('uId', uId);
      print("200");
      return true;
    } else {
      print('Login failed with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  } catch (error) {
    print('Error during login: $error');
    return false;
  }
}
