class Todo {
  int? _id;
  String? _title;
  String? _description;
  String? _date;
  int? _priority;
  // [this._description] when you have an optional
  // flutter only has one constructor change with the name eg Todo.withId();
  Todo(this._title, this._priority, this._date, [this._description = ""]);
  Todo.withId(this._id, this._title, this._priority, this._date,
      [this._description = ""]);
  // when you don't need to manipulate the value before returning it
  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get priority => _priority;
  String? get date => _date;

  set title(String? newTitle) {
    if (newTitle!.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String? newDescription) {
    if (newDescription!.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int? newPriority) {
    if (newPriority! >= 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set date(String? newDate) {
    _date = newDate;
  }

// map a collection of key value pair
// transform our todo into a map
//
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    map["id"] = _id;
    return map;
  }

// take anyobject and transform to a todo
  Todo.fromObject(dynamic o) {
    _id = o["id"];
    _title = o["title"];
    _description = o["description"];
    _priority = o["priority"];
    _date = o["date"];
  }
}
