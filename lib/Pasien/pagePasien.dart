import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          Column(
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
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 105, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.account_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Hi, LOREM IPSUM',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, top: 30.0),
                    child: Icon(
                      Icons.notifications,
                      color: Color.fromARGB(255, 37, 105, 255),
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                child: Text(
                  'Pengingat Waktu Ini',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              ReminderCard(
                icon: Icons.medical_services,
                title: 'Inza',
                subtitle: 'Pill\n1 Buah\nSetelah Makan',
                time: '08.00 - 10.00',
                isCurrent: true,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                child: Text(
                  'Yang Akan Datang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              ReminderCard(
                icon: Icons.local_pharmacy,
                title: 'Isoprinosine',
                subtitle: 'Syrup\n1 Sendok Makan\nSebelum Makan',
                time: '11.00 - 13.00',
                isCurrent: false,
              ),
              ReminderCard(
                icon: Icons.medication,
                title: 'Esomeprazole',
                subtitle: 'Tablet\n1/2 Tablet\nSetelah Makan',
                time: '20.00 - 22.00',
                isCurrent: false,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 105, 255),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.account_circle, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Hi, LOREM IPSUM',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, top: 30.0),
                    child: Icon(
                      Icons.notifications,
                      color: Color.fromARGB(255, 37, 105, 255),
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 20, right: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
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
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    availableGestures: AvailableGestures.all,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white),
                      weekendStyle: TextStyle(color: Colors.white),
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 125, 166, 255),
                            Color.fromARGB(255, 125, 166, 255),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      selectedDecoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 125, 166, 255),
                            Color.fromARGB(255, 125, 166, 255),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    focusedDay: today,
                    firstDay: DateTime.utc(2007, 10, 16),
                    lastDay: DateTime.utc(2026, 12, 31),
                    onDaySelected: _onDaySelected,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Obat Hari Ini : ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              ReminderCard(
                icon: Icons.local_pharmacy,
                title: 'Isoprinosine',
                subtitle: 'Syrup\n1 Sendok Makan\nSebelum Makan',
                time: '11.00 - 13.00',
                isCurrent: false,
              ),
            ],
          ),
          //profile
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 37, 100, 235),
                      Color.fromARGB(255, 96, 165, 250)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.account_circle,
                              color: Color.fromARGB(255, 70, 122, 238),
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            Text(
                              'LOREM IPSUM',
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
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //profile
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 99, 235),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
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
                  //personalisasi
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 99, 235),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
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
                  //pemandu
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 99, 235),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
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
                  //Pusat Bantuan
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 15.0, right: 15.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 99, 235),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
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
          ),
        ],
      )),
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          animationDuration: Duration(milliseconds: 350),
          color: Color.fromARGB(255, 37, 105, 255),
          onTap: _onItemTapped,
          items: [
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

class ReminderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final bool isCurrent;

  ReminderCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isCurrent = true,
  });

//Column untuk pengingat waktu obat
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              isCurrent ? Color.fromARGB(255, 37, 105, 255) : Colors.blue[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(icon, color: Colors.white, size: 36),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.0),
                if (isCurrent)
                  Icon(Icons.check_circle, color: Colors.white, size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
