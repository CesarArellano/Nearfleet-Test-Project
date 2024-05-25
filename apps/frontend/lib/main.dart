import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nearfleet_app/config/di/di.dart';
import 'package:nearfleet_app/domain/repositories/addresses_repository.dart';
import 'package:nearfleet_app/presentation/providers/addresses_bloc.dart';

import './config/router/app_router.dart';
import './config/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final addressesRepository = getIt.get<AddressesRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AddressesBloc(addressesRepository: addressesRepository))
      ],
      child: MaterialApp.router(
        title: 'Nearfleet App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}