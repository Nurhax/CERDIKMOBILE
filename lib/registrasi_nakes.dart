import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/login.dart';
import 'package:tubes/pilihRole.dart';
import 'package:http/http.dart' as http;
import 'Security/hashing_service.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: RegistrasiNakes(someCondition: true),
    ),
  );
}

class RegistrasiNakes extends StatelessWidget {
  final bool someCondition;
  RegistrasiNakes({
    super.key,
    required this.someCondition,
  });

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController namaLengkapTextController =
      TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController nomorSTRTextController = TextEditingController();

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

  Future<void> daftarNakesInsert(BuildContext context) async {
    if (usernameTextController.text.isNotEmpty &&
        namaLengkapTextController.text.isNotEmpty &&
        emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty &&
        nomorSTRTextController.text.isNotEmpty) {
      try {
        if (nomorSTRTextController.text.length != 7) {
          showErrorDialog(context, "Nomor STR Tidak Valid Harus 7 Digit!");
        } else if (emailTextController.text.contains("@")) {
          showErrorDialog(context, "Email Tidak Valid, Input Kembali Email!");
        } else {
          String uri = "http://10.0.2.2/APIPPB/insert_record_nakes.php";
          var res = await http.post(Uri.parse(uri), body: {
            "username": usernameTextController.text.trim(),
            "nama": namaLengkapTextController.text.trim(),
            "email": emailTextController.text.trim(),
            "password":
                HashingService.hashPassword(passwordTextController.text.trim()),
            "nomorSTR": nomorSTRTextController.text.trim()
          });
          //Nomor STR harus 7 angka
          if (res.statusCode == 200) {
            var response = jsonDecode(res.body);
            if (response["success"] == "true") {
              debugPrint("Record Insert Successfull");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registrasi Nakes Berhasil!')),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Login(someCondition: true)),
              );
            } else {
              debugPrint("Error ${response}");
            }
          } else {
            debugPrint("Error: ${res.statusCode}, ${res.body}");
          }
        }
      } catch (e) {
        print("ERROR! $e");
      }
    } else {
      print("Tolong Lengkapi Data Terlebih Dahulu!");
      showErrorDialog(context, "DATA BELUM LENGKAP!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: isDarkMode ? Color(0xFF2A2A3C) : Color(0xFF2563EB),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 480,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 202, 201, 201)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            controller: usernameTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Colors.blue,
                                    width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: namaLengkapTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.edit),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nama Lengkap',
                              labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey),
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Colors.blue,
                                    width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: emailTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey),
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Colors.blue,
                                    width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: passwordTextController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey),
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Colors.blue,
                                    width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: nomorSTRTextController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.credit_card),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              labelText: 'Nomor STR',
                              labelStyle: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Colors.blue,
                                    width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          //Backend registrasi disini untuk nakes
                          ElevatedButton(
                            onPressed: () async {
                              daftarNakesInsert(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? Color.fromARGB(255, 38, 202, 197)
                                  : const Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          )
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Pilihrole(someCondition: true)),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: isDarkMode
                              ? Color.fromARGB(255, 38, 202, 197)
                              : Colors.white,
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
                  Text(
                    'CERDIK',
                    style: TextStyle(
                      color: isDarkMode
                          ? Color.fromARGB(255, 38, 202, 197)
                          : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'REGISTRASI',
                    style: TextStyle(
                      color: isDarkMode
                          ? Color.fromARGB(255, 38, 202, 197)
                          : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Login(
                                  someCondition: true,
                                )),
                      );
                    },
                    child: Text(
                      'Sudah Punya Akun? Log in',
                      style: TextStyle(
                          color: isDarkMode
                              ? Color.fromARGB(255, 38, 202, 197)
                              : Colors.white),
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
