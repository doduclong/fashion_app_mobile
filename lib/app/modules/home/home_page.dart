import 'package:fashion_app/app/modules/home/home_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ListView(
            padding: FxSpacing.zero,
            children: <Widget>[
              Container(
                padding: FxSpacing.nBottom(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FxText.titleMedium("Welcome",
                        letterSpacing: 0, fontWeight: 600, color: theme.colorScheme.onBackground,),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute<void>(
                        //     builder: (BuildContext context) {
                        //       return NotificationDialog();
                        //     },
                        //     fullscreenDialog: true));
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Icon(
                            MdiIcons.bellOutline,
                            color: theme.colorScheme.onBackground,
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: FxContainer.rounded(
                              padding: FxSpacing.zero,
                              height: 14,
                              width: 14,
                              color: theme.colorScheme.primary,
                              child: Center(
                                child: FxText.labelSmall(
                                  "2",
                                  color: theme.colorScheme.onPrimary,
                                  fontSize: 9,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              FxContainer.bordered(
                paddingAll: 16,
                borderRadiusAll: 4,
                margin: FxSpacing.nBottom(24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FxContainer(
                              padding: FxSpacing.xy(12, 8),
                              color: theme.colorScheme.primary.withAlpha(28),
                              borderRadiusAll: 4,
                              child: FxText.bodySmall("Trending",
                                  color: theme.colorScheme.primary,
                                  letterSpacing: 0.3,
                                  fontWeight: 600),
                            ),
                            FxText.labelMedium("Colorful Sandal",
                                fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                            FxText.bodySmall("\$ 49.99",
                                fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground)
                          ],
                        ),
                      ),
                    ),
                    const FxContainer(
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadiusAll: 4,
                      child: Image(
                        image: AssetImage(
                            './assets/images/apps/shopping/product/product-8.jpg'),
                        width: 125,
                        height: 125,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.nBottom(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FxText.bodyLarge("Popular Deals",
                        fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                    FxText.bodySmall("View all",
                        color: theme.colorScheme.primary, letterSpacing: 0, )
                  ],
                ),
              ),
              FxSpacing.height(24),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: FxSpacing.left(24),
                      child: singleItemWidget(
                          image:
                          './assets/images/apps/shopping/product/product-10.jpg',
                          name: "Pop corn",
                          rate: 45.99,
                          context: context),
                    ),
                    Container(
                      margin: FxSpacing.left(24),
                      child: singleItemWidget(
                          image:
                          './assets/images/apps/shopping/product/product-7.jpg',
                          name: "Cosmic bang",
                          rate: 78.99,
                          context: context),
                    ),
                    Container(
                      margin: FxSpacing.left(24),
                      child: singleItemWidget(
                          image:
                          './assets/images/apps/shopping/product/product-5.jpg',
                          name: "Sweet Gems",
                          rate: 35.99,
                          context: context),
                    ),
                    Container(
                      margin: FxSpacing.left(24),
                      child: singleItemWidget(
                          image:
                          './assets/images/apps/shopping/product/product-2.jpg',
                          name: "Toffees",
                          rate: 28.49,
                          context: context),
                    ),
                    Container(
                      margin: FxSpacing.x(24),
                      child: singleItemWidget(
                          image:
                          './assets/images/apps/shopping/product/product-3.jpg',
                          name: "Candies",
                          rate: 15.99,
                          context: context),
                    ),
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.nBottom(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FxText.bodyLarge("For you", fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
                    FxText.bodySmall(
                      "View all",
                      letterSpacing: 0,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.nBottom(24),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: singleForYouWidget(
                        name: "Sweet Gems",
                        image:
                        './assets/images/apps/shopping/product/product-5.jpg',
                        shopName: 'El Primo',
                        star: 4.5,
                        price: 1470,
                        context: context
                      ),
                    ),
                    Container(
                      child: singleForYouWidget(
                        name: "Lipsticks",
                        image:
                        './assets/images/apps/shopping/product/product-4.jpg',
                        shopName: 'Bee Lipstore',
                        star: 3.8,
                        price: 1486,
                        context: context
                      ),
                    ),
                    Container(
                      child: singleForYouWidget(
                        name: "Candies",
                        image:
                        './assets/images/apps/shopping/product/product-3.jpg',
                        shopName: 'Bee Lipstore',
                        star: 4,
                        price: 1456,
                        context: context
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.nBottom(24),
                child: FxText.titleMedium("Best sellers",
                    fontWeight: 600, letterSpacing: 0, color: theme.colorScheme.onBackground),
              ),
              Container(
                margin: FxSpacing.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    singleSellerWidget(
                        image: './assets/images/profile/avatar_1.jpg',
                        name: 'Liss\'s Shop'),
                    singleSellerWidget(
                        image: './assets/images/profile/avatar_2.jpg',
                        name: 'Ekk Shop'),
                    singleSellerWidget(
                        image: './assets/images/profile/avatar_3.jpg',
                        name: 'Shop Center'),
                    singleSellerWidget(
                        image: './assets/images/profile/avatar_4.jpg',
                        name: 'Sweety')
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget singleItemWidget(
      {required String image, required String name, double? rate, BuildContext? context}) {
    //String key = Generator.randomString(10);
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context!,
        //     MaterialPageRoute(
        //         builder: (context) => ShoppingProductScreen(
        //           //heroTag: key,
        //           image: image,
        //         )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Image.asset(
              image,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: FxSpacing.top(8),
            child: FxText.bodyMedium(name,
                letterSpacing: 0, muted: true, fontWeight: 600, color: theme.colorScheme.onBackground),
          ),
          FxText.bodyMedium("\$ $rate", color: theme.colorScheme.onBackground),
        ],
      ),
    );
  }

  Widget singleSellerWidget({required String image, required String name}) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Image(
            image: AssetImage(image),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        FxSpacing.height(8),
        FxText.bodySmall(name, color: theme.colorScheme.onBackground)
      ],
    );
  }

  Widget singleForYouWidget(
      {required String name,
        required String image,
        required String shopName,
        required double star,
        int? price,
        BuildContext? context}) {
    //String key = Generator.randomString(10);
    return FxContainer.bordered(
      color: Colors.transparent,
      paddingAll: 16,
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(16),
      onTap: () {
        // Navigator.push(
        //     context!,
        //     MaterialPageRoute(
        //         builder: (context) => ShoppingProductScreen(
        //           //heroTag: key,
        //           image: image,
        //         )));
      },
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Image.asset(
              image,
              height: 90,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: FxContainer.none(
              height: 90,
              color: Colors.transparent,
              margin: FxSpacing.left(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FxText.titleMedium(
                        name,
                        fontWeight: 600,
                          color: theme.colorScheme.onBackground
                      ),
                      Icon(
                        MdiIcons.heart,
                        color: theme.colorScheme.onBackground.withAlpha(75),
                        size: 22,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FxStarRating(
                          rating: star,
                          size: 16,
                          inactiveColor: theme.colorScheme.onBackground),
                      Container(
                        margin: FxSpacing.left(8),
                        child:
                        FxText.bodyMedium(star.toString(), fontWeight: 600, color: theme.colorScheme.onBackground),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            MdiIcons.storeOutline,
                            color:
                            theme.colorScheme.onBackground.withAlpha(200),
                            size: 20,
                          ),
                          FxSpacing.width(4),
                          FxText.bodyMedium(shopName, color: theme.colorScheme.onBackground)
                        ],
                      ),
                      FxText.bodyMedium("\$ $price", fontWeight: 700, color: theme.colorScheme.onBackground)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}