import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/faliure.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks(
      {int pageNumber = 0});
  Future<Either<Failure, List<BookEntity>>> fetchNewestdBooks();
}
