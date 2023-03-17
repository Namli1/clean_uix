import 'package:flutter/material.dart';
import 'package:clean_uix/clean_uix.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.amber,
        backgroundColor: Colors.brown,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: CleanTheme(
          data: CleanThemeData(
            primary: Colors.brown,
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
  const MyHomePage({super.key, required this.title});

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
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[
            const SizedBox(height: 23),
            Text(
              "Clean_UIX",
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 77),
            Column(
              children: [
                CleanButton.text("Clean Button", onPressed: () {}),
                const SizedBox(height: 17),
                CleanButton(
                  onPressed: () {
                    CleanFloatingPanel.flow(
                      context,
                      showAlert: false,
                      builders: [
                        (ctx, next) {
                          return TextButton(
                            child: FlutterLogo(size: 77),
                            onPressed: next,
                          );
                        },
                        (ctx, next) {
                          return TextButton(
                            child: FlutterLogo(size: 33),
                            onPressed: next,
                          );
                        },
                      ],
                    );
                  },
                  interactionMode: InteractionMode.splash,
                  child: const Text("Open Flow Panel"),
                ),
                const SizedBox(height: 17),
                CleanButton.text(
                  "Open Clean Panel",
                  onPressed: () {
                    CleanPanel.present(context, showSidePanel: false,
                        builder: (context) {
                      return const FlutterLogo(
                        size: 300,
                      );
                    },
                        buttonBar: Column(
                          children: [
                            CleanButton.icon(
                              icon: const Icon(Icons.access_alarm_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ));
                  },
                  interactionMode: InteractionMode.opacity,
                ),
                const SizedBox(height: 17),
                CleanOutlinedButton(
                  onPressed: () {
                    CleanFloatingPanel.present(
                      context,
                      //showAlert: false,
                      builder: (ctx) {
                        return FlutterLogo(size: 77);
                      },
                    );
                    // showCustomModalBottomSheet(
                    //   containerWidget: (context, animation, child) {
                    //     return SafeArea(
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 70),
                    //         child: Material(
                    //           //color: backgroundColor,
                    //           clipBehavior: Clip.antiAlias,
                    //           borderRadius: BorderRadius.circular(12),
                    //           child: child,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    //   context: context,
                    //   builder: (context) {
                    //     return TestAnimated();
                    //   },
                    // );
                  },
                  interactionMode: InteractionMode.opacity,
                  child: const Text("Open Floating Panel"),
                ),
                const SizedBox(height: 17),
                CleanStickyPanel(
                  builder: (context, show) {
                    return CleanButton.text("Open Sticky Panel",
                        onPressed: () => show(
                              builder: (cancel) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("Sample text here"),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Sample Button")),
                                    CleanButton.icon(onPressed: () {}),
                                    CleanButton.text("Sample Clean",
                                        onPressed: () {}),
                                  ],
                                );
                              },
                              //preferDirection: PreferDirection.leftBottom,
                            ));
                  },
                ),
                // Builder(
                //   builder: (context) {
                //     return CleanButton.text("Open Sticky Panel", onPressed: () {
                //       CleanStickyPanel(
                //         child: (context, show) {
                //           return FlutterLogo();
                //         },
                //       );
                //     });
                //   },
                // )
              ],
            ),

            const SizedBox(height: 17),
            const CleanTextField(
              label: "Clean Text Field",
            ),
            const SizedBox(height: 17),
            CleanTextField.filled(
              label: "Clean Filled Text Field",
            ),
            const SizedBox(height: 17),
            OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber,
                ),
                child: FlutterLogo()),
            CleanOutlinedButton(
                interactionMode: InteractionMode.splash,
                onPressed: () {},
                style: CleanButton.styleFrom(
                    //foregroundColor: Colors.pink,
                    //backgroundColor: Colors.pink,
                    ),
                child: const FlutterLogo()),
            const SizedBox(height: 17),
            const SizedBox(height: 17),
            CleanButton(
                interactionMode: InteractionMode.splash,
                onPressed: () {},
                style: CleanButton.styleFrom(
                    foregroundColor: Colors.amber,
                    backgroundColor: Colors.pink),
                child: const FlutterLogo()),
            const CleanListItem(
              // title: Text("Hello there"),
              // overline: Text("An overline here"),
              titleText: "Title here",
              overlineText: "Overline here",
              subtitleText: "Subtitle here",
              leading: Icon(Icons.access_alarms_outlined),
              trailing: Icon(Icons.train),
            ),
            const SizedBox(height: 17),

            SizedBox(
              height: 300,
              width: 300,
              child: CleanGridSelect.builder(
                interactionMode: InteractionMode.splash,
                multiSelect: true,
                optionCount: 10,
                selectColor: Colors.amber,
                optionBuilder: (context, index) {
                  return GridSelectOption.text("Hello there",
                      value: index,
                      buttonStyle:
                          CleanButton.styleFrom(foregroundColor: Colors.blue));
                },
                onSelect: (selected, selectedValues) {
                  print("selected builder");
                },
              ),
            ),
            const SizedBox(height: 33),
            SizedBox(
              height: 300,
              width: 300,
              child: CleanGridSelect.cleanButtons(
                interactionMode: InteractionMode.splash,
                multiSelect: true,
                optionCount: 10,
                optionBuilder: (context, index) {
                  return GridSelectOption(
                      child: const FlutterLogo(), value: index);
                },
                onSelect: (selected, selectedValues) {
                  print("selected builder");
                },
              ),
            ),
            // const SizedBox(height: 33),
            // SizedBox(
            //   height: 300,
            //   width: 300,
            //   child: CleanGridSelect(
            //     interactionMode: InteractionMode.splash,
            //     selectColor: Colors.pink,
            //     multiSelect: true,
            //     options: [
            //       GridSelectOption.text("hello"),
            //       GridSelectOption.text("hello"),
            //       GridSelectOption.text("hello"),
            //     ],
            //     onSelect: (selected) {
            //       print("selected");
            //     },
            //   ),
            // ),

            ///!!!! THIS CAUSES APP TO BECOME UNRESPONSIVE !!!
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CleanGridSelect.childBuilder(
            //     optionBuilder: ((context, index) {
            //       return GridSelectOption(
            //         child: FlutterLogo(),
            //       );
            //     }),
            //     shrinkWrap: true,
            //     //interactionMode: InteractionMode.splash,
            //     // options: [
            //     //   GridSelectOption.text("Clean"),
            //     //   GridSelectOption.text("Grid"),
            //     //   GridSelectOption.text("Select"),
            //     // ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class TestAnimated extends StatefulWidget {
  const TestAnimated({
    Key? key,
  }) : super(key: key);

  @override
  State<TestAnimated> createState() => _TestAnimatedState();
}

class _TestAnimatedState extends State<TestAnimated> {
  bool _isLarge = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: Container(
        //height: _isLarge ? 500 : 100,
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              _isLarge = !_isLarge;
            });
          },
          icon: const Icon(Icons.expand_rounded),
          label: Text(
            "Enlarge",
            style: TextStyle(fontSize: _isLarge ? 77 : 22),
          ),
        ),
      ),
      // crossFadeState:
      //     !_isLarge ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      // firstChild:
      // secondChild: Container(
      //   height: 500,
      //   child: TextButton.icon(
      //     onPressed: () {
      //       setState(() {
      //         _isLarge = !_isLarge;
      //       });
      //     },
      //     icon: const Icon(Icons.expand_rounded),
      //     label: const Text(
      //       "Enlarge",
      //       style: TextStyle(fontSize: 77),
      //     ),
      //   ),
      //),
    );
  }
}
