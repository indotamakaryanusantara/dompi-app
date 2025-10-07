import '../models/transaction_model.dart';

// Stub implementation for non-web platforms
class DatabaseHelperStub {
  Future<List<DompiTransaction>> getAllTransactions() async {
    throw UnsupportedError('Database not supported on this platform');
  }

  Future<int> insertTransaction(DompiTransaction tx) async {
    throw UnsupportedError('Database not supported on this platform');
  }

  Future<int> deleteTransaction(int id) async {
    throw UnsupportedError('Database not supported on this platform');
  }

  Future<void> close() async {
    // No-op
  }
}
