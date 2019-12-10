import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  TabController _tabBarViewController;
  List<Widget> containers = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.white,
    ),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabBarViewController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) => Scaffold(
              body: Stack(
                children: <Widget>[
                  TabBarView(
                    controller: _tabBarViewController,
                    children: [Payment(), Graph(), PaymentCard()],
                  ),
                  SafeArea(
                    child: Container(
                      height: orientation == Orientation.portrait ? size.height * 0.2 : size.width * 0.2,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Wallet",
                                style: themeData.textTheme.title,
                              ),
                              IconButton(
                                icon: Icon(Icons.notifications_active),
                                onPressed: () {},
                              )
                            ],
                          ),
                          buildTabBar(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  TabBar buildTabBar() {
    return TabBar(
        controller: _tabController,
        onTap: (int index) {
          _tabBarViewController.animateTo(index);
        },
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
            insets: EdgeInsets.symmetric(horizontal: 40),
            borderSide: BorderSide(color: Colors.lightBlue, width: 2)),
        labelColor: Colors.indigo,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(
            text: "Payment",
            icon: Icon(Icons.payment),
          ),
          Tab(
            text: "Graph",
            icon: Icon(Icons.show_chart),
          ),
          Tab(
            icon: Icon(Icons.card_giftcard),
            text: "Card",
          )
        ]);
  }
}

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Payment"),
    );
  }
}

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Graph"),
    );
  }
}

class PaymentCard extends StatefulWidget {
  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Payment Card"),
    );
  }
}
