import 'package:flutter/material.dart';

class AsyncSearchAnchor extends StatefulWidget {
  const AsyncSearchAnchor();

  @override
  State<AsyncSearchAnchor> createState() => _AsyncSearchAnchorState();
}

class _AsyncSearchAnchorState extends State<AsyncSearchAnchor> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              controller.openView();
            },
          );
        }, suggestionsBuilder:
        (BuildContext context, SearchController controller) async {
      _searchingWithQuery = controller.text;
      final List<String> options =
      (await _FakeAPI.search(_searchingWithQuery!)).toList();

      // If another search happened after this one, throw away these options.
      // Use the previous options instead and wait for the newer request to
      // finish.
      if (_searchingWithQuery != controller.text) {
        return _lastOptions;
      }

      _lastOptions = List<ListTile>.generate(options.length, (int index) {
        final String item = options[index];
        return ListTile(
          title: Text(item),
        );
      });

      return _lastOptions;
    });
  }
}

// Mimics a remote API.
class _FakeAPI {
  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  // Searches the options, but injects a fake "network" delay.
  static Future<Iterable<String>> search(String query) async {
    if (query == '') {
      return const Iterable<String>.empty();
    }
    return _kOptions.where((String option) {
      return option.contains(query.toLowerCase());
    });
  }
}
