import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wassistant/ui/views/home_view/pages/settings_page.dart';
import 'package:wassistant/ui/widgets/search_floating_bar.dart';

import 'encyclopeida_page.dart';

/// Home page
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

/// State of HomePage
class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SearchFloatingBar(),
          // Just a test case for floating bar's floating,
          // pinned, snap attributes.
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * ((index + 8) % 9)],
                child: Text('list item $index'),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: Container(
        margin: EdgeInsets.fromLTRB(8, 32, 8, 8),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: CircleAvatar(),
                title: Text('Username'),
                subtitle: Text('Something'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //TODO: Maybe something about this guy...
                },
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                'images/menu_book_24px.svg',
                color: Colors.grey[600],
              ),
              title: Text('Encyclopedia'),
              onTap: () {
                Navigator.push(
                  context,
                  // The page slides in from the right and exits in reverse.
                  CupertinoPageRoute(
                    builder: (context) => EncyclopediaPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  // The page slides in from the right and exits in reverse.
                  CupertinoPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
