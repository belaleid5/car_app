import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/services/server_locator.dart';

import 'package:car_app/features/cars_feature/home/presentaion/manger/home_cubit.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/widgets/search_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchCubit>(
          create: (context) => sl<SearchCubit>()..getAllCars(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => sl<HomeCubit>(),
        ),
        // Add more BlocProvider entries here if needed
      ],
      child: const SearchScreenContent(),
    );
  }
}

