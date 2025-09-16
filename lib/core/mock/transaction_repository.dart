import 'mock_repository.dart';
import '../widgets/transaction_tile.dart';

class Transaction {
  final String id;
  final String title;
  final String? subtitle;
  final String amount;
  final String currency;
  final DateTime date;
  final TransactionType type;
  final String? icon;
  final String accountId;

  Transaction({
    required this.id,
    required this.title,
    this.subtitle,
    required this.amount,
    required this.currency,
    required this.date,
    required this.type,
    this.icon,
    required this.accountId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      amount: json['amount'] as String,
      currency: json['currency'] as String,
      date: DateTime.parse(json['date'] as String),
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.debit,
      ),
      icon: json['icon'] as String?,
      accountId: json['accountId'] as String,
    );
  }
}

class TransactionRepository {
  static Future<List<Transaction>> getTransactions() async {
    final jsonData = await MockRepository.loadJsonData(
      'assets/mock/transactions.json',
    );
    final transactions = jsonData
        .map((json) => Transaction.fromJson(json))
        .toList();
    return MockRepository.simulateNetworkDelayList(transactions);
  }

  static Future<List<Transaction>> getTransactionsByAccount(
    String accountId,
  ) async {
    final transactions = await getTransactions();
    return transactions
        .where((transaction) => transaction.accountId == accountId)
        .toList();
  }

  static Future<List<Transaction>> getRecentTransactions({
    int limit = 10,
  }) async {
    final transactions = await getTransactions();
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions.take(limit).toList();
  }

  static Future<List<Transaction>> getTransactionsByType(
    TransactionType type,
  ) async {
    final transactions = await getTransactions();
    return transactions
        .where((transaction) => transaction.type == type)
        .toList();
  }

  static Future<List<Transaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final transactions = await getTransactions();
    return transactions.where((transaction) {
      return transaction.date.isAfter(start) && transaction.date.isBefore(end);
    }).toList();
  }
}
