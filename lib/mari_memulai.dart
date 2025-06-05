import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tubes/pilihRole.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat
import 'package:tubes/Notification/noti_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //init Notfications
  NotiService().initNotification();

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
          title: 'Cerdik',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          home: HomePage(someCondition: true),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  final bool someCondition;
  const HomePage({super.key, required this.someCondition});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDarkMode ? Color(0xFF2A2A3C) : Colors.blue[300]!,
              isDarkMode ? Color(0xFF2A2A3C) : Colors.blue[700]!
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: 100, // Adjust this value to control image height
                    child: Image(
                      image: AssetImage('img/CerdikLogo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "CERDIK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 12.0,
                        color: isDarkMode
                            ? Color.fromARGB(255, 38, 202, 197)
                            : Color.fromARGB(255, 255, 255, 255),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Teman Setia\nAnda\nPengingat\nObat.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 40,
                        color: isDarkMode
                            ? Color.fromARGB(255, 38, 202, 197)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 12.0,
                            color: isDarkMode
                                ? Color.fromARGB(255, 38, 202, 197)
                                : Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    // final now = DateTime.now();
                    // final scheduleTime = DateTime(
                    //     now.year, now.month, now.day, now.hour, now.minute + 1);

                    // NotiService().scheduleNotification(
                    //   id: 999,
                    //   title: 'Test',
                    //   body: 'Custom Sound Test',
                    //   hour: scheduleTime.hour,
                    //   minute: scheduleTime.minute,
                    //   soundName: 'aurora',
                    // );

                    // print(
                    //     'Notification scheduled for ${scheduleTime.toLocal()} with sound aurora');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Pilihrole(someCondition: true)),
                    );
                  },
                  child: Text(
                    'Mari Memulai',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? Color.fromARGB(255, 38, 202, 197)
                        : Colors.white,
                    foregroundColor: isDarkMode ? Colors.white : Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
