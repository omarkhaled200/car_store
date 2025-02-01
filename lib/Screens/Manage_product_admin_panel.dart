import 'package:car_store/Screens/Add_product_admin_panel.dart';
import 'package:car_store/Screens/Edit_product_admin_panel.dart';
import 'package:car_store/Services/Home%20page%20management/Get_Latest_products_service.dart';
import 'package:car_store/Services/Product%20Management/Get_products_service.dart';
import 'package:car_store/Services/Product%20Management/delete_product_service.dart';
import 'package:car_store/constant.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/custom_button.dart';
import 'package:flutter/material.dart';

class ManageProductAdminPanel extends StatelessWidget {
  const ManageProductAdminPanel({super.key});
  static String id = 'ManageProductAdminPanel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: GetAllProductService().getallproduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductModel> products = snapshot.data!;
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: CustomButton(
                        text: 'Add product',
                        onpressed: () {
                          Navigator.pushNamed(context, AddProductAdminPanel.id);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Customtable(
                            products: products,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class Customtable extends StatelessWidget {
  Customtable({super.key, required this.products});

  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    print("prodcut length is ${products.length}");
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(150),
        1: FixedColumnWidth(150),
        2: FixedColumnWidth(150),
        3: FixedColumnWidth(150),
        4: FixedColumnWidth(150),
        5: FixedColumnWidth(150),
        6: FixedColumnWidth(150),
        7: FixedColumnWidth(150),
        8: FixedColumnWidth(150),
      },
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.black),
          children: [
            Center(
                child: Text('car name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Category',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Speed',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('engine',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('image',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('rating',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Action',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
          ],
        ),
        ...products.map((Car) {
          return TableRow(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.carname, style: const TextStyle(fontSize: 20)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.category,
                    style: const TextStyle(
                        fontSize: 20, overflow: TextOverflow.ellipsis)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.price, style: const TextStyle(fontSize: 20)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.speed, style: const TextStyle(fontSize: 20)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.engine, style: const TextStyle(fontSize: 20)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.image.toString(),
                    style: const TextStyle(
                        fontSize: 20, overflow: TextOverflow.ellipsis)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(Car.rating.toString(),
                    style: const TextStyle(fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, EditProductAdminPanel.id,
                      arguments: Car);
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  DeleteProductService().deleteproduct(prductid: Car.id);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]);
        })
      ],
    );
  }
}
