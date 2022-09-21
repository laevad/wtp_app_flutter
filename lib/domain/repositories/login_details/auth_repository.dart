abstract class AuthRepository {
  Future getAuthToken(String email, String pass);
}
