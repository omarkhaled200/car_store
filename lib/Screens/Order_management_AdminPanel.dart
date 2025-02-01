
import 'package:car_store/Services/Order%20management/Get_all_orders_service.dart';

import 'package:car_store/models/Order_model.dart';
import 'package:flutter/material.dart';

class OrderManagementAdminpanel extends StatefulWidget {
  const OrderManagementAdminpanel({super.key});

  static String id = 'OrderManagementAdminpanel';

  @override
  State<OrderManagementAdminpanel> createState() =>
      _OrderManagementAdminpanelState();
}

class _OrderManagementAdminpanelState extends State<OrderManagementAdminpanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: StreamBuilder(
          stream: Stream.fromFuture(GetAllOrdersService().extractKeysAsMap()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            Map<String, List<String>>? list = snapshot!.data;
              print('snapshot is :${snapshot}');
              return StreamBuilder(
                  stream:
                      Stream.fromFuture(GetAllOrdersService().getAllorder()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<OrderModel>? product = snapshot!.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "List of Orders",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: OrderTable(
                                  orderlist: product!,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderTable extends StatefulWidget {
  const OrderTable({super.key, required this.orderlist});
  final List<OrderModel> orderlist;

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {
  @override
  Widget build(BuildContext context) {
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
                child: Text('car Name',
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
                child: Text('Card number',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('CVC',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Expected Delivery',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Invoice Price',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white))),
            Center(
                child: Text('Status',
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
          ],
        ),
        ...widget.orderlist.map((order) {
          // التحقق من القيمة الافتراضية
          String dropdownvalue =
              ['Pending', 'Completed', 'Cancelled'].contains(order.status)
                  ? order.status
                  : 'Pending';

          return TableRow(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.productname,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.category,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.cardnumber,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.cvc, style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.location,
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${order.date} ${order.time}',
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(order.invoicePrice.toString(),
                      style: const TextStyle(fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: dropdownvalue,
                  items: const [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(
                        value: 'Completed', child: Text('Completed')),
                    DropdownMenuItem(
                        value: 'Cancelled', child: Text('Cancelled')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      order.status = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    // تنفيذ الأكشن المطلوب
                    print(
                        'Set Status for Order card number: ${order.cardnumber}');
                      
                  },
                  child: const Text(
                    'Set Status',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
