import 'package:car_store/Services/Product%20Management/Get_product_service.dart';
import 'package:car_store/Services/Wishlist/Check_wish_list_item.dart';
import 'package:car_store/Services/Wishlist/Get_user_wishlist.dart';
import 'package:car_store/Services/Wishlist/handle_wishlist.dart';
import 'package:car_store/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Favoritecar extends StatelessWidget {
  Favoritecar({super.key, required this.userid});
  final String userid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Favorite Car",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.fromFuture(GetUserWishlist().UserWishlist(userid)),
        builder: (context, snapshot) {
          print('snapshot is ${snapshot.data}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error snapshot : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cars available'));
          } else {
            List<String> productid = snapshot.data!;
            return StreamBuilder(
                stream: Stream.fromFuture(
                    GetProductService().getProduct(productid: productid)),
                builder: (context, snapshot) {
                  print('snapshot is ${snapshot.data}');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error snapshot: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No cars available'));
                  } else {
                    List<ProductModel> favouriteproduct = snapshot.data!;
                    return ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Custom_Favorite_car(
                            product: favouriteproduct[index],
                            userid: userid,
                          );
                        });
                  }
                });
          }
        },
      ),
    );
  }
}

class Custom_Favorite_car extends StatelessWidget {
  Custom_Favorite_car({
    super.key,
    required this.product,
    required this.userid,
  });
  final ProductModel product;
  final String userid;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Image.network(product.image),
                const SizedBox(
                  width: 100,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          product.carname,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Price: ',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                r'$' '${product.price}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                product.rating,
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
                                  onPressed: () {},
                                  child: const Text(
                                    'Buy Now',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              FutureBuilder<bool>(
                                future: CheckWishListItem()
                                    .checkItemExist(userid, product.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  final isInWishlist = snapshot.data ?? false;

                                  return GestureDetector(
                                    onTap: () async {
                                      await HandleWishlist()
                                          .addProductToWishlist(
                                        userId: userid,
                                        productId: product.id,
                                        product: product,
                                      );
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        color: isInWishlist
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
