class DompiTransaction {
  final int? id;
  final String title;
  final double amount;
  final String type;
  final int date;

  DompiTransaction({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type,
      'date': date,
    };
  }

  factory DompiTransaction.fromMap(Map<String, dynamic> map) {
    return DompiTransaction(
      id: map['id'] as int?,
      title: map['title'] as String,
      amount: map['amount'] as double,
      type: map['type'] as String,
      date: map['date'] as int,
    );
  }

  DompiTransaction copyWith({
    int? id,
    String? title,
    double? amount,
    String? type,
    int? date,
  }) {
    return DompiTransaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }
}

