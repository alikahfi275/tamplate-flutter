import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:tamplate_getx/data/models/token_model.dart';
import 'package:tamplate_getx/data/models/user_model.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([
      UserModelSchema,
      TokenModelSchema,
    ], directory: dir.path);
  }
}
