import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';
import 'package:hungry_app/features/check_out/views/checkout_view.dart';
import 'package:hungry_app/shared/custom_botton.dart';
import 'package:hungry_app/shared/custom_snakbar.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/constant/app_colors.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/data/user_model.dart';
import '../../auth/views/login_view.dart';
import '../data/cart_repo.dart';
import '../widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities=[];
  bool isLoading = false;
  bool isLoadingRemove = false;
  bool isGuest = false;
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) setState(() => userModel = user);
  }
  CartRepo cartRepo = CartRepo();
  GetCartResponse? cartResponse;

  Future<void> getCartData() async {
    try {
      if(!mounted) return;
      setState(()=> isLoading = true);

      final res = await cartRepo.getCartData();
      if(!mounted) return;
      final itemCount = res?.cartData.items.length ?? 0;
      setState((){
        cartResponse = res;
        quantities = List.generate(itemCount, (_)=>1);
        isLoading = false;
      });
    } catch (e) {
      if(!mounted) return;
      setState(()=> isLoading = false);
      print(e.toString());
    }
  }
  Future<void> removeCartItem(int id)async{
    try{
      setState(() {
        isLoadingRemove = true;
      });
      await cartRepo.removeCartItem(id);
      getCartData();
      setState(() {
        isLoadingRemove = false;
      });
    }catch(e){
      setState(() {
        isLoadingRemove = false;
      });
     print(e.toString());
    }
  }

  @override
  void initState() {
    getCartData();
    autoLogin();
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMin(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    if(!isGuest){
      return Skeletonizer(
        enabled: cartResponse == null,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            scrolledUnderElevation: 0.0,
            elevation: 0,
            leading: SizedBox.shrink(),
            centerTitle: true,
            backgroundColor: Colors.white,
            title: CustomText(
              text: 'My Cart',
              color: Colors.black87,
              weight: FontWeight.w600,
              size: 20,
            ),
          ),
          body: isLoading
              ? Center(child: CupertinoActivityIndicator())
              : Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  itemCount: cartResponse?.cartData.items.length ?? 0,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 120, top: 10),
                  itemBuilder: (context, index) {
                    final item = cartResponse!.cartData.items[index];
                    // if (cartResponse?.cartData.items == null || cartResponse!.cartData.items.isEmpty) {
                    //   return Center(child: Text("Your cart is empty"));
                    // }
                    // final item = cartResponse!.cartData.items[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(3, 3),
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: CartItem(
                          isLoading: isLoadingRemove,
                          image: item.image,
                          text: item.name,
                          desc: "Spicy ${item.spicy}",
                          number: quantities[index],
                          onAdd: () => onAdd(index),
                          onMin: () => onMin(index),
                          onRem: (){removeCartItem(item.itemId);},
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Floating total bar
              Positioned(
                right: -10,
                left: -10,
                bottom: -115,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [
                    //     AppColors.primary.withOpacity(0.8),
                    //     AppColors.primary.withOpacity(0.8),
                    //     AppColors.primary,
                    //   ],
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    borderRadius: BorderRadius.circular(30),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.9),
                    //     blurRadius: 3,
                    //     offset: const Offset(2, 3),
                    //   ),
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.9),
                    //     blurRadius: 800,
                    //     offset: const Offset(300, 50),
                    //   ),
                    // ],
                  ),
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Gap(8),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CheckoutView(
                            totalPrice: cartResponse?.cartData.totalPrice ?? "0.0",
                          )),
                        ),
                        child: CustomBotton(
                          height: 45,
                          text: 'Checkout',
                          gap: 80,
                          widget: CustomText(
                            text: '${cartResponse?.cartData.totalPrice} \$'?? "0.0",
                            size: 14,
                            color: Colors.white,
                          ),
                          color: AppColors.primary,
                          width: double.infinity,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // bottomSheet:   Container(
          //   padding: EdgeInsets.all(20),
          //   height: 100,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30),
          //         topRight: Radius.circular(30)),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.shade800,
          //         blurRadius: 20,
          //         offset: const Offset(0,0),
          //       )
          //     ]
          //   ),
          //   child: Row(
          //     mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          //     children: [
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           CustomText(text: 'Total',size: 15,),
          //           CustomText(text: '\$ 18.9',size: 24,),
          //
          //         ],
          //       ),
          //       CustomBotton(text: 'Checkout',
          //         onTap: (){
          //         Navigator.push(context, MaterialPageRoute(builder: (_){
          //           return CheckoutView();
          //         }));
          //         },
          //       ),
          //
          //     ],
          //   ),
          // ),
        ),
      );
    }
    else if (isGuest) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Guest Mode')),
            Gap(20),
            CustomBotton(
              onTap:
                  () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => LoginView()),
              ),
              text: 'Go to Login',
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
