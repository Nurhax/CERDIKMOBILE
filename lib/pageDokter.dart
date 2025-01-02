import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tubes/edit_hapus_obat.dart';
import 'package:tubes/models/jadwal.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/obat.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/opened_profile.dart';
import 'package:http/http.dart' as http;
import 'jadwalView/HomeJadwal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: pageDokter(nakesSaatIni: Nakes()),
    );
  }
}

class pageDokter extends StatefulWidget {
  final int initialIndex; // Tambahkan parameter ini
  final Nakes nakesSaatIni;

  const pageDokter(
      {super.key, this.initialIndex = 0, required this.nakesSaatIni});

  @override
  State<pageDokter> createState() => _pageDokterState();
}

class _pageDokterState extends State<pageDokter> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  late int _selectedIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Set tab awal berdasarkan parameter
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          dataPasienPage(nakesSaatIni: widget.nakesSaatIni),
          tambahPasienPage(nakesSaatIni: widget.nakesSaatIni),
          tambahObatPage(nakesSaatIni: widget.nakesSaatIni),
          morePage(nakesSaatIni: widget.nakesSaatIni),
        ],
      )),
      bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          backgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 350),
          color: const Color.fromARGB(255, 37, 105, 255),
          onTap: _onItemTapped,
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            Icon(
              Icons.all_inbox,
              color: Colors.white,
            ),
            Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ]),
    );
  }
}

class dataPasienPage extends StatefulWidget {
  final Nakes nakesSaatIni;
  dataPasienPage({super.key, required this.nakesSaatIni});

  @override
  State<dataPasienPage> createState() => _dataPasienPageState();
}

class _dataPasienPageState extends State<dataPasienPage> {
  List<Pasien> semuaPasien = [];
  List<Pasien> semuaPasienNakesSaatIni = [];
  List<Pasien> pasienHasilSearch = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPasien();
    searchController.addListener(_filterPasien);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterPasien);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchPasien() async {
    try {
      final pasien = await Pasien.fetchSemuaPasien();
      setState(() {
        semuaPasien = pasien;
        filterPasien(semuaPasien, semuaPasienNakesSaatIni);
      });
    } catch (error) {
      print("Failed to fetch jadwal: $error");
    }
  }

  void filterPasien(List<Pasien> semuaData, List<Pasien> pasienNakesSaatIni) {
    for (var dataPasien in semuaData) {
      if (dataPasien.idnakes == widget.nakesSaatIni.id) {
        pasienNakesSaatIni.add(dataPasien);
      }
    }

    for (var pasien in pasienNakesSaatIni) {
      pasien.gender = (pasien.gender == "L") ? "Pria" : "Wanita";

      if (pasien.usia != null) {
        int birthYear = int.parse(pasien.usia!.substring(6, 10)); // dd-MM-yyyy
        int age = DateTime.now().year - birthYear;
        pasien.usia = age.toString();
      }
    }

    pasienHasilSearch = List.from(pasienNakesSaatIni);
  }

  void _filterPasien() {
    String query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        pasienHasilSearch = List.from(semuaPasienNakesSaatIni);
      } else {
        pasienHasilSearch = semuaPasienNakesSaatIni.where((pasien) {
          return pasien.id?.toLowerCase().contains(query) ?? false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 37, 105, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Hi, ${widget.nakesSaatIni.username}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Search Bar
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Id Pasien",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 37, 99, 235)),
              prefixIcon: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 37, 99, 235),
              ),
              filled: true,
              fillColor: Colors.blue.shade100,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 37, 99, 235)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 37, 99, 235)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.only(left: 35.0),
          child: Column(
            children: [
              Text(
                "Jadwal Pasien Anda",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // List of Patients
        Expanded(
          child: pasienHasilSearch.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: pasienHasilSearch.length,
                  itemBuilder: (context, index) {
                    final pasien = pasienHasilSearch[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detailPageDokter(
                              pasienSaatIni: pasien,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 37, 105, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.account_circle,
                                color: Colors.white, size: 40),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pasien.nama ?? "NULL",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${pasien.usia ?? "N/A"} - ${pasien.gender ?? "N/A"}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/mascot.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Kamu belum punya pasien saat ini",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

class tambahPasienPage extends StatelessWidget {
  final Nakes nakesSaatIni;

  const tambahPasienPage({Key? key, required this.nakesSaatIni}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 37, 105, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Hi, ${nakesSaatIni.username}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        Center(
          child: Column(
            children: [
              Image.asset(
                'img/medicineTambahObat.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Tambah Jadwal\n Minum Obat Pasien',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 173, 202, 255), // Light blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TambahPasien(nakesSaatIni: nakesSaatIni), 
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tambah',
                        style: TextStyle(
                          color: Color.fromARGB(255, 37, 105, 255),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 37, 105, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
class tambahObatPage extends StatefulWidget {
  final Nakes nakesSaatIni;

  const tambahObatPage({Key? key, required this.nakesSaatIni}) : super(key: key);

  @override
  _tambahObatPageState createState() => _tambahObatPageState();
}
class _tambahObatPageState extends State<tambahObatPage> {
  final TextEditingController searchIdPasienTextController = TextEditingController();
  List<Obat> allObat = [];
  List<Obat> filteredObat = [];
  bool isLoading = true;

  // Assuming you have an instance of Nakes you need to pass to the AddMedicineScreen
  final Nakes nakesSaatIni = Nakes(); // Define or initialize your Nakes object here.

  @override
  void initState() {
    super.initState();
    _fetchAllObat();
    searchIdPasienTextController.addListener(_filterObat);
  }

  @override
  void dispose() {
    searchIdPasienTextController.dispose();
    super.dispose();
  }

  Future<void> _fetchAllObat() async {
    try {
      String uri = "http://10.0.2.2/APIPPB/view_obat.php";
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          allObat = data.map((item) => Obat.fromMap(item)).toList();
          filteredObat = List.from(allObat); // Initially show all obat
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  void _filterObat() {
    String query = searchIdPasienTextController.text.toLowerCase();
    setState(() {
      filteredObat = allObat
          .where((obat) =>
              (obat.nama?.toLowerCase().contains(query) ?? false) ||
              (obat.jenis?.toLowerCase().contains(query) ?? false) ||
              (obat.gejalaObat?.toLowerCase().contains(query) ?? false))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 37, 105, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Image(image: AssetImage('img/gambarDataObat.png')),
                            SizedBox(width: 8),
                            Text(
                              'Data Obat',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: searchIdPasienTextController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Color.fromARGB(255, 37, 99, 235)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 37, 99, 235),
                      ),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 37, 99, 235)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color.fromARGB(255, 37, 99, 235)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Text(
                    "Obat Yang Tersedia",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredObat.length,
                    itemBuilder: (context, index) {
                      final obat = filteredObat[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => detailObat(obat: obat,nakesSaatIni: nakesSaatIni),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 37, 105, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.local_pharmacy, color: Colors.white),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      obat.nama ?? "Unknown",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      obat.jenis ?? "Unknown",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMedicineScreen(nakesSaatIni: nakesSaatIni),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 37, 105, 255),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          );
  }
}

class morePage extends StatelessWidget {
  final Nakes nakesSaatIni;
  const morePage({super.key, required this.nakesSaatIni});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 37, 100, 235),
                Color.fromARGB(255, 96, 165, 250)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Row(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        color: Color.fromARGB(255, 70, 122, 238),
                        size: 60,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Text(
                        '${nakesSaatIni.username}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen.nakes(nakesSaatini: nakesSaatIni)),
                  );
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 40,
                    ),
                    Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Personalisasi
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onPressed: () {
                  // Aksi untuk tombol Personalisasi
                  print("Personalisasi button clicked");
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 40,
                    ),
                    Icon(
                      Icons.sunny,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Personalisasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Pemandu
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onPressed: () {
                  // Aksi untuk tombol Pemandu
                  print("Pemandu button clicked");
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 40,
                    ),
                    Icon(
                      Icons.chrome_reader_mode_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Pemandu",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Pusat Bantuan
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 37, 99, 235),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onPressed: () {
                  // Aksi untuk tombol Pusat Bantuan
                  print("Pusat Bantuan button clicked");
                },
                child: const Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 40,
                    ),
                    Icon(
                      Icons.wifi_calling_3_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Pusat Bantuan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class detailPageDokter extends StatefulWidget {
  final Pasien pasienSaatIni;

  detailPageDokter({super.key, required this.pasienSaatIni});

  @override
  State<detailPageDokter> createState() => _detailPageDokterState();
}

class _detailPageDokterState extends State<detailPageDokter> {
  // final Map<String, dynamic> patient;

  List<JadwalObat> semuaJadwal = [];
  List<JadwalObat> jadwalPasienSaatIni = [];
  Obat? salahSatuObatPasien = Obat();

  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously
    fetchJadwal();
  }

  void filterJadwalPasienSaatIni(
      List<JadwalObat> jadwalSemua, List<JadwalObat> jadwalSaatIni) {
    for (var jadwal in jadwalSemua) {
      if (jadwal.idPasien == widget.pasienSaatIni.id) {
        jadwalSaatIni.add(jadwal);
        // print(jadwal.idPasien);
        // print(widget.pasienSaatIni);
      }
    }
  }

  Future<void> fetchJadwal() async {
    try {
      final jadwal = await JadwalService.fetchJadwalObat();
      setState(() {
        semuaJadwal = jadwal;
        filterJadwalPasienSaatIni(semuaJadwal, jadwalPasienSaatIni);
      });
    } catch (error) {
      print("Failed to fetch jadwal: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.pasienSaatIni.nama ?? "NULL"),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoRow("Nama", widget.pasienSaatIni.nama ?? "NULL"),
            buildInfoRow(
                "Jenis Kelamin", widget.pasienSaatIni.gender ?? "NULL"),
            buildInfoRow("Umur", widget.pasienSaatIni.usia ?? "NULL"),
            buildInfoRow("Email", widget.pasienSaatIni.email ?? "NULL"),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text("Jadwal Obat",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: jadwalPasienSaatIni.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // Navigasi ke halaman detail obat
                      try {
                        final obat = await Obat.fetchObatByID(
                            int.parse(jadwalPasienSaatIni[index].idObat));
                        salahSatuObatPasien = obat;
                        // print(salahSatuObatPasien?.idObat);
                        // print(salahSatuObatPasien?.deskripsi);
                      } catch (e) {
                        print('ERROR! $e');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MedicationDetailPage(
                            obatSaatIni: salahSatuObatPasien ?? Obat(),
                            jadwalSuatuObat: jadwalPasienSaatIni[index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 37, 105, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon dengan latar belakang putih dan lingkaran
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.medication,
                                  color: Colors.white, size: 35),
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Jarak antara ikon dan teks
                          // Column untuk teks nama, dosis, dan waktu
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jadwalPasienSaatIni[index].namaObat,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  jadwalPasienSaatIni[index].dosis,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 8),
                                // Waktu yang didefinisiin bukan map euy :/
                                Row(children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      jadwalPasienSaatIni[index]
                                          .waktuKonsumsi, // Directly use the string
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 37, 105, 255),
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          // Icon untuk titik tiga di kanan atas
                          const Icon(Icons.more_vert, color: Colors.white),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(value, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class MedicationDetailPage extends StatefulWidget {
  final Obat obatSaatIni;
  final JadwalObat jadwalSuatuObat;

  const MedicationDetailPage(
      {super.key, required this.obatSaatIni, required this.jadwalSuatuObat});

  @override
  State<MedicationDetailPage> createState() => _MedicationDetailPageState();
}

class _MedicationDetailPageState extends State<MedicationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget.obatSaatIni.nama ?? "Detail Obat",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar atau ikon utama
            const Icon(
              Icons.medical_services_rounded,
              size: 100,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 16),
            // Nama obat
            Text(
              widget.jadwalSuatuObat.namaObat ?? "Nama Obat",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Deskripsi obat
            Text(
              widget.obatSaatIni.deskripsi ?? 'Tidak Ada Deskripsi Tersedia',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Jadwal Obat
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget
                      .jadwalSuatuObat.waktuKonsumsi, // Directly use the string
                  style: const TextStyle(
                    color: Color.fromARGB(255, 37, 105, 255),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            // Informasi detail obat
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                buildInfoCard("Jumlah", widget.jadwalSuatuObat.dosis),
                buildInfoCard("Jenis Obat", widget.jadwalSuatuObat.jenisObat),
                buildInfoCard("Gejala", widget.jadwalSuatuObat.gejala),
                buildInfoCard("Ukuran", widget.obatSaatIni.ukuran ?? "Mg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String value) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[400],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

//detail obat
class detailObat extends StatelessWidget {
  final Obat obat;
  final Nakes nakesSaatIni; 

  const detailObat({super.key, required this.obat,required this.nakesSaatIni});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(obat.nama ?? "Unknown Obat"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 37, 100, 235),
                    Color.fromARGB(255, 96, 165, 250)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Row(
                children: [
                  const Image(image: AssetImage('img/gambarObatDemam.png')),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        obat.nama ?? "Unknown Obat",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        obat.jenis ?? "Unknown Type",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        obat.ukuran ?? "Unknown Size",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tentang Obat",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              obat.deskripsi ?? "No description available.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the EditFormDataObat page when "Edit" is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFormDataObat(
                          nakesSaatIni: nakesSaatIni,  
                          initialObatName: obat.nama ?? "Unknown Obat",
                          initialJenisObat: obat.jenis ?? "Unknown Type",
                          initialDosis: obat.dosis ?? "Unknown Dosis", // Add the proper field from Obat
                          initialDeskripsi: obat.deskripsi ?? "No description available.",
                          initialGejalaObat: obat.gejalaObat ?? "Unknown Gejala",
                          initialUkuran: obat.ukuran ?? "Unknown Size",
                          obatId: obat.idObat ?? "0",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Color.fromARGB(255, 37, 100, 235)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Obat.deleteObatData(obat.idObat);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Hapus",
                    style: TextStyle(color: Color.fromARGB(255, 37, 100, 235)),
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
//class slicing iqbal
class TambahPasien extends StatefulWidget {
  final Nakes nakesSaatIni;
  const TambahPasien({Key? key, required this.nakesSaatIni}) : super(key: key);

  @override
  State<TambahPasien> createState() => TambahPasienState();
}

class TambahPasienState extends State<TambahPasien> {
  List<Pasien> semuaPasien = [];
  List<Pasien> pasienHasilSearch = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchPasien(); // Fetch data initially
    searchController.addListener(_filterPasien);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterPasien);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchPasien() async {
    try {
      final fetchedPasien = await Pasien.fetchSemuaPasien();
      setState(() {
        semuaPasien = fetchedPasien;
      });
    } catch (e) {
      print("Error fetching patients: $e");
    }
  }

  void _filterPasien() {
    final query = searchController.text.toLowerCase();

    setState(() {
      if (query.isNotEmpty) {
        pasienHasilSearch = semuaPasien
            .where((pasien) =>
                (pasien.id?.toLowerCase().contains(query) ?? false) ||
                (pasien.nama?.toLowerCase().contains(query) ?? false))
            .toList();
        isSearching = true;
      } else {
        isSearching = false;
        pasienHasilSearch.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'img/pasienSakit.png', // Replace with your image asset path
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Cari Pasien Lama",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "ID Pasien Lama",
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 27, 99, 235)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 27, 99, 235),
                ),
                filled: true,
                fillColor: Colors.blue.shade100,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 27, 99, 235))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 27, 99, 235))),
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
              ),
            ),
            const SizedBox(height: 20),
            // Search Results
            if (isSearching && pasienHasilSearch.isNotEmpty)
              SizedBox(
                height: 300, // Adjust height
                child: ListView.builder(
                  itemCount: pasienHasilSearch.length,
                  itemBuilder: (context, index) {
                    final pasien = pasienHasilSearch[index];
                    return ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Color.fromARGB(255, 37, 105, 255),
                          size: 40),
                      title: Text(pasien.nama ?? "No Name"),
                      subtitle: Text("ID: ${pasien.id}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TambahJadwalObatPasien(id: pasien.id!),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            else if (isSearching)
              const Text(
                "No results found",
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HasilCariPasienPage(
                      id: searchController.text,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                "Tambah ID Pasien Baru",
                style: TextStyle(
                    color: Color.fromARGB(255, 27, 99, 235), fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 173, 202, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HasilCariPasienPage extends StatefulWidget {
  final String id;
  const HasilCariPasienPage({super.key, required this.id});

  @override
  State<HasilCariPasienPage> createState() => _HasilCariPasienPageState();
}

class _HasilCariPasienPageState extends State<HasilCariPasienPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'img/pasienSakit.png', // Replace with your image asset path
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Cari Pasien Baru",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "ID Pasien Baru",
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 27, 99, 235)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 27, 99, 235),
                  ),
                  filled: true,
                  fillColor: Colors.blue.shade100,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 27, 99, 235))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 27, 99, 235))),
                  contentPadding: const EdgeInsets.only(left: 20, right: 20)),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TambahJadwalObatPasien(
                            id: searchController.text,
                          )),
                );
              },
              label: const Text(
                "Tambahkan Pasien",
                style: TextStyle(
                    color: Color.fromARGB(255, 27, 99, 235), fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 173, 202, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TambahJadwalObatPasien extends StatelessWidget {
  final String id;

  const TambahJadwalObatPasien({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
     return HomeScreen(patientId: id); // Pass the patientId to HomeScreen
  }
}