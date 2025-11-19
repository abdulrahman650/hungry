import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/view/home_view.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/glass_nav.dart';

import 'core/constant/app_colors.dart';
import 'features/auth/views/profile_view.dart';
import 'features/cart/views/cart_view.dart';
import 'features/orderHisory/views/order_history_view.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with TickerProviderStateMixin {
  late PageController controller;
  late List<AnimationController> iconControllers;
  late List<Widget> screen;
  int currentScreen = 0;

  @override
  void initState() {
    super.initState();
    screen = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    controller = PageController(initialPage: 0);

    iconControllers = List.generate(
      4,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      ),
    );

    iconControllers[currentScreen].forward();
  }

  @override
  void dispose() {
    controller.dispose();
    for (var c in iconControllers) c.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => currentScreen = index);

    // Animate selected icon
    iconControllers[index].forward();

    // Reverse others
    for (var i = 0; i < iconControllers.length; i++) {
      if (i != index) iconControllers[i].reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: IndexedStack(index: currentScreen, children: screen),
        bottomNavigationBar: GlassBottomNavBar(
          currentIndex: currentScreen,
          onTap: _onTabTapped,
          items: [
            BottomNavItemData(
              label: 'Home',
              icon: Icon(CupertinoIcons.home),
              filledIcon: AnimatedIcon(
                icon: AnimatedIcons.menu_home,
                progress: iconControllers[0],
              ),
            ),
            BottomNavItemData(
              label: 'Cart',
              icon: Icon(CupertinoIcons.cart),
              filledIcon: Badge(
                label: CustomText(text: '1', size: 10),
                child: AnimatedIcon(
                  icon: AnimatedIcons.view_list,
                  progress: iconControllers[1],
                ),
              ),
            ),
            BottomNavItemData(
              label: 'History',
              icon: Icon(Icons.table_bar_outlined),
              filledIcon: AnimatedIcon(
                icon: AnimatedIcons.list_view,
                progress: iconControllers[2],
              ),
            ),
            BottomNavItemData(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person_alt_circle),
              filledIcon: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu,
                progress: iconControllers[3],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Container(
//
//   padding: EdgeInsets.all( 10),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(30),
//     color: AppColors.primary,
//   ),
//   child: BottomNavigationBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     type: BottomNavigationBarType.fixed,
//     selectedItemColor: Colors.white,
//     unselectedItemColor: Colors.grey.shade700.withOpacity(.7),
//     currentIndex: currentScreen,
//
//     onTap: (index) {
//       setState(() => currentScreen = index);
//       controller.jumpToPage(currentScreen);
//     },
//     items: [
//       BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.home,size: 20),
//         label: "Home",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.cart,size: 20,),
//         label: "Cart",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.local_restaurant_sharp,size: 18),
//         label: "History",
//
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.profile_circled,size: 20),
//         label: "Profile",
//
//
//       ),
//     ],
//   ),
//
// ),
