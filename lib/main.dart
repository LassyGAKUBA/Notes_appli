import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'note_screen.dart';
import 'auth_service.dart';
import 'loginscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      home: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NoteScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}