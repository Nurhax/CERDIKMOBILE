import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tubes/login.dart';
import 'package:tubes/pilihRole.dart';
import 'package:http/http.dart' as http;
import 'Security/hashing_service.dart';

void main() {
  runApp(RegistrasiPasien());
}

class RegistrasiPasien extends StatelessWidget {
  RegistrasiPasien({super.key});
  final TextEditingController userNameTextController = TextEditingController();
  final TextEditingController namaLengkapTextController =
      TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController jenisKelaminTextController =
      TextEditingController();

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Register Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> daftarPasienInsert(BuildContext context) async {
    if (userNameTextController.text.isNotEmpty &&
        namaLengkapTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        tanggalLahirController.text.isNotEmpty &&
        jenisKelaminTextController.text.isNotEmpty) {
      try {
        String uri = "http://10.0.2.2/APIPPB/insert_record_pasien.php";
        var res = await http.post(Uri.parse(uri), body: {
          "username": userNameTextController.text.trim(),
          "password":
              HashingService.hashPassword(passwordTextController.text.trim()),
          "email": emailTextController.text.trim(),
          "usia": tanggalLahirController.text.trim(),
          "nama": namaLengkapTextController.text.trim(),
          "gender": jenisKelaminTextController.text.trim()
        });

        if (res.statusCode == 200) {
          var response = jsonDecode(res.body);
          if (response["success"] == "true") {
            debugPrint("Record Insert Successfull");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registrasi Berhasil!')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          } else {
            debugPrint("Error ${response}");
          }
        } else {
          debugPrint("Error: ${res.statusCode}, ${res.body}");
        }
      } catch (e) {
        print("ERROR! $e");
      }
    } else {
      print("TOLONG LENGKAPI DATA TERLEBIH DAHULU!");
      showErrorDialog(context, "DATA BELUM LENGKAP!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF2563EB),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 480,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: userNameTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              prefixIconColor: Colors.blue,
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: namaLengkapTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.edit),
                              labelText: 'Nama Lengkap',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: emailTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: tanggalLahirController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_month),
                              prefixIconColor: Colors.blue,
                              labelText: 'Tanggal Lahir (DD/MM/YYYY)',
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: jenisKelaminTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.wc_rounded),
                              prefixIconColor: Colors.blue,
                              labelText: 'Jenis Kelamin (L/P)',
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide:
                                    BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              daftarPasienInsert(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 7),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                                style: TextStyle(color: Colors.black38),
                                children: [
                                  TextSpan(
                                    text: 'Dengan ini saya menyetujui ',
                                  ),
                                  TextSpan(
                                      text: 'syarat dan ketentuan ',
                                      style: TextStyle(
                                        color: Colors.black45,
                                        decoration: TextDecoration.underline,
                                      )),
                                  TextSpan(
                                      text: 'yang berlaku untuk aplikasi ini.')
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Add your logo or icon here
            Stack(
              children: [
                Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pilihrole()),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )))
              ],
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: const Alignment(0.25, 0),
                    child: Image.asset(
                      'img/loadingtop.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'CERDIK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'REGISTRASI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text(
                      'Sudah Punya Akun? Log in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
