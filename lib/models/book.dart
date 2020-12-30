class Book {
  int _id;
  int _status;
  String _title;
  String _author;
  String _dateAdded;
  String _dateStarted;
  String _dateFinished;

  Book(this._status, this._title, this._author, [this._dateAdded,
      this._dateFinished, this._dateStarted]);

  Book.withId(
      this._id, this._status, this._title, this._author, this._dateAdded,
      [this._dateFinished, this._dateStarted]);

  int get id => _id;

  int get status => _status;

  String get title => _title;

  String get author => _author;

  String get dateAdded => _dateAdded;

  set title(String title) {
    this._title = title;
  }

  set author(String author) {
    this._author = author;
  }

  set dateAdded(String dateAdded) {
    this._dateAdded = dateAdded;
  }

  set status(int status) {
    this._status = status;
  }

  // Convert a book object into a map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if (id != null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['author'] = _author;
    map['status'] = _status;
    map['dateAdded'] = _dateAdded;

    return map;
  }

  // Convert a map object into a book object
  Book.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._author = map['author'];
    this._status = map['status'];
    this._dateAdded = map['dateAdded'];
  }
}
