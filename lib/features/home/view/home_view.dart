import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruits_market_app/core/constant/app_colors.dart';
import 'package:fruits_market_app/features/home/widget/food_category.dart';
import 'package:fruits_market_app/features/product/views/product_details_view.dart';
import 'package:fruits_market_app/shared/custom_text.dart';
import 'package:gap/gap.dart' show Gap;

import '../widget/cart_item.dart';
import '../widget/search_field.dart';
import '../widget/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ["All", "Combo", "Sliders", "Classic"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight:200 ,
floating: false,
pinned: true,
automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 30.0,right:20,left: 20 ),
                child: Column(
                  children: [
                    UserHeader(),
                    Gap(20),
                    SearchField(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                child:
                    FoodCategory(selectedIndex: selectedIndex, category: category),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(childCount: 6, (
                  context, index, ) =>GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(c){
                          return ProductDetailsView();
                        }));
                  },
                  child: CardItem(
                    image: "assets/images/imageHome1.png",
                    text: "Cheeseburger",
                    desc: "Wendy's Burger",
                    rate: "  4.9",
                                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
