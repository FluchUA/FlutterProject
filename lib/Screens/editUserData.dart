import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UserData/userData.dart';
import 'package:flutter_app/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditUserDataForm extends StatelessWidget {
  String _uID;
  UserData _userData;
  bool _updateData;
  var _context;

  //Контроллеры полей ввода, хранят введенную информацию
  TextEditingController _userName = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _dayOfBirthday = TextEditingController();

  EditUserDataForm(this._uID, this._userData, this._context, this._updateData);

  //Загружает введенные данные в базу данных
  void saveButton() async {
    if (_userName.text.isEmpty || _firstName.text.isEmpty || _lastName.text.isEmpty || _dayOfBirthday.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "You must fill in all of the fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else
    {
      await FirebaseFirestore.instance.collection("users").doc(_uID).set(
      {
        "userName" : _userName.text,
        "firstName" : _firstName.text,
        "lastName" : _lastName.text,
        "dayOfBirthday" : _dayOfBirthday.text,
      });

      if (_updateData) {
        Navigator.pop(_context);
      } else {
        _userData = UserData(_userName.text, _firstName.text, _lastName.text, _dayOfBirthday.text);
      }
    }
  }

  //Виджет окошка ввода данных
  Widget _regForm() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://allprint.moscow/wp-content/uploads/2018/10/mini-razmer.jpg"),
              fit: BoxFit.cover)),
      child: Center(
        child: Container(
        color: Colors.black12,
        width: 300,
        height: 330,
        child: Column(children: [
          TextCenterComponent("Registration Form"),
          InputComponent(Icon(Icons.supervised_user_circle), "User Name", _userName, false, 1, 1),
          InputComponent(Icon(Icons.drive_file_rename_outline), "First Name", _firstName, false, 1, 1),
          InputComponent(Icon(Icons.drive_file_rename_outline), "Last Name", _lastName, false, 1, 1),
          InputComponent(Icon(Icons.date_range), "Day of Birthday", _dayOfBirthday, false, 1, 1),
          ButtonComponent("Save", saveButton),
        ])
        )
      ),
    );
  }

  Widget _appBar() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(_context);
          },
        ),
      ),
      body: _regForm(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_updateData)
    {
      _userName.text = _userData.getUserName;
      _firstName.text = _userData.getFirstName;
      _lastName.text = _userData.getLastName;
      _dayOfBirthday.text = _userData.getDayOfBirthday;
    }

    return _updateData ? _appBar(): _regForm();
  }
}
