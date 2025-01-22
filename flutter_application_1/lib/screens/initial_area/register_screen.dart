import 'package:flutter/material.dart';
import '../../main.dart';
import '../../screens/initial_area/login_screen.dart';
import '../../widgets/user_form_validation/name_verification.dart';
import '../../widgets/user_form_validation/email_verification.dart';
import '../../widgets/user_form_validation/password_verification.dart';
import '../../widgets/user_form_validation/repeat_password_verification.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[800],
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 550.0,
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            child: RegisterForm(onRegister: addUser),
            ),
          ),
        ),
      ),
    );
  }

  void addUser(String name, String email, String password) {
    MyApp.addUser(nome: name, email: email, pwd: password);
  }
}

class RegisterForm extends StatefulWidget {
  final Function(String, String, String) onRegister;

  const RegisterForm({super.key, required this.onRegister});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<RepeatPasswordVerificationState> repeatPasswordKey =
      GlobalKey<RepeatPasswordVerificationState>();
  String _username = '';
  String _email = '';
  String _password = '';
  // (a linha abaixo faz um bypass do erro da IDE)
  // ignore: unused_field
  String _repeatPassword = ''; // Em uso para repeat_password_verification.dart


  void updateName(String username) {
    setState(() {
      _username = username;
    });
  }

  void updateEmail(String email) {
    setState(() {
      _email = email;
    });
  }

  void updatePassword(String password) {
    setState(() {
      _password = password;
      repeatPasswordKey.currentState?.updatePassword(password);
    });
  }

  void updateRepeatPassword(String repeatPassword) {
    setState(() {
      _repeatPassword = repeatPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 48.0,
              ),
            ),
            const SizedBox(height: 15),
            NameVerification(onNameChanged: updateName),
            const SizedBox(height: 5),
            EmailVerification(onEmailChanged: updateEmail),
            const SizedBox(height: 5),
            PasswordVerification(onPasswordChanged: updatePassword),
            const SizedBox(height: 5),
            RepeatPasswordVerification(
              key: repeatPasswordKey,
              onRepeatPasswordChanged: updateRepeatPassword,
              password: _password,
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      repeatPasswordKey.currentState!.isPasswordMatch()) {
                    _formKey.currentState!.save();
                    widget.onRegister(_username, _email, _password);

                    // Navigate to the login screen and show a successful registration popup after a delay
                    Navigator.pushReplacementNamed(context, '/login');
                    Future.delayed(const Duration(seconds: 2));

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Registado com sucesso'),
                          content: const Text('A tua conta foi criada com sucesso!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    'Registar',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }),
                );
              },
              child: const Text(
                'Já tens conta? Faz o login.',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}
