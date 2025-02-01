import 'package:car_store/Screens/main_page.dart';


import 'package:flutter/material.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key});
  static String id = 'CheckoutSuccess';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.amber,
              size: 250,
            ),
            const Text(
              'Payment Successful',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
            ),
            Center(
                child: Text('The car was purchased successfully.',
                    style: TextStyle(
                        fontSize: 28, color: Colors.black.withOpacity(0.4)))),
            Center(
                child: Text('You Can Check Your Order on The Menu Profile.',
                    style: TextStyle(
                        fontSize: 28, color: Colors.black.withOpacity(0.4)))),
            const SizedBox(
              height: 70,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MainPage.id
                    );
                  },
                  child:const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 32,
                        fontWeight: FontWeight.w800),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
