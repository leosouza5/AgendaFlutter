import 'package:agenda/features/contato/controller/contato_controller.dart';
import 'package:agenda/features/home/model/agenda_model.dart';
import 'package:agenda/features/home/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContatoController()),
        ChangeNotifierProvider(create: (context) => AgendaModel()),
      ],
      child: MaterialApp(
          title: 'Agenda',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF648a64)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen()),
    );
  }
}
