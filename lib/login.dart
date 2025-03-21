import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubes/loadingPageNakes.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/pilihRole.dart';
import 'package:tubes/loadingPagePasien.dart';
import 'package:http/http.dart' as http;
import 'Security/hashing_service.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Error"),
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

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF2563EB),
        body: SingleChildScrollView(
          // Added SingleChildScrollView
          child: SizedBox(
            // Added SizedBox with minimum height
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height *
                        0.65, // Adjusted height
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
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                controller: usernameController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  prefixIconColor: Colors.blue,
                                  labelText: 'Username',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
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
                              const SizedBox(height: 30),
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  prefixIconColor: Colors.blue,
                                  labelText: 'Password',
                                  labelStyle:
                                      const TextStyle(color: Colors.grey),
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
                              const SizedBox(height: 30),
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF2563EB)),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'img/logoGoogle.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Login dengan Google",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () async {
                                  Pasien pasienSaatini = Pasien();
                                  Nakes nakesSaatini = Nakes();
                                  String username =
                                      usernameController.text.trim();
                                  String password =
                                      passwordController.text.trim();
                                  String uriPasien =
                                      "http://10.0.2.2/APIPPB/view_pasien.php";
                                  String uriNakes =
                                      "http://10.0.2.2/APIPPB/view_nakes.php";

                                  try {
                                    // Check for Pasien role
                                    var pasienResponse =
                                        await http.get(Uri.parse(uriPasien));
                                    if (pasienResponse.statusCode == 200) {
                                      List<dynamic> listPasien =
                                          jsonDecode(pasienResponse.body);
                                      var user = listPasien.firstWhere(
                                        (user) =>
                                            user['username'] == username &&
                                            user['password'] == password,
                                        orElse: () => null,
                                      );
                                      if (user != null) {
                                        pasienSaatini.username =
                                            user['username'];
                                        pasienSaatini.password =
                                            user['password'];
                                        pasienSaatini.email = user['email'];
                                        pasienSaatini.id = user['idpasien'];
                                        pasienSaatini.usia = user['usia'];
                                        pasienSaatini.nama = user['nama'];
                                        pasienSaatini.gender = user['gender'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                loadingpagePasien(
                                                    pasienSaatini:
                                                        pasienSaatini),
                                          ),
                                        );
                                        return; // Exit function if found in pasien role
                                      }
                                    }

                                    // Check for Nakes role
                                    var nakesResponse =
                                        await http.get(Uri.parse(uriNakes));
                                    if (nakesResponse.statusCode == 200) {
                                      List<dynamic> listNakes =
                                          jsonDecode(nakesResponse.body);
                                      var user = listNakes.firstWhere(
                                        (user) =>
                                            user['username'] == username &&
                                            user['password'] == password,
                                        orElse: () => null,
                                      );
                                      if (user != null) {
                                        nakesSaatini.id = user['idnakes'];
                                        nakesSaatini.username =
                                            user['username'];
                                        nakesSaatini.namaLengkap =
                                            user['namalengkap'];
                                        nakesSaatini.email = user['email'];
                                        nakesSaatini.nomorSTR =
                                            user['nomorSTR'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                loadingpageNakes(
                                                    nakesSaatIni: nakesSaatini),
                                          ),
                                        );
                                        return; // Exit function if found in nakes role
                                      }
                                    }

                                    // If not found in both roles
                                    print(
                                        'Username atau password salah atau bukan role pasien/nakes');
                                    showErrorDialog(context,
                                        "Username atau Password Salah!");
                                  } catch (e) {
                                    print('Error Login: $e');
                                  }
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
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      TextSpan(
                                          text:
                                              'yang berlaku untuk aplikasi ini.')
                                    ]),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height *
                      0.05, // Adjusted top position
                  left: 0,
                  right: 0,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: const Alignment(0.20, 0),
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
                      const SizedBox(height: 10), // Reduced spacing
                      const Text(
                        'LOGIN',
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
                            MaterialPageRoute(
                                builder: (context) => Pilihrole()),
                          );
                        },
                        child: const Text(
                          'Belum Punya Akun? Registrasi',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
