import 'package:fake_store/features/cart/data/models/cart_item_model.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
    required this.productModel,
    required this.index,
  });
  final ProductModel productModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: '${productModel.id}_$index',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey.withValues(alpha: .15),
              image: DecorationImage(image: NetworkImage(productModel.image)),
            ),
          ),
        ),

        Positioned(
          top: 5,
          right: 2,
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: GestureDetector(
              onTap: () {
                HomeViewBody.isAdded = !HomeViewBody.isAdded;
                addOrDeleteProduct(context);
                BlocProvider.of<CartCubit>(context).readDataFromCart();
              },
              child: Icon(
                Icons.shopping_cart,
                color: isInCart(cartItems: context.watch<CartCubit>().cartItems)
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  isInCart({required List<Map<String, dynamic>>? cartItems}) {
    for (var element in cartItems ?? []) {
      if (element['product_id'] == productModel.id) {
        return true;
      }
    }
    return false;
  }

  addOrDeleteProduct(BuildContext context) {
    for (var element in context.read<CartCubit>().cartItems ?? []) {
      if (element['product_id'] == productModel.id) {
        context.read<CartCubit>().deleteFromCart(productId: productModel.id);

        return;
      }
    }
    context.read<CartCubit>().addToCart(
      cartItem: CartItemModel(productModel: productModel, quantity: 1),
    );
  }
}
