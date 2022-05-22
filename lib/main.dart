import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:champmastery/presentation/home/home_bloc.dart';
import 'package:champmastery/presentation/home/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      locale: const Locale('ru'),
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      home: BlocProvider(
        create: (context) => HomeBloc()..add(StartHomeEvent()),
        child: const HomePage(),
      ),
    ),
  );
}
