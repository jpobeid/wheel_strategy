class Stock {
  final String name;
  int phase;
  final DateTime dateOpen;
  final DateTime dateExpiration;
  final int nContracts;
  final double strike;
  final double premium;
  final double? cost;

  Stock({
    required this.name,
    required this.phase,
    required this.dateOpen,
    required this.dateExpiration,
    required this.nContracts,
    required this.strike,
    required this.premium,
    this.cost,
  });
}
