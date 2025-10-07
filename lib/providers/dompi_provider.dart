import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';
import '../db/database_helper.dart';
import '../db/web_database_helper.dart';

class DompiProvider with ChangeNotifier {
  List<DompiTransaction> _transactions = [];
  late final dynamic _dbHelper;
  
  DompiProvider() {
    _dbHelper = kIsWeb ? WebDatabaseHelper() : DatabaseHelper();
  }

  List<DompiTransaction> get transactions => _transactions;

  double get balance {
    double total_masuk = 0;
    double total_keluar = 0;
    for (var tx in _transactions) {
      if (tx.type == 'masuk') {
        total_masuk += tx.amount;
      } else if (tx.type == 'keluar') {
        total_keluar += tx.amount;
      }
    }
    return total_masuk - total_keluar;
  }

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getAllTransactions();
    notifyListeners();
  }

  Future<void> addIncome({
    required String title,
    required double amount,
  }) async {
    final transaction = DompiTransaction(
      title: title,
      amount: amount,
      type: 'masuk',
      date: DateTime.now().millisecondsSinceEpoch,
    );
    await _dbHelper.insertTransaction(transaction);
    await loadTransactions();
  }

  Future<void> addExpense({
    required String title,
    required double amount,
  }) async {
    final transaction = DompiTransaction(
      title: title,
      amount: amount,
      type: 'keluar',
      date: DateTime.now().millisecondsSinceEpoch,
    );
    await _dbHelper.insertTransaction(transaction);
    await loadTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await _dbHelper.deleteTransaction(id);
    await loadTransactions();
  }
}

