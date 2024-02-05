import 'package:flutter/material.dart';
import 'package:wheel_strategy/classes/stock.dart';
import 'package:wheel_strategy/widgets/wheel_painter.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  const StockCard({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    int daysFromOpen = DateTime.now().difference(stock.dateOpen).inDays;
    int daysTotal = stock.dateExpiration.difference(stock.dateOpen).inDays;

    return Card(
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(stock.name.toUpperCase()),
            Text('\$${stock.strike}'),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text('x${stock.nContracts} = \$${stock.premium}')),
            Expanded(
                flex: 2,
                child: LinearProgressIndicator(
                  value: daysFromOpen / daysTotal,
                )),
          ],
        ),
        leading: LayoutBuilder(builder: (context, constraints) {
          print(constraints.maxWidth);
          return Container(
            width: 35,
            color: Colors.green,
            child: CustomPaint(
              painter: WheelPainter(isOn: [true, true, false, false]),
            ),
          );
        }),
        trailing: Icon(Icons.arrow_drop_down_circle_outlined),
      ),
    );
  }
}
