import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../cubit/quantity_cubit.dart';
import '../../services/services.dart';
import '../../cubit/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../../utils/utils.dart';
import '../views.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    _getSimilarProducts();
    super.initState();
  }

  void _decreaseQty() {
    final qtyCubit = BlocProvider.of<QuantityCubit>(context);
    qtyCubit.quantityDecreased();
  }

  void _increaseQty() {
    final qtyCubit = BlocProvider.of<QuantityCubit>(context);
    qtyCubit.quantityIncreased();
  }

  void _getSimilarProducts() {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.fetchSimilarProducts(widget.product.categoryId);
  }

  void _toggleBottomSheet(bool value) {
    final bottomSheetCubit = BlocProvider.of<BottomsheetCubit>(context);
    bottomSheetCubit.toggle(value);
  }

  void _addToCart({required Product product, required int qty}) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.addToCart(
      product: product,
      qty: qty,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    return BlocBuilder<BottomsheetCubit, BottomsheetState>(
      builder: (context, state) {
        return state.isOpen
            ? BottomSheet(
                elevation: 20,
                backgroundColor: Colors.white,
                onClosing: () {
                  // Do something
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                builder: (BuildContext ctx) => Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Emzor paracetamol has been successfully added to cart!",
                        style: textStyle20,
                        textAlign: TextAlign.center,
                      ),
                      _buildButton(
                        onPressed: () {
                          _toggleBottomSheet(false);
                          Get.to(
                            () => BlocProvider.value(
                              value: BlocProvider.of<CartCubit>(context),
                              child: BlocProvider(
                                create: (context) => TotalCubit(),
                                child: const CartScreen(),
                              ),
                            ),
                          );
                        },
                        title: "VIEW CART",
                        border: false,
                      ),
                      _buildButton(
                        onPressed: () => _toggleBottomSheet(false),
                        title: "CONTINUE SHOPPING",
                        border: true,
                      ),
                    ],
                  ),
                ),
              )
            : BottomSheet(
                onClosing: () {
                  // Do something
                },
                builder: (BuildContext ctx) => Container(
                  height: 0,
                ),
              );
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTopSection(),
        _buildBodyContent(),
      ],
    );
  }

  Widget _buildBodyContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          bottom: 10.0,
          left: 20.0,
          right: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              _buildProductImage(),
              const SizedBox(height: 10.0),
              Center(child: Text(widget.product.name, style: textStyle20Bold)),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  '${widget.product.type} - ${widget.product.size}mg',
                  style: textStyle15GrayW600,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildSoldBySection(),
              const SizedBox(height: 20.0),
              _buildMiddleSection(),
              const SizedBox(height: 20.0),
              _buildProductDetailsSection(),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  widget.product.description,
                  style: textStyle15,
                ),
              ),
              const SizedBox(height: 10.0),
              _buildSimilarProductSection(),
              const SizedBox(height: 10.0),
              BlocBuilder<QuantityCubit, QuantityState>(
                builder: (context, state) {
                  return _buildButton(
                    onPressed: () {
                      _addToCart(
                        product: widget.product,
                        qty: state.quantity,
                      );
                      _toggleBottomSheet(true);
                    },
                    title: "Add to Cart",
                    border: false,
                    icon: Icons.shopping_cart_outlined,
                  );
                },
              ),
            ],
          ),
        ),
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

  Widget _buildSimilarProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SIMILAR PRODUCTS', style: textStyle15DROMiddleBlueBold),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                return _buildSuggestionListLoading();
              } else if (state is ProductLoading) {
                return _buildSuggestionListLoading();
              } else if (state is ProductLoaded) {
                return Row(
                  children: [
                    for (int i = 0; i < state.product.length; i++)
                      _buildProductItem(
                        product: state.product[i],
                      ),
                  ],
                );
              } else {
                // Error Widget
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionListLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Row(
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: 150.0,
              height: 100.0,
              margin: const EdgeInsets.only(right: 10.0),
            ),
        ],
      ),
    );
  }

  Widget _buildProductItem({
    required Product product,
  }) {
    return GestureDetector(
      onTap: () => Get.off(
        () => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductCubit(FakeProductRepository()),
            ),
            BlocProvider(
              create: (context) => QuantityCubit(),
            ),
          ],
          child: ProductScreen(product: product),
        ),
      ),
      child: Card(
        child: Container(
          width: 41.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.product.imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: textStyle13),
                          Text("${product.type} - ${product.size}mg",
                              style: textStyle13Gray),
                          const SizedBox(height: 10.0),
                          Text("₦${product.price}", style: textStyle13Bold),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('PRODUCT DETAILS', style: textStyle15DROMiddleBlueBold),
        Row(
          children: [
            _buildDetailItem(
              imageURL: "assets/images/pack_size.png",
              title: "PACK SIZE",
              value: widget.product.packSize,
            ),
            _buildDetailItem(
              imageURL: "assets/images/product_id.png",
              title: "PRODUCT ID",
              value: widget.product.productId,
            ),
          ],
        ),
        Row(
          children: [
            _buildDetailItem(
              imageURL: "assets/images/contituents.png",
              title: "CONSTITUENTS",
              value: widget.product.constituents,
            ),
            _buildDetailItem(
              imageURL: "assets/images/dispense.png",
              title: "DISPENSED IN",
              value: widget.product.dispensedIn,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem({
    required String title,
    required String value,
    required String imageURL,
  }) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: Image.asset(imageURL),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: textStyle10DROMiddleBlue),
                Text(
                  value,
                  style: textStyle12DROMiddleBlueBold,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMiddleSection() {
    String price =
        double.parse((widget.product.price).toStringAsFixed(2)).toString();
    return Row(
      children: [
        _buildQtyCounter(),
        const SizedBox(width: 15.0),
        Text(widget.product.dispensedIn, style: textStyle13Gray),
        const Spacer(),
        _buildPriceIndicator(
          price: price.substring(0, price.length - 2),
          decimal: price.substring(price.length - 2),
        ),
      ],
    );
  }

  Widget _buildQtyCounter() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(),
      ),
      child: Center(
        child: Row(
          children: [
            _buildQtyCounterButton(
              onPressed: _decreaseQty,
              icon: Icons.remove,
            ),
            const SizedBox(width: 13.0),
            BlocBuilder<QuantityCubit, QuantityState>(
              builder: (context, state) {
                return Text("${state.quantity}", style: textStyle15Bold);
              },
            ),
            const SizedBox(width: 13.0),
            _buildQtyCounterButton(
              onPressed: _increaseQty,
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyCounterButton({
    required Function onPressed,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Icon(icon),
    );
  }

  Widget _buildPriceIndicator({
    required String price,
    required String decimal,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(2, -4),
              child: Text(
                '₦ ',
                //superscript is usually smaller in size
                textScaleFactor: 0.7,
                style: textStyle15,
              ),
            ),
          ),
          TextSpan(
            text: price,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(1, 1),
              child: Text(
                decimal,
                textScaleFactor: 0.7,
                style: textStyle15Bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoldBySection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(widget.product.soldByImageURL),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SOLD BY", style: textStyle10Gray),
              Text(
                widget.product.soldBy,
                style: textStyle13DROMiddleBlueBold,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        FavButton(
          onPressed: () {},
          selected: widget.product.isFavourite,
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Center(
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: Image.asset(
          widget.product.imageURL,
          fit: BoxFit.cover,
        ),
      ),
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
                  Text("Pharmacy", style: textStyle22BoldWhite),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.to(
                      () => BlocProvider.value(
                        value: BlocProvider.of<CartCubit>(context),
                        child: BlocProvider(
                          create: (context) => TotalCubit(),
                          child: const CartScreen(),
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            if (state is CartInitial) {
                              return Positioned(
                                right: 0.0,
                                child: Container(),
                              );
                            } else if (state is CartLoading) {
                              return Positioned(
                                right: 0.0,
                                child: Container(),
                              );
                            } else if (state is CartLoaded) {
                              return state.cartItems.isNotEmpty
                                  ? Positioned(
                                      right: 0.0,
                                      child: Container(
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                          color: Colors.amber,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      right: 0.0,
                                      child: Container(),
                                    );
                            } else {
                              // Error Widget
                              return Positioned(
                                right: 0.0,
                                child: Container(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
