class NoteModel {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  NoteModel(this._title, this._priority, this._date, [this._description]);

  NoteModel.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get priority => _priority;

  String get date => _date;

  String get description => _description;

  String get title => _title;

  int get id => _id;

  set priority(int value) {
    if (value >= 1 && value <= 2) {
      _priority = value;
    }
  }

  set date(String value) {
    if (value.length <= 255) {
      _date = value;
    }
  }

  set description(String value) {
    if (value.length <= 255) {
      _description = value;
    }
  }

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

  //Convert note into map

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //Extract a note object from a map object
  NoteModel.fromMapObject(Map<String,dynamic> map ){

    this._id=map['id'];

    this._title=map['title'];
    this._priority=map['priority'];
    this._description=map['description'];
    this._date=map['date'];



  }


}
