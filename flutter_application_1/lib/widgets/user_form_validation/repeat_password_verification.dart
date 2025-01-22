import 'package:flutter/material.dart';

class RepeatPasswordVerification extends StatefulWidget {
  final void Function(String) onRepeatPasswordChanged;
  final String? password;
  final String? initialValue;

  const RepeatPasswordVerification({
    Key? key,
    required this.onRepeatPasswordChanged,
    this.password,
    this.initialValue,
  }) : super(key: key);

  @override
  RepeatPasswordVerificationState createState() => RepeatPasswordVerificationState();
}

class RepeatPasswordVerificationState extends State<RepeatPasswordVerification> {
  String? _repeatPassword;
  late TextEditingController _repeatPasswordController;

  @override
  void initState() {
    super.initState();
    _repeatPasswordController = TextEditingController(text: widget.initialValue);
  }

  void updatePassword(String password) {
    setState(() {
      _repeatPassword = password;
    });
    widget.onRepeatPasswordChanged(_repeatPassword!);
  }

  bool isPasswordMatch() {
    return _repeatPassword == widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _repeatPasswordController,
      key: ValueKey(widget.password),
      decoration: const InputDecoration(labelText: 'Repeat Password'),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty || value != widget.password) {
          return 'Passwords do not match';
        }
        return null;
      },
      onChanged: (value) {
        updatePassword(value);
        widget.onRepeatPasswordChanged(_repeatPassword!);
      },
    );
  }
}
