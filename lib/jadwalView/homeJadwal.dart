import 'package:flutter/material.dart';
import 'package:tubes/jadwalView/updateInputScreen.dart';

import 'package:tubes/models/jadwal.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'showInputScreen.dart';
import 'jadwal_detail.dart'; // Import the detail screen

class HomeScreen extends StatefulWidget {

  final String? patientId; 

  const HomeScreen({Key? key, this.patientId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Index for schedule page
  late Future<List<JadwalObat>> _futureJadwalObat;

  @override
  void initState() {
    super.initState();
    // Fetch data based on patientId if provided
    if (widget.patientId != null) {
      _futureJadwalObat = JadwalService.fetchJadwalById(widget.patientId!);
    } else {
      _futureJadwalObat = JadwalService.fetchJadwalObat();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshData() {
    setState(() {
      if (widget.patientId != null) {
        _futureJadwalObat = JadwalService.fetchJadwalById(widget.patientId!);
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
            onRefresh:
                refreshData, idJadwal: jadwal.idJadwal, // Call a method to refresh the list after editing
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
        return 'assets/icons/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Obat'),
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
                      color: Colors.white,
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
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text('Gejala: ${jadwal.gejala}'),
                                Text('Dosis: ${jadwal.dosis}'),
                                Text('Waktu Konsumsi: ${jadwal.waktuKonsumsi}'),
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
       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowInputScreen(onRefresh: refreshData),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
