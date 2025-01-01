import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tubes/models/manage_jadwal.dart';

class UpdateInputScreen extends StatefulWidget {
  final Function onRefresh;
  final Map<String, dynamic> jadwal;

  UpdateInputScreen({required this.onRefresh, required this.jadwal});

  @override
  _UpdateInputScreenState createState() => _UpdateInputScreenState();
}

class _UpdateInputScreenState extends State<UpdateInputScreen> {
  late TextEditingController idPasien;
  late TextEditingController namaObat;
  late TextEditingController gejala;
  late TextEditingController dosis;
  late TextEditingController deskripsi;
  late TextEditingController startDate;
  late TextEditingController endDate;
  late TextEditingController jumlah;

  String? selectedJenisObat;
  String? selectedFrekuensi;
  TimeOfDay? selectedWaktuKonsumsi;

  @override
  void initState() {
    super.initState();
    idPasien =
        TextEditingController(text: widget.jadwal['IDPasien'].toString());
    namaObat = TextEditingController(text: widget.jadwal['NamaObat'] ?? '');
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
    if (idPasien.text.isNotEmpty &&
        namaObat.text.isNotEmpty &&
        gejala.text.isNotEmpty &&
        dosis.text.isNotEmpty &&
        startDate.text.isNotEmpty &&
        endDate.text.isNotEmpty &&
        selectedJenisObat != null &&
        selectedFrekuensi != null &&
        selectedWaktuKonsumsi != null) {
      try {
        Map<String, String> data = {
          "IDPasien": idPasien.text,
          "NamaObat": namaObat.text,
          "Gejala": gejala.text,
          "Dosis": dosis.text,
          "Deskripsi": deskripsi.text,
          "JenisObat": selectedJenisObat!,
          "Start_Date": startDate.text,
          "End_Date": endDate.text,
          "Frekuensi": selectedFrekuensi!,
          "WaktuKonsumsi": selectedWaktuKonsumsi!.format(context),
          "Jumlah": jumlah.text,
        };
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Jadwal"),
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
                          controller: gejala,
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFFBFDBFE),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    maxLines: 8,
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
                    value: selectedFrekuensi?.isNotEmpty == true
                        ? selectedFrekuensi
                        : null,
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
