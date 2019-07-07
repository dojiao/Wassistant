import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wassistant/store/counter.dart';

/// Player page
class PlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Consumer<Counter>(
        builder: (_, counter, __) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('You have pushed the button this many times:'),
                  Text(
                    '${counter.count}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
      );
}
