import 'package:flutter/material.dart';
import 'package:wheel_strategy/classes/stock.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(stock.name.toUpperCase()),
        subtitle: Text('${stock.strike} - ${stock.dateExpiration}'),
        leading: Icon(stock.phase == 0 ? Icons.add : Icons.ac_unit),
        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
      ),
    );
  }
}
