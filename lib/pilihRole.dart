import 'package:flutter/material.dart';
import 'package:tubes/registrasi_nakes.dart';
import 'package:tubes/registrasi_pasien.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.currentTheme,
            home: Pilihrole(someCondition: true));
      },
    );
  }
}

class Pilihrole extends StatelessWidget {
  final bool someCondition;
  const Pilihrole({super.key, required this.someCondition});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode
                  ? Color(0xFF2A2A3C)
                  : Color.fromARGB(255, 37, 100, 235),
              isDarkMode
                  ? Color.fromARGB(255, 57, 51, 109)
                  : Color.fromARGB(255, 96, 165, 250)
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
              Column(
                children: [
                  Text(
                    'Halo! Aku Cerdik,\nKamu Siapa Ya?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Color.fromARGB(255, 38, 202, 197)
                          : Colors.white,
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
                          foregroundColor: isDarkMode
                              ? Colors.white
                              : const Color.fromARGB(
                                  255, 37, 121, 247), // Warna teks
                          backgroundColor: isDarkMode
                              ? Color.fromARGB(255, 38, 202, 197)
                              : Colors.white,
                          fixedSize:
                              const Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegistrasiNakes(someCondition: true)),
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
                          foregroundColor: isDarkMode
                              ? Colors.white
                              : const Color.fromARGB(
                                  255, 37, 121, 247), // Warna teks
                          backgroundColor: isDarkMode
                              ? Color.fromARGB(255, 38, 202, 197)
                              : Colors.white,
                          fixedSize:
                              const Size(180, 30) // Warna background tombol
                          ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegistrasiPasien(someCondition: true)),
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
