import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/core/api/api_service.dart';
import 'package:bookly/core/utils/functions/save_box.dart';

import '../../../../constants.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewestdBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiService.get(
        endPoint:
            'volumes?Filtering=free-ebooks&q=Programming&startIndex=${pageNumber * 10}');

    List<BookEntity> books = getBooksList(data);

    //! Hive store in local DB
    saveBoxDataLocal(books, kFeaturedBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestdBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&q=Programming&Sorting=newest');

    List<BookEntity> books = getBooksList(data);

    //! Hive store in local DB
    saveBoxDataLocal(books, kNewestBox);

    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
