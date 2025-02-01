
import 'package:car_store/Screens/Manage_product_admin_panel.dart';
import 'package:car_store/Screens/Order_management_AdminPanel.dart';
import 'package:car_store/Screens/Statistics_page_AdminPanel.dart';
import 'package:car_store/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class AdminPanelPages extends StatefulWidget {
  const AdminPanelPages({super.key});
  static String id = 'AdminPanelPages';

  @override
  State<AdminPanelPages> createState() => _StatisticsPageAdminpanelState();
}

class _StatisticsPageAdminpanelState extends State<AdminPanelPages> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
  const  StatisticsPageAdminpanel(),
  const  ManageProductAdminPanel(),
  const  OrderManagementAdminpanel(),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context); // لإغلاق الـ Drawer بعد الضغط على العنصر
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: <Widget>[
             DrawerHeader(
              child: Center( child: Row(
                children: [
                  Image.asset('assets/car_lolo1.png',width: 150,height: 150,),
                const  Text("Luxury",style: TextStyle(color: Colors.white,fontSize: 28),),
                ],
              )),
            ),
            ListTile(
              leading:const Icon(Icons.insert_chart_outlined_outlined,color: Colors.white,size: 26,),
              title: const Text("Statistics Page",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading:const Icon(Icons.store_mall_directory_rounded,color: Colors.white,size: 26,),
              title: const Text("Product Management",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
                leading:const Icon(Icons.receipt_long,color: Colors.white,size: 26,),
              title: const Text("Order Management",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
              onTap: () => _onDrawerItemTapped(2),
            ),
            ListTile(
                leading:const Icon(Icons.logout,color: Colors.white,size: 26,),
              title: const Text("Sign Out",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id                                                                                 );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
