import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pilihrole(),
    );
  }
}

class Pilihrole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
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
              SizedBox(height: 20),
              Column(
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
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Image(image: AssetImage('img/mascot.png')),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image(image: AssetImage('img/roledokter.png')),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Color.fromARGB(255, 37, 121, 247), // Warna teks
                          backgroundColor: Colors.white,
                          fixedSize: Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {},
                      child: const Text("Tenaga Kesehatan")),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image(image: AssetImage('img/rolepasien.png')),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Color.fromARGB(255, 37, 121, 247), // Warna teks
                          backgroundColor: Colors.white,
                          fixedSize: Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {},
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

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.white, // Warna latar belakang tombol
        foregroundColor: Colors.blue, // Warna teks tombol
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
