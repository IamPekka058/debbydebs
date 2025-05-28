class Debt {
  Debt({
    required this.id,
    required this.name,
    required this.description,
    required this.contactId,
    required this.amount,
    required this.isPaid,
  });

  factory Debt.fromMap(final Map<String, dynamic> map) => Debt(
    id: map["id"],
    name: map["name"],
    description: map["description"],
    contactId: map["contactId"],
    amount: map["amount"],
    isPaid: map["isPaid"] == 1,
  );
  int id;
  String name;
  String description;
  int contactId;
  double amount;
  bool isPaid;

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "contactId": contactId,
    "amount": amount,
    "isPaid": isPaid ? 1 : 0,
  };
}
