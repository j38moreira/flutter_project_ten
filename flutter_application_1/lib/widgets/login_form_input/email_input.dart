import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  final void Function(String) onEmailChanged;

  const EmailInput({Key? key, required this.onEmailChanged}) : super(key: key);

  @override
  EmailInputState createState() => EmailInputState();
}

class EmailInputState extends State<EmailInput> {
  String? _email;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _email = value;
        });
        widget.onEmailChanged(_email!);
      },
    );
  }
}
