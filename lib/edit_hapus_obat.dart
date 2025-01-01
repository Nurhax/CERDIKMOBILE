import 'package:flutter/material.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/obat.dart';
import 'pageDokter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddMedicineScreen(
        nakesSaatIni: Nakes(),
      ),
    );
  }
}

class AddMedicineScreen extends StatelessWidget {
  final Nakes nakesSaatIni;
  final TextEditingController _medicineNameController = TextEditingController();

  AddMedicineScreen({super.key, required this.nakesSaatIni}); // Removed 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'img/medicineTambahObat.png',
                width: 110,
                height: 110,
              ),
            ),
            const SizedBox(height: 38),
            const Text(
              "Obat Apa Yang Ingin Kamu Tambahkan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            // Input Field
            TextFormField(
              controller: _medicineNameController,
              decoration: InputDecoration(
                hintText: "Ketik nama obat",
                hintStyle: const TextStyle(color: Colors.grey),
                fillColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 3.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Ketikkan Obat Pada Kolom Di Atas",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get the entered medicine name
                  String obatName = _medicineNameController.text;

                  // Pass obatName to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JenisObatPage(
                        nakesSaatIni: nakesSaatIni,
                        obatName: obatName, // Pass obatName here
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2563eb),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JenisObatPage extends StatefulWidget {
  final Nakes nakesSaatIni;
  final String obatName; // Add the obat name

  const JenisObatPage(
      {super.key, required this.nakesSaatIni, required this.obatName});

  @override
  _JenisObatPageState createState() => _JenisObatPageState();
}

class _JenisObatPageState extends State<JenisObatPage> {
  String? _selectedObat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'img/first-aid-kit.png',
                  width: 90,
                  height: 90,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Jenis Obat',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih Jenis Obat',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff2563eb), Color(0xff60a5fa)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListView(
                  children: [
                    _buildRadioItem('Kapsul', Icons.medication),
                    _buildRadioItem('Tablet', Icons.circle_rounded),
                    _buildRadioItem('Obat cair', Icons.water_drop),
                    _buildRadioItem(
                        'Lotion, gel', Icons.medication_liquid_rounded),
                    _buildRadioItem('Cream', Icons.medication_liquid),
                    _buildRadioItem('Suntikan', Icons.vaccines),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahDosisObatPage(
                        nakesSaatIni: widget.nakesSaatIni,
                        obatName: widget.obatName,
                        jenisObat: _selectedObat ?? '',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2563eb)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildRadioItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, size: 40, color: Colors.white),
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedObat,
        onChanged: (value) {
          setState(() {
            _selectedObat = value;
          });
        },
        activeColor: Colors.white,
      ),
    );
  }
}

class TambahDosisObatPage extends StatefulWidget {
  final Nakes nakesSaatIni;
  final String obatName;
  final String jenisObat;

  const TambahDosisObatPage({
    super.key,
    required this.nakesSaatIni,
    required this.obatName,
    required this.jenisObat,
  });

  @override
  _TambahDosisObatPageState createState() => _TambahDosisObatPageState();
}

class _TambahDosisObatPageState extends State<TambahDosisObatPage> {
  String? _selectedDosis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JenisObatPage(
                      nakesSaatIni: widget.nakesSaatIni,
                      obatName: widget.obatName)),
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'img/syringe.png',
                  width: 110, // adjust as needed
                  height: 110, // adjust as needed
                ),
                const SizedBox(height: 3),
                const Text(
                  'Tambahkan Dosis Obat',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dosis Obat',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Ketik dosis obat",
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Satuan Ukuran',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff2563eb), Color(0xff60a5fa)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  children: [
                    _buildRadioItem('mg'),
                    _buildRadioItem('mcg'),
                    _buildRadioItem('g'),
                    _buildRadioItem('ml'),
                    _buildRadioItem('%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FormDataObat(nakesSaatIni: widget.nakesSaatIni)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2563eb)),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildRadioItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedDosis,
        onChanged: (value) {
          setState(() {
            _selectedDosis = value;
          });
        },
        activeColor: Colors.white,
      ),
    );
  }
}

//Form Data Obat (input)
class FormDataObat extends StatefulWidget {
  final Nakes nakesSaatIni;

  const FormDataObat({super.key, required this.nakesSaatIni});

  @override
  _FormDataObatState createState() => _FormDataObatState();
}

class _FormDataObatState extends State<FormDataObat> {
  final _formKey = GlobalKey<FormState>();
  String? _obatName;
  String? _dosis;
  String? _jenisObat;
  String? _satuan;
  String? _gejala; // New field
  String? _deskripsi; // New field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Form Data Obat',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Existing Fields
                    TextFormField(
                      initialValue: _obatName,
                      decoration: InputDecoration(
                        labelText: 'Nama Obat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _obatName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _dosis,
                      decoration: InputDecoration(
                        labelText: 'Dosis Obat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Dosis obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _dosis = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _jenisObat,
                      decoration: InputDecoration(
                        labelText: 'Jenis Obat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _jenisObat = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _satuan,
                      decoration: InputDecoration(
                        labelText: 'Satuan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Satuan tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _satuan = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // New Fields for Gejala and Deskripsi
                    TextFormField(
                      initialValue: _gejala,
                      decoration: InputDecoration(
                        labelText: 'Gejala Obat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _gejala = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _deskripsi,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deskripsi = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Debugging: Print all the field values
                            print("Submitting Data:");
                            print("Nama Obat: $_obatName");
                            print("Dosis: $_dosis");
                            print("Jenis Obat: $_jenisObat");
                            print("Satuan: $_satuan");
                            print("Gejala: $_gejala");
                            print("Deskripsi: $_deskripsi");

                            // Call insertObatData from the Obat model, including the missing dosis argument
                            bool success = await Obat.insertObatData(
                              _obatName!, // nama
                              _jenisObat!, // jenis
                              _dosis!, // saranPenyajian
                              _gejala ?? '', // gejala
                              _deskripsi ?? '', // deskripsi
                              _satuan!, // satuan
                            );

                            if (success) {
                              // Navigate to the confirmation page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormConfirmationPage(
                                    nakesSaatIni: widget.nakesSaatIni,
                                    obatName: _obatName!,
                                    dosis: _dosis!,
                                    jenisObat: _jenisObat!,
                                    satuan: _satuan!,
                                    gejala: _gejala ?? '',
                                    deskripsi: _deskripsi ?? '',
                                  ),
                                ),
                              );
                            } else {
                              // Handle error if needed
                              print("Failed to insert data");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0Xffbfdbfe),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          "Simpan Data Obat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2563eb)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormConfirmationPage extends StatelessWidget {
  final Nakes nakesSaatIni;
  final String obatName;
  final String dosis;
  final String jenisObat;
  final String satuan;
  final String gejala;
  final String deskripsi;

  const FormConfirmationPage({
    super.key,
    required this.nakesSaatIni,
    required this.obatName,
    required this.dosis,
    required this.jenisObat,
    required this.satuan,
    required this.gejala,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Data Obat yang Dimasukkan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Nama Obat: $obatName"),
            Text("Dosis: $dosis"),
            Text("Jenis Obat: $jenisObat"),
            Text("Satuan: $satuan"),
            Text("Gejala: $gejala"),
            Text("Deskripsi: $deskripsi"),
          ],
        ),
      ),
    );
  }
}

class EditFormDataObat extends StatelessWidget {
  final Nakes nakesSaatIni;
  final String initialObatName;
  final String initialJenisObat;
  final String initialDosis;
  final String initialDeskripsi;
  final String initialGejalaObat; // Corrected to 'gejalaObat'
  final String initialUkuran;

  const EditFormDataObat({
    super.key,
    required this.nakesSaatIni,
    required this.initialObatName,
    required this.initialJenisObat,
    required this.initialDosis,
    required this.initialDeskripsi,
    required this.initialGejalaObat, // Corrected to 'gejalaObat'
    required this.initialUkuran,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController obatNameController =
        TextEditingController(text: initialObatName);
    TextEditingController jenisObatController =
        TextEditingController(text: initialJenisObat);
    TextEditingController dosisController =
        TextEditingController(text: initialDosis);
    TextEditingController deskripsiController =
        TextEditingController(text: initialDeskripsi);
    TextEditingController gejalaObatController = TextEditingController(
        text: initialGejalaObat); // Corrected to 'gejalaObat'
    TextEditingController ukuranController =
        TextEditingController(text: initialUkuran);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TambahDosisObatPage(
                        nakesSaatIni: nakesSaatIni,
                        obatName: obatNameController.text,
                        jenisObat: jenisObatController.text,
                      )),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Nama obat"),
              const SizedBox(height: 8),
              TextFormField(
                controller: obatNameController,
                decoration: InputDecoration(
                  hintText: "Paracetamol",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Dosis obat"),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dosisController,
                      decoration: InputDecoration(
                        hintText: "3",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("mg"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("Jenis obat"),
              const SizedBox(height: 8),
              TextFormField(
                controller: jenisObatController,
                decoration: InputDecoration(
                  hintText: "Tablet",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Ukuran obat"),
              const SizedBox(height: 8),
              TextFormField(
                controller: ukuranController,
                decoration: InputDecoration(
                  hintText: "500 mg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Gejala obat"), // Corrected to 'Gejala obat'
              const SizedBox(height: 8),
              TextFormField(
                controller: gejalaObatController,
                decoration: InputDecoration(
                  hintText: "Demam, sakit kepala",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              const Text("Deskripsi obat"),
              const SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tulis deskripsi obat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Submitting Data:");
                    print("Nama Obat: " + obatNameController.text);
                    print("Dosis: " + dosisController.text);
                    print("Jenis Obat:" + jenisObatController.text);
                    print("Satuan: " + ukuranController.text);
                    print("Gejala: " + gejalaObatController.text);
                    print("Deskripsi: " + deskripsiController.text);
                    Obat.updateObatData(
                      obatNameController.text,
                      jenisObatController.text,
                      dosisController.text,
                      deskripsiController.text,
                      gejalaObatController.text, // Corrected to 'gejalaObat'
                      ukuranController.text,
                    );

                    print("Data updated successfully!");
                    // Close the page on success
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0Xffbfdbfe),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Edit Obat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2563eb)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
