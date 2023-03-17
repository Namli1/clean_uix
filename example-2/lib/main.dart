import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_uix/clean_uix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // colorScheme: ColorScheme(
        //   primary: Colors.black,
        //   secondary: Colors.white,
        // ),
        textTheme: const TextTheme(
            headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        )),
      ),
      home: CleanTheme(
          data: CleanThemeData(
            primary: Colors.green,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            elevation: 3,
            interactionMode: InteractionMode.scale,
          ),
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: FlutterLogo(),
      // Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       // Column is also a layout widget. It takes a list of children and
      //       // arranges them vertically. By default, it sizes itself to fit its
      //       // children horizontally, and tries to be as tall as its parent.
      //       //
      //       // Invoke "debug painting" (press "p" in the console, choose the
      //       // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //       // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //       // to see the wireframe for each widget.
      //       //
      //       // Column has various properties to control how it sizes itself and
      //       // how it positions its children. Here we use mainAxisAlignment to
      //       // center the children vertically; the main axis here is the vertical
      //       // axis because Columns are vertical (the cross axis would be
      //       // horizontal).
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.min,
      //       children: <Widget>[
      //         const SizedBox(height: 23),
      //         Text(
      //           "Clean_UIX",
      //           style: Theme.of(context).textTheme.headline2,
      //         ),
      //         const SizedBox(height: 77),
      //         Flexible(
      //           child: CleanButton(
      //             onPressed: () {},
      //             interactionMode: InteractionMode.splash,
      //             child: const Text("Clean Button"),
      //           ),
      //         ),
      //         const SizedBox(height: 17),
      //         Flexible(
      //           child: CleanButton.icon(
      //             onPressed: () {
      //               CleanPanel.present(context, builder: (context) {
      //                 return const FlutterLogo(
      //                   size: 300,
      //                 );
      //               },
      //                   buttonBar: Column(
      //                     children: [
      //                       CleanButton.icon(
      //                         icon: const Icon(Icons.access_alarm_outlined),
      //                         onPressed: () {},
      //                       ),
      //                     ],
      //                   ));
      //             },
      //             interactionMode: InteractionMode.scale,
      //             icon: const Icon(
      //               Icons.clean_hands,
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 17),
      //         CleanOutlinedButton(
      //           onPressed: () {},
      //           child: const FlutterLogo(),
      //           interactionMode: InteractionMode.opacity,
      //         ),
      //         const SizedBox(height: 17),
      //         const CleanTextField(
      //           label: "Clean Text Field",
      //         ),
      //         const SizedBox(height: 17),
      //         CleanTextField.filled(
      //           label: "Clean Filled Text Field",
      //         ),
      //         const SizedBox(height: 17),
      //         const Flexible(
      //           child: CleanListItem(
      //             // title: Text("Hello there"),
      //             // overline: Text("An overline here"),
      //             titleText: "Title here",
      //             overlineText: "Overline here",
      //             subtitleText: "Subtitle here",
      //             leading: Icon(Icons.access_alarms_outlined),
      //             trailing: Icon(Icons.train),
      //           ),
      //         ),
      //         const SizedBox(height: 17),
      //         Flexible(
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: CleanGridSelect.childBuilder(
      //               optionBuilder: ((context, index) {
      //                 return GridSelectOption(
      //                   child: FlutterLogo(),
      //                 );
      //               }),
      //               shrinkWrap: true,
      //               //interactionMode: InteractionMode.splash,
      //               // options: [
      //               //   GridSelectOption.text("Clean"),
      //               //   GridSelectOption.text("Grid"),
      //               //   GridSelectOption.text("Select"),
      //               // ],
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 17),
      //         CleanToast.text(
      //           "Clean Toast",
      //           primary: Colors.green,
      //           icon: const Icon(
      //             Icons.check,
      //           ),
      //           onClosePressed: () {},
      //         ),
      //         const SizedBox(height: 17),
      //         CleanAlert.simpleText(
      //           text: "Hello there",
      //           title: "Title here very long as well.",
      //           subtitle: "Subtitle here",
      //           bottomWidget: const FlutterLogo(),
      //         ).rotate(),
      //         const SizedBox(height: 33),
      //         CleanButton.text("Cool Rotated Alert", onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (_) => CleanAlert.simpleText(
      //               text: "Hello there",
      //               title: "Title here very long as well.",
      //               subtitle: "Subtitle here",
      //               bottomWidget: const FlutterLogo(),
      //             ).rotate(),
      //           );
      //         }),
      //         const SizedBox(height: 77),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
