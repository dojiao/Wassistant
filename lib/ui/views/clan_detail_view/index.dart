import 'package:flutter/material.dart';

/// Clan detail view
class ClanDetailView extends StatelessWidget {
  final int _clanId;

  /// Returns a widget to display clan details
  ClanDetailView(this._clanId);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Clan detail'),
        ),
        body: Center(
          child: Text(_clanId.toString()),
        ),
      );
}
