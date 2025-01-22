import 'package:flutter_application_1/screens/user_area/mapa_page.dart';

import '../../screens/user_area/atividade_page.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../screens/user_area/profile_page.dart';
//  import '../../screens/user_area/mapa_page.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysHide;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    if (MyApp.loggedInUser == null) {
      // Use Future.delayed to schedule the logic after the build phase
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });

      // Return an empty container or loading indicator while the navigation happens
      return const SizedBox.shrink();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: darkMode ? const Icon(Icons.lightbulb_outline) : const Icon(Icons.lightbulb),
            onPressed: () {
              setState(() {
                darkMode = !darkMode;
              });
            },
          ),
          title: Row(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/logo.png',
                height: 80, // Adjust the height as needed
                width: 90, // Adjust the width as needed
                scale: 1,
              ),
              const Spacer(), // Fills the available space
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              color: darkMode ? Colors.white : Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
          ],
        ),
        body: _getPage(currentPageIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          unselectedItemColor: darkMode ? Colors.white : Colors.black, // Added this line
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, color: currentPageIndex == 0 ? const Color(0xffFF7559) : null),
              label: 'Pagina Inicial',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.commute, color: currentPageIndex == 1 ? const Color(0xffFF7559) : null),
              label: 'Atividades',
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const MapaPage();
      case 1:
        return const AtividadePage();
      case 2:
        return const ProfilePage();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }
}
