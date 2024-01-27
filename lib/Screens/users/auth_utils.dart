import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
Future<bool> isUserAuthenticated(FlutterSecureStorage secureStorage) async {
  try {
    final jwtToken = await secureStorage.read(key: 'jwt_token');
    if (jwtToken != null) {
      final bool isTokenValid = await isJwtTokenValid(jwtToken);
      return isTokenValid;
    }
    return false;
  } catch (e) {
    // Handle the error, you can log it or return false
    print('Error checking user authentication: $e');
    return false;
  }
}

Future<bool> isJwtTokenValid(String jwtToken) async {
  try {
    // Decode the JWT token to access its header
    final Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
    
    // Check if the "alg" (algorithm) claim in the header is "HS256"
    final String algorithm = decodedToken['alg'] ?? '';
    if (algorithm != 'HS256') {
      return false; // Invalid algorithm
    }

    // Verify JWT token expiration
    final bool isTokenValid = JwtDecoder.isExpired(jwtToken);

    return !isTokenValid;
  } catch (e) {
    // Handle the error, you can log it or return false
    print('Error verifying JWT token: $e');
    return false;
  }
}