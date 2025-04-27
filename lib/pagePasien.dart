// import 'dart:ffi';
// import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tubes/PanduanPasienPage.dart';
import 'package:tubes/edit_notif.dart';
import 'package:tubes/models/jadwal.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/opened_profile.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat
import 'package:tubes/chatPage.dart';

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

  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          home: pagePasien(
            pasienSaatIni: Pasien(),
          ),
        );
      },
    );
  }
}

class pagePasien extends StatefulWidget {
  final Pasien pasienSaatIni;
  final int initialIndex;

  const pagePasien(
      {super.key, this.initialIndex = 0, required this.pasienSaatIni});

  @override
  State<pagePasien> createState() => _pagePasienState();
}

class _pagePasienState extends State<pagePasien> {
  int _selectedIndex = 0;
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Warna latar belakang
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          BerandaPasien(pasienSaatIni: widget.pasienSaatIni),
          jadwalPasienPage(pasienSaatIni: widget.pasienSaatIni),
          profilePasien(pasienSaatIni: widget.pasienSaatIni),
        ],
      )),
      bottomNavigationBar: CurvedNavigationBar(
          index: _selectedIndex,
          backgroundColor: isDarkMode
              ? const Color.fromARGB(255, 182, 181, 181)!
              : Colors.white,
          color: isDarkMode
              ? Color(0xFF2A2A3C)
              : const Color.fromARGB(255, 37, 105, 255),
          animationDuration: const Duration(milliseconds: 350),
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
              Icons.more_horiz,
              color: Colors.white,
            ),
          ]),
    );
  }
}

class BerandaPasien extends StatefulWidget {
  final Pasien pasienSaatIni;
  const BerandaPasien({super.key, required this.pasienSaatIni});

  @override
  State<BerandaPasien> createState() => _BerandaPasienState();
}

class _BerandaPasienState extends State<BerandaPasien> {
  List<JadwalObat> semuaJadwal = [];
  List<JadwalObat> jadwalPasienSaatIni = [];
  List<JadwalObat> jadwalPasienKedepannya = [];

  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 37, 105, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Apakah Kamu Yakin\nSudah Meminum Obat Ini?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Icon(
                  Icons.medical_services,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.white, size: 30),
                      onPressed: () {
                        setState(() {
                          jadwalPasienSaatIni[index].isConfirmedNakes = "1";
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously
    fetchJadwal();
  }

  void filterJadwal(List<JadwalObat> semuaData, List<JadwalObat> jadwalSaatIni,
      List<JadwalObat> jadwalKedepannya) {
    for (var jadwal in semuaData) {
      DateTime startDate = DateTime.parse(jadwal.startDate);
      DateTime endDate = DateTime.parse(jadwal.endDate);
      DateTime now = DateTime.now();

      if ((now.isAfter(startDate) || now.isAtSameMomentAs(startDate)) &&
          (now.isBefore(endDate) || now.isAtSameMomentAs(endDate)) &&
          widget.pasienSaatIni.id == jadwal.idPasien) {
        jadwalSaatIni.add(jadwal);
      }
      if ((now.isBefore(endDate) || now.isAtSameMomentAs(endDate)) &&
          jadwal.idPasien == widget.pasienSaatIni.id) {
        jadwalKedepannya.add(jadwal);
      }
    }
  }

  bool intToBool(int value) {
    return value == 0; // Returns true if value is 0, false if value is 1
  }

  static IconData iconJadwal(String jenisObat) {
    if (jenisObat.toLowerCase().contains("tablet")) {
      return Icons.medical_services_outlined;
    } else if (jenisObat.toLowerCase().contains("kapsul")) {
      return Icons.medical_information;
    } else if (jenisObat.toLowerCase().contains("syrup") ||
        jenisObat.toLowerCase().contains("cair")) {
      return Icons.medication_liquid;
    } else if (jenisObat.toLowerCase().contains("lotion") ||
        jenisObat.toLowerCase().contains("gel")) {
      return Icons.medical_information_outlined;
    } else if (jenisObat.toLowerCase().contains("cream")) {
      return Icons.medication_outlined;
    } else {
      return Icons.medication_outlined;
    }
  }

  // Fetch Jadwal data
  Future<void> fetchJadwal() async {
    try {
      final jadwal = await JadwalService.fetchJadwalObat();
      setState(() {
        semuaJadwal = jadwal;
        filterJadwal(semuaJadwal, jadwalPasienSaatIni, jadwalPasienKedepannya);
        print(jadwalPasienSaatIni);
        print(jadwalPasienKedepannya);
      });
    } catch (error) {
      print("Failed to fetch jadwal: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    // final List<Map<String, dynamic>> reminders = [
    //   {
    //     'icon': Icons.medical_services,
    //     'title': 'Inza',
    //     'subtitle': 'Pill\n1 Buah\nSetelah Makan',
    //     'time': '08.00 - 10.00',
    //     'isCurrent': true,
    //   },
    //   {
    //     'icon': Icons.local_pharmacy,
    //     'title': 'Isoprinosine',
    //     'subtitle': 'Syrup\n1 Sendok Makan\nSebelum Makan',
    //     'time': '11.00 - 13.00',
    //     'isCurrent': false,
    //   },
    //   {
    //     'icon': Icons.medication,
    //     'title': 'Esomeprazole',
    //     'subtitle': 'Tablet\n1/2 Tablet\nSetelah Makan',
    //     'time': '20.00 - 22.00',
    //     'isCurrent': false,
    //   },
    // ];

    // final currentReminder =
    //     reminders.where((reminder) => reminder['isCurrent'] == true).toList();
    // final upcomingReminders =
    //     reminders.where((reminder) => reminder['isCurrent'] == false).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top greeting section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Color(0xFF2A2A3C)
                        : const Color.fromARGB(255, 37, 105, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Hi, ${widget.pasienSaatIni.username}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0, top: 30.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SoundNotificationScreen(
                                someCondition: true,
                                pasienSaatIni: widget.pasienSaatIni,
                              )),
                    );
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: isDarkMode
                        ? Color(0xFF2A2A3C)
                        : const Color.fromARGB(255, 37, 105, 255),
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 25.0, top: 20.0),
            child: Text(
              'Pengingat Saat Ini',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          // If there are any current reminders, display them using ListView.builder
          jadwalPasienSaatIni.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jadwalPasienSaatIni.length,
                    itemBuilder: (context, index) {
                      // final reminder = jadwalPasienSaatIni[index];
                      // final reminder = currentReminder[index];
                      return ReminderCard(
                        icon: iconJadwal(jadwalPasienSaatIni[index].jenisObat),
                        title: jadwalPasienSaatIni[index].namaObat,
                        subtitle:
                            '${jadwalPasienSaatIni[index].jenisObat}\n${jadwalPasienSaatIni[index].dosis}\n${jadwalPasienSaatIni[index].deskripsi}',
                        time: jadwalPasienSaatIni[index].waktuKonsumsi,
                        isCurrent: intToBool(int.parse(
                            jadwalPasienSaatIni[index].isConfirmedNakes)),
                        onCheckPressed: (context, index) {
                          _showConfirmationDialog(context, index);
                        },
                        indexObat: index,
                      );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/mascot.png',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Tidak ada pengingat waktu ini",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(left: 25.0, top: 20.0),
            child: Text(
              'Yang Akan Datang',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 8),
          // Use ListView.builder for upcoming reminders
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: jadwalPasienKedepannya.length,
              itemBuilder: (context, index) {
                // final reminder = upcomingReminders[index];
                return ReminderCard(
                    icon: iconJadwal(jadwalPasienKedepannya[index].jenisObat),
                    title: jadwalPasienKedepannya[index].namaObat,
                    subtitle:
                        '${jadwalPasienKedepannya[index].jenisObat}\n${jadwalPasienKedepannya[index].dosis}\n${jadwalPasienKedepannya[index].deskripsi}',
                    time: jadwalPasienKedepannya[index].waktuKonsumsi,
                    isCurrent: false,
                    indexObat: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class jadwalPasienPage extends StatefulWidget {
  final Pasien pasienSaatIni;
  const jadwalPasienPage({super.key, required this.pasienSaatIni});

  @override
  State<jadwalPasienPage> createState() => _jadwalPasienPageState();
}

class _jadwalPasienPageState extends State<jadwalPasienPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<JadwalObat> jadwalObatKalender = [];

  @override
  void initState() {
    super.initState();
    // Fetch data asynchronously
    fetchJadwal();
  }

  Future<void> fetchJadwal() async {
    try {
      final jadwal = await JadwalService.fetchJadwalObat();
      setState(() {
        jadwalObatKalender = jadwal;
      });
    } catch (error) {
      print("Failed to fetch jadwal: $error");
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay; // Mengupdate hari yang dipilih
      _focusedDay = focusedDay; // Mengupdate hari fokus
    });
  }

  // Function to filter the jadwal based on the selected date
  List<JadwalObat> getFilteredJadwal() {
    List<JadwalObat> filteredJadwal = [];

    for (var jadwal in jadwalObatKalender) {
      DateTime startDate = DateTime.parse(jadwal.startDate);
      DateTime endDate = DateTime.parse(jadwal.endDate);

      // Check if the selected date is within the start and end date range
      if (_selectedDay.isAfter(startDate.subtract(Duration(days: 1))) &&
          _selectedDay.isBefore(endDate.add(Duration(days: 1))) &&
          jadwal.idPasien == widget.pasienSaatIni.id) {
        filteredJadwal.add(jadwal);
      }
    }
    return filteredJadwal;
  }

  static IconData iconJadwal(String jenisObat) {
    if (jenisObat.toLowerCase().contains("tablet")) {
      return Icons.medical_services_outlined;
    } else if (jenisObat.toLowerCase().contains("kapsul")) {
      return Icons.medical_information;
    } else if (jenisObat.toLowerCase().contains("syrup") ||
        jenisObat.toLowerCase().contains("cair")) {
      return Icons.medication_liquid;
    } else if (jenisObat.toLowerCase().contains("lotion") ||
        jenisObat.toLowerCase().contains("gel")) {
      return Icons.medical_information_outlined;
    } else if (jenisObat.toLowerCase().contains("cream")) {
      return Icons.medication_outlined;
    } else {
      return Icons.medication_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, top: 25.0, bottom: 10.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Color(0xFF2A2A3C)
                        : const Color.fromARGB(255, 37, 105, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Hi, ${widget.pasienSaatIni.username}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, bottom: 10.0, right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SoundNotificationScreen(
                                  someCondition: false,
                                  pasienSaatIni: widget.pasienSaatIni,
                                )),
                      );
                    },
                    icon: Icon(
                      Icons.notifications,
                      color: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      size: 30.0,
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [
                          const Color(0xFF1E1E1E), // Warna gelap atas
                          const Color(0xFF2A2A2A), // Warna gelap bawah
                        ]
                      : [
                          Color.fromARGB(255, 96, 165, 250),
                          Color.fromARGB(255, 37, 100, 235),
                        ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TableCalendar(
                rowHeight: 50,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: Colors.white,
                  ),
                  weekendStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: isDarkMode
                            ? [
                                const Color(0xFF2A2A3C), // Warna gelap atas
                                const Color(0xFF2A2A3C), // Warna gelap bawah
                              ]
                            : [
                                Color.fromARGB(255, 125, 166, 255),
                                Color.fromARGB(255, 125, 166, 255),
                              ]),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 125, 166, 255),
                      Color.fromARGB(255, 125, 166, 255),
                    ]),
                    shape: BoxShape.circle,
                  ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(day, _selectedDay);
                }, // Menggunakan variabel _selectedDay
                firstDay: DateTime.utc(2007, 10, 16),
                lastDay: DateTime.utc(2026, 12, 31),
                focusedDay: _focusedDay,
                onDaySelected: _onDaySelected,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0),
                child: Text(
                  "Obat Hari Ini : ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            ),
          ),
          //pake list terus ngecek apakah tanggalnya sesuai, jika sesuai maka tampilkan
          // ReminderCard(
          //   icon: Icons.local_pharmacy,
          //   title: 'Isoprinosine',
          //   subtitle: 'Syrup\n1 Sendok Makan\nSebelum Makan',
          //   time: '11.00 - 13.00',
          //   isCurrent: false,
          // ),
          ...getFilteredJadwal().map((jadwal) {
            return ReminderCard(
                icon: iconJadwal(jadwal
                    .jenisObat), // Or use dynamic icon based on your jadwal data
                title: jadwal.namaObat,
                subtitle:
                    '${jadwal.jenisObat}\n${jadwal.dosis}\n${jadwal.deskripsi} ',
                time: jadwal.waktuKonsumsi,
                isCurrent: false,
                indexObat: 0);
          }).toList(),
        ],
      ),
    );
  }
}

class profilePasien extends StatelessWidget {
  final Pasien pasienSaatIni;
  profilePasien({super.key, required this.pasienSaatIni});

  // Tambahkan GlobalKey untuk setiap tombol
  // final GlobalKey keyProfile = GlobalKey();
  // final GlobalKey keyPersonalisasi = GlobalKey();
  // final GlobalKey keyPemandu = GlobalKey();
  // final GlobalKey keyBantuan = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [
                          const Color(0xFF2A2A3C), // Warna gelap atas
                          Color(0xFF2A2A3C), // Warna gelap bawah
                        ]
                      : [
                          const Color(0xFF2564EB), // Warna terang atas
                          const Color(0xFF60A5FA), // Warna terang bawah
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
                            color: isDarkMode
                                ? Color(0xFF2A2A3C)
                                : const Color.fromARGB(255, 37, 105, 255),
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
                            '${pasienSaatIni.username}',
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
                    // key: keyProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen.pasien(
                                someCondition: true,
                                pasienSaatini: pasienSaatIni)),
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
                    // key: keyPersonalisasi,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Consumer<ThemeProvider>(
                            builder: (context, themeProvider, child) {
                              return AlertDialog(
                                title: const Text("Mode Tampilan"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RadioListTile<bool>(
                                      value: false, // Light Mode
                                      groupValue: themeProvider.isDarkMode,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          themeProvider.toggleTheme(value);
                                          Navigator.pop(context);
                                        }
                                      },
                                      title: const Text("LIGHT MODE"),
                                      secondary: const Icon(Icons.wb_sunny,
                                          color: Colors.amber),
                                    ),
                                    RadioListTile<bool>(
                                      value: true, // Dark Mode
                                      groupValue: themeProvider.isDarkMode,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          themeProvider.toggleTheme(value);
                                          Navigator.pop(context);
                                        }
                                      },
                                      title: const Text("DARK MODE"),
                                      secondary: const Icon(
                                          Icons.nightlight_round,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
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
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => PanduanPasien(
                          someCondition: true,
                        ),
                      );
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
                    // key: keyBantuan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      // Aksi untuk tombol Pusat Bantuan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage()),
                      );
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
        ));
  }
}

class ReminderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final int indexObat;
  final bool isCurrent;
  final void Function(BuildContext, int)? onCheckPressed;

  const ReminderCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.indexObat,
    this.isCurrent = true,
    this.onCheckPressed,
  });

//Column untuk pengingat waktu obat
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isCurrent
              ? const Color.fromARGB(255, 37, 105, 255)
              : Colors.blue[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    time,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10.0),
                if (isCurrent)
                  GestureDetector(
                    onTap: () {
                      if (onCheckPressed != null) {
                        // Use the callback to notify the parent
                        onCheckPressed!(context,
                            this.indexObat); // You can pass the index here
                      }
                    },
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
