import 'package:bookly/Features/home/domain/entites/book_entity.dart';
import 'package:hive/hive.dart';

void saveBoxDataLocal(List<BookEntity> books, String boxName) {
  var box = Hive.box<BookEntity>(boxName);
  box.addAll(books);
}
