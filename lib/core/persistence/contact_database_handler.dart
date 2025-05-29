import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/models/contact_dto.dart";
import "package:debbydebs/core/persistence/app_database.dart";
import "package:sqflite/sqflite.dart";

class ContactDatabaseHandler {
  factory ContactDatabaseHandler() => _instance;
  ContactDatabaseHandler._internal();

  static final ContactDatabaseHandler _instance =
      ContactDatabaseHandler._internal();

  final AppDatabase _appDatabase = AppDatabase();

  Future<void> insertContact(final Contact contact) async {
    insertContactDTO(ContactDTO(name: contact.name));
  }

  Future<void> insertContactDTO(final ContactDTO contact) async {
    final Database db = await _appDatabase.database;
    await db.insert(
      "contacts",
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteContact(final Contact contact) async {
    final Database db = await _appDatabase.database;
    await db.delete("contacts", where: "id = ?", whereArgs: [contact.id]);
  }

  Future<void> deleteContactById(final int id) async {
    final Database db = await _appDatabase.database;
    await db.delete("contacts", where: "id = ?", whereArgs: [id]);
  }

  Future<bool> safeToDeleteContact(final int contactId) async {
    final Database db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      "debts",
      where: "contactId = ?",
      whereArgs: [contactId],
    );
    return maps.isEmpty;
  }

  Future<List<Contact>> getAllContacts() async {
    final Database db = await _appDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query("contacts");
    return List.generate(
      maps.length,
      (final i) => Contact(id: maps[i]["id"], name: maps[i]["name"]),
    );
  }

  Future<Contact> getContactById(final int id) async {
    final Database db = await _appDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(
      "contacts",
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      throw Exception("Contact not found");
    }
  }
}
