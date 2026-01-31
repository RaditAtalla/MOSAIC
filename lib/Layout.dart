import 'package:flutter/material.dart';
import 'package:mosaic/screens/akun_screen.dart';
import 'package:mosaic/screens/jadwal_screen.dart';
import 'package:mosaic/screens/materi_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentPage = 0;
  static const List<Widget> _pages = [
      JadwalScreen(),
      MateriScreen(),
      AkunScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFC),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 48),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            leading: CircleAvatar(
              backgroundImage: AssetImage("profile.png"),
              radius: 60,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rabu, 21 Januari 2026",
                  style: TextStyle(fontSize: 16, color: Color(0xFF3D7984)),
                ),
                Text(
                  "Hi, Radit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, color: Colors.black, size: 28),
              ),
            ],
          ),
        ),
      ),

      body: _pages[_currentPage],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: (int index) {
          print(index);
          setState(() {
            _currentPage = index;
          });
        },
        height: 100,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(color: Color(0xFF13C8EC));
            }
            return const TextStyle(color: Color(0xFF94A3B8));
          },
        ),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.calendar_today, size: 32, color: Color(0xFF94A3B8)),
            label: "Jadwal",
            selectedIcon: Icon(
              Icons.calendar_today,
              color: Color(0xFF13C8EC),
              size: 32,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book, size: 32, color: Color(0xFF94A3B8)),
            label: "Materi",
            selectedIcon: Icon(
              Icons.menu_book,
              color: Color(0xFF13C8EC),
              size: 32,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle, size: 32, color: Color(0xFF94A3B8)),
            label: "Akun",
            selectedIcon: Icon(
              Icons.account_circle,
              color: Color(0xFF13C8EC),
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
