import 'package:car_store/Services/Order%20management/Cancel_Order_service.dart';
import 'package:car_store/Services/Order%20management/Get_User_Orders_service.dart';
import 'package:car_store/Services/Order%20management/Get_order_service.dart';
import 'package:car_store/models/Order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderUserPage extends StatelessWidget {
  const OrderUserPage({super.key});
  static String id = 'OrderUserPage';

  @override
  Widget build(BuildContext context) {
    var userid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24)),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 28,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                  const Text(
                    "My Order",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder(
                stream: Stream.fromFuture(
                    GetUserOrdersService().GetUserOrders(userid)),
                builder: (context, snapshot) {
                  print('snapshot is ${snapshot.data}');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error snapshot 1: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No cars available'));
                  } else {
                    List<String> productid = snapshot.data!;

                    print('prodcut id is : $productid');
                    return StreamBuilder(
                        stream: Stream.fromFuture(GetOrderService()
                            .GetOrder(productid: productid, userid: userid)),
                        builder: (context, snapshot) {
                          print('snapshot 2 is ${snapshot.data}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'Error snapshot 2: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No cars available'));
                          } else {
                            List<OrderModel> favouriteproduct = snapshot.data!;
                            print('the list equal : $favouriteproduct');
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ListView.builder(
                                  itemCount: favouriteproduct!.length,
                                  itemBuilder: (context, index) {
                                    return Customorder(
                                      productid: productid[index],
                                      userid: userid,
                                      order: favouriteproduct[index],
                                    );
                                  }),
                            );
                          }
                        });
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Customorder extends StatelessWidget {
  const Customorder({
    super.key,
    required this.order,
    required this.userid,
    required this.productid,
  });
  final OrderModel order;
  final String userid;
  final String productid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 300,
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Image.network(
                  order.image,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      order.productname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Price: ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          r'$' '${order.invoicePrice}',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Date: ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          order.date,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Order is: ${order.status}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              CancelOrderService().CancelOrder(
                                  prductid: productid,
                                  userid: userid,
                                  );
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
