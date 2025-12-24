import 'package:flutter/material.dart';

class NotesPopup extends StatefulWidget {
  final String initialNotes;

  const NotesPopup({
    super.key,
    this.initialNotes = '',
  });

  @override
  State<NotesPopup> createState() => _NotesPopupState();
}

class _NotesPopupState extends State<NotesPopup> {
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.initialNotes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Σημειώσεις Παραγγελίας'),
      content: TextField(
        controller: _notesController,
        decoration: const InputDecoration(
          hintText: 'Προσθέστε σημειώσεις...',
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Άκυρο'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _notesController.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF2CD00),
          ),
          child: const Text('Ολοκλήρωση'),
        ),
      ],
    );
  }
}
