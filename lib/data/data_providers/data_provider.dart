import '../../core/configs/configs.dart';

class DataProvider {
  static String sessionsById(int id) => "$server/sessions/$id";

  static String get login => "$server/auth";
}
