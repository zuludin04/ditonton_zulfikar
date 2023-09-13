import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchToolbar extends StatefulWidget {
  const SearchToolbar({super.key});

  @override
  State<SearchToolbar> createState() => _SearchToolbarState();
}

class _SearchToolbarState extends State<SearchToolbar> {
  List<String> searchMenu = <String>['Movie', 'TV Series'];
  bool searchMovie = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onSubmitted: (query) {
              var provider =
                  Provider.of<MovieSearchNotifier>(context, listen: false);
              provider.fetchMovieSearch(searchMovie, query);
            },
            decoration: const InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
        ),
        const SizedBox(width: 16),
        DropdownMenu<String>(
          initialSelection: searchMenu.first,
          onSelected: (String? value) {
            setState(() {
              searchMovie = value! == 'Movie';
            });
          },
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 24, horizontal: 12)),
          width: 130,
          dropdownMenuEntries:
              searchMenu.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        )
      ],
    );
  }
}
