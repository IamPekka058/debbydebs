import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class ContactListTile extends StatefulWidget {
  final int contactId;
  final String contactName;
  final Function(int id) onEdit;
  final Function(int id) onDelete;
  final bool isSelected;
  final GestureTapCallback? onSelect;

  const ContactListTile({
    super.key,
    required this.contactId,
    required this.onEdit,
    required this.onDelete,
    required this.contactName,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  State<ContactListTile> createState() => _ContactListTileState();
}

class _ContactListTileState extends State<ContactListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          ListTile(
            onTap: widget.onSelect,
            textColor: Colors.black,
            leading: Initicon(text: widget.contactName, size: 30),

            title: Text(widget.contactName),
            subtitle: Text(widget.contactId.toString()),
            trailing:
                widget.isSelected
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton(
                          // TODO(IamPekka058): Implement edit functionality
                          onPressed: null,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: () => widget.onDelete(widget.contactId),
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.red,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              const SizedBox(width: 5),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    : null,
          ),
        ],
      ),
    );
  }
}
