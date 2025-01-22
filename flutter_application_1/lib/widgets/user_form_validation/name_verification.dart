import 'package:flutter/material.dart';

class NameVerification extends StatefulWidget {
  final void Function(String) onNameChanged;
  final String? initialValue;

  const NameVerification({
    Key? key,
    required this.onNameChanged,
    this.initialValue
  }) : super(key: key);

  @override
  NameVerificationState createState() => NameVerificationState();
}

class NameVerificationState extends State<NameVerification> {
  String? _name;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your username';
        }

        return null;
      },
      onChanged: (value) {
        setState(() {
          _name = value;
        });
        widget.onNameChanged(_name!);
      },
    );
  }

}
