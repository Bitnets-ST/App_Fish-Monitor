import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math' as math;
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  late AnimationController _animationController;
  late AnimationController _circleController;
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    // Inicializa el video
    _videoController = VideoPlayerController.asset('assets/videos/splash.mp4')
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print(email);
    print(password);

    final url = Uri.parse('https://backendmongodb-production.up.railway.app/api/user');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('Respuesta del servidor: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userName = data['email']; // Ajusta si backend devuelve 'email'

        print(userName);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bienvenido, $userName')),
        );

        // Navega al Dashboard
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credenciales inválidas')),
        );
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de red')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    _circleController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video de fondo
          if (_videoController.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            ),
          // Gradiente azul marino encima del video
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xCC0A2342), // azul marino oscuro con opacidad 80%
                  Color(0xCC193660), // azul marino medio con opacidad 80%
                  Color(0xCC274472), // azul marino claro con opacidad 80%
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Formulario y logo
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo con aura animada
                    Center(
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 800),
                        child: AnimatedBuilder(
                          animation: _circleController,
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.rotate(
                                  angle: _circleController.value * 2 * math.pi,
                                  child: CustomPaint(
                                    size: const Size(120, 120),
                                    painter: NeonCirclePainter(),
                                  ),
                                ),
                                Transform.scale(
                                  scale: 1.0 +
                                      (math.sin(_animationController.value *
                                              math.pi *
                                              2) *
                                          0.03),
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFE94CEB)
                                              .withOpacity(0.2),
                                          blurRadius: 15,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/Logo1.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    const SizedBox(height: 16),
                    // Campo de usuario
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Usuario',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Campo de contraseña
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[100],
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (v) {
                            setState(() {
                              _rememberMe = v ?? false;
                            });
                          },
                        ),
                        const Text('Recuérdame'),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('¿Olvidaste tu contraseña?',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A90E2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('INGRESAR',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Copyright de Bitnets
                    const Text(
                      '© 2025 Bitnets. Todos los derechos reservados.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NeonCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final sweepGradient = SweepGradient(
      startAngle: 0.0,
      endAngle: math.pi * 2,
      colors: [
        const Color(0xFFE94CEB), // rosa
        const Color(0xFF00C6FB), // celeste claro
        const Color(0xFF005BEA), // azul intenso
        const Color(0xFF00E1FF), // cian
        const Color(0xFFE94CEB), // rosa
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final paint = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 3);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 2,
      paint,
    );

    // Círculo exterior difuso
    final paintGlow = Paint()
      ..shader = sweepGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 8);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 2,
      paintGlow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 