import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Screens/NoteDetail.dart';
import 'package:note_app/models/NoteModel.dart';
import 'package:note_app/utils/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count;
  DatabaseHelper databaseHelper=DatabaseHelper();
  List<NoteModel> noteModel;



  @override
  Widget build(BuildContext context) {

    if(noteModel==null) {
      noteModel = List<NoteModel>();

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),

      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           navigateToDetails('Add Note');
          debugPrint('FAB clicked');
        },
        tooltip: 'Add note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 8.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(this.noteModel[position].priority),
                child: getPriorityIcon(this.noteModel[position].priority),
              ),
              title: Text('Dummy Title'),
              subtitle: Text('Dummy Title'),
              trailing:
              GestureDetector(
                child: Icon(Icons.delete, color: Colors.grey,),
                onTap: () {
                  _delete(context, noteModel[position]);
                },
              ),
              onTap: () {
                navigateToDetails('Edit Note');
                debugPrint('Onclick on title');
              },
            ),
          );
        });
  }

  void navigateToDetails(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){return
      NodeDetails(title);
    }));

  }


  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }


  void _delete(BuildContext context, NoteModel note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
     // updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<NoteModel>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteModel = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

}
