import 'package:elibrary/pages/home/home_page.dart';
import 'package:elibrary/pages/my_library_page.dart';
import 'package:elibrary/pages/profile_page.dart';
import 'package:elibrary/pages/progress_literasi/progress_literasi_page.dart';
import 'package:elibrary/pages/admin_app/admin_app_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationMenu extends StatefulWidget {
  static const routeName = '/menu';

  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _pageIndex = 0;

  final screenBody = [
    const HomePage(),
    const MyLibraryPage(),
    const ProgressLiterasiPage(),
    const ProfilePage(),
    const AdminAppPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screenBody[_pageIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: GNav(
                selectedIndex: _pageIndex,
                onTabChange: (index) {
                  setState(() => _pageIndex = index);
                },
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                gap: 8,
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.book_outlined,
                    text: 'My Library',
                  ),
                  GButton(
                    icon: Icons.task_outlined,
                    text: 'Progress',
                  ),
                  GButton(
                    icon: Icons.person_outline,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: Icons.admin_panel_settings_outlined,
                    text: 'Admin',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
