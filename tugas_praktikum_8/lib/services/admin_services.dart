import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/admin.dart';

class AdminService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users'; // Mock API

  Future<List<Admin>> getAdmins() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Admin.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load admins');
    }
  }

  Future<Admin> getAdmin(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Admin.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load admin');
    }
  }

  Future<void> deleteAdmin(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete admin');
    }
  }
}