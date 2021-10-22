import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';
import '../../utils/utils.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var items = ['1', '2', '3', '4', '5', '6', '7', '8'];

  @override
  void initState() {
    _calculateTotal();
    super.initState();
  }

  void _calculateTotal() {
    final totalCubit = BlocProvider.of<TotalCubit>(context);
    final cartState = BlocProvider.of<CartCubit>(context).state;
    totalCubit.calculateTotal(cartState.cartItems);
  }

  void _removeCartItem(CartItem cartItem) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.removeFromCart(cartItem);
  }

  void _updateCartItem({required CartItem cartItem, required String? qty}) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.updateCartItem(cartItem, qty);
    _calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTopSection(),
        _buildCartItems(),
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<TotalCubit, TotalState>(
        builder: (context, state) {
          return Row(
            children: [
              Text("Total: ", style: textStyle15),
              Text("₦${state.total}", style: textStyle15Bold),
              const Spacer(),
              _buildButton(
                onPressed: () {},
                title: "CHECKOUT",
                border: false,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton({
    required Function onPressed,
    required String title,
    IconData? icon,
    required bool border,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: border
            ? Border.all(color: AppCustomColors.droPurple, width: 2)
            : null,
        gradient: border
            ? null
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppCustomColors.droPurpleGradientLeft,
                  AppCustomColors.droPurpleGradientRight
                ],
              ),
      ),
      child: MaterialButton(
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon, color: Colors.white),
              if (icon != null) const SizedBox(width: 10.0),
              Text(
                title,
                style:
                    border ? textStyle13PurpleAccentW600 : textStyle13WhiteBold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartInitial) {
                return Container();
              } else if (state is CartLoading) {
                return Container();
              } else if (state is CartLoaded) {
                return Column(
                  children: [
                    for (int i = 0; i < state.cartItems.length; i++)
                      _buildCartItem(cartItem: state.cartItems[i]),
                  ],
                );
              } else {
                // Error Widget
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem({
    required CartItem cartItem,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              width: 100.0,
              height: 100.0,
              child: Image.asset(cartItem.product.imageURL),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(cartItem.product.name, style: textStyle15Bold),
                  Text(
                    "${cartItem.product.type} - ${cartItem.product.size}mg",
                    style: textStyle13Gray,
                  ),
                  Text("₦${cartItem.product.price}", style: textStyle15Bold),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: cartItem.qty.toString(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: textStyle13,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? qty) =>
                          _updateCartItem(cartItem: cartItem, qty: qty),
                    ),
                  ),
                ),
                Button(
                  onPressed: () => _removeCartItem(cartItem),
                  icon: Icon(
                    Icons.delete,
                    color: AppCustomColors.primaryColor,
                  ),
                  text: "Remove",
                  textStyle: textStyle13Purple,
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildTopSection() {
    return Container(
      height: 120.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppCustomColors.droPurpleGradientRight,
            AppCustomColors.droPurpleGradientLeft,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0.0,
            child: Image.asset(
              "assets/images/dashboard_bg_image.png",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10.0),
                  Text("Cart", style: textStyle22BoldWhite),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
