import 'package:first_app/camera_widget.dart';
import 'package:first_app/screens/page_reveal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nima/nima_actor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.7);
  int index = 0;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn)
          ..addListener(() => setState(() {}));
    animationController.forward(from: 0.0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
//        body: new NimaActor("assets/manhe.nma", alignment:Alignment.center, fit:BoxFit.contain, animation:"manhe_animate"),

      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (int i) {
              index = i;
              animationController.forward(from: 0.0);
              setState(() {});
            },
            children: <Widget>[
              Container(
                  child: PageReveal(
                revealPercent: index != 0 ? 0.0 : animation.value,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    "Capture crush photo",
                    style: themeData.textTheme.title,
                  )),
                ),
              )),
              Container(
                  child: PageReveal(
                revealPercent: index != 1 ? 0.0 : animation.value,
                child: Opacity(
                  opacity: animation.value,
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 - (100 * animation.value), 0.0),
                      child: CameraApp(),
                    ),
                  ),
                ),
              ))
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(index == 0
                  ? FontAwesomeIcons.chevronCircleDown
                  : FontAwesomeIcons.chevronCircleUp),
              onPressed: () {
                pageController.animateToPage(index == 0 ? 1 : 0,
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn);
              },
            ),
          )
        ],
      ),
    );
  }
}
