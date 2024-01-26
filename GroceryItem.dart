import 'package:flutter/material.dart';
import 'dart:math';


class GroceryItem {
  final String name;
  final double price;
  final String imageAssetPath;

  GroceryItem({
    required this.name,
    required this.price,
    required this.imageAssetPath,
  });

  void addToCart(BuildContext context) {
    Cart.instance.add(this);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class Cart {
  List<GroceryItem> _items = [];

  Cart._privateConstructor();

  static final Cart _instance = Cart._privateConstructor();

  static Cart get instance => _instance;

  void add(GroceryItem item) {
    _items.add(item);
  }

  void remove(GroceryItem item) {
    _items.remove(item);
  }

  List<GroceryItem> get items => _items;
}
