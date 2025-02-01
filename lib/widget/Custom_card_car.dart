import 'package:flutter/material.dart';
import 'package:car_store/Services/Wishlist/Check_wish_list_item.dart';
import 'package:car_store/Services/Wishlist/handle_wishlist.dart';
import 'package:car_store/models/product_model.dart';

class Custom_card_car extends StatefulWidget {
  Custom_card_car({
    super.key,
    required this.product,
    required this.userid,
  });

  final ProductModel product;
  final String userid;

  @override
  State<Custom_card_car> createState() => _Custom_card_carState();
}

class _Custom_card_carState extends State<Custom_card_car> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ======= Card Container =======
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                offset: const Offset(10, 10),
              ),
            ]),
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.carname,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.price,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 130),
                        Text(
                          widget.product.rating,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ======= Product Image =======
          Positioned(
            top: -10,
            left: 55,
            child: Image.network(
              widget.product.image,
              height: 210,
              width: 290,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 100,
                color: Colors.grey,
              ),
            ),
          ),
          // ======= Wishlist Icon =======
          Positioned(
            top: 20,
            left: 10,
            child: FutureBuilder<bool>(
              future: CheckWishListItem().checkItemExist(widget.userid, widget.product.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                final isInWishlist = snapshot.data ?? false;
            

                return GestureDetector(
                  onTap: () async {
                    await HandleWishlist().addProductToWishlist(
                      userId: widget.userid,
                      productId: widget.product.id,
                      product: widget.product,
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
                      color: isInWishlist ? Colors.red : Colors.grey,
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
