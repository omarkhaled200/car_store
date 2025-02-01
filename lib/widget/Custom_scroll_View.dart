import 'package:car_store/Screens/ViewAll_product.dart';
import 'package:car_store/Screens/description_screen.dart';
import 'package:car_store/Services/Home%20page%20management/Get_Category_latest_service.dart';
import 'package:car_store/constant.dart';
import 'package:car_store/cubit/homepage_cubit.dart';
import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/Custom_card_car.dart';
import 'package:car_store/widget/Row_name_viewall.dart';
import 'package:car_store/widget/custom_pageview_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Custom_scroll_View extends StatelessWidget {
  Custom_scroll_View({
    super.key,
    required this.userid,
  });
  final String userid;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomepageCubit>(context).startListeningForCars('BMW');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/car_lolo1.png',
              width: 100,
              height: 80,
            ),
            const Text(
              'Luxury',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        actions: [
          Stack(clipBehavior: Clip.none, children: [
            Positioned(
              right: 2,
              top: 3,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const Icon(
              Icons.notifications_none_rounded,
              size: 28,
            ),
          ]),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_rounded),
                    ),
                    labelText: 'Search'),
              ),
            ),
            SliverToBoxAdapter(child: Custompageview_indecator()),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommendation',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            ////////////////////////////////////////////////////////////! BMW cars
            SliverToBoxAdapter(
              child: StreamBuilder(
                stream: Stream.fromFuture(
                    GetCategoryLatestService().getCarsByCategory('BMW')),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductModel> bmcar = snapshot.data!;
                    return Row_name_viewall(
                      name: 'BMW',
                      ontap: () {
                        Navigator.pushNamed(context, ViewallProduct.id,
                            arguments: {
                              'products': bmcar,
                              "title": 'BMW Car',
                              'userid': userid
                            });
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            SliverToBoxAdapter(
                child: StreamBuilder(
                    stream:  BlocProvider.of<HomepageCubit>(context).carsStream,
                    builder: (context, snapshot) {
                      print('snapshot is ${snapshot.data}');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No BMW cars available'));
                      } else {
                        List<ProductModel> bmwCars = snapshot.data!;
                        return SizedBox(
                            height: 260,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: bmwCars.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DescriptionScreen.id,
                                            arguments: {
                                              'productmodel':bmwCars[index],
                                              'userid':userid
                                            });
                                      },
                                      child: Custom_card_car(
                                          userid: userid,
                                          product: bmwCars[index]));
                                }));
                      }
                    })),
            ////////////////////////////////////////////////////////////!Mercedes Benz Cars
            SliverToBoxAdapter(
              child: StreamBuilder(
                stream: Stream.fromFuture(GetCategoryLatestService()
                    .getCarsByCategory('Mercedes Benz')),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductModel> MercedesBenz = snapshot.data!;
                    return Row_name_viewall(
                      name: 'Mercedes Benz',
                      ontap: () {
                        Navigator.pushNamed(context, ViewallProduct.id,
                            arguments: {
                              'products': MercedesBenz,
                              "title": 'Mercedes Benz Car',
                              'userid': userid
                            });
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            SliverToBoxAdapter(
                child: StreamBuilder(
                    stream: Stream.fromFuture(GetCategoryLatestService()
                        .getCarsByCategory('Mercedes Benz')),
                    builder: (context, snapshot) {
                      print('snapshot is ${snapshot.data}');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No BMW cars available'));
                      } else {
                        List<ProductModel> MercedesBenz = snapshot.data!;
                        return SizedBox(
                            height: 260,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: MercedesBenz.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DescriptionScreen.id,
                                            arguments: {
                                              'productmodel':
                                                  MercedesBenz[index],
                                              'userid': userid
                                            });
                                      },
                                      child: Custom_card_car(
                                          userid: userid,
                                          product: MercedesBenz[index]));
                                }));
                      }
                    })),
            ////////////////////////////////////////////////////////////////!porsche cars

            SliverToBoxAdapter(
              child: StreamBuilder(
                stream: Stream.fromFuture(
                    GetCategoryLatestService().getCarsByCategory('porsche')),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<ProductModel> porschecar = snapshot.data!;
                    return Row_name_viewall(
                      name: 'porsche',
                      ontap: () {
                        Navigator.pushNamed(context, ViewallProduct.id,
                            arguments: {
                              'products': porschecar,
                              "title": 'porsche Car',
                              'userid': userid
                            });
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),

            SliverToBoxAdapter(
                child: StreamBuilder(
                    stream: Stream.fromFuture(GetCategoryLatestService()
                        .getCarsByCategory('porsche')),
                    builder: (context, snapshot) {
                      print('snapshot is ${snapshot.data}');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No BMW cars available'));
                      } else {
                        List<ProductModel> porscheCars = snapshot.data!;
                        return SizedBox(
                            height: 260,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: porscheCars.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, DescriptionScreen.id,
                                            arguments: {
                                              'productmodel':porscheCars[index],
                                              'userid':userid
                                      },
                                      );
                                      },
                                      child: Custom_card_car(
                                          userid: userid,
                                          product: porscheCars[index]));
                                }));
                      }
                    })),
//////////////////////////////////////////////////////////////////!
          ],
        ),
      ),
    );
  }
}
