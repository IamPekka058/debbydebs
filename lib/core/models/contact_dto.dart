class ContactDTO {
  final String name;

  ContactDTO({required this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
