import 'package:fake_store/core/api/api_services.dart';
import 'package:fake_store/core/functions/on_generate_route.dart';
import 'package:fake_store/core/services/local_notification_service.dart';
import 'package:fake_store/core/services/shared_preferences_singlton.dart';
import 'package:fake_store/core/services/sql_service.dart';
import 'package:fake_store/features/auth/data/models/user_model.dart';
import 'package:fake_store/features/cart/presentation/manager/cubits/cart/cart_cubit.dart';
import 'package:fake_store/features/splash/presentation/views/splash_view.dart';
import 'package:fake_store/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesSinglton.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SqlDbService.getDb(dbName: 'cart_db');
  ApiServices.init();
  await LocalNotificationService.init();
  runApp(FakeStore());
}

class FakeStore extends StatelessWidget {
  const FakeStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: UserModel(),
      child: BlocProvider(
        create: (context) => CartCubit(),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light().copyWith(
              primary: Colors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: SplashView.routeName,
        ),
      ),
    );
  }
}
