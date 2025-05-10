class DebtDTO {
  String name;
  String description;
  int contactId;
  double amount;
  bool isPaid;

  DebtDTO({
    required this.name,
    required this.description,
    required this.contactId,
    required this.amount,
    required this.isPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'contactId': contactId,
      'amount': amount,
      'isPaid': isPaid ? 1 : 0,
    };
  }
}
