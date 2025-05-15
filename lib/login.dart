import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tubes/loadingPageNakes.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/pilihRole.dart';
import 'package:tubes/loadingPagePasien.dart';
import 'package:http/http.dart' as http;

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
                height: 450,
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
                          const SizedBox(height: 30),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              prefixIconColor: Colors.blue,
                              labelText: 'Password',
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
                          const SizedBox(height: 30),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFF2563EB)),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'img/logoGoogle.png', // Replace with your image asset path
                                    width: 20, // Adjust width
                                    height: 20, // Adjust height
                                  ),
                                  const SizedBox(
                                      width: 8), // Space between image and text
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
                              String username = usernameController.text.trim();
                              String password = passwordController.text.trim();
                              String uriPasien =
                                  "http://10.0.2.2/APIPPB/view_pasien.php";
                              String uriNakes =
                                  "http://10.0.2.2/APIPPB/view_nakes.php";

                              //Backend disini ngecek apakah password dan rolenya sesuai yang di register
                              try {
                                var pasienResponse =
                                    await http.get(Uri.parse(uriPasien));
                                if (pasienResponse.statusCode == 200) {
                                  List<dynamic> listPasien =
                                      jsonDecode(pasienResponse.body);
                                  var User = listPasien.firstWhere(
                                    (user) =>
                                        user['username'] == username &&
                                        user['password'] == password,
                                    orElse: () =>
                                        null, // Return null if no match is found
                                  );
                                  if (User != null) {
                                    pasienSaatini.username = User['username'];
                                    pasienSaatini.password = User['password'];
                                    pasienSaatini.email = User['email'];
                                    pasienSaatini.id = User['idpasien'];
                                    pasienSaatini.usia = User['usia'];
                                    pasienSaatini.nama = User['nama'];
                                    pasienSaatini.gender = User['gender'];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                loadingpagePasien(
                                                    pasienSaatini:
                                                        pasienSaatini)));
                                  } else {
                                    print(
                                        'username atau password salah atau bukan role pasien');
                                  }
                                } else {
                                  print("ERROR HTTP: $pasienResponse");
                                }
                              } catch (e) {
                                print('Error Login: $e');
                              }

                              try {
                                var nakesResponse =
                                    await http.get(Uri.parse(uriNakes));
                                if (nakesResponse.statusCode == 200) {
                                  List<dynamic> listNakes =
                                      jsonDecode(nakesResponse.body);
                                  var User = listNakes.firstWhere(
                                    (user) =>
                                        user['username'] == username &&
                                        user['password'] == password,
                                    orElse: () =>
                                        null, // Return null if no match is found
                                  );
                                  if (User != null) {
                                    nakesSaatini.id = User['idnakes'];
                                    nakesSaatini.username = User['username'];
                                    nakesSaatini.namaLengkap =
                                        User['namalengkap'];
                                    nakesSaatini.email = User['email'];
                                    nakesSaatini.nomorSTR = User['nomorSTR'];
                                    // print(
                                    //     "Print yang masuk ${nakesSaatini.id} ${nakesSaatini.username} ${nakesSaatini.namaLengkap} ${nakesSaatini.email} ${nakesSaatini.nomorSTR}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                loadingpageNakes(
                                                  nakesSaatIni: nakesSaatini,
                                                )));
                                  }
                                }
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
                          const SizedBox(height: 30),
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
            Positioned(
              top: 50,
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
                  const SizedBox(height: 30),
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
                      // Navigate to login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Pilihrole()),
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
    );
  }
}
