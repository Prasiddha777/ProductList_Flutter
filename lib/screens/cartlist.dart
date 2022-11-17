import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cart/database/db_helper.dart';
import 'package:cart/model/cart_model.dart';
import 'package:cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Cart List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Center(
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
          const SizedBox(
            width: 25,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 0,
                              ),
                              child: ListTile(
                                leading: Image.network(
                                    snapshot.data![index].image.toString()),
                                title: Text(
                                  snapshot.data![index].productName.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rs ${snapshot.data![index].productPrice.toString()} per ${snapshot.data![index].unitTag.toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            int quantity =
                                                snapshot.data![index].quantity;
                                            int price = snapshot
                                                .data![index].initialPrice;
                                            quantity--;
                                            int? newprice = quantity * price;
                                            if (quantity > 0) {
                                              dbHelper!
                                                  .updateQuantity(
                                                Cart(
                                                    id: snapshot
                                                        .data![index].id,
                                                    productId: snapshot
                                                        .data![index].productId
                                                        .toString(),
                                                    productName: snapshot
                                                        .data![index]
                                                        .productName,
                                                    initialPrice: snapshot
                                                        .data![index]
                                                        .initialPrice,
                                                    productPrice: newprice,
                                                    quantity: quantity,
                                                    unitTag: snapshot
                                                        .data![index].unitTag
                                                        .toString(),
                                                    image: snapshot
                                                        .data![index].image
                                                        .toString()),
                                              )
                                                  .then((value) {
                                                quantity = 0;
                                                newprice = 0;
                                                cart.removeTotalPrice(
                                                    double.parse(snapshot
                                                        .data![index]
                                                        .initialPrice
                                                        .toString()));
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                              });
                                            }
                                          },
                                          child: const Icon(Icons.remove),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(snapshot.data![index].quantity
                                            .toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              int quantity = snapshot
                                                  .data![index].quantity;
                                              int price = snapshot
                                                  .data![index].initialPrice;
                                              quantity++;
                                              int? newprice = quantity * price;
                                              dbHelper!
                                                  .updateQuantity(
                                                Cart(
                                                    id: snapshot
                                                        .data![index].id,
                                                    productId: snapshot
                                                        .data![index].productId
                                                        .toString(),
                                                    productName: snapshot
                                                        .data![index]
                                                        .productName,
                                                    initialPrice: snapshot
                                                        .data![index]
                                                        .initialPrice,
                                                    productPrice: newprice,
                                                    quantity: quantity,
                                                    unitTag: snapshot
                                                        .data![index].unitTag
                                                        .toString(),
                                                    image: snapshot
                                                        .data![index].image
                                                        .toString()),
                                              )
                                                  .then((value) {
                                                quantity = 0;
                                                newprice = 0;
                                                cart.addTotalPrice(double.parse(
                                                    snapshot.data![index]
                                                        .initialPrice
                                                        .toString()));
                                              }).onError((error, stackTrace) {
                                                print(error.toString());
                                              });
                                            },
                                            child: const Icon(Icons.add)),
                                      ],
                                    )
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    dbHelper!.deleteCartList(
                                        snapshot.data![index].id!);
                                    //
                                    cart.removeCounter();
                                    cart.removeTotalPrice(double.parse(snapshot
                                        .data![index].productPrice
                                        .toString()));
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),

          //
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                  ? false
                  : true,
              child: Column(
                children: [
                  ReusableWidget(
                    title: 'Sub Total',
                    value: r'Rs ' + value.getTotalPrice().toStringAsFixed(2),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  ReusableWidget({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
