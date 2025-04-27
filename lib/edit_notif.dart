import 'package:flutter/material.dart';
import 'package:tubes/pagePasien.dart';
import 'package:tubes/models/pasien.dart';
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
          home: SoundNotificationScreen(
              pasienSaatIni: Pasien(), someCondition: true),
        );
      },
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Color(0xFF2A2A3C) : Color.fromARGB(255, 37, 105, 255),
        title: Text(
          'Suara Notifikasi',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
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
            colors: isDarkMode
                ? [
                    Color.fromARGB(255, 182, 181, 181), // Warna gelap atas
                    Color.fromARGB(255, 182, 181, 181), // Warna gelap bawah
                  ]
                : [
                    Color.fromARGB(255, 37, 100, 235),
                    Colors.blue.shade400 // Warna terang bawah
                  ],
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
                      color:
                          isDarkMode ? Color(0xFF2A2A3C) : Colors.blue.shade700,
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
                          color: isDarkMode
                              ? Color(0xFF2A2A3C)
                              : const Color.fromARGB(255, 37, 105, 255),
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
                          activeColor:
                              isDarkMode ? Color(0xFF00FFF5) : Colors.white,
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
                          color: isDarkMode
                              ? Color(0xFF2A2A3C)
                              : const Color.fromARGB(255, 37, 105, 255),
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
                          activeColor:
                              isDarkMode ? Color(0xFF00FFF5) : Colors.white,
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
