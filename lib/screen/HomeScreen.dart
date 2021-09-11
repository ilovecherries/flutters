import 'package:flutter/material.dart';
import 'package:flutters/model/BooruImage.dart';
import 'package:flutters/util/RequestBuilder.dart';
import 'package:flutters/widget/Entry.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final booru = BooruHTTPClient('www.ponerpics.org', true);

  final PagingController<int, BooruImage> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await booru.searchImages([], pageKey);
      _pagingController.appendPage(newItems, pageKey + 1);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, BooruImage>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<BooruImage>(
          itemBuilder: (context, item, index) => Entry(item)));
}
