import 'package:moneytracker/usreg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = "http://127.0.0.1:5002/api/v1/userreg";

  Future<List<UserReg>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => UserReg.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load items from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load items from API: $e');
    }
  }

  Future<void> addUsers(UserReg item) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(item.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to add item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }
}
