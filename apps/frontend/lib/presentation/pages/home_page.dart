import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Center(
        child: Text('HomeScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.map_sharp),
        onPressed: () => context.push('/maps')
      ),
    );
  }
}