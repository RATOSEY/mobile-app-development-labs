import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 1 Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  // Локальний стан лічильника
  int _counter = 0;

  // Контролер для зчитування тексту з TextField
  final TextEditingController _controller = TextEditingController();

  // Метод обробки введених даних
  void _processInput() {
    final input = _controller.text;

    // Сценарій 2: Термінальна команда
    if (input == "Avada Kedavra") {
      setState(() {
        _counter = 0;
      });
      _controller.clear(); // Очищаємо поле після успішної команди
      return;
    }

    // Спроба розпарсити введене значення як ціле число
    final intValue = int.tryParse(input);

    if (intValue != null) {
      // Сценарій 1: Математична операція (інкремент)
      setState(() {
        _counter += intValue;
      });
      _controller.clear();
    } else {
      // Сценарій 3: Обробка виключень (невалідний стан)
      // Виводимо SnackBar, стан лічильника не змінюється
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Помилка: введіть ціле число або секретну команду.'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Звільнення ресурсів контролера для уникнення витоків пам'яті
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лабораторна робота №1'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Поточне значення лічильника:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 48),
            // Компонент введення даних
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Введіть число або команду',
                hintText: 'Наприклад: 5, -3 або Avada Kedavra',
              ),
              // Обробка натискання Enter на клавіатурі
              onSubmitted: (_) => _processInput(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _processInput,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Застосувати', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}