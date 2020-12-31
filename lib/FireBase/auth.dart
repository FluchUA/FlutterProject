import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  //Авторизация пользователя
  Future loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    } catch (e) {
      print(e);
      return null;
    }
  }

  //Регистрация пользователя
  Future registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;

    } catch (e) {
      print(e);
      return null;
    }
  }

  //Выход пользователя
  Future logOut() async {
    await _fAuth.signOut();
  }

  //Подписка на поток изменений аутентификации
  Stream<User> get currentUser {
    return _fAuth.authStateChanges();
  }
}