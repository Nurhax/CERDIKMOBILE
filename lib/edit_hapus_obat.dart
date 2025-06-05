import 'package:flutter/material.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/obat.dart';
import 'pageDokter.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat

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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          home: AddMedicineScreen(nakesSaatIni: Nakes(), someCondition: true),
        );
      },
    );
  }
}

class AddMedicineScreen extends StatelessWidget {
  final bool someCondition;
  final Nakes nakesSaatIni;
  final TextEditingController _medicineNameController = TextEditingController();

  AddMedicineScreen(
      {super.key, required this.someCondition, required this.nakesSaatIni});

  @override
  Widget build(BuildContext context) {
    print(nakesSaatIni.id);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageDokter(
                  initialIndex: 2,
                  nakesSaatIni: nakesSaatIni,
                ),
              ),
            );
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
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            // Input Field
            TextFormField(
              controller: _medicineNameController,
              decoration: InputDecoration(
                hintText: "Ketik nama obat",
                hintStyle: TextStyle(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 51, 51, 51)
                      : Colors.grey,
                ),
                fillColor: Colors.blue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 51, 51, 51)
                        : Colors.blue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 51, 51, 51)
                          : Colors.blue,
                      width: 3.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Ketikkan Obat Pada Kolom Di Atas",
              style: TextStyle(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 51, 51, 51)
                      : Colors.grey,
                  fontSize: 14),
            ),
            const SizedBox(height: 20),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Get the entered medicine name
                  String obatName = _medicineNameController.text;
                  Obat obatData = Obat();
                  obatData.nama = obatName;

                  // Pass obatName to the next screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JenisObatPage(
                        nakesSaatIni: nakesSaatIni,
                        obatData: obatData, // Pass obatName here
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? const Color(0xFF2A2A3C)
                      : const Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Lanjutkan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Color(0xff2563eb),
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
  final Obat obatData;

  const JenisObatPage(
      {super.key, required this.nakesSaatIni, required this.obatData});

  @override
  _JenisObatPageState createState() => _JenisObatPageState();
}

class _JenisObatPageState extends State<JenisObatPage> {
  String? _selectedObat;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMedicineScreen(
                        someCondition: true,
                        nakesSaatIni: widget.nakesSaatIni,
                      )),
            );
          },
        ),
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
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
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? [
                            Color(0xFF2A2A3C), // Warna gelap atas
                            Color(0xFF2A2A3C), // Warna gelap bawah
                          ]
                        : [Color(0xff2563eb), Color(0xff60a5fa)],
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
                  widget.obatData.jenis = _selectedObat ?? '';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TambahDosisObatPage(
                        nakesSaatIni: widget.nakesSaatIni,
                        obatData: widget.obatData,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? Color(0xFF2A2A3C) : Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                child: Text(
                  "Lanjutkan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Color(0xff2563eb)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
    );
  }

  Widget _buildRadioItem(String title, IconData icon) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return ListTile(
      leading: Icon(
        icon,
        size: 40,
        color: isDarkMode ? Color(0xFF00FFF5) : Colors.white,
      ),
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
        activeColor: isDarkMode ? Color(0xFF00FFF5) : Colors.white,
      ),
    );
  }
}

class TambahDosisObatPage extends StatefulWidget {
  final Nakes nakesSaatIni;
  Obat obatData;

  TambahDosisObatPage(
      {super.key, required this.nakesSaatIni, required this.obatData});

  @override
  _TambahDosisObatPageState createState() => _TambahDosisObatPageState();
}

class _TambahDosisObatPageState extends State<TambahDosisObatPage> {
  final TextEditingController _dosisController = TextEditingController();
  String? _selectedSatuan;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            widget.obatData.dosis = _dosisController.text;
            widget.obatData.ukuran = _selectedSatuan;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => JenisObatPage(
                      nakesSaatIni: widget.nakesSaatIni,
                      obatData: widget.obatData)),
            );
          },
        ),
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
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
                  controller: _dosisController,
                  decoration: InputDecoration(
                    hintText: "Ketik dosis obat",
                    hintStyle: TextStyle(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 51, 51, 51)
                          : Colors.grey,
                    ),
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
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? [
                            Color(0xFF2A2A3C), // Warna gelap atas
                            Color(0xFF2A2A3C) // Warna gelap bawah
                          ]
                        : [Color(0xff2563eb), Color(0xff60a5fa)],
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
                  widget.obatData.dosis = _dosisController.text;
                  widget.obatData.ukuran = _selectedSatuan;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormDataObat(
                            nakesSaatIni: widget.nakesSaatIni,
                            obatData: widget.obatData)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? Color(0xFF2A2A3C) : Color(0Xffbfdbfe),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                child: Text(
                  "Lanjutkan",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Color(0xff2563eb)),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
    );
  }

  Widget _buildRadioItem(String title) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedSatuan,
        onChanged: (value) {
          setState(() {
            _selectedSatuan = value;
          });
        },
        activeColor: isDarkMode ? Color(0xFF00FFF5) : Colors.white,
      ),
    );
  }
}

//Form Data Obat (input)
class FormDataObat extends StatefulWidget {
  final Nakes nakesSaatIni;
  Obat obatData;

  FormDataObat({Key? key, required this.nakesSaatIni, required this.obatData})
      : super(key: key);

  @override
  _FormDataObatState createState() => _FormDataObatState();
}

class _FormDataObatState extends State<FormDataObat> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _obatNameController;
  late TextEditingController _dosisController;
  late TextEditingController _jenisObatController;
  late TextEditingController _satuanController;
  late TextEditingController _gejalaController;
  late TextEditingController _deskripsiController;

  @override
  void initState() {
    super.initState();
    _obatNameController = TextEditingController(text: widget.obatData.nama);
    _dosisController = TextEditingController(text: widget.obatData.dosis);
    _jenisObatController = TextEditingController(text: widget.obatData.jenis);
    _satuanController = TextEditingController(text: widget.obatData.ukuran);
    _gejalaController = TextEditingController(text: widget.obatData.gejalaObat);
    _deskripsiController =
        TextEditingController(text: widget.obatData.deskripsi);
  }

  @override
  void dispose() {
    _obatNameController.dispose();
    _dosisController.dispose();
    _jenisObatController.dispose();
    _satuanController.dispose();
    _gejalaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Form Data Obat',
          style: TextStyle(
            color: isDarkMode ? Colors.black : Colors.black, // atau sesuaikan
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Existing Fields
                    TextFormField(
                      initialValue: _obatNameController.text,
                      decoration: InputDecoration(
                        labelText: 'Nama Obat',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _obatNameController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _dosisController.text,
                      decoration: InputDecoration(
                        labelText: 'Dosis Obat',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Dosis obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _dosisController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _jenisObatController.text,
                      decoration: InputDecoration(
                        labelText: 'Jenis Obat',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jenis obat tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _jenisObatController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _satuanController.text,
                      decoration: InputDecoration(
                        labelText: 'Satuan',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Satuan tidak boleh kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _satuanController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // New Fields for Gejala and Deskripsi
                    TextFormField(
                      initialValue: _gejalaController.text,
                      decoration: InputDecoration(
                        labelText: 'Gejala Obat',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _gejalaController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _deskripsiController.text,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        labelStyle: TextStyle(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 51, 51, 51)
                              : Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deskripsiController.text = value;
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
                            // Update the Obat model with current field values.
                            widget.obatData.nama = _obatNameController.text;
                            widget.obatData.dosis = _dosisController.text;
                            widget.obatData.jenis = _jenisObatController.text;
                            widget.obatData.ukuran = _satuanController.text;
                            widget.obatData.gejalaObat = _gejalaController.text;
                            widget.obatData.deskripsi =
                                _deskripsiController.text;

                            // Call insert via the model.
                            bool success = await Obat.insertObatData(
                              widget.obatData.nama!,
                              widget.obatData.jenis!,
                              widget.obatData.dosis!,
                              widget.obatData.gejalaObat ?? '',
                              widget.obatData.deskripsi ?? '',
                              widget.obatData.ukuran!,
                            );

                            if (success) {
                              // Navigate to the confirmation page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormConfirmationPage(
                                      nakesSaatIni: widget.nakesSaatIni,
                                      obatData: widget.obatData),
                                ),
                              );
                            } else {
                              // Handle error if needed
                              print("Failed to insert data");
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? Color(0xFF2A2A3C)
                              : Color(0Xffbfdbfe),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          "Simpan Data Obat",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? Colors.white
                                  : Color(0xff2563eb)),
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
  final Obat obatData;

  const FormConfirmationPage(
      {super.key, required this.nakesSaatIni, required this.obatData});

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
            Text("Nama Obat: ${obatData.nama}"),
            Text("Dosis: ${obatData.dosis}"),
            Text("Jenis Obat: ${obatData.jenis}"),
            Text("Satuan: ${obatData.ukuran}"),
            Text("Gejala: ${obatData.gejalaObat}"),
            Text("Deskripsi: ${obatData.deskripsi}"),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => pageDokter(
                        initialIndex:
                            2, // or any index you want to open (e.g., 0 for Home)
                        nakesSaatIni: nakesSaatIni,
                      ),
                    ),
                    (route) => false, // Removes all previous routes
                  );
                },
                child: const Text("Back to Home"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EditFormDataObat extends StatefulWidget {
  final Nakes nakesSaatIni;
  final Obat obat;

  const EditFormDataObat(
      {super.key, required this.nakesSaatIni, required this.obat});

  @override
  _EditFormDataObatState createState() => _EditFormDataObatState();
}

class _EditFormDataObatState extends State<EditFormDataObat> {
  late TextEditingController obatNameController;
  late TextEditingController jenisObatController;
  late TextEditingController dosisController;
  late TextEditingController deskripsiController;
  late TextEditingController gejalaObatController;
  late TextEditingController ukuranController;
  String oldObatname = '';

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing Obat data
    obatNameController = TextEditingController(text: widget.obat.nama);
    oldObatname = widget.obat.nama!;
    jenisObatController = TextEditingController(text: widget.obat.jenis);
    dosisController = TextEditingController(text: widget.obat.dosis);
    deskripsiController = TextEditingController(text: widget.obat.deskripsi);
    gejalaObatController = TextEditingController(text: widget.obat.gejalaObat);
    ukuranController = TextEditingController(text: widget.obat.ukuran);
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    obatNameController.dispose();
    jenisObatController.dispose();
    dosisController.dispose();
    deskripsiController.dispose();
    gejalaObatController.dispose();
    ukuranController.dispose();
    oldObatname = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Data Obat',
          style: TextStyle(
            color: isDarkMode ? Colors.black : Colors.black, // atau sesuaikan
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor:
            isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pageDokter(
                        initialIndex: 2,
                        nakesSaatIni: widget.nakesSaatIni,
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
              Text(
                "Nama obat",
                style: TextStyle(
                  color: isDarkMode
                      ? const Color.fromARGB(255, 51, 51, 51)
                      : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: obatNameController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Paracetamol",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1),
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color.fromARGB(255, 198, 198, 198)
                      : const Color(0xFFCCE5FF),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Dosis obat",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: dosisController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "3",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color:
                                  isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: isDarkMode
                                  ? Color(0xFF2A2A3C)
                                  : const Color.fromARGB(255, 37, 105, 255),
                              width: 1),
                        ),
                        filled: true,
                        fillColor: isDarkMode
                            ? const Color.fromARGB(255, 198, 198, 198)
                            : const Color(0xFFCCE5FF),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 17),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color.fromARGB(255, 198, 198, 198)
                          : const Color(0xFFCCE5FF),
                      border: Border.all(
                        color: isDarkMode
                            ? const Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "mg",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Jenis obat",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: jenisObatController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Tablet",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1),
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color.fromARGB(255, 198, 198, 198)
                      : const Color(0xFFCCE5FF),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ukuran obat",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ukuranController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "500 mg",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1),
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color.fromARGB(255, 198, 198, 198)
                      : const Color(0xFFCCE5FF),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Gejala obat",
                style: TextStyle(color: Colors.black),
              ), // Corrected to 'Gejala obat'
              const SizedBox(height: 8),
              TextFormField(
                controller: gejalaObatController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Demam, sakit kepala",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1),
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color.fromARGB(255, 198, 198, 198)
                      : const Color(0xFFCCE5FF),
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              const Text(
                "Deskripsi obat",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: deskripsiController,
                style: TextStyle(color: Colors.black),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Tulis deskripsi obat",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                        color: isDarkMode
                            ? Color(0xFF2A2A3C)
                            : const Color.fromARGB(255, 37, 105, 255),
                        width: 1),
                  ),
                  filled: true,
                  fillColor: isDarkMode
                      ? const Color.fromARGB(255, 198, 198, 198)
                      : const Color(0xFFCCE5FF),
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
                    print("Nama Obat lama: $oldObatname");

                    // Pass the 'id' along with other details
                    Obat.updateObatData(
                        widget.obat.idObat!,
                        obatNameController.text,
                        oldObatname,
                        jenisObatController.text,
                        dosisController.text,
                        deskripsiController.text,
                        gejalaObatController.text,
                        ukuranController.text);

                    print("Data updated successfully!");
                    // Close the page on success
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? Color(0xFF2A2A3C)
                        : const Color(0Xffbfdbfe),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Edit Obat",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            isDarkMode ? Color(0xFF00D1C1) : Color(0xff2563eb)),
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
