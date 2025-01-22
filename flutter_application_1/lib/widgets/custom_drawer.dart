import 'package:flutter/material.dart';

class InitialDrawer extends StatelessWidget {
  const InitialDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // Background
        color: const Color.fromARGB(255, 109, 105, 105),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 65,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 126, 9, 1),
                ),
                child: Text(
                  'Menu', 
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'About the app',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed('/about'),
            ),
            ListTile(
              title: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed('/login'),
            ),
            ListTile(
              title: const Text(
                'Register',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onTap: () => Navigator.of(context).pushNamed('/register'),
            )
          ],
        ),
      )
    );
  }
}
