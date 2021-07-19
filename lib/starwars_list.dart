import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/starwars_repo.dart';
import 'package:getwidget/getwidget.dart';

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
      _people.addAll(people);
      _page++;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          itemCount: _people.length,
          itemBuilder: (context, index) {
            final People people = _people[index];
            if (index + 1 == _people.length && _page <= 9) {
              fetchPeople();
            }
            return Container(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      GFAvatar(
                        backgroundImage: NetworkImage(people.imageIndex),
                        backgroundColor: Colors.blue,
                        shape: GFAvatarShape.standard,
                        radius: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            people.name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text("BirthYear: " + people.birthYear,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          Text("Mass: " + people.mass + " kg.",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
