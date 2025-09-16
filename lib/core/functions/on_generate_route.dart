import 'package:fake_store/features/auth/presentation/views/login_view.dart';
import 'package:fake_store/features/auth/presentation/views/sign_up_view.dart';
import 'package:fake_store/features/cart/presentation/views/cart_view.dart';
import 'package:fake_store/features/home/data/models/product_model.dart';
import 'package:fake_store/features/home/presentation/manager/cubits/notification_cubit.dart';
import 'package:fake_store/features/home/presentation/views/home_view.dart';
import 'package:fake_store/features/home/presentation/views/product_details_view.dart';
import 'package:fake_store/features/layout/presentation/views/layout_view.dart';
import 'package:fake_store/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:fake_store/features/home/presentation/notification_view.dart';
import 'package:fake_store/features/order/presentation/views/order_view.dart';
import 'package:fake_store/features/search/presentation/views/search_view.dart';
import 'package:fake_store/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case NotificationView.routeName:
      return MaterialPageRoute(builder: (context) => NotificationView());
    case OrderView.routeName:
      return MaterialPageRoute(builder: (context) => const OrderView());
    case LayoutView.routeName:
      return MaterialPageRoute(builder: (context) => const LayoutView());

    case CartView.routeName:
      return MaterialPageRoute(builder: (context) => const CartView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case SearchView.routeName:
      return MaterialPageRoute(builder: (context) => const SearchView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case ProductDetailsView.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'] as ProductModel;
      final int? index = args['index'] ?? 0 as int?;
      return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailsView(productModel: product, index: index);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      );

    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
