import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/users_response.dart';

class UserDataSource {
  Future<List<UsersResponse>> fetchUsers() async {
    final response = await http.get(
      Uri.parse("https://mocki.io/v1/c5a90d24-be6d-480c-95cc-3d5deb95ed46"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => UsersResponse.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener los datos");
    }
  }
}
