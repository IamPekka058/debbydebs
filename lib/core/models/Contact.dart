class Contact {
  final int id;
  final String name;

  Contact({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }

  Contact fromMap(Map<String, dynamic> map) {
    return Contact(id: map['id'], name: map['name']);
  }
}
