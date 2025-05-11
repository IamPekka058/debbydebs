import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/ui/contacts/contacts_view_model.dart';
import 'package:flutter/material.dart';

class ContactViewViewModel extends ChangeNotifier {
  final ContactViewModel _contactViewModel = ContactViewModel();

  List<Contact> get contacts => _contactViewModel.contacts;

  ContactViewViewModel() {
    _contactViewModel.addListener(() {
      notifyListeners();
    });
    _contactViewModel.getContacts();
  }
  void addContact(Contact contact) {
    _contactViewModel.addContact(contact);
  }

  void removeContact(Contact contact) {
    _contactViewModel.removeContact(contact);
  }

  void getContacts() {
    _contactViewModel.getContacts();
  }
}
