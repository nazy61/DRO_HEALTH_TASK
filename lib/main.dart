import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'cubit/cubits.dart';
import 'services/services.dart';
import 'utils/utils.dart';
import 'views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'DRO Health',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppCustomColors.primaryColor,
            fontFamily: 'Proxima',
          ),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CategoryCubit(FakeCategoryRepository()),
              ),
              BlocProvider(
                create: (context) => ProductCubit(FakeProductRepository()),
              ),
              BlocProvider(
                create: (context) => ScrollCubit(),
              ),
              BlocProvider(
                create: (context) => SearchCubit(),
              ),
              BlocProvider(
                create: (context) => NavbarCubit(),
              ),
              BlocProvider(
                create: (context) => SelectedCategoryCubit(),
              ),
              BlocProvider(
                create: (context) => CartCubit(),
              ),
            ],
            child: const DashboardScreen(),
          ),
        );
      },
    );
  }
}
