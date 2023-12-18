import 'package:hive/hive.dart';
import 'package:manage_my_expenses_app/models/expense.dart';

class CategoriesAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    // TODO: implement read
    return Category.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    // TODO: implement write
    writer.writeByte(obj.index);
  }
}
