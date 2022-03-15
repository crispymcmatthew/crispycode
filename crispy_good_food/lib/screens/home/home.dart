import 'package:flutter/material.dart';
import 'package:crispy_good_food/models/recipe.cat.api.dart';
import 'package:crispy_good_food/models/recipe_cat.dart';
import 'package:crispy_good_food/screens/widgets/recipe_cat_card.dart';
import '../../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  late List<RecipeCat> _recipes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipeCat();
  }

  Future<void> getRecipeCat() async {
    _recipes = await RecipeCatApi.getRecipeCat();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.restaurant_menu),
            const SizedBox(width: 10),
            const Text('Food Recipes'),
            const SizedBox(width: 170),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCatCard(
              title: _recipes[index].displayName,
              thumbnailUrl: _recipes[index].displayImage
          );
        },
      ),
    );
  }
}

