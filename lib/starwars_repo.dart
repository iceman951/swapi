import 'package:dio/dio.dart';

class People {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String eyeColor;
  final String birthYear;
  final String gender;
  final String homeworld;
  final String url;
  final String imageIndex;

  People(
      this.name,
      this.height,
      this.mass,
      this.hairColor,
      this.skinColor,
      this.eyeColor,
      this.birthYear,
      this.gender,
      this.homeworld,
      this.url,
      this.imageIndex);

  factory People.fromJson(dynamic data) {
    String index = data['url'].toString().substring(29, 31).replaceAll('/', '');
    return People(
        data['name'],
        data['height'],
        data['mass'],
        data['hair_color'],
        data['skin_color'],
        data['eye_color'],
        data['birth_year'],
        data['gender'],
        data['homeworld'],
        data['url'],
        index);
  }
}

class StarwarsRepo {
  Future<List<People>> fetchPeople({int page = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<dynamic> results = response.data['results'];
    return results.map((people) => People.fromJson(people)).toList();
  }
}
