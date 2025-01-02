import 'package:flutter/material.dart';

class PanduanPasien {
  static void showGuideDialog(BuildContext context) {
    // Daftar panduan
    final List<String> guidePages = [
      '1. Beranda Pasien:\n   - Di halaman ini, Anda dapat melihat pengingat obat yang harus diminum saat ini dan yang akan datang.\n   - Tekan ikon check untuk mengonfirmasi bahwa Anda telah meminum obat.\n   - Ikon notifikasi digunakan sebagai setting notifikasi pengingat obat.',
      '2. Jadwal Pasien:\n   - Di halaman ini, Anda dapat melihat jadwal obat berdasarkan tanggal.\n   - Pilih tanggal untuk melihat obat yang harus diminum pada hari tersebut.',
      '3. Profil Pasien:\n   - Di halaman ini, Anda dapat melihat informasi profil Anda.\n   - Anda juga dapat mengakses pengaturan dan personalisasi dari sini.\n   - Anda juga dapat mengakses pusat bantuan untuk memberikan jawaban untuk pertanyaan umum (FAQ).',
    ];

    // Menggunakan PageController untuk mengelola halaman
    PageController pageController = PageController();
    int currentPage = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 23, 85, 221),
              title: const Text(
                'Panduan Penggunaan',
                style: TextStyle(color: Colors.white),
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 150,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: guidePages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            guidePages[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Tutup',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      const Text('Prev', style: TextStyle(color: Colors.white)),
                  onPressed: currentPage > 0
                      ? () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
                TextButton(
                  child:
                      const Text('Next', style: TextStyle(color: Colors.white)),
                  onPressed: currentPage < guidePages.length - 1
                      ? () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
