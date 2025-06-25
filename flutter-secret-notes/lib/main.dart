import 'package:flutter/material.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/notes_page.dart';

void main() {
  runApp(SecretNotesApp());
}

class SecretNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Notes',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/notes': (context) => NotesPage(),
      },
    );
  }
}
