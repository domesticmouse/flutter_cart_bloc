import 'package:cart_bloc/logic/bloc/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text("Cart App Using BLOC"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if(state is CartLoading){
                  return const CircularProgressIndicator();
                }
                if(state is CartLoaded){
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.5,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                state.items[index].image,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(width: 22,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.items[index].itemName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                    Text(
                                      "\$ ${state.items[index].price}"
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  context.read<CartBloc>().add(ItemRemoved(state.items[index]));
                                }, 
                                icon: const Icon(Icons.delete)
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            )
          )
        ],
      ),
    );
  }
}
