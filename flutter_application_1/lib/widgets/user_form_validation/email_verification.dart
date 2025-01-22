import 'package:flutter/material.dart';
import '../../main.dart';

class EmailVerification extends StatefulWidget {
  final void Function(String) onEmailChanged;
  final String? initialValue;

  const EmailVerification({
    Key? key,
    required this.onEmailChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  EmailVerificationState createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {
  String? _email;
  bool _isEmailAvailable = true;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }

        // Check if the email is available using the checkEmailAvailable function
        _isEmailAvailable = MyApp.checkEmailAvailable(value);

        if (!_isEmailAvailable) {
          return 'This email is already taken';
        }

        return null;
      },
      onChanged: (value) {
        setState(() {
          _email = value;
        });
        widget.onEmailChanged(_email!);
      },
    );
  }
}
