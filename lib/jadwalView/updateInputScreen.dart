import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes/jadwalView/showInputScreen.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'package:tubes/Models/obat.dart';
import 'package:provider/provider.dart';
import 'package:tubes/theme_provider.dart'; // Import file yang dibuat

class UpdateInputScreen extends StatefulWidget {
  final String idJadwal;
  final Function onRefresh;
  final Map<String, dynamic> jadwal;

  const UpdateInputScreen(
      {required this.onRefresh,
      Key? key,
      required this.idJadwal,
      required this.jadwal})
      : super(key: key);

  @override
  _UpdateInputScreenState createState() => _UpdateInputScreenState();
}

class _UpdateInputScreenState extends State<UpdateInputScreen> {
  late TextEditingController idPasien;
  late TextEditingController gejala;
  late TextEditingController dosis;
  late TextEditingController deskripsi;
  late TextEditingController startDate;
  late TextEditingController endDate;
  late TextEditingController jumlah;

  String? selectedNamaObat;
  String? selectedJenisObat;
  String? selectedFrekuensi;
  TimeOfDay? selectedWaktuKonsumsi;
  String? idObat;

  List<Obat> listObatDropdown = [];

  Future<void> fetchObatDropdown() async {
    try {
      final result = await Obat.fetchAllObat();
      setState(() {
        listObatDropdown = result;
      });
    } catch (e) {
      print("Gagal mengambil data obat: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    idPasien =
        TextEditingController(text: widget.jadwal['IDPasien'].toString());
    gejala = TextEditingController(text: widget.jadwal['Gejala'] ?? '');
    dosis = TextEditingController(text: widget.jadwal['Dosis'] ?? '');
    deskripsi = TextEditingController(text: widget.jadwal['Deskripsi'] ?? '');
    startDate = TextEditingController(text: widget.jadwal['Start_Date'] ?? '');
    endDate = TextEditingController(text: widget.jadwal['End_Date'] ?? '');
    jumlah =
        TextEditingController(text: widget.jadwal['Jumlah']?.toString() ?? '');
    selectedJenisObat = widget.jadwal['JenisObat'];
    selectedFrekuensi = widget.jadwal['Frekuensi'];
    String? timeString = widget.jadwal['WaktuKonsumsi'];
    selectedWaktuKonsumsi =
        timeString != null ? parseTimeOfDay(timeString) : null;
    fetchObatDropdown();
  }

  TimeOfDay? parseTimeOfDay(String timeString) {
    try {
      final format = DateFormat.jm(); // 'jm' stands for '2:25 PM'
      final dateTime = format.parse(timeString);
      return TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      print('Error parsing time: $e');
      return null;
    }
  }

  Future<void> submitForm() async {
    if (selectedNamaObat != "" &&
        gejala.text.isNotEmpty &&
        dosis.text.isNotEmpty &&
        startDate.text.isNotEmpty &&
        endDate.text.isNotEmpty &&
        selectedJenisObat != null &&
        selectedFrekuensi != null &&
        selectedWaktuKonsumsi != null) {
      try {
        Map<String, String> data = {
          "IDJadwal": widget.idJadwal,
          "IDPasien": idPasien.text,
          "IDObat": idObat!,
          "NamaObat": selectedNamaObat!,
          "Gejala": gejala.text, // Sesuaikan nama field
          "Dosis": jumlah.text, // Sesuaikan nama field
          "Deskripsi": deskripsi.text,
          "JenisObat": selectedJenisObat!,
          "Start_Date": startDate.text,
          "End_Date": endDate.text,
          "WaktuKonsumsi": formatTimeOfDay(selectedWaktuKonsumsi!),
          "Frekuensi": selectedFrekuensi!, // Tambahan field jika diperlukan
          "IsConfirmedNakes": "0"
        };

        print(selectedFrekuensi);

        final response = await JadwalService.updateJadwal(data);
        if (response["status"] == "success") {
          Navigator.pop(context);
          widget.onRefresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Jadwal successfully updated")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update Jadwal")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields")),
      );
    }
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedWaktuKonsumsi = picked;
        print(selectedWaktuKonsumsi);
      });
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
          "Update Jadwal",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isDarkMode
            ? Color(0xFF2A2A3C)
            : const Color.fromARGB(255, 37, 105, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                    isDarkMode ? 'img/pillDark.png' : 'assets/images/pills.png',
                    width: 100,
                    height: 100),
              ),
              TextField(
                controller: idPasien,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Masukkan ID Pasien",
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Nama Obat",
                          style: TextStyle(color: Colors.black),
                        ),
                        DropdownButtonFormField(
                          value: selectedNamaObat,
                          style: TextStyle(color: Colors.black),
                          items: listObatDropdown.map((obat) {
                            return DropdownMenuItem<String>(
                              value: obat.nama,
                              child: Text(
                                obat.nama!,
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedNamaObat = value;

                              final selectedObat = listObatDropdown
                                  .firstWhere((obat) => obat.nama == value);

                              deskripsi.text = selectedObat.deskripsi ?? '';
                              gejala.text = selectedObat.gejalaObat ?? '';
                              idObat = selectedObat.idObat;
                              final jenis = selectedObat.jenis;
                              if (jenis == 'Kapsul' ||
                                  jenis == 'Tablet' ||
                                  jenis == 'Obat cair' ||
                                  jenis == 'Cream' ||
                                  jenis == 'Lotion, gel' ||
                                  jenis == 'Suntiokan') {
                                selectedJenisObat = jenis;
                              } else {
                                selectedJenisObat = 'Tablet'; // default
                              }
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Input Obat Baru",
                            hintStyle: TextStyle(
                              color: isDarkMode ? Colors.white70 : Colors.black,
                            ),
                            filled: true,
                            fillColor: isDarkMode
                                ? Color(0xFF2A2A3C)
                                : const Color.fromARGB(255, 37, 105, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          dropdownColor: isDarkMode
                              ? Color(0xFF2A2A3C)
                              : const Color.fromARGB(255, 37, 105, 255),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Penyakit",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextField(
                          controller: gejala,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Masukkan penyakit",
                            hintStyle: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text("Deskripsi", style: TextStyle(color: Colors.black)),
                  TextField(
                    controller: deskripsi,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Masukkan deskripsi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Color.fromARGB(255, 231, 231, 231)
                          : Color(0xFFBFDBFE), // Background color
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(255, 179, 178, 178)),
                    ),
                    maxLines: 8,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Jenis Obat",
                    style: TextStyle(color: Colors.black),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'Kapsul';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'Kapsul'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.medication,
                              size: 50,
                              color: selectedJenisObat == 'Kapsul'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Color.fromARGB(255, 201, 201, 201)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'Tablet';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'Tablet'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.circle_rounded,
                              size: 50,
                              color: selectedJenisObat == 'Tablet'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Color.fromARGB(255, 206, 206, 206)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'Obat cair';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'Obat cair'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.water_drop,
                              size: 50,
                              color: selectedJenisObat == 'Obat cair'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Color.fromARGB(255, 206, 206, 206)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'Lotion, gel';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'Lotion, gel'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.medication_liquid_rounded,
                              size: 50,
                              color: selectedJenisObat == 'Lotion, gel'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Color.fromARGB(255, 206, 206, 206)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'Cream';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'Cream'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.medication_liquid,
                              size: 50,
                              color: selectedJenisObat == 'Cream'
                                  ? (isDarkMode
                                      ? Color(0xFF00FFF5)
                                      : const Color.fromARGB(255, 37, 105, 255))
                                  : isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : Color.fromARGB(255, 206, 206, 206)),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedJenisObat = 'Suntikan';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedJenisObat == 'Suntikan'
                                    ? (isDarkMode
                                        ? Color(0xFF00FFF5)
                                        : const Color.fromARGB(
                                            255, 37, 105, 255))
                                    : Colors.transparent,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(Icons.vaccines,
                                size: 50,
                                color: selectedJenisObat == 'Suntikan'
                                    ? (isDarkMode
                                        ? Color(0xFF00FFF5)
                                        : const Color.fromARGB(
                                            255, 37, 105, 255))
                                    : isDarkMode
                                        ? Color(0xFF2A2A3C)
                                        : Color.fromARGB(255, 206, 206, 206)),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Mulai",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextField(
                          readOnly: true,
                          controller: startDate,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "17 Juni 2024",
                            hintStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : const Color.fromARGB(
                                          255, 179, 178, 178)),
                              onPressed: () => _selectDate(context, startDate),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Selesai",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextField(
                          readOnly: true,
                          controller: endDate,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "22 Juni 2024",
                            hintStyle: TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today,
                                  color: isDarkMode
                                      ? Color(0xFF2A2A3C)
                                      : const Color.fromARGB(
                                          255, 179, 178, 178)),
                              onPressed: () => _selectDate(context, endDate),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Waktu Konsumsi",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedWaktuKonsumsi?.format(context) ?? '',
                    ),
                    decoration: InputDecoration(
                      hintText: "08.00 - 10.00",
                      hintStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time,
                            color: isDarkMode
                                ? Color(0xFF2A2A3C)
                                : const Color.fromARGB(255, 179, 178, 178)),
                        onPressed: () => _selectTime(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Jumlah",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextField(
                    controller: jumlah,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text(
                    "Frekuensi",
                    style: TextStyle(color: Colors.black),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedFrekuensi?.isNotEmpty == true
                        ? selectedFrekuensi
                        : null,
                    style: TextStyle(color: Colors.white),
                    items: [
                      DropdownMenuItem(
                          value: "Setiap Hari", child: Text("Setiap Hari")),
                      DropdownMenuItem(
                          value: "Setiap 2 Hari", child: Text("Setiap 2 Hari")),
                      // Add more options here
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFrekuensi = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Pilih frekuensi",
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.black,
                      ),
                      filled: true,
                      fillColor: isDarkMode
                          ? Color(0xFF2A2A3C)
                          : const Color.fromARGB(255, 37, 105, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    dropdownColor: isDarkMode
                        ? Color(0xFF2A2A3C)
                        : const Color.fromARGB(255, 37, 105, 255),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? Color(0xFF2A2A3C)
                      : const Color.fromARGB(
                          255, 37, 105, 255), // warna latar tombol
                  foregroundColor: isDarkMode
                      ? Color(0xFF00D1C1)
                      : Colors.white, // warna teks tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // bentuk tombol
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // ukuran
                ),
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
