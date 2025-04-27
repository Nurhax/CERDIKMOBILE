import 'package:flutter/material.dart';
import 'package:tubes/login.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/pasien.dart';
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
          home: ProfileScreen.pasien(
              pasienSaatini: Pasien(), someCondition: true),
        );
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final bool someCondition;
  final Pasien? pasienSaatini;
  final Nakes? nakesSaatini;
  const ProfileScreen.pasien(
      {super.key, required this.someCondition, required this.pasienSaatini})
      : nakesSaatini = null;
  @override
  const ProfileScreen.nakes(
      {super.key, required this.someCondition, required this.nakesSaatini})
      : pasienSaatini = null;
  //isiNakes

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Color.fromARGB(255, 182, 181, 181) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue[400],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Top Section with Half-circle and Profile Icon
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    isDarkMode ? Color(0xFF2A2A3C) : Colors.blue[400]!,
                    isDarkMode ? Color(0xFF2A2A3C) : Colors.blue[600]!
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width,
                      100,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            isDarkMode ? Color(0xFF00FFF5) : Colors.blue[400]!,
                        width: 3),
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: isDarkMode ? Color(0xFF00FFF5) : Colors.blue[400],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          // Profile Fields
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              //nanti ganti datanya sesuai akun yang masuk
              children: [
                if (pasienSaatini != null) ...[
                  _buildProfileField(
                      Icons.person, '${pasienSaatini!.username}', context),
                  _buildProfileField(
                      Icons.edit, '${pasienSaatini!.nama}', context),
                  _buildProfileField(
                      Icons.email, '${pasienSaatini!.email}', context),
                  _buildProfileField(
                      Icons.calendar_today, '${pasienSaatini!.usia}', context),
                  _buildProfileField(
                      Icons.person_outline, '${pasienSaatini!.gender}', context)
                ],
                if (nakesSaatini != null) ...[
                  _buildProfileField(
                      Icons.person, '${nakesSaatini!.username}', context),
                  _buildProfileField(
                      Icons.edit, '${nakesSaatini!.namaLengkap}', context),
                  _buildProfileField(
                      Icons.no_accounts, '${nakesSaatini!.nomorSTR}', context),
                  _buildProfileField(
                      Icons.email, '${nakesSaatini!.email}', context),
                ]
              ],
            ),
          ),

          const Spacer(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login(someCondition: true)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'LOGOUT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField(IconData icon, String text, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
            color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
