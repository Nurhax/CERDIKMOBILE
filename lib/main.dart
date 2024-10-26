import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cerdik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[300]!, Colors.blue[700]!],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo atau Ikon
            const Icon(
              Icons.medication, // Gunakan ikon yang relevan
              color: Colors.white,
              size: 80.0,
            ),
            const SizedBox(height: 20),
            
            // Teks CERDIK
            const Text(
              "CERDIK",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            
            // Teks Deskripsi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Teman Setia Anda Pengingat Obat.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Tombol Mari Memulai
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol ditekan, seperti navigasi ke halaman lain
                print("Tombol Mari Memulai ditekan");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Warna tombol
                foregroundColor: Colors.blue,  // Warna teks tombol
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Mari Memulai',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
