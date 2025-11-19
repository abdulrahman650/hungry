import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_services.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';

class CartRepo{
  final ApiService _apiService = ApiService();


  /// AddToCart
  Future<void> addToCart(CartRequestModel cartData)async{
   try{

     final res = await _apiService.post("cart/add", cartData.toJson());
     if(res["code"]== 200 && res["data"]== null){
       throw ApiError(message: res["message"]);
     }
   }catch (e){
     throw ApiError(message: e.toString());
   }
  }

  ///GetCart
  Future<GetCartResponse?> getCartData ()async{
   try{
     final res = await _apiService.get("cart");
     if(res is ApiError){
       throw ApiError(message: res.message);
     }

     return GetCartResponse.fromJson(res);
   }catch(e){
     throw ApiError(message: e.toString());
   }
  } 
  
  /// deleteCartItem
 Future<void> removeCartItem(int id)async{
    try{
      final res = await _apiService.delete("cart/remove/$id", {},);
      if(res["code"]== 200 && res["data"]== null){
        throw ApiError(message: res["message"]);
      }
    }catch(e){
      throw ApiError(message:"Remove Item From Cart: ${e.toString()}");
    }
 }
}