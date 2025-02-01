import 'package:car_store/models/Order_model.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/Custom_location_data.dart';
import 'package:car_store/widget/Custom_pick_Date.dart';
import 'package:car_store/widget/Custom_pick_time.dart';
import 'package:car_store/widget/Elevated_Button_Check_out.dart';
import 'package:car_store/widget/Payment_Change.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  static String id = 'CheckOutScreen';

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  OrderModel? order;

  @override

  @override
  void initState() {
    super.initState();
    // تهيئة order مع القيم الافتراضية
    order = OrderModel(
      image: '',
      cardnumber: '',
      category: '',
      cvc: '',
      date: '',
      expiredate: '',
      invoicePrice: '',
      location: '',
      productname: '',
      status: '',
      time: '',
    );
  }
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ProductModel carProduct = arguments['carproduct'];
    String userid = arguments['userid'];


    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.91,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(44),
                    bottomRight: Radius.circular(44)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  color: const Color(0xff4D535B),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 24,
                                )),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                          ),
                          const Text(
                            'Booking Car',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Image.network(
                        "${carProduct.image}",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            carProduct.carname,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                '4.9',
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        carProduct.price,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        color: Colors.grey,
                        indent: 20,
                        endIndent: 20,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomLocationdata(
                        labeltext: 'Enter your location',
                        icon: const Icon(
                          Icons.my_location_outlined,
                          size: 30,
                        ),
                        onchange: (value) {
                          setState(() {
                            order!.location = value; // تحديث الموقع
                          });
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Set date and time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? newdate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                                if (newdate == null) return;
                                setState(() {
                                  date = newdate;
                                  order!.date =
                                      newdate.toString(); // تحديث التاريخ
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xff303A46),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${date.day}/${date.month}/${date.year}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.amber,
                                      size: 24,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                TimeOfDay? newtime = await showTimePicker(
                                    context: context, initialTime: time);
                                if (newtime == null) return;
                                setState(() {
                                  time = newtime;
                                  order!.time =
                                      newtime.format(context); // تحديث الوقت
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: const Color(0xff303A46),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white,
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      time.format(context),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const Icon(
                                      Icons.timer_outlined,
                                      color: Colors.amber,
                                      size: 24,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text(
                            'Payment Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 210,
                              decoration: BoxDecoration(
                                color: const Color(0xff333B45),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Credit card',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 22),
                                      ),
                                      CustomLocationdata(
                                        labeltext: 'Enter Card number',
                                        icon: const Icon(
                                            Icons.credit_card_rounded),
                                        onchange: (value) {
                                          setState(() {
                                            order!.cardnumber =
                                                value; // تحديث رقم البطاقة
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: 200,
                                              child: CustomLocationdata(
                                                labeltext: 'MM/YY',
                                                icon: const Icon(
                                                    Icons.timer_outlined),
                                                onchange: (value) {
                                                  setState(() {
                                                    order!.expiredate =
                                                        value; // تحديث تاريخ الانتهاء
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: SizedBox(
                                              width: 200,
                                              child: CustomLocationdata(
                                                labeltext: 'CVC',
                                                icon: const Icon(Icons
                                                    .verified_user_outlined),
                                                onchange: (value) {
                                                  setState(() {
                                                    order!.cvc =
                                                        value; // تحديث CVC
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButtonCheckOut(
              formkey: formkey,
              productid: carProduct.id,
              userid: userid,
              order: order!, // إرسال order المكتمل
            )
          ],
        ),
      ),
    );
  }
}
