import 'package:dro_health/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../views/views.dart';
import '../../../models/models.dart';
import '../../../cubit/cubits.dart';
import '../../../widgets/widgets.dart';
import '../../../utils/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    ScrollDirection? _lastScrollDirection;
    _getCategories();
    _getProducts();

    _controller.addListener(() {
      if (_lastScrollDirection != _controller.position.userScrollDirection) {
        _lastScrollDirection = _controller.position.userScrollDirection;

        _scrolled(_lastScrollDirection!);
      }
    });
    super.initState();
  }

  void _getCategories() {
    final categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.getCategory();
  }

  void _getProducts() {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProduct();
  }

  void _searchProducts(String keyword) {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.searchProduct(keyword);

    _isSearching(keyword);
  }

  void _searchProductsByCategory(String keyword) {
    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.searchProductByCategory(keyword);

    _isSearchingByCategory(keyword);
  }

  void _isSearchingByCategory(String keyword) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    searchCubit.searchByCategory(keyword);

    final selectedCategoryCubit =
        BlocProvider.of<SelectedCategoryCubit>(context);
    selectedCategoryCubit.categorySelected(keyword);
  }

  void _scrolled(ScrollDirection direction) {
    final scrollCubit = BlocProvider.of<ScrollCubit>(context);
    scrollCubit.changedScrollDirection(direction);
  }

  void _isSearching(String keyword) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    searchCubit.searchChanged(keyword);
  }

  void _cancelSearch() {
    _isSearching("");
    _searchProducts("");
    _isSearchingByCategory("");
    _searchController.text = "";
  }

  void _viewAllCategories() {
    final selectedCategoryCubit =
        BlocProvider.of<SelectedCategoryCubit>(context);
    selectedCategoryCubit.categorySelected("view all");

    final productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.searchProductByCategory("");
  }

  void _toggleFavorite(int productId) {
    // final productCubit = BlocProvider.of<ProductCubit>(context);
    // productCubit.favoriteProduct(productId);
  }

  void _addToCart(Product product) {
    final cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.addToCart(
      product: product,
      qty: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("-----------------Home Widget built---------------------");
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: BlocBuilder<ScrollCubit, ScrollState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            onPressed: () => Get.to(
              () => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<CartCubit>(context),
                  ),
                  BlocProvider(
                    create: (context) => TotalCubit(),
                  ),
                ],
                child: const CartScreen(),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            label: Container(
              height: 50.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppCustomColors.droRedGradientRight,
                    AppCustomColors.droRedGradientLeft,
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    child: child,
                    sizeFactor: animation,
                    axis: Axis.horizontal,
                  ),
                ),
                child:
                    state.isScrollDown ? _collapsedFAB() : _buildExpandedFAB(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpandedFAB() {
    return Row(
      children: [
        Text("Add To Order", style: textStyle13WhiteBold),
        const SizedBox(width: 10.0),
        const Icon(Icons.shopping_cart_outlined, size: 30.0),
        const SizedBox(width: 10.0),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return Container();
            } else if (state is CartLoading) {
              return Container();
            } else if (state is CartLoaded) {
              return state.cartItems.isNotEmpty
                  ? Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Text(
                          "${state.cartItems.length}",
                          style: textStyle13Bold,
                        ),
                      ),
                    )
                  : Container();
            } else {
              // Error Widget
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _collapsedFAB() {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Icon(Icons.shopping_cart_outlined, size: 30.0),
        ),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return Container();
            } else if (state is CartLoading) {
              return Container();
            } else if (state is CartLoaded) {
              return state.cartItems.isNotEmpty
                  ? Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: Container(
                        width: 15.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Text(
                            "${state.cartItems.length}",
                            style: textStyle13Bold,
                          ),
                        ),
                      ),
                    )
                  : Container();
            } else {
              // Error Widget
              return Container();
            }
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopSection(),
        BlocBuilder<SelectedCategoryCubit, SelectedCategoryState>(
          builder: (context, state) {
            if (state.name == "view all") {
              return _buildAllCategoriesWidget();
            } else {
              return _buildScrollContent();
            }
          },
        ),
      ],
    );
  }

  Widget _buildAllCategoriesWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, bottom: 5.0),
            child: Text("CATEGORIES", style: textStyle15GrayW600),
          ),
          _buildAllCatGrid(),
        ],
      ),
    );
  }

  Widget _buildAllCatGrid() {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: (40.0.w / 90.0),
          children: List.generate(
            4,
            (index) {
              return Center(
                child: _buildCategoriesItem(
                  imageURL: state.category[index].imageURL,
                  name: state.category[index].name,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildScrollContent() {
    return Expanded(
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return state.isSearching
                    ? Container()
                    : _buildCategoriesSection();
              },
            ),
            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductInitial) {
                  return Container();
                } else if (state is ProductLoading) {
                  return Container(
                    child: _buildSuggestionListLoading(),
                  );
                } else if (state is ProductLoaded) {
                  if (state.product.isNotEmpty) {
                    return _buildSuggestionSection(state);
                  } else {
                    return _buildNoProductFoundWidget();
                  }
                } else {
                  // Error Widget
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoProductFoundWidget() {
    return Center(
      child: Column(
        children: [
          Image.asset("assets/images/404.png"),
          const SizedBox(height: 20.0),
          Text(
            "No result found for “${_searchController.text}”",
            style: textStyle13Bold,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionSection(state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 5.0),
            child: Text("SUGGESTIONS", style: textStyle15GrayW600),
          ),
          _buildSuggestionList(state),
        ],
      ),
    );
  }

  Widget _buildSuggestionList(state) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, searchState) {
        return GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio:
              searchState.isSearching ? (40.0.w / 210.0) : (40.0.w / 150.0),
          children: List.generate(
            state.product.length,
            (index) {
              return Center(
                child: _buildSuggestionItem(
                  product: state.product[index],
                  state: searchState,
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSuggestionListLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: GridView.count(
        padding: const EdgeInsets.all(0),
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          4,
          (index) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 40.0.w,
                height: 200.0,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryListLoading() {
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

  Widget _buildSuggestionItem({
    required Product product,
    required state,
  }) {
    return GestureDetector(
      onTap: () => Get.to(
        () => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProductCubit(FakeProductRepository()),
            ),
            BlocProvider(
              create: (context) => QuantityCubit(),
            ),
            BlocProvider(
              create: (context) => BottomsheetCubit(),
            ),
            BlocProvider.value(
              value: BlocProvider.of<CartCubit>(context),
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
                    image: AssetImage(product.imageURL),
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
                    if (state.isSearching)
                      FavButton(
                        onPressed: () => _toggleFavorite(product.id),
                        selected: product.isFavourite,
                      ),
                  ],
                ),
              ),
              const Spacer(),
              if (state.isSearching)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    onPressed: () => _addToCart(product),
                    borderSide: BorderSide(
                      color: AppCustomColors.droPurple,
                      width: 1,
                    ),
                    text: "ADD TO CART",
                    textStyle: textStyle13PurpleAccentW600,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return BlocBuilder<SelectedCategoryCubit, SelectedCategoryState>(
          builder: (context, selectedCatState) {
            return Container(
              color: AppCustomColors.droGray,
              child: Column(
                children: [
                  _buildTopSearchContainer(),
                  if (!state.isSearchingByCategory &&
                      !(selectedCatState.name != null &&
                          selectedCatState.name != ""))
                    _buildDeliveryLocation(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 20.0),
      child: Column(
        children: [
          _buildCategoriesTopSection(),
          _buildCategoriesList(),
        ],
      ),
    );
  }

  Widget _buildCategoriesList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitial) {
            return Container();
          } else if (state is CategoryLoading) {
            return _buildCategoryListLoading();
          } else if (state is CategoryLoaded) {
            return Row(
              children: [
                for (int i = 0; i < state.category.length; i++)
                  _buildCategoriesItem(
                    imageURL: state.category[i].imageURL,
                    name: state.category[i].name,
                  ),
              ],
            );
          } else {
            return Container(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoriesItem({
    required String imageURL,
    required String name,
  }) {
    return GestureDetector(
      onTap: () => _searchProductsByCategory(name),
      child: Container(
        height: 100.0,
        width: 150.0,
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BlocBuilder<SelectedCategoryCubit, SelectedCategoryState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    color: state.name == null
                        ? Colors.black45
                        : state.name == name
                            ? Colors.purple.shade900.withOpacity(0.5)
                            : Colors.black45,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              },
            ),
            Center(
              child: Text(name, style: textStyle13WhiteBold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("CATEGORIES", style: textStyle15GrayW600),
        Button(
          text: "VIEW ALL",
          onPressed: _viewAllCategories,
          textStyle: textStyle15PurpleAccentW600,
        ),
      ],
    );
  }

  Widget _buildDeliveryLocation() {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined),
          Text("Delivery in ", style: textStyle13),
          Text(
            "Lagos, NG",
            style: textStyle13Bold,
          ),
        ],
      ),
    );
  }

  Widget _buildTopSearchContainer() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return BlocBuilder<SelectedCategoryCubit, SelectedCategoryState>(
          builder: (context, selectedCatState) {
            return Container(
              height: state.isSearchingByCategory ||
                      (selectedCatState.name != null &&
                          selectedCatState.name != "")
                  ? 120.0
                  : 174.0,
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
              child: _buildAnimator(
                state: state,
                selectedCatState: selectedCatState,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAnimator({
    required state,
    required selectedCatState,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1000),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          FadeTransition(
        opacity: animation,
        child: SizeTransition(
          child: child,
          sizeFactor: animation,
          axis: Axis.vertical,
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
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: state.isSearchingByCategory
                ? const EdgeInsets.only(
                    top: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  )
                : const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    children: [
                      if (state.isSearchingByCategory ||
                          (selectedCatState.name != null &&
                              selectedCatState.name != ""))
                        IconButton(
                          onPressed: _cancelSearch,
                          icon: const Icon(Icons.navigate_before,
                              color: Colors.white),
                        ),
                      state.isSearchingByCategory ||
                              (selectedCatState.name != null &&
                                  selectedCatState.name != "")
                          ? Text("Categories", style: textStyle22BoldWhite)
                          : Text("Pharmacy", style: textStyle22BoldWhite),
                      const Spacer(),
                      Stack(
                        children: [
                          state.isSearchingByCategory ||
                                  (selectedCatState.name != null &&
                                      selectedCatState.name != "")
                              ? const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                )
                              : Image.asset("assets/images/car.png"),
                          Positioned(
                            right: 0.0,
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!state.isSearchingByCategory &&
                    !(selectedCatState.name != null &&
                        selectedCatState.name != ""))
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchBox(
                                controller: _searchController,
                                onChanged: _searchProducts,
                                hint: "Search",
                              ),
                            ),
                            if (state.isSearching)
                              Button(
                                text: "Cancel",
                                textStyle: textStyle13WhiteBold,
                                onPressed: _cancelSearch,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
