import 'package:flutter/material.dart';
import 'package:tubes/login.dart';
import 'package:tubes/models/nakes.dart';
import 'package:tubes/models/pasien.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen.pasien(pasienSaatini: Pasien()),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final Pasien? pasienSaatini;
  final Nakes? nakesSaatini;
  const ProfileScreen.pasien({super.key, required this.pasienSaatini})
      : nakesSaatini = null;
  @override
  const ProfileScreen.nakes({super.key, required this.nakesSaatini})
      : pasienSaatini = null;
  //isiNakes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 37, 100, 235),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 37, 100, 235)!, Color.fromARGB(255, 70, 122, 238)!],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
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
                    border: Border.all(color: Color.fromARGB(255, 70, 122, 238)!, width: 3),
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color.fromARGB(255, 37, 100, 235),
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
                      Icons.person, '${pasienSaatini!.username}'),
                  _buildProfileField(Icons.edit, '${pasienSaatini!.nama}'),
                  _buildProfileField(Icons.email, '${pasienSaatini!.email}'),
                  _buildProfileField(
                      Icons.calendar_today, '${pasienSaatini!.usia}'),
                  _buildProfileField(
                      Icons.person_outline, '${pasienSaatini!.gender}')
                ],
                if (nakesSaatini != null) ...[
                  _buildProfileField(Icons.person, '${nakesSaatini!.username}'),
                  _buildProfileField(
                      Icons.edit, '${nakesSaatini!.namaLengkap}'),
                  _buildProfileField(
                      Icons.no_accounts, '${nakesSaatini!.nomorSTR}'),
                  _buildProfileField(Icons.email, '${nakesSaatini!.email}'),
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
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
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

  Widget _buildProfileField(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 37, 100, 235)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color.fromARGB(255, 37, 100, 235)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color.fromARGB(255, 37, 100, 235)),
            ),
          ),
        ],
      ),
    );
  }
}
