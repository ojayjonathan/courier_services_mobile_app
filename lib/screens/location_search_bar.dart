import 'dart:math';

import 'package:courier_services/models/location.dart';
import 'package:courier_services/services/place_service.dart';
import 'package:courier_services/theme.dart';
import 'package:flutter/material.dart';

String randomString(int len) {
  const _chars = "ABCDEFDGUUIYKNMLPOUYZVFSHGD987462541432";
  Random _rand = Random();
  return String.fromCharCodes(Iterable.generate(
      len, (_) => _chars.codeUnitAt(_rand.nextInt(_chars.length))));
}

class AddressSearch extends SearchDelegate<Suggestion?> {
  final placeService = PlaceApiProvider(randomString(10));
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: placeService.fetchSuggestions(this.query, "en"),
      builder: (context, snapshot) {
        List<Suggestion> _suggetions =
            snapshot.data != null ? snapshot.data as List<Suggestion> : [];
        if (snapshot.hasError) {
          return Text("${snapshot.error.toString()}");
        }
        return query == ''
            ? Container(
                padding: EdgeInsets.all(16.0),
                child: Text('Enter location name'),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      // we will display the data returned from our future here
                      leading: Icon(
                        Icons.location_on,
                        color: ColorTheme.primaryColor,
                      ),
                      title: Text(_suggetions[index].description.split(",")[0]),
                      subtitle: Text(_suggetions[index]
                          .description
                          .split(",")
                          .sublist(1)
                          .join(",")),
                      onTap: () {
                        close(context, _suggetions[index]);
                      },
                    ),
                    itemCount: _suggetions.length,
                  )
                : Container(child: Text('Loading...'));
      },
    );
  }
}
