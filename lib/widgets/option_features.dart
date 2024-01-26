import 'package:flutter/material.dart';

class OptionParameters extends StatelessWidget {
  final bool isCoveredCall;
  final TextEditingController controllerContracts;
  final TextEditingController controllerCost;
  final TextEditingController controllerStrike;
  final TextEditingController controllerPremium;

  const OptionParameters({
    super.key,
    required this.isCoveredCall,
    required this.controllerContracts,
    required this.controllerCost,
    required this.controllerStrike,
    required this.controllerPremium,
  });

  Row makeQuantityRow(
      {required String label,
      required TextEditingController controllerQuantity}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: Text(label)),
        Expanded(
          flex: 2,
          child: TextField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero, isDense: true),
            keyboardType: TextInputType.number,
            maxLength: 7,
            controller: controllerQuantity,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        makeQuantityRow(
            label: 'Contracts:', controllerQuantity: controllerContracts),
        makeQuantityRow(label: 'Strike:', controllerQuantity: controllerStrike),
        makeQuantityRow(
            label: 'Total premium:', controllerQuantity: controllerPremium),
        isCoveredCall ? makeQuantityRow(
            label: 'Share avg cost:', controllerQuantity: controllerCost) : Container(),
      ],
    );
  }
}
