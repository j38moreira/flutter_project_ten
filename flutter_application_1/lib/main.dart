import 'package:flutter/material.dart';

import 'data/data.dart';
import 'models/user.dart';
import 'screens/initial_area/about_screen.dart';
import 'screens/initial_area/login_screen.dart';
import 'screens/initial_area/register_screen.dart';
import 'screens/user_area/my_home_page.dart';
import 'screens/user_area/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static int currentUserId = 4;
  static User? loggedInUser;

  const MyApp({super.key});

  static void setLoggedInUser(User user) {
    loggedInUser = user;
  }

  @override
  Widget build(BuildContext context) {
    populateWithExamples();

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/about':(context) => const AboutScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MyHomePage(),
        '/profile':(context) => const ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  static void addUser({
    required String nome,
    required String email,
    required String pwd,
    int? numCCard,
    int? valCard,
    int? ccv,
    String? imgUser

  }) {
    users.add(
      User(
        currentUserId,
        nome,
        email,
        pwd,
        numCCard ?? 0,
        valCard ?? 0,
        ccv ?? 0,
        imgUser ?? 'assets/images/profile.png',
        [],
      ),
    );
    currentUserId += 1;
  }

  static bool checkLogin(String email, String pwd) {
    for (var user in users) {
      if (user.email == email && user.pwd == pwd) {
        MyApp.setLoggedInUser(user);
        return true;
      }
    }
    return false;
  }

  static bool checkEmailAvailable(String email) {
    for (var user in users) {
      if (user.email == email) {
        return false;
      }
    }
    return true;
  }

  static void populateWithExamples() {
    addUser(nome: "exemplo1", email: "exemplo1@gmail.com", pwd: "exemplo1");
    addUser(nome: "exemplo2", email: "exemplo2@gmail.com", pwd: "exemplo2");
  }

}
