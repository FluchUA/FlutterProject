import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/editNote.dart';
import 'package:flutter_app/UserData/userData.dart';

class NotesForm extends StatelessWidget {
  String _uID;
  UserData _userData;
  var _context;
  List<Container> listNotes = new List();

  NotesForm(this._uID, this._userData, this._context);

  //Виджет заметки
  Widget _note(String title, String text, String dateCreate) {
    String _dateCreate = dateCreate;
    return Container(
      width: 180,
      height: 200,
      color: Color.fromARGB(50, 0, 0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Divider(
                color: Colors.black45,
                thickness: 1,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.fade,
                      maxLines: 9,
                    )
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                _context,
                MaterialPageRoute(builder: (context) => NoteForm(_uID, title, text, dateCreate))
            );
          },
        ),
      ),
    );
  }

  //Загрузка с базы данных заметки, если есть генерирует виджеты с загруженными данными
  Widget _loadNotes() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("notes " + _uID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot != null)
        {
          int count = snapshot.data.docs.length;
          if (count > 0)
          {
            listNotes.clear();

            snapshot.data.docs.forEach((element) { listNotes.add(_note(element["title"], element["text"], element["dateCreate"])); });
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: listNotes,
            );
          } else
          {
            return Center(
              child: Container (
                height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight) * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    "No notes",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return Text("ok");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://bgfons.com/upload/books_texture3018.jpg"),
              fit: BoxFit.cover)),
      child: SingleChildScrollView (
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child : _loadNotes()
          ),
        ),
      ),
    );
  }
}