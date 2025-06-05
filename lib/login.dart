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
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat
import 'package:flutter/gestures.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const Login(someCondition: true),
    ),
  );
}

class Login extends StatefulWidget {
  final bool someCondition;
  const Login({
    super.key,
    required this.someCondition,
  });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        _showTermsDialog();
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Syarat dan Ketentuan'),
          content: SingleChildScrollView(
            child: Text(
              'Dengan menggunakan aplikasi CERDIK, Anda menyetujui bahwa:\n\n'
              '• Data pribadi Anda dapat digunakan untuk keperluan analisis dan layanan aplikasi.\n'
              '• Anda bertanggung jawab atas keamanan akun Anda sendiri.\n'
              '• Dilarang keras menggunakan aplikasi untuk tujuan yang melanggar hukum.\n'
              '• Pengembang berhak memperbarui syarat dan ketentuan tanpa pemberitahuan sebelumnya.\n'
              '• Kontak developer: iqbalnur2009@gmail.com',
              textAlign: TextAlign.start,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Selesai'),
            ),
          ],
        );
      },
    );
  }

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF2A2A3C) : Color(0xFF2563EB),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Logo and top content
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
                  const SizedBox(height: 30),
                  Text(
                    'LOGIN',
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
                            builder: (context) =>
                                Pilihrole(someCondition: true)),
                      );
                    },
                    child: Text(
                      'Belum Punya Akun? Registrasi',
                      style: TextStyle(
                          color: isDarkMode
                              ? Color.fromARGB(255, 38, 202, 197)
                              : Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // White container with form
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 202, 201, 201)
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
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
                              prefixIcon: Icon(Icons.person),
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
                                  vertical: 10, horizontal: 10),
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
                          const SizedBox(height: 30),
                          TextField(
                            controller: passwordController,
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconColor:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue,
                              labelText: 'Password',
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
                              suffixIcon: GestureDetector(
                                onLongPress: () {
                                  setState(() {
                                    _hidePassword = false;
                                  });
                                },
                                onLongPressUp: () {
                                  setState(() {
                                    _hidePassword = true;
                                  });
                                },
                                child: Icon(
                                  _hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : const Color(0xFF2563EB)),
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
                              String username = usernameController.text.trim();
                              String password = passwordController.text.trim();
                              String uriPasien =
                                  "https://letzgoo.net/api/view_pasien.php";
                              String uriNakes =
                                  "https://letzgoo.net/api/view_nakes.php";

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
                                        HashingService.verifyPassword(
                                            password, user['password']),
                                    orElse: () => null,
                                  );
                                  if (user != null) {
                                    pasienSaatini.username = user['username'];
                                    pasienSaatini.password = user['password'];
                                    pasienSaatini.email = user['email'];
                                    pasienSaatini.id = user['idpasien'];
                                    pasienSaatini.usia = user['usia'];
                                    pasienSaatini.nama = user['nama'];
                                    pasienSaatini.gender = user['gender'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => loadingpagePasien(
                                          pasienSaatini: pasienSaatini,
                                          someCondition: true,
                                        ),
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
                                        HashingService.verifyPassword(
                                            password, user['password']),
                                    orElse: () => null,
                                  );
                                  if (user != null) {
                                    nakesSaatini.id = user['idnakes'];
                                    nakesSaatini.username = user['username'];
                                    nakesSaatini.namaLengkap =
                                        user['namalengkap'];
                                    nakesSaatini.email = user['email'];
                                    nakesSaatini.nomorSTR = user['nomorSTR'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => loadingpageNakes(
                                          nakesSaatIni: nakesSaatini,
                                          someCondition: true,
                                        ),
                                      ),
                                    );
                                    return; // Exit function if found in nakes role
                                  }
                                }

                                // If not found in both roles
                                print(
                                    'Username atau password salah atau bukan role pasien/nakes');
                                showErrorDialog(
                                    context, "Username atau Password Salah!");
                              } catch (e) {
                                print('Error Login: $e');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? Color.fromARGB(255, 38, 202, 197)
                                  : Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 30),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
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
                                    ),
                                    recognizer: _tapGestureRecognizer,
                                  ),
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
          ],
        ),
      ),
    );
  }
}
