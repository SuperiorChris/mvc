// controllers/login_controller.dart
import '../models/user_model.dart';  // Asegúrate de que esta línea esté presente

class LoginController {
  static Future<bool> login(User user) async {
    // Aquí agregas tu lógica de autenticación, por ejemplo:
    // Verificar el usuario en la base de datos, etc.
    if (user.email == 'test@example.com' && user.password == 'password123') {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}