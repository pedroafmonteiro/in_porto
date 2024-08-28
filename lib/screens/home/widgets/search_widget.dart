import 'package:flutter/material.dart';

import '../../settings/settings_view.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SearchAnchor(
        viewBackgroundColor: Theme.of(context).primaryColor,
        dividerColor: Theme.of(context).primaryColor,
        builder: (BuildContext context, SearchController controller) {
          return TextButton(
            onPressed: () {
              controller.openView();
            },
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: 10),
                Text(
                  'Search In Porto',
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings_rounded,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ],
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'Item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(
                    () {
                      controller.closeView(item);
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
