import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/app_bar_with_actions.dart';
import 'modules_page.dart';
import 'grades_page.dart';
import 'resources_page.dart';
import 'announcements_page.dart';

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const TeacherModulesPage(),
    const TeacherGradesPage(),
    const TeacherResourcesPage(),
    const TeacherAnnouncementsPage(),
  ];

  final List<String> _pageTitles = [
    'Mes Modules',
    'Notes',
    'Ressources',
    'Annonces',
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
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book_rounded),
              label: 'Modules',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grade_outlined),
              activeIcon: Icon(Icons.grade_rounded),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_outlined),
              activeIcon: Icon(Icons.folder_rounded),
              label: 'Ressources',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.campaign_outlined),
              activeIcon: Icon(Icons.campaign_rounded),
              label: 'Annonces',
            ),
          ],
        ),
      ),
    );
  }
}
