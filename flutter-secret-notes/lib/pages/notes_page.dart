import 'package:flutter/material.dart';
import '../services/eth_service.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final EthService _ethService = EthService();
  final List<String> _notes = [];
  final _noteController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() {
      _isLoading = true;
    });
    await _ethService.init();
    final notes = await _ethService.getNotes();
    setState(() {
      _notes.clear();
      _notes.addAll(notes);
      _isLoading = false;
    });
  }

  Future<void> _addNote() async {
    final noteText = _noteController.text;
    if (noteText.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await _ethService.storeNote(noteText);
      _noteController.clear();
      await _loadNotes();
    }
  }

  Future<void> _deleteNote(int index) async {
    setState(() {
      _notes.removeAt(index);
    });
    // For mock service, no blockchain delete, so just update UI
  }

  void _editNoteDialog(int index) {
    _noteController.text = _notes[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Note'),
        content: TextField(
          controller: _noteController,
          autofocus: true,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _noteController.clear();
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final editedText = _noteController.text;
              if (editedText.isNotEmpty) {
                setState(() {
                  _notes[index] = editedText;
                });
                // For mock service, no blockchain update, so just update UI
              }
              _noteController.clear();
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secret Notes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  TextField(
                    controller: _noteController,
                    decoration: InputDecoration(
                      labelText: 'New Note',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addNote,
                    child: Text('Add Note'),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _notes.isEmpty
                        ? Center(child: Text('No notes yet'))
                        : ListView.builder(
                            itemCount: _notes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_notes[index]),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => _editNoteDialog(index),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => _deleteNote(index),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
