import 'package:firebase_cli_linux/logic/home_cubit.dart';
import 'package:firebase_cli_linux/logic/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>HomeCubit()..getProducts(),
      child: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context,state){
          var cubit = HomeCubit.get(context); // <--- fixes the bloc error I had previously
          return Scaffold(
            body: 
            (state is HomeLoading)? // loading
            const Center(child: CircularProgressIndicator()):
            (state is HomeError)? // error
            Text('list is empty'):
            SafeArea(
              child: ListView.separated(   // else (success)
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Image.network(cubit.products[index].image!, height: 300, width: 300,),
                        Text(cubit.products[index].name!),
                      ],
                    );
                  },
                  separatorBuilder: (context,index){
                    return SizedBox(height: 10);
                  },
                  itemCount: cubit.products.length
              ),
            ),
          );
        },
      ),
    );
  }
}
