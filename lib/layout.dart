import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruits_market_app/features/home/view/home_view.dart';

import 'core/constant/app_colors.dart';
import 'features/auth/views/profile_view.dart';
import 'features/cart/views/cart_view.dart';
import 'features/orderHisory/views/order_history_view.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late PageController controller;

  late List<Widget> screen;
  int currentScreen = 0;

  @override
  void initState() {
    screen = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: screen,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade700.withOpacity(.7),
          currentIndex: currentScreen,

          onTap: (index) {
            setState(() => currentScreen = index);
            controller.jumpToPage(currentScreen);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: "Order History",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
