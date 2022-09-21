abstract class AuthRepository {
  Future getAuthToken(String email, String pass);

  Future<bool> isAuthenticated();
}
