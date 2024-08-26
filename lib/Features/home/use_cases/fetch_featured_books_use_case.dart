import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:bookly/Features/home/domain/repositories/home_repo.dart';
import 'package:bookly/core/use_cases_core/use_case.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/faliure.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;
  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call([int params = 0]) async {
    return await homeRepo.fetchFeaturedBooks(pageNumber: params);
  }
}
