import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../utils/format_currency.dart';

class TransactionItem extends StatelessWidget {
  final DompiTransaction transaction;
  final Function onDelete;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final is_income = transaction.type == 'masuk';
    final amount_color = is_income ? Colors.green : Colors.red;

    return ListTile(
      title: Text(
        transaction.title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        formatDateFromMillis(transaction.date),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${is_income ? '+' : '-'} ${formatCurrency(transaction.amount)}',
            style: TextStyle(
              color: amount_color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(),
          ),
        ],
      ),
    );
  }
}

