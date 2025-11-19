import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hungry_app/features/home/widget/food_category.dart';
import 'package:hungry_app/features/product/views/product_details_view.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:skeletonizer/skeletonizer.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/data/user_model.dart';
import '../data/prodect_repo.dart';
import '../data/product_model.dart';
import '../widget/card_item.dart';
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
  final TextEditingController controller = TextEditingController();
  List<ProductModel>? products;
  List<ProductModel>? allProducts;

  ProductRepo productRepo = ProductRepo();
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  late final user = authRepo.currentUser;
  late final isGuest = authRepo.isGuest;

  /// get profile
  Future<void> loadUser() async {
    if (!authRepo.isGuest) {
      final user = authRepo.currentUser ?? await authRepo.getProfileData();
      setState(() => userModel = user);
    }
  }

  /// get product
  Future<void> getProducts() async {
    final response = await productRepo.getProducts();
    setState(() {
      allProducts = response;
      products = response;
    });
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              ///header
              SliverAppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                toolbarHeight: 200,
                floating: false,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      UserHeader(
                        userImage:
                            authRepo.currentUser?.image ??
                            "https://scontent.fcai21-4.fna.fbcdn.net/v/t39.30808-1/514095766_1975821399826969_8656803689883884495_n.jpg?stp=dst-jpg_s200x200_tt6&_nc_cat=104&ccb=1-7&_nc_sid=1d2534&_nc_ohc=DqDbDCqQxx4Q7kNvwGFxXVD&_nc_oc=AdkcvKJPFhMX9irGcjmvTtq1fUxyDhKOIGsF1xzF3C70FfZ1X1gwGsRBcRjOD8aro-I&_nc_zt=24&_nc_ht=scontent.fcai21-4.fna&_nc_gid=F4ZIsTQLnkkVlizyFLf0FQ&oh=00_AfikUD45sT8URfJMcqy_iSen1jbn_URJp14otZDXSIk87g&oe=6923DB8F,",
                        userName: authRepo.currentUser?.name ?? " My Dear",
                      ),
                      Gap(20),
                      SearchField(
                        controller: controller,
                        onChanged: (value) {
                          final query = value.toLowerCase();
                          setState(() {
                            products = allProducts
                                ?.where(
                                  (p) => p.name.toLowerCase().contains(query),
                                )
                                .toList();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              /// Category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5,
                  ),
                  child: FoodCategory(
                    selectedIndex: selectedIndex,
                    category: category,
                  ),
                ),
              ),

              /// GridView
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.73,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: products?.length ?? 6,
                    (context, index) {
                      final product = products?[index];
                      if (product == null) {
                        return CupertinoActivityIndicator();
                      }
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => ProductDetailsView(
                              productImage: product.image,
                              productId: product.id,
                              productPrice: product.price,
                            ),
                          ),
                        ),
                        child: CardItem(
                          text: product.name,
                          image: product.image,
                          desc: product.desc,
                          rate: product.rate,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
