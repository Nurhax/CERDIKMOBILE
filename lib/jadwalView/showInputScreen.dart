import 'package:flutter/material.dart';
import 'package:tubes/models/manage_jadwal.dart';

class ShowInputScreen extends StatefulWidget {
  final Function onRefresh;

  ShowInputScreen({required this.onRefresh});

  @override
  _ShowInputScreenState createState() => _ShowInputScreenState();
}

class _ShowInputScreenState extends State<ShowInputScreen> {
  final TextEditingController idPasien = TextEditingController();
  final TextEditingController namaObat = TextEditingController();
  final TextEditingController penyakit = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  String? selectedJenisObat;
  String? selectedFrekuensi;
  TimeOfDay? selectedWaktuKonsumsi;

  Future<void> submitForm() async {
    if (idPasien.text.isNotEmpty &&
        namaObat.text.isNotEmpty &&
        penyakit.text.isNotEmpty &&
        startDate.text.isNotEmpty &&
        endDate.text.isNotEmpty &&
        selectedWaktuKonsumsi != null &&
        jumlah.text.isNotEmpty &&
        selectedFrekuensi != null) {
      try {
        Map<String, String> data = {
          "IDPasien": idPasien.text,
          "NamaObat": namaObat.text,
          "Gejala": penyakit.text, // Sesuaikan nama field
          "Dosis": jumlah.text, // Sesuaikan nama field
          "Deskripsi": deskripsi.text,
          "JenisObat": selectedJenisObat!,
          "Start_Date": startDate.text,
          "End_Date": endDate.text,
          "WaktuKonsumsi": selectedWaktuKonsumsi!.format(context),
          "Frekuensi": selectedFrekuensi!, // Tambahan field jika diperlukan
        };

        print('Data to be sent: $data');

        final response = await JadwalService.insertJadwal(data);
        if (response["status"] == "success") {
          Navigator.pop(context);
          widget.onRefresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Jadwal berhasil ditambahkan")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Gagal menambahkan jadwal")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } else {
      print('ID Pasien: ${idPasien.text}');
      print('Nama Obat: ${namaObat.text}');
      print('Gejala: ${penyakit.text}'); // Tambahkan log untuk field baru
      print('Dosis: ${jumlah.text}'); // Tambahkan log untuk field baru
      print('Start Date: ${startDate.text}');
      print('End Date: ${endDate.text}');
      print('Waktu Konsumsi: ${selectedWaktuKonsumsi?.format(context)}');
      print('Frekuensi: ${selectedFrekuensi}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap isi semua field yang diperlukan")),
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
    if (picked != null && picked != selectedWaktuKonsumsi) {
      setState(() {
        selectedWaktuKonsumsi = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Jadwal"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/images/pills.png',
                    width: 100, height: 100),
              ),
              TextField(
                controller: idPasien,
                decoration: InputDecoration(
                  hintText: "Masukkan ID Pasien",
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text("Nama Obat"),
                        TextField(
                          controller: namaObat,
                          decoration: InputDecoration(
                            hintText: "Masukkan nama obat",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Penyakit"),
                        TextField(
                          controller: penyakit,
                          decoration: InputDecoration(
                            hintText: "Masukkan penyakit",
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
                  Text("Deskripsi"),
                  TextField(
                    controller: deskripsi,
                    decoration: InputDecoration(
                      hintText: "Masukkan deskripsi",
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      filled: true,
                      fillColor: Color(0xFFBFDBFE), // Background color
                      hintStyle:
                          TextStyle(color: Colors.grey), // Hint text color
                    ),
                    maxLines: 8, // Number of lines for a big text area
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text("Jenis Obat"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'pil';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'pil'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/icons/pil.png',
                            width: 50, // Adjust size as needed
                            height: 50, // Adjust size as needed
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'salep';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'salep'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/icons/salep.png',
                            width: 50, // Adjust size as needed
                            height: 50, // Adjust size as needed
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'krim';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'krim'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/icons/krim.png',
                            width: 50, // Adjust size as needed
                            height: 50, // Adjust size as needed
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'botol';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'botol'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/icons/botol.png',
                            width: 50, // Adjust size as needed
                            height: 50, // Adjust size as needed
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedJenisObat = 'tablet';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedJenisObat == 'tablet'
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Image.asset(
                            'assets/icons/tablet.png',
                            width: 50, // Adjust size as needed
                            height: 50, // Adjust size as needed
                          ),
                        ),
                      ),
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
                        Text("Mulai"),
                        TextField(
                          readOnly: true,
                          controller: startDate,
                          decoration: InputDecoration(
                            hintText: "17 Juni 2024",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
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
                        Text("Selesai"),
                        TextField(
                          readOnly: true,
                          controller: endDate,
                          decoration: InputDecoration(
                            hintText: "22 Juni 2024",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
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
                  Text("Waktu Konsumsi"),
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: selectedWaktuKonsumsi?.format(context) ?? '',
                    ),
                    decoration: InputDecoration(
                      hintText: "08.00 - 10.00",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () => _selectTime(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text("Jumlah"),
                  TextField(
                    controller: jumlah,
                    decoration: InputDecoration(
                      hintText: "0",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Column(
                children: [
                  Text("Frekuensi"),
                  DropdownButtonFormField<String>(
                    value: selectedFrekuensi,
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
                      hintText: "Setiap Hari",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
