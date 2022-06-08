import 'package:flutter/material.dart';
import 'package:flutterutils/shared/colors.dart';
import 'package:flutterutils/shared/dimensions.dart';
import 'package:flutterutils/shared/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class Product {
  final int productId;
  final String productTitle;
  final double productPrice;
  final String productImage;

  const Product(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productImage});
}

class CartNotifier extends ChangeNotifier {
  List<Product> selectedProducts = [];

  List<int> selectedProductsIds = [];

  List<double> selectedProductsPrice = [];

  addToCart({required Product product}) {
    if (selectedProductsIds.contains(product.productId)) {
      selectedProducts.remove(product);
      selectedProductsIds.remove(product.productId);
      selectedProductsPrice.remove(product.productPrice);
      notifyListeners();
    } else {
      selectedProducts.add(product);
      selectedProductsIds.add(product.productId);
      selectedProductsPrice.add(product.productPrice);
      notifyListeners();
    }
    ;
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> _products = [
      Product(
          productId: 1,
          productImage: "assets/images/h1.png",
          productTitle: "Sony XML",
          productPrice: 2000),
      Product(
          productId: 2,
          productImage: "assets/images/h2.png",
          productTitle: "Boat Audio",
          productPrice: 3500),
      Product(
          productId: 3,
          productImage: "assets/images/h2.png",
          productTitle: "Omega 1251",
          productPrice: 1500),
      Product(
          productId: 4,
          productImage: "assets/images/h1.png",
          productTitle: "Noise PY8",
          productPrice: 6000),
      Product(
          productId: 5,
          productImage: "assets/images/h2.png",
          productTitle: "Sony 116",
          productPrice: 6000),
      Product(
          productId: 6,
          productImage: "assets/images/h1.png",
          productTitle: "Boat ZMn8",
          productPrice: 6000)
    ];

    CartNotifier cartNotifier({required bool renderUI}) =>
        Provider.of<CartNotifier>(context, listen: renderUI);

    bool containsInCart({required int productId}) =>
        cartNotifier(renderUI: true).selectedProductsIds.contains(productId);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          cartNotifier(renderUI: true).selectedProducts.length > 0
              ? GestureDetector(
                  onTap: () {
                    pushNewScreen(context, screen: ShoppingCartView());
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("View cart",
                                style: KCustomTextStyle.kMedium(
                                    context, 10, KConstantColors.whiteColor)))),
                    decoration: BoxDecoration(
                        color: KConstantColors.redColor,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )
              : const SizedBox.shrink(),
      appBar: AppBar(
          backgroundColor: KConstantColors.bgColorFaint,
          title: Text("Ecommerce store",
              style: KCustomTextStyle.kBold(context, 16))),
      backgroundColor: KConstantColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            vSizedBox2,
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8, crossAxisCount: 2),
              itemCount: _products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.2,
                            color: KConstantColors.texturedWhiteColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: Image.asset(_products[index].productImage)),
                        vSizedBox1,
                        Text(_products[index].productTitle,
                            style: KCustomTextStyle.kBold(context, 18)),
                        Text("\$${_products[index].productPrice}",
                            style: KCustomTextStyle.kMedium(
                                context, 10, KConstantColors.whiteColor)),
                        vSizedBox1,
                        GestureDetector(
                          onTap: () {
                            cartNotifier(renderUI: false)
                                .addToCart(product: _products[index]);
                          },
                          child: Container(
                            width: 150,
                            child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        !containsInCart(
                                                productId:
                                                    _products[index].productId)
                                            ? "Add to cart"
                                            : "Added in cart",
                                        style: KCustomTextStyle.kMedium(context,
                                            10, KConstantColors.whiteColor)))),
                            decoration: BoxDecoration(
                                color: !containsInCart(
                                        productId: _products[index].productId)
                                    ? KConstantColors.blueColor
                                    : KConstantColors.redColor,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            vSizedBox4
          ],
        ),
      ),
    );
  }
}

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier({required bool renderUI}) =>
        Provider.of<CartNotifier>(context, listen: renderUI);

    List<Product> _products = cartNotifier(renderUI: true).selectedProducts;

    _productList() {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _products.length,
        itemBuilder: (BuildContext context, int index) {
          Product _data = _products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(children: [
                Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(_data.productImage)),
                hSizedBox3,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_data.productTitle,
                        style: KCustomTextStyle.kBold(context, 14)),
                    Text("\$${_data.productPrice}",
                        style: KCustomTextStyle.kMedium(
                            context, 10, KConstantColors.whiteColor)),
                    vSizedBox1,
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: KConstantColors.bgColorFaint,
                            child: Icon(Icons.remove, size: 15)),
                        hSizedBox2,
                        Text("1",
                            style: KCustomTextStyle.kMedium(
                                context, 10, KConstantColors.whiteColor)),
                        hSizedBox2,
                        CircleAvatar(
                            radius: 15,
                            backgroundColor: KConstantColors.bgColorFaint,
                            child: Icon(Icons.add, size: 15)),
                      ],
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (cartNotifier(renderUI: false).selectedProducts.length ==
                        1) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: KConstantColors.bgColorFaint,
                              title: Text("Atleast 1 product is needed in cart",
                                  style: KCustomTextStyle.kMedium(
                                      context, 12, KConstantColors.whiteColor)),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: KCustomTextStyle.kMedium(context,
                                            10, KConstantColors.whiteColor))),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Clear all",
                                        style: KCustomTextStyle.kMedium(context,
                                            10, KConstantColors.whiteColor)))
                              ],
                            );
                          });
                    } else {
                      cartNotifier(renderUI: false)
                          .addToCart(product: _products[index]);
                    }
                  },
                  child: Container(
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Remove",
                                style: KCustomTextStyle.kMedium(
                                    context, 10, KConstantColors.whiteColor)))),
                    decoration: BoxDecoration(
                        color: KConstantColors.redColor,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                hSizedBox2
              ]),
            ),
          );
        },
      );
    }

    double total = cartNotifier(renderUI: true)
        .selectedProductsPrice
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: AppBar(
          backgroundColor: KConstantColors.bgColorFaint,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("My cart", style: KCustomTextStyle.kBold(context, 12))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vSizedBox2,
            _productList(),
            Text("Delivery location",
                style: KCustomTextStyle.kBold(context, 14)),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: KConstantColors.whiteColor),
              leading: Icon(Icons.map, color: KConstantColors.whiteColor),
              title: Text("Near St andrew church",
                  style: KCustomTextStyle.kBold(context, 10)),
              subtitle: Text("0112 house no 12",
                  style: KCustomTextStyle.kMedium(
                      context, 10, KConstantColors.whiteColor)),
            ),
            vSizedBox2,
            Text("Payment Info", style: KCustomTextStyle.kBold(context, 14)),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: KConstantColors.whiteColor),
              leading: Icon(FontAwesomeIcons.dollarSign,
                  color: KConstantColors.whiteColor),
              title: Text("Visa classic",
                  style: KCustomTextStyle.kBold(context, 10)),
              subtitle: Text("**** 1211",
                  style: KCustomTextStyle.kMedium(
                      context, 10, KConstantColors.whiteColor)),
            ),
            vSizedBox2,
            Text("Order info", style: KCustomTextStyle.kBold(context, 14)),
            vSizedBox1,
            Row(
              children: [
                Text("Subtotal",
                    style: KCustomTextStyle.kMedium(
                        context, 9, KConstantColors.texturedWhiteColor)),
                Spacer(),
                Text("\$${total}", style: KCustomTextStyle.kBold(context, 10)),
                hSizedBox2,
              ],
            ),
            Row(
              children: [
                Text("Shipping cost",
                    style: KCustomTextStyle.kMedium(
                        context, 9, KConstantColors.texturedWhiteColor)),
                Spacer(),
                Text("\$10", style: KCustomTextStyle.kBold(context, 10)),
                hSizedBox2,
              ],
            ),
            vSizedBox1,
            Row(
              children: [
                Text("Total",
                    style: KCustomTextStyle.kBold(
                        context, 14, KConstantColors.texturedWhiteColor)),
                Spacer(),
                Text("\$${total + 10}",
                    style: KCustomTextStyle.kBold(context, 25)),
                hSizedBox2,
              ],
            ),
            vSizedBox3,
            Container(
              height: 50,
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Proceed to checkout",
                              style: KCustomTextStyle.kMedium(
                                  context, 10, KConstantColors.whiteColor)),
                          hSizedBox2,
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 12, color: KConstantColors.whiteColor)
                        ],
                      ))),
              decoration: BoxDecoration(
                  color: KConstantColors.blueColor,
                  borderRadius: BorderRadius.circular(16)),
            ),
            vSizedBox5
          ],
        ),
      ),
    );
  }
}
