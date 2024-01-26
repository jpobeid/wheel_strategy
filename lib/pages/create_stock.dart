import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheel_strategy/classes/stock.dart';
import 'package:wheel_strategy/widgets/option_features.dart';

StateProvider dateExpirationProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

class CreateStockPage extends StatefulWidget {
  const CreateStockPage({super.key});

  @override
  State<CreateStockPage> createState() => _CreateStockPageState();
}

class _CreateStockPageState extends State<CreateStockPage> {
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
  DateTime _dateOpen = DateTime.now();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerContracts.dispose();
    _controllerStrike.dispose();
    _controllerPremium.dispose();
    _controllerCost.dispose();
    super.dispose();
  }

  Row makeDateSelector({
    required String label,
    required DateTime dateOfInterest,
    required bool isInPast,
    required Function assignPickedDate,
  }) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(label)),
        Expanded(
          flex: 1,
          child: TextButton(
            child: Text(
                '${dateOfInterest.year}-${dateOfInterest.month}-${dateOfInterest.day}'),
            onPressed: () async {
              DateTime today = DateTime.now();
              DateTime firstDate =
                  isInPast ? DateTime(today.year - 2, 1, 1) : today;
              DateTime lastDate =
                  isInPast ? today : DateTime(today.year + 2, 12, 31);
              DateTime? result = await showDatePicker(
                  context: context, firstDate: firstDate, lastDate: lastDate);
              if (result != null) {
                assignPickedDate(result);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New stock'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Name:')),
                Expanded(
                  flex: 2,
                  child: TextField(
                    maxLength: 5,
                    controller: _controllerName,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Opened via:')),
                Expanded(
                  flex: 2,
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
            makeDateSelector(
                label: 'Open date:',
                dateOfInterest: _dateOpen,
                isInPast: true,
                assignPickedDate: (DateTime result) {
                  setState(() {
                    _dateOpen = result;
                  });
                }),
            makeDateSelector(
                label: 'Exp. date:',
                dateOfInterest: _dateExpiration,
                isInPast: false,
                assignPickedDate: (DateTime result) {
                  setState(() {
                    _dateExpiration = result;
                  });
                }),
            OptionParameters(
              isCoveredCall: _phase == 1,
              controllerContracts: _controllerContracts,
              controllerStrike: _controllerStrike,
              controllerPremium: _controllerPremium,
              controllerCost: _controllerCost,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            bool isExpirationAfterOpen =
                (_dateExpiration.year > _dateOpen.year) ||
                    (_dateExpiration.year == _dateOpen.year &&
                        _dateExpiration.month > _dateOpen.month) ||
                    (_dateExpiration.year == _dateOpen.year &&
                        _dateExpiration.month == _dateOpen.month &&
                        _dateExpiration.day > _dateOpen.day);
            if (isExpirationAfterOpen) {
              try {
                Stock stock = Stock(
                  name: _controllerName.text,
                  phase: _phase,
                  dateOpen: _dateOpen,
                  dateExpiration: _dateExpiration,
                  nContracts: int.parse(_controllerContracts.text),
                  strike: double.parse(_controllerStrike.text),
                  premium: double.parse(_controllerPremium.text),
                  cost: _controllerCost.text.isEmpty
                      ? null
                      : double.parse(_controllerCost.text),
                );
                Navigator.of(context).pop(stock);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invalid input fields'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Exp. date must be after open date'),
                  duration: Duration(milliseconds: 500),
                ),
              );
            }
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
