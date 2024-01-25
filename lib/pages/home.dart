import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wheel_strategy/classes/stock.dart';

final stockProvider = StateProvider<List<Map<String, Object>>>((ref) => []);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, Object>> stockList = ref.watch(stockProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView(
          children: stockList
              .map(
                (e) => Card(
                  child: ListTile(
                    title: Text(e['name'].toString()),
                  ),
                ),
              )
              .toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Stock stock = Stock(name: 'jblu', phase: 4);
            stock.phase = 5;
            print(stock);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
