import 'package:badges/badges.dart';
import 'package:cart/databases/db_helper.dart';
import 'package:cart/model/cart_model.dart';
import 'package:cart/provider/cart_provider.dart';
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
  //name
  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];

  //unit
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];

  //price
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];

  //image
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
    //
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  );
                },
              ),
              animationDuration: const Duration(milliseconds: 300),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
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
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                    productImage[index].toString(),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                //
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        productUnit[index].toString() +
                                            " " +
                                            "Rs" +
                                            " " +
                                            productPrice[index].toString(),
                                      ),
                                      //
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper!
                                                .insert(
                                              Cart(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index]
                                                    .toString(),
                                                initialPrice:
                                                    productPrice[index]
                                                        .toString(),
                                                productPrice:
                                                    productPrice[index]
                                                        .toString(),
                                                quantity: 1,
                                                unitTag: productName[index]
                                                    .toString(),
                                                image: productImage[index]
                                                    .toString(),
                                              ),
                                            )
                                                .then((value) {
                                              print('Product is added to cart');
                                              cart.addTotalPrice(double.parse(
                                                  productPrice[index]
                                                      .toString()));
                                              cart.addCounter();
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
