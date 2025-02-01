import 'dart:io';

import 'package:car_store/Services/Product%20Management/update_product_service.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductAdminPanel extends StatefulWidget {
  const EditProductAdminPanel({super.key});
  static String id = 'EditProductAdminPanel';

  @override
  State<EditProductAdminPanel> createState() => _EditProductAdminPanelState();
}

class _EditProductAdminPanelState extends State<EditProductAdminPanel> {
  List<String> valueList = ['BMW', 'Mercedes Benz', 'porsche'];
  ProductModel? newproduct;
  ProductModel? product;

  File? image;
  final PickedFile = ImagePicker();

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    uploadImage() async {
      XFile? xFile = await PickedFile.pickImage(source: ImageSource.gallery);
      if (xFile != null) {
        setState(() {
          image = File(xFile.path);
        });
      } else {
        image = File(product.image);
      }
    }


@override
void initState() {
  super.initState();
  if (product != null) {
    newproduct = ProductModel(
      id: product.id,
      carname: product.carname,
      descriptoin: product.descriptoin,
      price: product.price,
      image: product.image,
      rating: product.rating,
      category: product.category,
      engine: product.engine,
      seats: product.seats,
      speed: product.speed,
    );
  } else {
      print(product);
      // Handle the case when product is null
      // مثلاً يمكن أن تظهر رسالة خطأ أو تضع قيم فارغة
      newproduct = ProductModel(
          id: "1",
          carname: "omar",
          descriptoin: "dddd",
          price: "333",
          image: "",
          rating: "3",
          category: "BMW",
          engine: "444",
          seats: "4",
          speed: "444");
    }

}





    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("No product data found")),
      );
    }

    String dropdownvalue = product.category;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Edit Product',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    )),
                CustomTextFieldAdminPanel(
                  labeltext: product.carname,
                  onchange: (value) {
                    setState(() {
                       print('Previous: ${newproduct!.carname}, New: $value');
                      newproduct!.carname =
                          value.isNotEmpty ? value : product.carname;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.descriptoin,
                  onchange: (value) {
                    setState(() {
                      newproduct!.descriptoin =
                          value.isNotEmpty ? value : product.descriptoin;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.price,
                  onchange: (value) {
                    setState(() {
                      newproduct!.price =
                          value.isNotEmpty ? value : product.price;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.seats,
                  onchange: (value) {
                    setState(() {
                      newproduct!.seats =
                          value.isNotEmpty ? value : product.seats;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.speed,
                  onchange: (value) {
                    setState(() {
                      newproduct!.speed =
                          value.isNotEmpty ? value : product.speed;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.engine,
                  onchange: (value) {
                    setState(() {
                      newproduct!.engine =
                          value.isNotEmpty ? value : product.engine;
                    });
                  },
                ),
                CustomTextFieldAdminPanel(
                  labeltext: product.rating,
                  onchange: (value) {
                    setState(() {
                      newproduct!.rating =
                          value.isNotEmpty ? value : product.rating;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            gapPadding: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            gapPadding: 5)),
                    alignment: Alignment.bottomLeft,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w600),
                    borderRadius: BorderRadius.circular(24),
                    focusColor: Colors.amber,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down_circle),
                    iconSize: 28,
                    iconEnabledColor: Colors.black,
                    value: dropdownvalue,
                    items: const [
                      DropdownMenuItem(
                          value: 'Category', child: Text('Category')),
                      DropdownMenuItem(value: 'BMW', child: Text('BMW')),
                      DropdownMenuItem(
                          value: 'Mercedes Benz', child: Text('Mercedes Benz')),
                      DropdownMenuItem(
                          value: 'porsche', child: Text('porsche')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropdownvalue = value!;
                        newproduct!.category =
                          value.isNotEmpty ? value : product.category;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: uploadImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Image',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                image == null
                    ? const Text(
                        'Not Choosen Image',
                        style: TextStyle(fontSize: 24),
                      )
                    : Image.file(image!, width: 200, height: 200),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Edit',
                  onpressed: () {
                    print(
                        'newproduct descrption is ${newproduct!.descriptoin}');
                    UpdateProductService().updateprodcutRequestWithfile(
                        product: newproduct!, id: product.id, file: image!);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldAdminPanel extends StatelessWidget {
  CustomTextFieldAdminPanel(
      {super.key, required this.labeltext, required this.onchange});
  final String labeltext;
  void Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        onChanged: onchange,
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field is required';
          }
        },
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: labeltext,
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.3),
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
      ),
    );
  }
}
