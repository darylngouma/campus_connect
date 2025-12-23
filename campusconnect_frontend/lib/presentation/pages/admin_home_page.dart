import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_bar_with_actions.dart';
import 'admin/users_page.dart';
import 'admin/modules_management_page.dart';
import 'admin/statistics_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminStatisticsPage(),
    const AdminUsersPage(),
    const AdminModulesManagementPage(),
  ];

  final List<String> _pageTitles = [
    'Statistiques',
    'Utilisateurs',
    'Modules',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Statistiques',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              activeIcon: Icon(Icons.people_rounded),
              label: 'Utilisateurs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book_rounded),
              label: 'Modules',
            ),
          ],
        ),
      ),
    );
  }
}
