import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/widgets/loader_widget.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const LoaderWidget(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [asyncNavigatorObserver],
          title: 'DW barbershop',
          routes: {
            '/': (_) => const SplashPage(),
          },
        );
      },
    );
  }
}
