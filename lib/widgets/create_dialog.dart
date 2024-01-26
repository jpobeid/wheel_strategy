import 'package:flutter/material.dart';
import 'package:wheel_strategy/classes/stock.dart';
import 'package:wheel_strategy/widgets/option_features.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  final TextEditingController _controllerName = TextEditingController(text: '');
  final TextEditingController _controllerContracts =
      TextEditingController(text: '');
  final TextEditingController _controllerStrike =
      TextEditingController(text: '');
  final TextEditingController _controllerPremium =
      TextEditingController(text: '');
  final TextEditingController _controllerCost = TextEditingController(text: '');
  int _phase = 0;
  DateTime _dateExpiration = DateTime.now();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerContracts.dispose();
    _controllerStrike.dispose();
    _controllerPremium.dispose();
    _controllerCost.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 3, child: Text('Name:')),
              Expanded(
                flex: 2,
                child: TextField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero, isDense: true),
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
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Sold CS put'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Sold CC'),
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
          const Divider(),
          Row(
            children: [
              const Expanded(flex: 1, child: Text('Exp date:')),
              Expanded(
                flex: 1,
                child: TextButton(
                  child: Text(
                      '${_dateExpiration.year}-${_dateExpiration.month}-${_dateExpiration.day}'),
                  onPressed: () async {
                    DateTime today = DateTime.now();
                    DateTime lastDate = DateTime(today.year + 2, 12, 31);
                    DateTime? result = await showDatePicker(
                        context: context, firstDate: today, lastDate: lastDate);
                    if (result != null) {
                      setState(() {
                        _dateExpiration = result;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          TableCC(
            isCoveredCall: _phase == 1,
            controllerContracts: _controllerContracts,
            controllerStrike: _controllerStrike,
            controllerPremium: _controllerPremium,
            controllerCost: _controllerCost,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            try {
              Stock stock = Stock(
                name: _controllerName.text,
                phase: _phase,
                dateExpiration: _dateExpiration,
                nContracts: int.parse(_controllerContracts.text),
                strike: double.parse(_controllerStrike.text),
                premium: double.parse(_controllerPremium.text),
                cost: _controllerCost.text.isEmpty
                    ? null
                    : double.parse(_controllerCost.text),
              );
            } catch (e) {
              print(e);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
