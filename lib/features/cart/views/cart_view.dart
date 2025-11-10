import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruits_market_app/features/check_out/views/checkout_view.dart';
import 'package:fruits_market_app/shared/custom_botton.dart';
import 'package:fruits_market_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

import '../../../core/constant/app_colors.dart';
import '../widgets/cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

final int itemCount =3;
   late List<int> quantities;

   @override
  void initState(){
     super.initState();
     quantities =List.generate(itemCount, (_) =>1);

   }

   void onAdd(int index){
     setState(() {
       quantities[index] ++;
     });
   }

   void onMin(int index){
     setState(() {
       if(quantities[index]>1)
         {
           quantities[index]--;
         }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:ListView.builder(
          itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CartItem(
              image: "assets/images/splash_image.png",
              text: "Hamburger",
              desc: "Veggie Burger",
              number: quantities[index],
            onAdd: ()=> onAdd(index),
              onMin: ()=>onMin(index),
            ),
          );
        },
          itemCount: itemCount,
          padding: const EdgeInsets.only(bottom: 120,top:10),

        )
      ),






      bottomSheet:   Container(
        padding: EdgeInsets.all(20),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 20,
              offset: const Offset(0,0),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween ,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Total',size: 15,),
                CustomText(text: '\$ 18.9',size: 24,),

              ],
            ),
            CustomBotton(text: 'Checkout',
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return CheckoutView();
              }));
              },
            ),

          ],
        ),
      ),


    );
  }
}
