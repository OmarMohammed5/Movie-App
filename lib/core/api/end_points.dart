class EndPoints {
  static String baseUrl = "https://food-api-omega.vercel.app/api/v1/";
  static String signIn = "user/signin";
  static String signUp = "user/signup";

  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String name = "name";
  static String email = "email";
  static String errorMessage = "errorMessage";
  static String status = "status";
  static String id = "id";
  static String token = "token";
  static String password = "password";
  static String confirmPassword = "confirmPassword";
  static String message = "message";
  static String profilePic = "profilePic";
  static String location = 'location';
}
