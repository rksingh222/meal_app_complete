import 'package:flutter/material.dart';
import '../Widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FilterScreen(this.currentFilters,this.saveFilters);



  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['Gluten'];
    _vegan = widget.currentFilters['Vegan'];
    _vegetarian = widget.currentFilters['Vegetarian'];
    _lactoseFree = widget.currentFilters['Lactose'];
    super.initState();
  }


  Widget _buildListTileWidget(String title, String description,
      bool currentValue, Function handler) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value:currentValue,
      onChanged: handler,
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Your Filters'),
      actions: [
        IconButton(icon: Icon(Icons.save), onPressed:(){
          Map<String,bool> selectedFilters = {
            'Gluten': _glutenFree,
            'Vegan': _vegan,
            'Vegetarian': _vegetarian,
            'Lactose': _lactoseFree,
          };
          widget.saveFilters(selectedFilters);
        },),
      ],
    ),
    drawer: MainDrawer(),
    body: Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'Adjust Your Meal Selection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              _buildListTileWidget(
                  'Gluten Free', 'Only Include Gluten Free Meals',
                  _glutenFree, (value) {
                setState(() {
                  _glutenFree = value;
                });
              }),
              _buildListTileWidget(
                  'Lactose Free', 'Only Include Lactose Free Meals',
                  _lactoseFree, (value) {
                setState(() {
                  _lactoseFree = value;
                });
              }),
              _buildListTileWidget(
                  'Vegetarian', 'Only Include Vegetarian Meals',
                  _vegetarian, (value) {
                setState(() {
                  _vegetarian = value;
                });
              }),
              _buildListTileWidget(
                  'Vegan', 'Only Include Vegan Meals',
                  _vegan, (value) {
                setState(() {
                  _vegan = value;
                });
              }),
            ],
          ),
        )
      ],
    ),
  );
}}
