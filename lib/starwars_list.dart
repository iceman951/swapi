import 'package:flutter/cupertino.dart';
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
    var people = await _repo.fetchPeople(page: _page);
    setState(() {
      _people = List<People>.from(people);
      _people.addAll(people);
    });
  }

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _people.length,
        itemBuilder: (context, index) {
          return Text(_people[index].name);
        });
  }
}
