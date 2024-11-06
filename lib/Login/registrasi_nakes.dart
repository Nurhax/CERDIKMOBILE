import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFF2563EB),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 580,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              prefixIconColor: Colors.blue,
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                borderSide:
                                    BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.edit),
                              labelText: 'Nama Lengkap',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.grey),
                              prefixIconColor: Colors.blue,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.credit_card),
                              prefixIconColor: Colors.blue,
                              labelText: 'Nomor STR',
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                borderSide:
                                    BorderSide(color: Color(0xFF2563EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black38),
                              children: [
                                TextSpan(
                                  text: 'Dengan ini saya menyetujui ',
                                ),
                                TextSpan(
                                  text: 'syarat dan ketentuan ',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    decoration: TextDecoration.underline,
                                  )
                                ),
                                TextSpan(
                                  text: 'yang berlaku untuk aplikasi ini.'
                                )
                              ]
                            ), 
                            
                          )
                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Add your logo or icon here
             Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(onPressed: (){},
                  icon: const Icon(Icons.arrow_back_ios, 
                  color: Colors.white,)
                  )
                )
              ],
            ),
            Positioned(
              top: 80  ,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  Align(
                    alignment: const Alignment(0.25, 0),
                    child: Image.asset(
                      'img/loadingtop.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 1),
                  const Text(
                    'CERDIK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                    const SizedBox(height: 40),
                  const Text(
                    'REGISTRASI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                      },
                      child: const Text(
                        'Sudah Punya Akun? Log in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
