import 'package:flutter/material.dart';
import 'package:tubes/pagePasien.dart';
import 'package:tubes/models/pasien.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SoundNotificationScreen(
        pasienSaatIni: Pasien(),
        someCondition: true,
      ),
    );
  }
}

class SoundNotificationScreen extends StatefulWidget {
  final bool someCondition;
  final Pasien pasienSaatIni;

  @override
  _SoundNotificationScreenState createState() =>
      _SoundNotificationScreenState();
  const SoundNotificationScreen(
      {super.key, required this.someCondition, required this.pasienSaatIni});
}

class _SoundNotificationScreenState extends State<SoundNotificationScreen> {
  String selectedSound = 'Aurora';
  final List<String> defaultSounds = [
    'Aurora',
    'Bamboo',
    'Chord',
    'Circles',
    'Hello',
    'Keys',
    'Popcorn',
    'Blues',
    'Pinball',
    'Bell Tower',
    'Chicken Sound',
    'Duck Sound'
  ];

  final List<String> customSounds = ['Tambah suara notifikasi', 'Dj Angkot'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Suara Notifikasi',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Periksa nilai dari someCondition
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => widget.someCondition
                        ? pagePasien(
                            initialIndex: 0,
                            pasienSaatIni: widget.pasienSaatIni,
                          )
                        : pagePasien(
                            initialIndex: 1,
                            pasienSaatIni: widget.pasienSaatIni)),
              );
            },
            child: const Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Icon Row
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      Icons.music_note,
                      color: Colors.blue.shade700,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // Default Sound Section
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Suara Default',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ...defaultSounds.map((sound) => Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: RadioListTile(
                          title: Text(
                            sound,
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: sound,
                          groupValue: selectedSound,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              selectedSound = value!;
                            });
                          },
                        ),
                      )),

                  // Divider Line
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Divider(color: Colors.white),
                  ),

                  // Custom Sound Section
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Custom suara',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  ...customSounds.map((sound) => Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: RadioListTile(
                          title: Text(
                            sound,
                            style: const TextStyle(color: Colors.white),
                          ),
                          value: sound,
                          groupValue: selectedSound,
                          activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              selectedSound = value!;
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
