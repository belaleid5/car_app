class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://qent.up.railway.app/api';

  // Auth Endpoints
  static const String registerEndpoint = '$baseUrl/auth/register/';
  static const String loginEndpoint = '$baseUrl/auth/login/';
  static const String refreshTokenEndpoint = '$baseUrl/auth/refresh';
  static const String logoutEndpoint = '$baseUrl/auth/logout';
  static const String forgotPasswordEndpoint = '$baseUrl/auth/forgot_password/';
  static const String resetPasswordEndpoint = '$baseUrl/auth/reset_password/';
  static const String verifyCodePhoneEndpoint =
      '$baseUrl/auth/phone/request_verify_code/';
  static const String confirmCodePhoneEndpoint =
      '$baseUrl/auth/phone/confirm_verify_code/';
  static const String brandsEndpoint = '$baseUrl/brands/';
  static const String bestCarsEndpoint = '$baseUrl/cars/best';
  static const String nearestCarsEndpoint = '$baseUrl/cars/nearest';
  static const String reviewsEndpoint = '$baseUrl/cars/1/reviews';

  ///cars/best/
  static const String locations = '$baseUrl/public/register_locations/';
  static const String search = "$baseUrl/cars/search";

  //cars/nearest

  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
  static const String applicationJson = 'application/json';
  static const String acceptLanguage = 'Accept-Language';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String languageKey = 'language';
  static const String themeKey = 'theme';

  // API Timeouts (in seconds)
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;
}
