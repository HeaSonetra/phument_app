import 'mock_repository.dart';

class Account {
  final String id;
  final String accountNumber;
  final String accountName;
  final String balance;
  final String currency;
  final String accountType;
  final bool isActive;
  final DateTime lastTransaction;

  Account({
    required this.id,
    required this.accountNumber,
    required this.accountName,
    required this.balance,
    required this.currency,
    required this.accountType,
    required this.isActive,
    required this.lastTransaction,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      accountNumber: json['accountNumber'] as String,
      accountName: json['accountName'] as String,
      balance: json['balance'] as String,
      currency: json['currency'] as String,
      accountType: json['accountType'] as String,
      isActive: json['isActive'] as bool,
      lastTransaction: DateTime.parse(json['lastTransaction'] as String),
    );
  }
}

class AccountRepository {
  static Future<List<Account>> getAccounts() async {
    final jsonData = await MockRepository.loadJsonData(
      'assets/mock/accounts.json',
    );
    final accounts = jsonData.map((json) => Account.fromJson(json)).toList();
    return MockRepository.simulateNetworkDelayList(accounts);
  }

  static Future<Account?> getAccountById(String id) async {
    final accounts = await getAccounts();
    try {
      return accounts.firstWhere((account) => account.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<List<Account>> getActiveAccounts() async {
    final accounts = await getAccounts();
    return accounts.where((account) => account.isActive).toList();
  }
}
