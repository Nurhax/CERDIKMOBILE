import 'dart:convert';

import 'package:http/http.dart' as http;

class Pasien {
  String? id;
  String? username;
  String? password;
  String? email;
  String? usia;
  String? nama;
  String? gender;
  String? idnakes;

  @override
  Pasien();

  @override
  Pasien.api(
      {required this.id,
      required this.username,
      required this.email,
      required this.usia,
      required this.nama,
      required this.gender,
      required this.idnakes});

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien.api(
        id: json['idpasien'],
        username: json['username'],
        email: json['email'],
        usia: json['usia'],
        nama: json['nama'],
        gender: json['gender'],
        idnakes: json['idnakes']);
  }
  static Future<List<Pasien>> fetchSemuaPasien(
      {String searchQuery = ""}) async {
    String uri = "https://letzgoo.net/api/view_pasien.php?search=$searchQuery";

    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> listPasien = jsonDecode(response.body);
        return listPasien.map((pasien) => Pasien.fromJson(pasien)).toList();
      } else {
        throw Exception(
            "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<bool> updatePasienBaru(String idnakes, String idpasien) async {
    try {
      final response = await http
          .post(Uri.parse("https://letzgoo.net/api/nakes_baru.php"), body: {
        "idpasien": idpasien,
        "idnakes": idnakes
      }); // Debugging: Log the response body
      print("Response body: ${response.body}");

      // ✅ Cek jika response kosong
      if (response.body.isEmpty) {
        print("Error: Empty response from server");
        return false;
      }

      // ✅ Parse JSON hanya jika tidak kosong
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success'] == "true") {
        return true;
      } else {
        print("Error: ${responseData['error']}");
        return false;
      }
    } catch (error) {
      // Debugging: Catch any network or unexpected errors
      print("Error updating data: $error");
      return false;
    }
  }
}
