import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheel_strategy/classes/stock.dart';
import 'package:wheel_strategy/pages/create_stock.dart';
import 'package:wheel_strategy/widgets/stock_card.dart';

import '../widgets/wheel_painter.dart';

final stocksProvider = StateProvider<List<Stock>>((ref) => []);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Stock> stocks = ref.watch(stocksProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: stocks.map((e) => StockCard(stock: e)).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Stock? newStock = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateStockPage()),
            );
            if (newStock != null) {
              ref
                  .read(stocksProvider.notifier)
                  .update((state) => [...state, newStock]);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
