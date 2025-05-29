import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/user/cubit/name_imput_cubit.dart';

class NameInputScreen extends StatefulWidget {
  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final _controller = TextEditingController();

  void _saveName() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    // Usar el cubit para guardar el nombre
    context.read<UserCubit>().setUsername(name);

    // Navegar a HomeScreen (o reemplazar)
    Navigator.pushReplacementNamed(context, '/home'); // O como manejes rutas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿Cómo te llamas?', style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _saveName, child: Text('Continuar')),
          ],
        ),
      ),
    );
  }
}
