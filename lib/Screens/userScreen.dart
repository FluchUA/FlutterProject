import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/editNote.dart';
import 'package:flutter_app/Screens/editUserData.dart';
import 'package:flutter_app/Screens/notesScreen.dart';
import 'package:flutter_app/Screens/userDataScreen.dart';
import 'package:flutter_app/UserData/userData.dart';
import 'package:flutter_app/components.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _UserScreenForm();
  }
}

class _UserScreenForm extends StatefulWidget {
  @override
  createState() => new _UserScreenState();
}

class _UserScreenState extends State<_UserScreenForm> {
  UserData _userdata;
  bool showUserData = false;
  var _firebaseUser = FirebaseAuth.instance.currentUser;

  //AppBar с окном редактирования данных пользователя
  Widget _ScaffoldEditUserData() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Edit Profile"),
        centerTitle: true,
        actions: <Widget>[
          IconButtonLogOut(),
        ],
      ),
      body: EditUserDataForm(_firebaseUser.uid, _userdata, context, false),
    );
  }

  //AppBar с окном земеток
  Widget _ScaffoldNotesScreen() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Column(
          children: [
            Text("My Notes"),
            Text(
              "User: " + _userdata.getUserName,
              style: TextStyle(
                fontSize: 15,
              )
            ),
          ]
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButtonLogOut(),
        ],
        leading: IconButton(
          icon: Icon(Icons.supervised_user_circle),
          tooltip: 'Toggle Bluetooth',
          iconSize: 40,
          onPressed: () {
            showUserDataFunc();
          },
        ),
      ),
      body: NotesForm(_firebaseUser.uid, _userdata, context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteForm(_firebaseUser.uid, "", "", ""))
          )
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  //AppBar с окном данных пользователя
  Widget _ScaffoldShowUserDataScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.black54,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.drive_file_rename_outline),
            iconSize: 30,
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditUserDataForm(_firebaseUser.uid, _userdata, context, true))
              )
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          iconSize: 40,
          onPressed: () {
            showUserDataFunc();
          },
        ),
      ),
      body: UserDataForm(_firebaseUser.uid, _userdata),
    );
  }

  //Выбор экрана в зависимости от того новый ли это пользователь
  //если новый загрузит экран ввода данных пользователя иначе окно заметок
  Widget _selectScreen() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseUser.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var cloudData = snapshot.data.data();

          if (cloudData == null) {
            return _ScaffoldEditUserData();
          } else {
            if (_userdata == null) {
              _userdata = UserData(
                  cloudData["userName"],
                  cloudData["firstName"],
                  cloudData["lastName"],
                  cloudData["dayOfBirthday"]);
            } else
            {
              _userdata.setUserName(cloudData["userName"]);
              _userdata.setFirstName(cloudData["firstName"]);
              _userdata.setLastName(cloudData["lastName"]);
              _userdata.setDayOfBirthday(cloudData["dayOfBirthday"]);
            }

            if (showUserData) return _ScaffoldShowUserDataScreen();
            return _ScaffoldNotesScreen();
          }
        }
      });
  }

  void showUserDataFunc() {
    setState(() {
      showUserData = !showUserData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _selectScreen();
  }
}
