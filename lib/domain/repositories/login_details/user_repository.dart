abstract class UserRepository {
  Future getUser();
  Future updateProfile(String name, String email, String currPass,
      String newPass, String conPass, String image);
}
