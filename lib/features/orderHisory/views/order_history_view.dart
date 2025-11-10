import 'package:flutter/material.dart';
import 'package:fruits_market_app/shared/custom_botton.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text.dart';
  class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:ListView.builder(
            itemBuilder: (context,index){
              return Card(
color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                  child: Column(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/splash_image.png", width: 100,),
                              CustomText(text: "Hamburger", weight: FontWeight.bold,) ,
                              CustomText(
                                  text:  "Veggie Burger",),
                            ],
                          ),

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: "Hamburger", weight: FontWeight.bold,) ,
                                CustomText(text: "Qty : X3", ) ,
                                CustomText(text: "Price : 20", ) ,

                              ],
                            ),
                          ),

                        ],
                      ),
                      Gap(20),
                      CustomBotton(text: "Order Again",
                      width: double.infinity,
                        color: Colors.grey.shade400,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 4,
            padding: const EdgeInsets.only(bottom: 120,top:10),

          )
      ),
    );
  }
}
