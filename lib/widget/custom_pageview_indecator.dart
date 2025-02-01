import 'package:car_store/Services/Home%20page%20management/Get_Latest_products_service.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Custompageview_indecator extends StatelessWidget {
  Custompageview_indecator({super.key});
  final _controllar = PageController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetLatestProductsService().getlatestproduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data!;
            return SizedBox(
              height: 400,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 350,
                    child: PageView.builder(
                      controller: _controllar,
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return CustomCard(product: products[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                      child: SmoothPageIndicator(
                    controller: _controllar,
                    count: 4,
                    effect: const SlideEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black,
                      dotHeight: 8,
                    ),
                  )),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
