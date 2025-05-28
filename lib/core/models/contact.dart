class Contact {

  Contact({required this.id, required this.name});

  factory Contact.fromMap(final Map<String, dynamic> map) => Contact(id: map["id"], name: map["name"]);
  final int id;
  final String name;

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}
