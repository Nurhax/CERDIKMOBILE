import 'dart:convert';

import 'package:http/http.dart' as http;

class Obat {
  String? idObat;
  String? nama;
  String? jenis;
  String? gejalaObat;
  String? ukuran;
  String? dosis;
  String? deskripsi;

  @override
  Obat();

  @override
  Obat.api(
      {required this.idObat,
      required this.nama,
      required this.jenis,
      required this.ukuran,
      required this.gejalaObat,
      required this.deskripsi});

  factory Obat.fromMap(Map<String, dynamic> map) {
    return Obat.api(
      idObat: map['idobat']?.toString(),
      nama: map['nama'],
      jenis: map['jenis'],
      ukuran: map['ukuran'],
      gejalaObat: map['GejalaObat'],
      deskripsi: map['deskripsi'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idobat': idObat,
      'nama': nama,
      'jenis': jenis,
      'ukuran': ukuran,
      'GejalaObat': gejalaObat,
      'deskripsi': deskripsi,
    };
  }

  static Future<List<Obat>> fetchAllObat({http.Client? client}) async {
    client ??= http.Client(); // Use real client if not mocked
    final response =
        await client.get(Uri.parse('https://letzgoo.net/api/view_obat.php'));
    try {
      if (response.statusCode == 200) {
        List<dynamic> listObat = jsonDecode(response.body);
        return listObat.map((item) => Obat.fromMap(item)).toList();
      } else {
        throw Exception(
            "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<Obat?> fetchObatByID(int id) async {
    String uri = "https://letzgoo.net/api/get_obat.php?id=$id";

    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> listObat = jsonDecode(response.body);
        if (listObat.isNotEmpty) {
          return Obat.fromMap(
              listObat[0]); // Return the first Obat object from the list
        } else {
          return null; // No Obat found
        }
      } else {
        throw Exception(
            "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<bool> insertObatData(
    String nama,
    String jenis,
    String dosis, // This is saranPenyajian
    String gejala, // This should be gejalaobat in the backend
    String deskripsi,
    String satuan, // This is the 'ukuran' in the database
  ) async {
    String uri =
        "https://letzgoo.net/api/insert_record_obat.php"; // Replace with your actual URL

    try {
      final response = await http.post(
        Uri.parse(uri),
        body: {
          'nama': nama,
          'jenis': jenis,
          'dosis': dosis, // This is the 'saranPenyajian' in the backend
          'gejala':
              gejala, // This matches the 'gejalaobat' parameter in the backend
          'ukuran': satuan,
          'deskripsi':
              deskripsi, // This matches the 'ukuran' column in the database
        },
      );

      // Debugging: log the response status and body
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("Response Data: $data"); // Log the decoded data

        if (data['success'] == 'true') {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(
            "Failed to insert data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error inserting data: $e"); // Log the error
      throw Exception("Error inserting data: $e");
    }
  }

  static Future<bool> updateObatData(
      String obatId, // Add 'id' as a parameter
      String obatName,
      String old_obat_name,
      String jenisObat,
      String dosis,
      String deskripsi,
      String gejalaObat,
      String ukuran) async {
    try {
      final response = await http.post(
        Uri.parse("https://letzgoo.net/api/update_obat.php"),
        body: {
          "idobat": obatId, // Pass the 'id' of the obat
          "nama": obatName,
          "old_nama": old_obat_name,
          "jenis": jenisObat,
          "dosis": dosis,
          "gejala": gejalaObat,
          "ukuran": ukuran,
          "deskripsi": deskripsi,
        },
      );

      // Debugging: Log the response body
      print("Response body: ${response.body}");

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success'] == "true") {
        return true;
      } else {
        print("Error: ${responseData['error']}"); // Log the error message
        return false;
      }
    } catch (error) {
      // Debugging: Catch any network or unexpected errors
      print("Error updating data: $error");
      return false;
    }
  }

  static Future<bool> deleteObatData(String? idObat) async {
    try {
      // Log the ID being sent for deletion
      print("Attempting to delete obat with ID: $idObat");

      // Perform the HTTP POST request
      final response = await http.post(
        Uri.parse("https://letzgoo.net/api/delete_obat.php"),
        body: {"idobat": idObat},
      );

      // Debugging: Log the response body
      print("Response body: ${response.body}");

      // Decode the response
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Check success status
      if (response.statusCode == 200) {
        if (responseData['success'] == "true") {
          print("Obat deleted successfully!");
          return true;
        } else {
          // Log the API-reported error if deletion failed
          print("API Error: ${responseData['error'] ?? 'Unknown error'}");
          return false;
        }
      } else {
        // Log unexpected status codes
        print("Error: Unexpected status code ${response.statusCode}");
        return false;
      }
    } catch (error) {
      // Log any exceptions
      print("Exception while deleting obat: $error");
      return false;
    }
  }
}
