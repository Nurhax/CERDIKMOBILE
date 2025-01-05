import 'package:flutter/material.dart';

class PanduanDokter {
  static void showGuideDialog(BuildContext context) {
    // Daftar panduan
    final List<String> guidePages = [
      '1. Beranda Dokter:\n   - Di halaman ini, Anda dapat melihat jadwal pasien anda.\n   - Terdapat search untuk mencari nama pasien anda.',
      '2. Tambah Jadwal Pasien:\n   - Di halaman ini, Anda dapat menambahkan jadwal pasien yang terdiri dari data pasien, obat yang harus pasien minum.',
      '3. Data Obat:\n   - Di halaman ini, Anda dapat melihat informasi obat.\n   - Anda dapat menambahkan data obat yang terdiri dari nama obat,dosis obat,jenis obat, gambar obat , dan deskripsi obat.\n   - Terdapat search untuk mencari nama obat yang anda inginkan.',
      '4. Profil Pasien:\n   - Di halaman ini, Anda dapat melihat informasi profil Anda.\n   - Anda juga dapat mengakses pengaturan dan personalisasi dari sini.\n   - Anda juga dapat mengakses pusat bantuan untuk memberikan jawaban untuk pertanyaan umum (FAQ).',
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
