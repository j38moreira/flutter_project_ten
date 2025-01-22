import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Page'),
        backgroundColor: Colors.grey[800],
      ),
      drawer: const InitialDrawer(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'QuickDrop',
                      style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    """
Numa vista geral, engloba os seguintes pontos:\n\n\n
1) Antes do login ser efetuado:\n
1.1) Registo de utilizadores novos\n
1.2) Login de utilizadores existentes\n\n\n
2) Depois do login ser efetuado:\n
...
(as nossas funcionalidades depois)
                  """,
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.green,
                    ),
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
