import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/pagePasien.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loadingpagePasien(pasienSaatini: Pasien()),
    );
  }
}

class loadingpagePasien extends StatefulWidget {
  final Pasien pasienSaatini;
  const loadingpagePasien({super.key, required this.pasienSaatini});

  @override
  _loadingpagePasienState createState() => _loadingpagePasienState();
}

class _loadingpagePasienState extends State<loadingpagePasien> {
  @override
  void initState() {
    super.initState();
    // Delay selama 5 detik, kemudian pindah ke pageNakes
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                pagePasien(pasienSaatIni: widget.pasienSaatini)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 37, 100, 235),
              Color.fromARGB(255, 96, 165, 250),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 80.0),
                    child: Image(image: AssetImage('img/loadingtop.png')),
                  ),
                ],
              ),
              Text(
                "CERDIK",
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 70),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Cermat\nIngat\nDosis\nKesehatan",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            offset:
                                Offset(1.0, 1.0), // Mengatur posisi bayangan
                            blurRadius:
                                12.0, // Menentukan seberapa blur bayangan
                            color: Color.fromARGB(
                                255, 255, 255, 255), // Warna bayangan (hitam)
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Image(
                        image: AssetImage('img/loadingbody1.png'),
                        width: 130.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 35.0),
                        child: Image(
                            image: AssetImage('img/loadingbody2.png'),
                            width: 90.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 80.0),
                    child: Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white, // Warna bola loading
                        size: 50.0, // Ukuran bola loading
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
