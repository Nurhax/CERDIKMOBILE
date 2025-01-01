import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tubes/models/jadwal.dart';

class JadwalService {
  static Future<List<JadwalObat>> fetchJadwalObat() async {
    String url =
        "http://10.0.2.2/APIPPB/get_jadwal.php"; // Your endpoint for fetching data
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        List<JadwalObat> jadwalObat =
            body.map((dynamic item) => JadwalObat.fromJson(item)).toList();
        return jadwalObat;
      } else {
        throw Exception("Failed to load Jadwal");
      }
    } catch (e) {
      throw Exception("Error fetching Jadwal: $e");
    }
  }
  static Future<List<JadwalObat>> fetchJadwalById(String patientId) async {
    String uri = "http://10.0.2.2/APIPPB/get_jadwal.php?idPasien=$patientId";
    
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> listJadwal = jsonDecode(response.body);
        return listJadwal.map((jadwal) => JadwalObat.fromJson(jadwal)).toList();
      } else {
        throw Exception("Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<Map<String, dynamic>> insertJadwal(
      Map<String, String> data) async {
    String url = "http://10.0.2.2/APIPPB/insert_jadwal.php";
    try {
      final res = await http.post(Uri.parse(url), body: data);
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Failed to insert Jadwal: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error inserting Jadwal: $e");
    }
  }

  static Future<Map<String, dynamic>> updateJadwal(
      Map<String, String> data) async {
    String url = "http://10.0.2.2/APIPPB/update_jadwal.php";
    try {
      final res = await http.post(Uri.parse(url), body: data);
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Failed to update Jadwal: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating Jadwal: $e");
    }
  }

  static Future<Map<String, dynamic>> deleteJadwal(String id) async {
    String url = "http://10.0.2.2/Jadwal_Api/delete_jadwal.php";
    try {
      final res = await http.post(Uri.parse(url), body: {"IDPasien": id});
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception("Failed to delete Jadwal: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error deleting Jadwal: $e");
    }
  }
}
