import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../../models/user.dart';
import '../../screens/user_area/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late User? _user;
  final Uri _url = Uri.parse('https://quickdropTeN.github.io');

  @override
  void initState() {
    super.initState();
    if (MyApp.loggedInUser != null) {
      _user = MyApp.loggedInUser;
    }
  }

  void _handleLogout() {
    MyApp.loggedInUser = null;
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _editProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfilePage()),
    );
    if (result != null && result is User) {
      setState(() {
        _user = result;
      });
    }
  }

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Espere'),
            content: const Text('A abrir o website...'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (MyApp.loggedInUser == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox.shrink();
    }

    return Builder(
      builder: (context) {
        return Theme(
          data: Theme.of(context),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 32.0),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 8),
                  Text(_user!.nome),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _editProfile();
                            if (MyApp.loggedInUser != null) {
                              setState(() {
                                _user = MyApp.loggedInUser;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text(
                            'Editar perfil',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _launchUrl,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                          ),
                          child: const Text(
                            'Centro de ajuda',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _handleLogout,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16.0),
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
