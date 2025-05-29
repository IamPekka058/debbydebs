import "package:debbydebs/core/models/contact.dart";
import "package:debbydebs/core/models/debt_dto.dart";
import "package:debbydebs/core/providers/contact_provider.dart";
import "package:debbydebs/core/providers/debt_provider.dart";
import "package:debbydebs/ui/_widgets/app_bar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_initicon/flutter_initicon.dart";
import "package:provider/provider.dart";

class DebtCreationScreen extends StatelessWidget {
  DebtCreationScreen({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: const DebbyAppBar(),
    body: ChangeNotifierProvider(
      create: (_) => DebtCreationScreenViewModel(),
      child: Consumer<DebtCreationScreenViewModel>(
        builder:
            (final context, final model, final child) => Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/Logo.png",
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
                    padding: const EdgeInsets.all(8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (final value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Debt Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: "Description",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: amountController,
                            validator: (final value) {
                              if (value == null || value.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"^\d+\.?\d{0,2}"),
                              ),
                            ],
                            decoration: const InputDecoration(
                              labelText: "Amount",
                              border: OutlineInputBorder(),
                              suffixText: "€",
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                            validator: (final value) {
                              if (value == null) {
                                return "This field is required";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Friend",
                              border: OutlineInputBorder(),
                            ),
                            hint: const Text("Select a friend who owes you"),
                            value: model.selectedContact,
                            items: model.contacts,
                            onChanged: model.selectContact,
                          ),
                          const SizedBox(height: 10),
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
                            child: const Row(
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
                            child: const Row(
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
            ),
      ),
    ),
  );

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<GlobalKey<FormState>>("formKey", formKey))
      ..add(
        DiagnosticsProperty<TextEditingController>(
          "nameController",
          nameController,
        ),
      )
      ..add(
        DiagnosticsProperty<TextEditingController>(
          "descriptionController",
          descriptionController,
        ),
      )
      ..add(
        DiagnosticsProperty<TextEditingController>(
          "amountController",
          amountController,
        ),
      );
  }
}

class DebtCreationScreenViewModel extends ChangeNotifier {
  DebtCreationScreenViewModel() {
    getContacts();
  }
  List<DropdownMenuItem<int>> contacts = [];
  int? selectedContact;

  Future<void> getContacts() async {
    final List<Contact> contacts = await ContactProvider().getAllContacts();
    for (final contact in contacts) {
      this.contacts.add(
        DropdownMenuItem(
          value: contact.id,
          child: Row(
            children: [
              Initicon(text: contact.name, size: 30),
              const SizedBox(width: 10),
              Text(contact.name),
            ],
          ),
        ),
      );
    }
    notifyListeners();
  }

  void selectContact(final int? id) {
    selectedContact = id;
    notifyListeners();
  }

  void addDebt(
    final String name,
    final String description,
    final double amount,
    final int? contactId,
  ) {
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
    DebtProvider().insertDebtDTO(debt);
    notifyListeners();
  }
}
