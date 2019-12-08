import 'package:first_app/screens/secondsreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int index = 0;
  PageController _pageController = PageController(initialPage: 0, viewportFraction:0.8);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondScreen()));
          },
          child: Icon(Icons.add),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                height: size.height / 2,
                width: size.width,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int i){
                      index = i;
                      setState(() {

                      });
                  },
                  children: <Widget>[
                    Container(
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: (((size.height / 2) - (size.height * 0.1 / 2))) -
                  size.height / 4 -
                  (size.height / 4 * 0.3),
              child: Container(
                height: size.height * 0.1,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.red,
                      child: Icon(Icons.arrow_back),
                      onPressed:index == 0 ? null : () {
                        if (index > 0) {
                          _pageController.animateToPage(index - 1,
                              duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);

                        }
                      },
                    ),
                    SizedBox(
                      width: 100,
                      child: Center(
                        child: Text("$index"),
                      ),
                    ),
                    FlatButton(
                      color: Colors.blue,
                      child: Icon(Icons.arrow_forward),
                      onPressed: index == 2 ? null : () {
                        if (index >= 0 && index <2) {
                          _pageController.animateToPage(index+1,
                              duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);

                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
