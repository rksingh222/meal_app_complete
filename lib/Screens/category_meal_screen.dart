import 'package:flutter/material.dart';
import '../Widget/meal_item.dart';
import '../dummy_data.dart';
import '../model/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {

  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {

    if(!_loadedInitData){
      final routeArg =
      ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArg['title'];
      final categoryId = routeArg['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
      print("called did change dependencies");
    }


    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeMeal(String id){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            removeItem: _removeMeal,
            
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
