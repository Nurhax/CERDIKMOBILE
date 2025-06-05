import 'package:flutter/material.dart';
import 'package:tubes/pagePasien.dart';
import 'package:tubes/models/pasien.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'theme_provider.dart'; // Import file yang dibuat

String? selectedSound;
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

  void _handleSoundSelection(String value) {
    if (value == 'Tambah suara notifikasi') {
      _showAddSoundDialog();
    } else {
      setState(() {
        selectedSound = value;
      });
    }
  }

  void _handleAddSound(String soundName) {
    setState(() {
      customSounds.insert(customSounds.length - 1, soundName);
    });
  }

  void _showAddSoundDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomSoundDialog(
        onAdd: _handleAddSound,
      ),
    );
  }

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
                    radius: 0,
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
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image.asset(
                      'img/gambarNotif.png',
                      height: 80, // Besarkan gambar
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      'Suara Default',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                              _handleSoundSelection(value);
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

class SoundIconsRow extends StatelessWidget {
  const SoundIconsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          5,
          (index) => const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Icon(
              Icons.music_note,
              color: Color(0xFF4A90E2),
            ),
          ),
        ),
      ),
    );
  }
}

class SoundSection extends StatelessWidget {
  final String title;
  final List<String> sounds;
  final String selectedSound;
  final Function(String) onSoundSelected;

  const SoundSection({
    Key? key,
    required this.title,
    required this.sounds,
    required this.selectedSound,
    required this.onSoundSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        ...sounds.map((sound) => SoundListTile(
              sound: sound,
              selectedSound: selectedSound,
              onSoundSelected: onSoundSelected,
            )),
      ],
    );
  }
}

class SoundListTile extends StatelessWidget {
  final String sound;
  final String selectedSound;
  final Function(String) onSoundSelected;

  const SoundListTile({
    Key? key,
    required this.sound,
    required this.selectedSound,
    required this.onSoundSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4A90E2).withOpacity(0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: RadioListTile(
        title: Text(
          sound,
          style: const TextStyle(color: Colors.white),
        ),
        value: sound,
        groupValue: selectedSound,
        activeColor: Colors.white,
        onChanged: (value) => onSoundSelected(value as String),
      ),
    );
  }
}

class CustomSoundDialog extends StatelessWidget {
  final Function(String) onAdd;

  const CustomSoundDialog({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  Future<String?> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first.path;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isDarkMode ? Color(0xFF2A2A3C) : Color(0xFF4A90E2),
              isDarkMode ? Color(0xFF2A2A3C) : Color(0xFF87CEEB)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tambah Suara',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final String? filePath = await _pickAudioFile();
                if (filePath != null) {
                  onAdd('Panah asmara');
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: isDarkMode ? Color(0xFF00FFF5) : Colors.white,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Panah asmara',
                      style: TextStyle(
                        color: isDarkMode ? Color(0xFF00FFF5) : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onAdd('Panah asmara');
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Color(0xFF2A2A3C) : Colors.white,
                minimumSize: const Size(150, 45),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                        color: isDarkMode ? Color(0xFF00FFF5) : Colors.white)),
              ),
              child: Text(
                'Tambah',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
