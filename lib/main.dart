import 'package:car_store/Screens/Add_product_admin_panel.dart';
import 'package:car_store/Screens/Admin_Panel_pages.dart';
import 'package:car_store/Screens/Check_out_screen.dart';
import 'package:car_store/Screens/Checkout_success.dart';
import 'package:car_store/Screens/Edit_product_admin_panel.dart';
import 'package:car_store/Screens/Get_started_screen.dart';
import 'package:car_store/Screens/Order_management_AdminPanel.dart';
import 'package:car_store/Screens/Order_user_page.dart';
import 'package:car_store/Screens/Register_page.dart';
import 'package:car_store/Screens/Statistics_page_AdminPanel.dart';
import 'package:car_store/Screens/User_edit_account.dart';
import 'package:car_store/Screens/ViewAll_product.dart';
import 'package:car_store/Screens/Manage_product_admin_panel.dart';
import 'package:car_store/Screens/description_screen.dart';
import 'package:car_store/Screens/login_screen.dart';
import 'package:car_store/Screens/main_page.dart';
import 'package:car_store/cubit/homepage_cubit.dart';
import 'package:car_store/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Car_Store());
}

class Car_Store extends StatelessWidget {
  const Car_Store({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomepageCubit(),
        ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        GetStartedScreen.id:(context)=>const GetStartedScreen(),
        RegisterPage.id: (context)=> RegisterPage(),
        LoginScreen.id:(context)=> LoginScreen(),
        MainPage.id:(context)=>const MainPage(),
        ViewallProduct.id:(context)=>const ViewallProduct(),   
        DescriptionScreen.id:(context)=>const DescriptionScreen(),
        CheckoutSuccess.id:(context)=>const CheckoutSuccess(),  
        CheckOutScreen.id:(context)=>const CheckOutScreen(),
        OrderUserPage.id:(context)=>const OrderUserPage(),
        UserEditAccount.id:(context)=> UserEditAccount(),

        AdminPanelPages.id:(context)=>const AdminPanelPages(),   
        StatisticsPageAdminpanel.id:(context)=>const StatisticsPageAdminpanel(),   
        AddProductAdminPanel.id:(context)=> AddProductAdminPanel(),
        EditProductAdminPanel.id:(context)=>const EditProductAdminPanel(),  
        ManageProductAdminPanel.id:(context)=>const ManageProductAdminPanel(),  
        // OrderManagementAdminpanel.id:(context)=>const OrderManagementAdminpanel(),  
      },

      initialRoute: GetStartedScreen.id,

    ));
  }
}