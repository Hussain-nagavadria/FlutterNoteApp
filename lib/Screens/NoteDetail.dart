import 'package:flutter/material.dart';

class NodeDetails extends StatefulWidget {
  String appBarTitle;
  NodeDetails(this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return NodeDetailState(this.appBarTitle);
  }
}

class NodeDetailState extends State<NodeDetails> {
  static var _priorities = ['High', 'Low'];
  String appBarTitle;
  var selectedText='';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  NodeDetailState(this.appBarTitle);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorities
                    .map((String dropDownMenuItem) => DropdownMenuItem<String>(
                          child: Text(dropDownMenuItem),
                          value: dropDownMenuItem,
                        ))
                    .toList(),
                onChanged: (valueSelected) {
                  setState(() {
                    debugPrint('user has selected $valueSelected');
                  });
                },
                value: 'Low',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint("Something changed inside the text field");
                },
                decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint(
                      "Something changed inside the description text field");
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Row(
                children: <Widget>[
                  Expanded(child: RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                     'Save',
                      style: TextStyle(color: Colors.white),
                     textScaleFactor: 1.5,

                    ),
                    onPressed:(){
                      setState(() {
                        debugPrint('Save button pressed()');
                      });
                    },
                  )),
                  Container(width: 5.0,),
                  Expanded(child: RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.5,
                    ),
                    onPressed:(){
                      setState(() {
                        debugPrint('delete button pressed()');
                      });
                    },
                  ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
