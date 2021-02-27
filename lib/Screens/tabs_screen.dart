import 'package:flutter/material.dart';

import './favorite_screen.dart';
import './categories_screen.dart';
import '../Widget/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String,Object>> _pages = [
    {'page':CategoriesScreen(),'title': 'Categories'},
    {'page':FavoriteScreen(),'title': 'Favorite'},
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index){
      setState(() {
        _selectedPageIndex = index;

      });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: Text(_pages[_selectedPageIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedPageIndex]['page'],
         bottomNavigationBar: BottomNavigationBar(
           onTap: _selectPage,
           backgroundColor: Colors.blue,
           unselectedItemColor: Colors.white,
           selectedItemColor: Colors.yellow,
           currentIndex: _selectedPageIndex,
           type: BottomNavigationBarType.fixed,
           items: [
             BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories',),
             BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
           ],
         ) ,
        );
  }
}
