import 'package:flutter/material.dart';
import 'package:flutter_widget_test/calculator.dart';
import 'package:flutter_widget_test/custom_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  double a = 0;
  double b = 0;
  double toplam = 0;
  Calculator calculator = Calculator();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const CustomText(text: 'Text1'),
            const CustomText(text: 'Text2'),
            const CustomText(text: 'Text3'),
            const CustomText(text: 'Text4'),
            TextField(
              key: const Key('Tf1'),
              onChanged: (value) {
                setState(() {
                  a = double.parse(value);
                });
              },
            ),
            TextField(
              key: const Key('Tf2'),
              onChanged: (value) {
                setState(() {
                  b = double.parse(value);
                  toplam = calculator.add(a, b);
                });
              },
            ),
            CustomText(text: toplam.toString()),
            ElevatedButton(onPressed: () {}, child: const Icon(Icons.place)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
