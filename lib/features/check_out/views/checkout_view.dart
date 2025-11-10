import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruits_market_app/core/constant/app_colors.dart';
import 'package:fruits_market_app/features/check_out/widget/order_details_widget.dart';
import 'package:fruits_market_app/shared/custom_text.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_botton.dart';
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late String selectedMethod = "Cach";
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Order Summary", size: 20, weight: FontWeight.w500,),
              Gap(10),
              OrderDetailsWidget(
                order: "18.8",
                taxes: "3.5",
                fees: "2.4",
                total: "100.00",
              ),
              Gap(80),
              CustomText(text: "Payment methods ", size: 20, weight: FontWeight.w500,),
              Gap(20),
          
              ListTile(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Color(0xff3C2F2F),
                contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
                leading: Image.asset("assets/icons/dollar.png",width: 60,),
                title: CustomText(text: "Cash on Delivery",color:Colors.white ,),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "Cash",
                groupValue: selectedMethod,
                  onChanged: (v){
                    setState(()=>selectedMethod == v!);
                  },
                ),
                onTap: ()=>setState(() => selectedMethod = 'Cash'),
          
              ),
              Gap(10),
              ListTile(
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.blue.shade900,
                contentPadding: EdgeInsets.symmetric(vertical: 2,horizontal: 16),
                leading: Image.asset("assets/icons/visa5.png",width: 60,),
                title: CustomText(text: "Debit card",color:Colors.white ,),
                subtitle: CustomText(text: "3434 **** **** 4123",color:Colors.white ,),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: "Visa",
                  groupValue: selectedMethod,
                  onChanged: (v){
                    setState(()=>selectedMethod == v!);
                  },
                ),
                onTap: ()=>setState(() => selectedMethod = 'Visa'),
          
              ),
              Gap(5),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (v){},
                  activeColor: Color(0xFFEF2A39),
                  ),
                  CustomText(text: "Save card details for future payments"),
                ],
              ),

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: 'Total Price',size: 20,),
                  CustomText(text: '\$ 18.9',size: 27,),

                ],
              ),
              CustomBotton(text: 'Pay Now',
                onTap: (){
                showDialog(
                    context: context,
                  builder :(_){
                      return Dialog(
                        backgroundColor: Colors.transparent,
child: Padding(
 padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical:250 ),
  child: Container(
    width: 300,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          blurRadius: 15,
          offset: Offset(0, 0),

        )
      ],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary,
            child: Icon(CupertinoIcons.check_mark,color: Colors.white,size: 30,),


          ),
          CustomText(text: 'Success!',
            weight: FontWeight.bold,
            color: AppColors.primary,
            size: 20,),
          Gap(4),
          CustomText(text: 'Your payment was successful.\n A receipt for this purchase has\n been sent to your email.',
          color: Colors.grey.shade400,
            size: 11,
          ),
         Gap(10),
          CustomBotton(text: "Go Back",
          width: 200,
            onTap: (){
            Navigator.pop(context);
            },
          )

        ],
      ),
    ),
  ),
),
                      );
                    },
                );
                },
              ),

            ],
          ),
        ),
      ),


    );
  }
}
