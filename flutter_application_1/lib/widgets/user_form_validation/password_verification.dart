import 'package:flutter/material.dart';

class PasswordVerification extends StatefulWidget {
  final void Function(String) onPasswordChanged;
  final String? initialValue;

  const PasswordVerification({
    Key? key,
    required this.onPasswordChanged,
    this.initialValue
  }) : super(key: key);

  @override
  PasswordVerificationState createState() => PasswordVerificationState();
}

enum PasswordStrength {
  invalid,
  weak,
  moderate,
  strong,
}

class PasswordVerificationState extends State<PasswordVerification> {
  String? _password;
  late TextEditingController _passwordController;
  PasswordStrength _passwordStrength = PasswordStrength.invalid;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: widget.initialValue);
    // Evaluates current password strength before showing the message
    if (_passwordController.text.isNotEmpty) {
      evaluatePasswordStrength(_passwordController.text);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose(); // Prevent memory leaks
    super.dispose();
  }

  void evaluatePasswordStrength(String value) {
    setState(() {
      bool hasUppercase = false;
      bool hasDigits = false;
      bool hasSpecialCharacters = false;

      for (int i = 0; i < value.length; i++) {
        // If both are set, no need to check for it anymore
        if (!hasUppercase) {
          if (value[i].toUpperCase() != value[i].toLowerCase()) {
            if (value[i] == value[i].toUpperCase()) {
              hasUppercase = true;
            }
          }
        }

        // If it has digits, no need to check for it anymore
        if (!hasDigits) {
          if (value[i].compareTo('0') >= 0 && value[i].compareTo('9') <= 0) {
            hasDigits = true;
          }
        }

        // If it has special characters, no need to check for it anymore
        if (!hasSpecialCharacters) {
          if (!value[i].toUpperCase().contains(RegExp(r'[A-Z0-9]'))) {
            hasSpecialCharacters = true;
          }
        }

        // If all conditions are met, break out of the loop
        if (hasUppercase && hasDigits && hasSpecialCharacters) {
          break;
        }
      }

      // Check if the password is valid before updating the strength
      if (value.isNotEmpty && value.length >= 6) {
        bool hasAnyConditions () {
          return hasUppercase || hasDigits || hasSpecialCharacters;
        }
        if (value.length < 10) {
          if (hasAnyConditions()) {
            _passwordStrength = PasswordStrength.moderate;
          } else {
            _passwordStrength = PasswordStrength.weak;
          }
        } else if (value.length < 15) {
          if (hasAnyConditions()) {
            _passwordStrength = PasswordStrength.strong;
          } else {
            _passwordStrength = PasswordStrength.moderate;
          }
        } else {
          _passwordStrength = PasswordStrength.strong;
        }
      } else {
        _passwordStrength = PasswordStrength.invalid;
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty || value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _password = value;
            });
            widget.onPasswordChanged(_password!);
            evaluatePasswordStrength(value);
          },
        ),
        // Display password strength indicator
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Password Strength: ${_passwordStrength.toString().split('.').last}',
            style: TextStyle(
              color: _passwordStrength == PasswordStrength.invalid
                  ? Colors.grey
                  : _passwordStrength == PasswordStrength.weak
                      ? Colors.redAccent
                      : _passwordStrength == PasswordStrength.moderate
                        ?Colors.orangeAccent
                        :Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
