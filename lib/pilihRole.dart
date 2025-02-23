import 'package:flutter/material.dart';
import 'package:tubes/registrasi_nakes.dart';
import 'package:tubes/registrasi_pasien.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pilihrole(),
    );
  }
}

class Pilihrole extends StatelessWidget {
  const Pilihrole({super.key});

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
              Color.fromARGB(255, 96, 165, 250)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Column(
                children: [
                  Text(
                    'Halo! Aku Cerdik,\nKamu Siapa Ya?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Image(image: AssetImage('img/mascot.png')),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Image(image: AssetImage('img/roledokter.png')),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                              255, 37, 121, 247), // Warna teks
                          backgroundColor: Colors.white,
                          fixedSize:
                              const Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrasiNakes()),
                        );
                      },
                      child: const Text("Tenaga Kesehatan")),
                ],
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Image(image: AssetImage('img/rolepasien.png')),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                              255, 37, 121, 247), // Warna teks
                          backgroundColor: Colors.white,
                          fixedSize:
                              const Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrasiPasien()),
                        );
                      },
                      child: const Text("Pasien")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white, // Warna latar belakang tombol
        foregroundColor: Colors.blue, // Warna teks tombol
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }
}
