import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './Screens/category_meal_screen.dart';

import './Screens/categories_screen.dart';
import './Screens/meal_details_screen.dart';
import './Screens/tabs_screen.dart';
import './Screens/filter_screen.dart';
import './model/meal.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Meal> _availableMeals = DUMMY_MEALS;

  Map<String,bool> _filters = {
    'Gluten': false,
    'Vegan': false,
    'Vegetarian': false,
    'Lactose': false,
  };

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['Gluten'] && !meal.isGlutenFree)
          {
            return false;
          }
        if(_filters['Vegan'] && !meal.isVegan)
        {
          return false;
        }
        if(_filters['Vegetarian'] && !meal.isVegetarian)
        {
          return false;
        }
        if(_filters['Lactose'] && !meal.isLactoseFree)
        {
          return false;
        }
        return true;
      }
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: '/',
      routes: {
        '/' :(ctx)=> TabsScreen(),
        CategoryMealScreen.routeName :(ctx)=> CategoryMealScreen(_availableMeals),
        MealDetailsScreen.routeName :(ctx)=> MealDetailsScreen(),
        FilterScreen.routeName :(ctx)=> FilterScreen(_filters,_setFilters),
      },

      onUnknownRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
    );
  }
}