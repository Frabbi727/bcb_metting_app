import '../../core/values/api_endpoints.dart';
import '../models/user_model.dart';
import 'base_dao.dart';

class UserDao extends BaseDao {
  UserDao(super.dio);

  Future<UserModel> getUserProfile(String userId) async {
    final response = await getRequest<Map<String, dynamic>>('${ApiEndPoints.userProfile}/$userId');
    if (response.data == null) {
      throw Exception('Empty response from user profile endpoint');
    }
    return UserModel.fromJson(response.data!);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await postRequest<Map<String, dynamic>>(
      ApiEndPoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data ?? {};
  }
}
