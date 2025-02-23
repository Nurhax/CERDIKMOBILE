import 'package:flutter/material.dart';
import 'package:tubes/models/jadwal.dart';

class JadwalDetailScreen extends StatelessWidget {
  final JadwalObat jadwal;

  JadwalDetailScreen({required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(jadwal.namaObat),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                _getIconPath(jadwal.jenisObat), // Use your _getIconPath method
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Gejala: ${jadwal.gejala}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Dosis: ${jadwal.dosis}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Waktu Konsumsi: ${jadwal.waktuKonsumsi}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Jenis Obat: ${jadwal.jenisObat}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Start Date: ${jadwal.startDate}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'End Date: ${jadwal.endDate}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Add your edit functionality here
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }

  // Use your _getIconPath method
  String _getIconPath(String jenisObat) {
    switch (jenisObat.toLowerCase()) {
      case 'pil':
        return 'assets/icons/pil.png';
      case 'salep':
        return 'assets/icons/salep.png';
      case 'krim':
        return 'assets/icons/krim.png';
      case 'botol':
        return 'assets/icons/botol.png';
      case 'tablet':
        return 'assets/icons/tablet.png';
      default:
        return 'assets/icons/default.png';
    }
  }
}
