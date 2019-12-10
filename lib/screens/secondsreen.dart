import 'package:first_app/screens/slide_right.dart';
import 'package:first_app/screens/thirdscreen.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as english;

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> words = english.nouns.take(10).toList()..sort();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, SlideRightRoute(
            page: ThirdScreen()
          ))
          ,child: Icon(Icons.add) ,),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: GridView(
            children: List.generate(words.length, (int index) {
              return buildListTile(words[index]);
            }),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4)));
  }

  Widget buildListTile(String word) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          SlideRightRoute(
              page: WordDetail(
            word: word,
          ))),
      child: Hero(
          tag: word,
          child: Card(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$word',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ))),
    );
  }
}

class WordDetail extends StatefulWidget {
  final String word;

  const WordDetail({Key key, @required this.word})
      : assert(word != null),
        super(key: key);

  @override
  _WordDetailState createState() => _WordDetailState();
}

class _WordDetailState extends State<WordDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close))
                ],
              ),
            ),
          ),
          Center(
            child: Hero(
              tag: widget.word,
              child: Container(
                width: 400,
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.word}',
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
