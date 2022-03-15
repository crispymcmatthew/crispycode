import 'dart:convert';
import 'package:crispy_good_food/models/recipe_cat.dart';
import 'package:http/http.dart' as http;

class RecipeCatApi {
  static Future<List<RecipeCat>> getRecipeCat() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/categories/list');

    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": "053ec961demshd80816170b8fa4fp1131dfjsn0f6420c95390",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['browse-categories']){
      _temp.add(i['display']);
    }

    return RecipeCat.recipesFromSnapshot(_temp);
  }
}