class Debt {
  String id;
  String name;
  String description;
  int contactId;
  double amount;
  bool isPaid;

  Debt({
    required this.id,
    required this.name,
    required this.description,
    required this.contactId,
    required this.amount,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'contactId': contactId,
      'amount': amount,
      'isPaid': isPaid ? 1 : 0,
    };
  }

  factory Debt.fromMap(Map<String, dynamic> map) {
    return Debt(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      contactId: map['contactId'],
      amount: map['amount'],
      isPaid: map['isPaid'] == 1,
    );
  }
}
