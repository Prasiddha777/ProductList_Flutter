import 'package:badges/badges.dart';
import 'package:cart/database/db_helper.dart';
import 'package:cart/model/cart_model.dart';
import 'package:cart/provider/cart_provider.dart';
import 'package:cart/screens/cartlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  //
  DBHelper? dbHelper = DBHelper();

  //
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'KG',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612',
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612',
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612',
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Home Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: Badge(
                animationDuration: const Duration(milliseconds: 300),
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                  size: 27,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 3,
                      ),
                      child: ListTile(
                          leading:
                              Image.network(productImage[index].toString()),
                          title: Text(
                            productName[index].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Rs ${productPrice[index].toString()} per ${productUnit[index].toString()}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                            ),
                            onPressed: () {
                              dbHelper!
                                  .insert(
                                Cart(
                                    id: index,
                                    productId: index.toString(),
                                    productName: productName[index].toString(),
                                    initialPrice: productPrice[index],
                                    productPrice: productPrice[index],
                                    quantity: 1,
                                    unitTag: productUnit[index].toString(),
                                    image: productImage[index].toString()),
                              )
                                  .then((value) {
                                print('Product is added');
                                cart.addTotalPrice(double.parse(
                                    productPrice[index].toString()));
                                cart.addCounter();
                              }).onError((error, stackTrace) {
                                print(error.toString());
                              });
                            },
                            child: Text('Add to Cart'),
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
