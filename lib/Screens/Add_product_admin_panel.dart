import 'dart:io';

import 'package:car_store/Services/Product%20Management/Add_product_service.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProductAdminPanel extends StatefulWidget {
  AddProductAdminPanel({super.key});
  static String id = 'AddProductAdminPanel';

  @override
  State<AddProductAdminPanel> createState() => _AddProductAdminPanelState();
}

class _AddProductAdminPanelState extends State<AddProductAdminPanel> {
  List<String> valueList = ['BMW', 'Mercedes Benz', 'porsche'];
  String dropdownvalue = 'Category';
  ProductModel? product;

  void initState() {
    super.initState();
    // تهيئة المنتج هنا
    product = ProductModel(
      id:'',
      carname: '',
      descriptoin: '',
      price: '',
      image: '',
      rating: '',
      category: '',
      engine: '',
      seats: '',
      speed: '',
    );
  }

  File? image;
  final PickedFile = ImagePicker();


  uploadImage() async {
    XFile? xFile = await PickedFile.pickImage(source: ImageSource.gallery);
        if (xFile != null) {
      setState(() {
        image = File(xFile.path);
        product!.image = image!.path;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  )),
              CustomTextFieldAdminPanel(
                labeltext: 'Product Name',
                onchange: (value) {
                  product!.carname = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Description',
                onchange: (value) {
                  product!.descriptoin = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Price',
                onchange: (value) {
                  product!.price = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Number of Seats',
                onchange: (value) {
                  product!.seats = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Highest Speed',
                onchange: (value) {
                  product!.speed = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Engine Output',
                onchange: (value) {
                  product!.engine = value;
                },
              ),
              CustomTextFieldAdminPanel(
                labeltext: 'Rating',
                onchange: (value) {
                  product!.rating = value;
                },
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
                    DropdownMenuItem(value: 'porsche', child: Text('porsche')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropdownvalue = value!;
                      product!.category = value;
                    });
                  },
                ),
              ),
              SizedBox(
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
                text: 'Add',
                onpressed: () {
                  AddProductService().addprodcutRequestWithfile(product: product!,file: image!);
                },
              )
            ],
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
  final void Function(String)? onchange;
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
          labelText: labeltext,
          labelStyle: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
      ),
    );
  }
}
