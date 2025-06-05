import 'package:flutter/material.dart';
import 'package:tubes/models/jadwal.dart';
import 'package:provider/provider.dart';
import 'package:tubes/theme_provider.dart'; // Import file yang dibuat

class JadwalDetailScreen extends StatelessWidget {
  final JadwalObat jadwal;

  JadwalDetailScreen({required this.jadwal});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          jadwal.namaObat,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode
            ? Color(0xFF2A2A3C)
            : const Color.fromARGB(255, 37, 105, 255),
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

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF2A2A3C) : Colors.white,
                border: Border.all(
                  color:
                      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                      context, Icons.local_pharmacy, 'Gejala', jadwal.gejala),
                  _buildDetailRow(
                      context, Icons.donut_large_sharp, 'Dosis', jadwal.dosis),
                  _buildDetailRow(context, Icons.access_time, 'Waktu Konsumsi',
                      jadwal.waktuKonsumsi),
                  _buildDetailRow(
                      context, Icons.category, 'Jenis Obat', jadwal.jenisObat),
                  _buildDetailRow(context, Icons.calendar_today, 'Start Date',
                      jadwal.startDate),
                  _buildDetailRow(
                      context, Icons.event, 'End Date', jadwal.endDate),
                ],
              ),
            ),
            // Text(
            //   'Gejala: ${jadwal.gejala}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   'Dosis: ${jadwal.dosis}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   'Waktu Konsumsi: ${jadwal.waktuKonsumsi}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   'Jenis Obat: ${jadwal.jenisObat}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   'Start Date: ${jadwal.startDate}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Text(
            //   'End Date: ${jadwal.endDate}',
            //   style: TextStyle(fontSize: 18),
            // ),
            // Add more details as needed
            Spacer(),
            //Unused edit button
            // ElevatedButton(
            //   onPressed: () {
            //     // Add your edit functionality here
            //   },
            //   child: Text('Edit'),
            // ),
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
        return 'assets/icons/tablet.png';
    }
  }
}

Widget _buildDetailRow(
    BuildContext context, IconData icon, String label, String value) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  final isDarkMode = themeProvider.isDarkMode;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: isDarkMode
          ? Color.fromARGB(255, 39, 39, 53)
          : Colors.grey.shade100, // Ganti warna di sini
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            color: isDarkMode ? Colors.white70 : Colors.black87, size: 20),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
