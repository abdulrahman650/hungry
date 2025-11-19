import 'package:flutter/material.dart';
import 'package:hungry_app/shared/custom_botton.dart';
import 'package:gap/gap.dart';
import '../../../shared/custom_text.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/data/user_model.dart';
import '../../auth/views/login_view.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
bool isGuest = false;
  bool isLoading = true;
  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();
  late final UserModel? user = authRepo.currentUser;

@override
void initState() {
  super.initState();
  initPage();
}

Future<void> initPage() async {
  setState(() => isLoading = true);

  // تحميل حالة المستخدم مرة واحدة فقط
  await authRepo.autoLogin();

  setState(() {
    isGuest = authRepo.isGuest;
    userModel = authRepo.currentUser;
    isLoading = false;
  });
}
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!isGuest) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/splash_image.png",
                                width: 100,
                              ),
                              CustomText(
                                text: "Hamburger",
                                weight: FontWeight.bold,
                              ),
                              CustomText(text: "Veggie Burger"),
                            ],
                          ),

                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Hamburger",
                                  weight: FontWeight.bold,
                                ),
                                CustomText(text: "Qty : X3"),
                                CustomText(text: "Price : 20"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      CustomBotton(
                        text: "Order Again",
                        width: double.infinity,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: 2,
            padding: const EdgeInsets.only(bottom: 120, top: 10),
          ),
        ),
      );
    } else if (isGuest) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Guest Mode')),
            Gap(20),
            CustomBotton(
              onTap: () => Navigator.pushReplacement(
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
