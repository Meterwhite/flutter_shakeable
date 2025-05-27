## Features
`Let the flutter widget say NO by shaking itself.`
`Minimalist API design philosophy: shakeable + widget`

## Getting started
#### Installing
Add the following dependency to your pubspec.yaml file:
```yaml
dependencies:
  flutter_shakeable: latest_version
```

#### Importing
Import the package into your Dart code:
```dart
import 'package:flutter_shakeable/flutter_shakeable.dart';
```

## Example
#### Modifying the default Flutter project
- Apply `shakeable` to any 3 widgets, then trigger the shake animation by clicking the button.

```dart

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// 1️⃣  Create an instance of Shakeable
  final shakeable = Shakeable();

  void _incrementCounter() {
    // 3️⃣ Trigger the shake animation
    shakeable.shake();
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 2️⃣ Add the Shakeable to the widgets you want to shake
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 1
        title: shakeable + Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 2
            shakeable + const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton:
          // 3
          shakeable +
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
    );
  }
}

```