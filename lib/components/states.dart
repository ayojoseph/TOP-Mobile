import 'package:flutter/cupertino.dart';

class NewsPageState extends ChangeNotifier {
  int _pageState = 0;

  Map _data = {
    "content": "",
    "title": "",
    "date": "",
  };
  String _content = "";
  String _title = "";
  String _date = "";

  int getState() {
    return _pageState;
  }

  String getTitle() {
    return _title;
  }

  Map getData() {
    return _data;
  }

  void updateContents(title, content, date) {
    _data['content'] = content;
    _data['title'] = title;
    _data['date'] = date;
    notifyListeners();
  }

  void toggleState() {
    if (_pageState == 1) {
      _pageState = 0;
    } else {
      _pageState = 1;
    }
    notifyListeners();
  }
}
