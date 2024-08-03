import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cli_linux/models/products_model.dart';

import 'home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit():super(HomeInitial());
  static HomeCubit get(context)=>BlocProvider.of(context);

  // get products
  List<ProductsModel> products = [];
  getProducts() async{
    emit(HomeLoading());
    try{
      var data = await FirebaseFirestore.instance.collection('products').get();
      for (var element in data.docs) {
        products.add(ProductsModel.fromJson(element.id, element.data()));
      }
      emit(HomeSuccess());
    }
    catch(err){
      print(err);
      emit(HomeError());
    }
  }
}