import 'package:flutter/material.dart';
import 'package:tubes/jadwalView/updateInputScreen.dart';

import 'package:tubes/models/jadwal.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'showInputScreen.dart';
import 'jadwal_detail.dart'; // Import the detail screen
import 'package:provider/provider.dart';
import 'package:tubes/theme_provider.dart'; // Import file yang dibuat

class HomeScreen extends StatefulWidget {
  final String? patientId;

  const HomeScreen({Key? key, this.patientId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Index for schedule page
  late Future<List<JadwalObat>> _futureJadwalObat = Future.value([]);

  Future<void> _loadAndFilterJadwal() async {
    final allJadwal = await JadwalService.fetchJadwalObat();

    if (widget.patientId != null) {
      final filtered = filterJadwalByPasienId(allJadwal, widget.patientId!);
      setState(() {
        _futureJadwalObat = Future.value(filtered);
      });
    } else {
      setState(() {
        _futureJadwalObat = Future.value(allJadwal);
      });
    }
  }

  List<JadwalObat> filterJadwalByPasienId(
      List<JadwalObat> allJadwal, String pasienId) {
    return allJadwal.where((jadwal) => jadwal.idPasien == pasienId).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadAndFilterJadwal();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshData() {
    setState(() {
      if (widget.patientId != null) {
        _loadAndFilterJadwal();
      } else {
        _futureJadwalObat = JadwalService.fetchJadwalObat();
      }
    });
  }

  Future<void> handleDelete(String id) async {
    try {
      final response = await JadwalService.deleteJadwal(id);
      if (response["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Jadwal successfully deleted")),
        );
        refreshData();
      } else {
        throw Exception("Failed to delete Jadwal");
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  void _handleMenuAction(String value, JadwalObat jadwal) {
    if (value == 'Edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateInputScreen(
            jadwal: {
              'IDPasien': jadwal.idPasien,
              'NamaObat': jadwal.namaObat,
              'Gejala': jadwal.gejala,
              'Dosis': jadwal.dosis,
              'Deskripsi': jadwal.deskripsi,
              'Start_Date': jadwal.startDate,
              'End_Date': jadwal.endDate,
              'JenisObat': jadwal.jenisObat,
              'Frekuensi': jadwal.frekuensi,
              'WaktuKonsumsi': jadwal.waktuKonsumsi,
            },
            onRefresh: refreshData,
            idJadwal: jadwal
                .idJadwal, // Call a method to refresh the list after editing
          ),
        ),
      );
    } else if (value == 'Delete') {
      print('Deleting ID: ${jadwal.idJadwal}'); // Add debug log
      handleDelete(jadwal.idJadwal.toString()); // Ensure the correct ID is used
    }
  }

  String _getIconPath(String jenisObat) {
    print('jenisObat: $jenisObat'); // Debugging statement

    switch (jenisObat.trim().toLowerCase()) {
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
          'Jadwal Obat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode
            ? Color(0xFF2A2A3C)
            : const Color.fromARGB(255, 37, 105, 255),
      ),
      body: FutureBuilder<List<JadwalObat>>(
        future: _futureJadwalObat,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada jadwal obat yang tersedia.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final jadwal = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            JadwalDetailScreen(jadwal: jadwal),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Color(0xFF2A2A3C) : Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              _getIconPath(jadwal.jenisObat),
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jadwal.namaObat,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Gejala: ${jadwal.gejala}',
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  'Dosis: ${jadwal.dosis}',
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  'Waktu Konsumsi: ${jadwal.waktuKonsumsi}',
                                  style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          onSelected: (value) =>
                              _handleMenuAction(value, jadwal),
                          itemBuilder: (BuildContext context) {
                            return {'Edit', 'Delete'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      //Remove navbar random
      //  bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       label: 'Calendar',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.more_horiz),
      //       label: 'More',
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowInputScreen(
                  onRefresh: refreshData, pasienID: widget.patientId!),
            ),
          );
        },
        backgroundColor: isDarkMode
            ? Color(0xFF2A2A3C)
            : const Color.fromARGB(255, 37, 105, 255),
        child: Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
    );
  }
}
