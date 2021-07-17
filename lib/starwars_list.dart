import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/starwars_repo.dart';

class StarwarsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StarwarsListStates();
  }
}

class _StarwarsListStates extends State {
  final StarwarsRepo _repo;
  late List<People> _people;
  late int _page;

  _StarwarsListStates() : _repo = new StarwarsRepo();

  void initState() {
    super.initState();
    _page = 1;
    _people = [];

    fetchPeople();
  }

  Future<void> fetchPeople() async {
    if (_page <= 9) {
      var people = await _repo.fetchPeople(page: _page);
      setState(() {
        _people.addAll(people);
        _page++;
      });
    }
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _people.length,
        itemBuilder: (context, index) {
          return Card(
              child: Text(_people[index].name +
                  " " +
                  _people[index].imageIndex +
                  "length: " +
                  _people.length.toString()));
        });
  }
}
