import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/FireBase/auth.dart';
import 'package:flutter_app/selectionScreens.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  //Убирает ошибку которая появляестся если использовать асинхронную функцию внутри main ()
  await Firebase.initializeApp();             //Инизиализация (убирает ошибку)
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(      //пускает значение value всем виджетам вниз по иерархии
      value: FireAuth().currentUser,        //в данном случае поток изменений аутентификации
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenSelection(),
      )
    );
  }
}

