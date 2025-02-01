import 'package:car_store/Screens/Register_page.dart';
import 'package:car_store/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});
  static String id = 'GetStartedScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff1D1F20),
      appBar: AppBar(
        backgroundColor: Color(0xff1D1F20),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/car_lolo1.png',
              width: 100,
              height: 80,
            ),
            const Text(
              'Luxury',
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          const  SizedBox(height: 50),
            Image.asset('assets/pngwing.com (1).png'),
          const  Column(children: [
              Text(
                'Luxury Cars',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Enjoy the Premium',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Find a variety of the car of your dreams, at agood price and quality premium.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ]),
          const  SizedBox(
              height: 100,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize:const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.id);
                },
                child:const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                )),
          const  SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            const    Text(
                  'don\'t have an account?  ',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: InkWell(
                      child:const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
