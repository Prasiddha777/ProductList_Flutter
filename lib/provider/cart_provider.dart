import 'dart:developer';

import 'package:cart/database/db_helper.dart';
import 'package:cart/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  //
  DBHelper dbHelper = DBHelper();
  //
  int _counter = 0;
  int get counter => _counter;

  //
  double _totalPrice = 0;
  double get totalPrice => _totalPrice;

  //
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getData() async {
    _cart = dbHelper.getCartList();
    return _cart;
  }

  //
  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  //
  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  //
  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  //
  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  //
  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  //
  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  //
  void removeTotalPrice(double prodcutPrice) {
    _totalPrice = _totalPrice - prodcutPrice;
    _setPrefItems();
    notifyListeners();
  }

  //
  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
