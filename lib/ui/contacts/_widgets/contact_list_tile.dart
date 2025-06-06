import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_initicon/flutter_initicon.dart";

class ContactListTile extends StatefulWidget {
  const ContactListTile({
    required this.contactId,
    required this.onEdit,
    required this.onDelete,
    required this.contactName,
    required this.isSelected,
    required this.onSelect,
    super.key,
  });
  final int contactId;
  final String contactName;
  final Function(int id) onEdit;
  final Function(int id) onDelete;
  final bool isSelected;
  final GestureTapCallback? onSelect;

  @override
  State<ContactListTile> createState() => _ContactListTileState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty("contactId", contactId))
      ..add(StringProperty("contactName", contactName))
      ..add(ObjectFlagProperty<Function(int id)>.has("onEdit", onEdit))
      ..add(ObjectFlagProperty<Function(int id)>.has("onDelete", onDelete))
      ..add(DiagnosticsProperty<bool>("isSelected", isSelected))
      ..add(ObjectFlagProperty<GestureTapCallback?>.has("onSelect", onSelect));
  }
}

class _ContactListTileState extends State<ContactListTile> {
  @override
  Widget build(final BuildContext context) => Card(
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
                          backgroundColor: WidgetStateProperty.all(Colors.grey),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.edit, color: Colors.white),
                            SizedBox(width: 5),
                            Text("Edit", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      FilledButton(
                        onPressed: () => widget.onDelete(widget.contactId),
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.red),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              "Delete",
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
