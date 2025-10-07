import 'dart:convert';
import 'dart:html' as html;
import '../models/transaction_model.dart';

class WebDatabaseHelper {
  static const String _storageKey = 'dompi_transactions';

  Future<List<DompiTransaction>> getAllTransactions() async {
    final storage = html.window.localStorage;
    final data = storage[_storageKey];
    
    if (data == null || data.isEmpty) {
      return [];
    }
    
    try {
      final List<dynamic> jsonList = jsonDecode(data);
      return jsonList.map((json) => DompiTransaction.fromMap(json)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    } catch (e) {
      return [];
    }
  }

  Future<int> insertTransaction(DompiTransaction tx) async {
    final transactions = await getAllTransactions();
    final newId = transactions.isEmpty ? 1 : transactions.map((t) => t.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
    
    final newTransaction = tx.copyWith(id: newId);
    transactions.add(newTransaction);
    
    await _saveTransactions(transactions);
    return newId;
  }

  Future<int> deleteTransaction(int id) async {
    final transactions = await getAllTransactions();
    transactions.removeWhere((tx) => tx.id == id);
    
    await _saveTransactions(transactions);
    return 1;
  }

  Future<void> _saveTransactions(List<DompiTransaction> transactions) async {
    final storage = html.window.localStorage;
    final jsonList = transactions.map((tx) => tx.toMap()).toList();
    storage[_storageKey] = jsonEncode(jsonList);
  }

  Future<void> close() async {
    // No-op for web
  }
}
