import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';

class CustomLocationSearch extends SearchDelegate {
  final GooglePlace googlePlace;

  CustomLocationSearch(this.googlePlace);
  final List<SearchResult>? suggestions = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 3) {
      return const Center(
        child: Text("Enter location details. Minimum 3 characters."),
      );
    }

    return FutureBuilder<TextSearchResponse?>(
      future: autoCompleteSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressWidget());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          }

          if (snapshot.hasData) {
            final TextSearchResponse? response = snapshot.data;
            if (response?.results?.isEmpty ?? true) {
              return Center(
                child: Text("No results found!"),
              );
            }
            final List<SearchResult> searchResult = response?.results ?? [];
            return ListView.builder(
              itemBuilder: (_, i) {
                return Card(
                  child: ListTile(
                    tileColor: ColorUtils.white,
                    title: Text(
                      "${searchResult[i].name}",
                    ),
                    subtitle: Text(
                      "${searchResult[i].formattedAddress}",
                    ),
                    onTap: () {
                      close(context, searchResult[i]);
                    },
                  ),
                );
              },
              itemCount: searchResult.length,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
            );
          }
        }
        return Container();
      },
    );
  }

  Future<TextSearchResponse?> autoCompleteSearch(String value) async {
    return await googlePlace.search.getTextSearch(value);
    // if (result != null && result.results != null) {
    //   suggestions?.clear();
    //   suggestions?.addAll(result.results?.toList() ?? []);
    // }
  }
}
