class ContactDTO {
  ContactDTO({required this.name});
  final String name;

  Map<String, dynamic> toMap() => {"name": name};
}
