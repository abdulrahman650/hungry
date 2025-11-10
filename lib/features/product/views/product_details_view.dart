import 'package:flutter/material.dart';
import 'package:fruits_market_app/core/constant/app_colors.dart';
import 'package:fruits_market_app/features/product/widgets/topping_card.dart';
import 'package:fruits_market_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_botton.dart';
import '../widgets/spicy_slider.dart';
class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
double value=0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,)),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              SpicySlider(
              value: value,
              onChanged: (v)=>setState(() =>value=v),
              ),
          
              Gap(50),
              CustomText(text: 'Toppings',
              size: 20,
              ),
              Gap(60),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:List.generate(4, (index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ToppingCard(
                        imageUrl:"assets/images/tomato.png",
                        title:'Tomato',
                        onAdd:(){},
          
                      ),
                    );
                  }),
                ),
              ),
              Gap(20),
              CustomText(text: 'Side Options',
                size: 20,
              ),
              Gap(60),
              SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:List.generate(4, (index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ToppingCard(
                        imageUrl:"assets/images/tomato.png",
                        title:'Tomato',
                        onAdd:(){},
          
                      ),
                    );
                  }),
                ),
              ),
              Gap(200),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 15,
              offset: Offset(0, 0),

            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total',size: 20,),
                  CustomText(text: '\$ 18.9',size: 27,),
                ],
              ),
              CustomBotton(text: 'Add To Cart',
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
