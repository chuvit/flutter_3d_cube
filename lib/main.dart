import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

// final blackVisibilityState = StateProvider

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Offset offset = Offset.zero;
  bool black = true;
  bool purple = true;
  bool lime = true;
  bool blue = true;
  bool pink = false;

  int blackPosition = 0;

  double startPosition = 0.0;
  double currentPosition = 0.0;
  double yRotationPool = 0.0;

  @override
  void initState() {
    super.initState();
    print(offset.dy * pi / 180);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // void round(double numToRound) {
  //   List<String> toString = numToRound.toStringAsFixed(3).split('.');
  //   String firstHalf = toString[0];
  //   // int secondHalf = int.parse(toString[1]);

  //   while (toString[1].length < 2) {
  //     toString[1] = "${toString[1]}0";
  //   }
  //   print(toString);

  //   String decimalPlacesInput = "";
  //   double decimalPlacesOutput = 0.0;

  //   for (var i = 0; i < toString[1].length; i++) {
  //     // print(toString[1][i]);
  //     if (i < 2) {
  //       decimalPlacesInput += toString[1][i];
  //     }

  //     if (i == 2 && int.parse(toString[1][i]) >= 5) {
  //       decimalPlacesOutput =
  //           double.parse("$firstHalf.${int.parse(decimalPlacesInput) + 1}");
  //       print(decimalPlacesOutput);
  //       // decimalPlacesOutput = (int.parse(decimalPlacesInput) + 1).toDouble();
  //       break;
  //     }
  //     // else if (i == 2 && int.parse(toString[1][i]) >= 5) {
  //     //   decimalPlacesOutput =
  //     //       double.parse("$firstHalf.${int.parse(decimalPlacesInput)}");
  //     //   break;
  //     // }
  //   }

  //   // return decimalPlacesOutput;
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: ((details) {
        // print(details.delta.dy);
        setState(() {
          offset = Offset(
            // offset.dx + details.delta.dx,
            offset.dx + details.delta.dx,
            offset.dy,
          );

          double currentRotationY =
              double.parse((offset.dy * pi / 180).toStringAsFixed(2)) % 6.28;

          double currentRotationX =
              double.parse((offset.dx * pi / 180).toStringAsFixed(2)) % 6.28;
          // if (!details.delta.direction.isNegative) {
          //   currentRotation++;
          // } else {
          //   currentRotation--;
          // }

          // final newRotation = double.parse(currentRotation.toStringAsFixed(2));
          if (currentRotationY >= 0.0 && currentRotationY <= 1.48 ||
              currentRotationY > 4.8) {
            black = true;
          } else {
            black = false;
          }

          if (currentRotationY >= 1.53 && currentRotationY <= 3.04 ||
              currentRotationY > 0.0 && currentRotationY <= 1.53) {
            purple = true;
          } else {
            purple = false;
          }

          if (currentRotationY >= 1.6 && currentRotationY <= 4.62 ||
              currentRotationX >= 1.54 && currentRotationX <= 4.61) {
            lime = true;
          } else {
            lime = false;
          }

          if (currentRotationY >= 3.24 && currentRotationY <= 6.19) {
            blue = true;
          } else {
            blue = false;
          }

          if (currentRotationX >= 0.1 && currentRotationX <= 3.04) {
            pink = true;
          } else {
            pink = false;
          }

          print(currentRotationX);
        });
      }),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(offset.dy * pi / 180)
            ..rotateY(-offset.dx * pi / 180),
          alignment: Alignment.center,
          child: Center(
            child: Cube(
              blackVisibility: black,
              purpleVisibility: purple,
              limeVisibility: lime,
              blueVisibility: blue,
              pinkVisibility: pink,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Cube extends StatelessWidget {
  const Cube(
      {Key? key,
      required this.blackVisibility,
      required this.purpleVisibility,
      required this.limeVisibility,
      required this.blueVisibility,
      required this.pinkVisibility})
      : super(key: key);

  final bool blackVisibility;
  final bool purpleVisibility;
  final bool limeVisibility;
  final bool blueVisibility;
  final bool pinkVisibility;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, 100.0),
          child: Visibility(
            visible: limeVisibility,
            child: Container(
              color: Colors.lime,
              child: const FlutterLogo(
                size: 200,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(100.0, 0.0, 0.0)
            ..rotateY(pi / 2),
          alignment: Alignment.center,
          child: Container(
            color: Colors.orange,
            child: const FlutterLogo(
              size: 200,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, 100.0, 0.0)
            ..rotateX(pi / 2),
          alignment: Alignment.center,
          child: Visibility(
            visible: blueVisibility,
            child: Container(
              color: Colors.blue,
              child: const SizedBox(
                width: 200.0,
                height: 200.0,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(0.0, -100.0, 0.0)
            ..rotateX(pi / 2),
          alignment: Alignment.center,
          child: Visibility(
            visible: purpleVisibility,
            child: Container(
              color: Colors.purple,
              child: const SizedBox(
                width: 200.0,
                height: 200.0,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, -100.0),
          child: Visibility(
            visible: blackVisibility,
            child: Container(
              color: Colors.black,
              child: const FlutterLogo(
                size: 200,
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(-100.0, 0.0, 0.0)
            ..rotateY(pi / 2),
          alignment: Alignment.center,
          child: Visibility(
            visible: pinkVisibility,
            child: Container(
              color: Colors.pink,
              child: const FlutterLogo(
                size: 200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
