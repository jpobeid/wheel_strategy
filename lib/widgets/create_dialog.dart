import 'package:flutter/material.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  final TextEditingController _controllerName = TextEditingController(text: '');
  int _phase = 0;

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New stock'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Expanded(flex: 1, child: Text('Name:')),
              Expanded(
                flex: 1,
                child: TextField(
                  maxLength: 5,
                  controller: _controllerName,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(flex: 1, child: Text('Opened via:')),
              Expanded(
                flex: 1,
                child: DropdownButton(
                  value: _phase,
                  items: [
                    DropdownMenuItem(
                      child: Text('Sold CSP'),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text('Sold CC'),
                      value: 1,
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _phase = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            print(_controllerName.text);
            Navigator.of(context).pop();
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
