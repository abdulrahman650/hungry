import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';
import 'package:hungry_app/features/home/data/topping_model.dart';
import 'package:hungry_app/features/product/widgets/topping_card.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/custom_botton.dart';
import '../../cart/data/cart_repo.dart';
import '../../home/data/prodect_repo.dart';
import '../widgets/spicy_slider.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId,
    required this.productPrice,
  });

  final String productImage;
  final int productId;
  final String productPrice;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
  List<int> selectedToppings = [];
  List<int> selectedOptions = [];

  List<ToppingModel>? toppings;
  List<ToppingModel>? options;
  bool isLoading = false;

  ///product Function
  ProductRepo productRepo = ProductRepo();

  Future<void> getToppings() async {
    final response = await productRepo.getToppings();
    setState(() {
      toppings = response;
    });
  }

  Future<void> getOptions() async {
    final response = await productRepo.getOptions();
    setState(() {
      options = response;
    });
  }

  /// cart Function
  CartRepo cartRepo = CartRepo();

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: (widget.productImage.isEmpty ?? true),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                SpicySlider(
                  value: value,
                  img: widget.productImage,
                  onChanged: (v) => setState(() => value = v),
                ),

                Gap(50),
                CustomText(text: 'Toppings', size: 20),
                Gap(10),

                /// Toppings
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(toppings?.length ?? 4, (index) {
                      final topping = toppings?[index];
                      final id = topping?.id;
                      if (topping == null) {
                        return CupertinoActivityIndicator();
                      }
                      final isSelected = selectedToppings.contains(id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ToppingCard(
                          imageUrl: topping.image,
                          title: topping.name,
                          onAdd: () {
                            final id = topping?.id ?? 1;
                            setState(() {
                              if (selectedToppings.contains(id)) {
                                selectedToppings.remove(id);
                              } else {
                                selectedToppings.add(id);
                              }
                            });
                          },
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.4)
                              : AppColors.primary.withOpacity(0.1),
                        ),
                      );
                    }),
                  ),
                ),
                Gap(20),
                CustomText(text: 'Side Options', size: 20),
                Gap(10),

                ///Options
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(options?.length ?? 4, (index) {
                      final option = options?[index];
                      final id = option?.id;
                      if (option == null) {
                        return CupertinoActivityIndicator();
                      }
                      final isSelected = selectedOptions.contains(id);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ToppingCard(
                          imageUrl: option.image,
                          title: option.name,
                          onAdd: () {
                            final id = option.id ?? 1;
                            setState(() {
                              if (selectedOptions.contains(id)) {
                                selectedOptions.remove(id);
                              } else {
                                selectedOptions.add(id);
                              }
                            });
                          },
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.4)
                              : AppColors.primary.withOpacity(0.1),
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
            color: AppColors.primary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Price Sandwich:',
                      size: 16,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: '\$ ${widget.productPrice}' ?? "0.0",
                      size: 27,
                      color: Colors.white,
                    ),
                  ],
                ),
                CustomBotton(
                  widget: isLoading
                      ? CupertinoActivityIndicator(color: AppColors.primary)
                      : Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  text: 'Add To Cart',
                  onTap: () async {
                    try {
                      setState(() => isLoading = true);
                      final cartItem = CartModel(
                        productId: widget.productId,
                        qty: 1,
                        spicy: value,
                        toppings: selectedToppings,
                        options: selectedOptions,
                      );
                      await cartRepo.addToCart(
                        CartRequestModel(items: [cartItem]),
                      );
                      setState(() => isLoading = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added to Cart Successfully")),
                      );
                    } catch (e) {
                      setState(() => isLoading = false);
                      throw ApiError(message: e.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
