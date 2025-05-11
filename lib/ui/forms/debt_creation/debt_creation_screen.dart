import 'package:debbydebs/core/models/contact.dart';
import 'package:debbydebs/core/models/debt_dto.dart';
import 'package:debbydebs/core/persistence/database_handler.dart';
import 'package:debbydebs/ui/_widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:provider/provider.dart';

class DebtCreationScreen extends StatelessWidget {
  DebtCreationScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DebbyAppBar(),
      body: ChangeNotifierProvider(
        create: (_) => DebtCreationScreenViewModel(),
        child: Consumer<DebtCreationScreenViewModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                      Text(
                        "Hi, there!",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Debt Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              labelText: "Description",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: amountController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText: "Amount",
                              border: OutlineInputBorder(),
                              suffixText: "€",
                            ),
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == null) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Friend",
                              border: OutlineInputBorder(),
                            ),
                            hint: Text("Select a friend who owes you"),
                            value: model.selectedContact,
                            items: model.contacts,
                            onChanged: model.selectContact,
                          ),
                          SizedBox(height: 10),
                          FilledButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                model.addDebt(
                                  nameController.text,
                                  descriptionController.text,
                                  double.parse(amountController.text),
                                  model.selectedContact,
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                Text(
                                  "Your friend owes you",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                model.addDebt(
                                  nameController.text,
                                  descriptionController.text,
                                  -double.parse(amountController.text),
                                  model.selectedContact,
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white),
                                Text(
                                  "You owe your friend",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DebtCreationScreenViewModel extends ChangeNotifier {
  List<DropdownMenuItem<int>> contacts = [];
  int? selectedContact;

  DebtCreationScreenViewModel() {
    getContacts();
  }

  void getContacts() async {
    final List<Contact> contacts = await DatabaseHandler().getAllContacts();
    for (var contact in contacts) {
      this.contacts.add(
        DropdownMenuItem(
          value: contact.id,
          child: Row(
            children: [
              Initicon(text: contact.name, size: 30),
              SizedBox(width: 10),
              Text(contact.name),
            ],
          ),
        ),
      );
    }
    notifyListeners();
  }

  void selectContact(int? id) {
    selectedContact = id;
    notifyListeners();
  }

  void addDebt(String name, String description, double amount, int? contactId) {
    if (name.isEmpty || contactId == null) {
      return;
    }
    final debt = DebtDTO(
      name: name,
      description: description,
      contactId: contactId,
      amount: amount,
      isPaid: false,
    );
    DatabaseHandler().insertDebtDTO(debt);
    notifyListeners();
  }
}
