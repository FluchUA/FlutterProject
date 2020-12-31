import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NoteForm extends StatelessWidget {
  TextEditingController _titleCntrl = TextEditingController();
  TextEditingController _textCntrl = TextEditingController();

  String _uID;
  String _title;
  String _text;
  String _dateCreate;

  NoteForm(this._uID, this._title, this._text, this._dateCreate);

  //Загружает введенные данные в базу данных
  void saveButton() async {
    if (_dateCreate == "") _dateCreate = new DateTime.now().toString();

    if (_titleCntrl.text.isEmpty || _textCntrl.text.isEmpty) {
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
      await FirebaseFirestore.instance.collection("notes " + _uID).doc(_dateCreate).set(
      {
        "title" : _titleCntrl.text,
        "text" : _textCntrl.text,
        "dateCreate" : _dateCreate,
      });
    }
  }

  //Виджет окошка данных
  Widget _form() {
    return Center(
      child: Container (
        width: 380,
        height: 380,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputComponent(Icon(Icons.title), "Title", _titleCntrl, false, 1, 1),
            InputComponent(Icon(Icons.tab), "Text", _textCntrl, false, 10, 10),
            ButtonComponent("Save", saveButton),
          ],
        ),
      ),
    );
  }

  void deleteNote() async {
    await FirebaseFirestore.instance.collection("notes " + _uID).doc(_dateCreate).delete();
  }

  @override
  Widget build(BuildContext context) {
    if (_title != "")
    {
      _titleCntrl.text = _title;
      _textCntrl.text = _text;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text("Edit Note"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 30,
            onPressed: () {
              deleteNote();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://image.freepik.com/free-photo/top-view-for-business-background-blank-notebook-for-painting-drawing-and-sketching-on-wooden-texture_64749-2747.jpg"),
                fit: BoxFit.cover)),
          child: _form(),
      ),
    );
  }
}
