import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const PanduanPasien(someCondition: true),
    ),
  );
}

class PanduanItem {
  final String gambarPath;
  final String deskripsi;

  PanduanItem({required this.gambarPath, required this.deskripsi});
}

class PanduanPasien extends StatefulWidget {
  final bool someCondition;
  const PanduanPasien({
    super.key,
    required this.someCondition,
  });
  @override
  _PanduanPasienState createState() => _PanduanPasienState();
}

class _PanduanPasienState extends State<PanduanPasien> {
  int _currentStep = 0;

  final List<PanduanItem> _panduanList = [
    PanduanItem(
      gambarPath: 'img/homebutton.png',
      deskripsi: 'Ikon tersebut digunakan untuk menampilkan tampilan dari home',
    ),
    PanduanItem(
      gambarPath: 'img/tambahjadwal.png',
      deskripsi:
          'Ikon tersebut digunakan untuk menampilkan tampilan pada halaman kalender',
    ),
    PanduanItem(
      gambarPath: 'img/morepage.png',
      deskripsi:
          'Ikon tersebut digunakan untuk menampilkan fitur profile,personalisasi,pemandu,dan pusat bantuan',
    ),
    PanduanItem(
      gambarPath: 'img/notifIcon.png',
      deskripsi: 'ikon tersebut digunakan untuk melakukan setting notifikasi',
    ),
    PanduanItem(
      gambarPath: 'img/profileIcon.png',
      deskripsi: 'Profile digunakan untuk menampilkan data - data dari user',
    ),
    PanduanItem(
      gambarPath: 'img/personalisasiIcon.png',
      deskripsi:
          'Personalisasi digunakan untuk mengubah tema dari aplikasi dengan pilihan light mode atau dark mode',
    ),
    PanduanItem(
      gambarPath: 'img/Pusatbantuan.png',
      deskripsi:
          'Pusat bantuan digunakan untuk chat dengan chatbot yang sudah disediakan oleh sistem',
    ),
    PanduanItem(
      gambarPath: 'img/loadingbody1.png',
      deskripsi: 'Panduan selesai, selamat mencoba!',
    ),
  ];

  void _nextStep() {
    if (_currentStep < _panduanList.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      Navigator.of(context).pop(); // Keluar dari dialog
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _lewatiPanduan() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final current = _panduanList[_currentStep];

    return AlertDialog(
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        width: 300, // Tetapkan lebar tetap
        height: 330, // Tetapkan tinggi tetap
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              current.gambarPath,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              current.deskripsi,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Color(0xFF2A2A3C) : Colors.black),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevStep,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255)),
                  child: const Text('Prev'),
                ),
                ElevatedButton(
                  onPressed: _lewatiPanduan,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Lewati',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255)),
                  child: Text(
                    _currentStep == _panduanList.length - 1
                        ? 'Selesai'
                        : 'Next',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
