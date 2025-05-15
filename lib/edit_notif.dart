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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Suara Notifikasi',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.someCondition
                      ? pagePasien(
                          initialIndex: 0, pasienSaatIni: widget.pasienSaatIni)
                      : pagePasien(
                          initialIndex: 1, pasienSaatIni: widget.pasienSaatIni),
                ),
              );
            },
            child: const Text(
              'Simpan',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 37, 100, 235), Colors.blue.shade400],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight),
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
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Suara Default',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    ...defaultSounds.map((sound) => Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: RadioListTile(
                            tileColor: Colors.transparent,
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Divider(color: Colors.white),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Custom suara',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    ...customSounds.map((sound) => Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: RadioListTile(
                            tileColor: Colors.transparent,
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
        ],
      ),
    );
  }
}