import 'package:dio/dio.dart';

import '../../core/configs/configs.dart';
import '../data_providers/data_provider.dart';
import '../models/app_user.dart';
import '../models/chat_session.dart';
import '../models/res_user.dart';

class HttpServices {
  Dio dio = Dio();

  HttpServices() {
    dio.options.baseUrl = url;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  Future<AppUser> login(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post(DataProvider.login,
          data: {"email": email, "password": password});

      ResUser resUser = ResUser.fromMap(response.data);
      return resUser.appUser;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ChatSession>> sessionsById({required int id}) async {
    try {
      Response response = await dio.get(DataProvider.sessionsById(id));
      List<dynamic> resData = response.data;
      List<ChatSession> sessions =
          resData.map((map) => ChatSession.fromMap(map)).toList();
      return sessions;
    } catch (e) {
      throw e.toString();
    }
  }
}
