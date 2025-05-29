import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import '../main.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'new_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showLogo = false;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    
    // Mostrar logo después de un breve retraso
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _showLogo = true;
      });
    });

    // Mostrar texto después del logo
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _showText = true;
      });
    });

    // Navegar a la pantalla de login después de 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => const NewLoginScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.navyBlue : AppColors.primaryLightBlue,
      body: Stack(
        children: [
          // Fondo con ondas
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(
                animationValue: _controller.value,
                isDarkMode: isDarkMode,
              ),
            ),
          ),
          
          // Contenido centrado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo animado
                _showLogo 
                  ? FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: ZoomIn(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/Logo1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(height: 160),
                
                const SizedBox(height: 30),
                
                // Texto animado
                _showText 
                  ? FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Fish Monitor',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 32),
                
                const SizedBox(height: 10),
                
                // Subtítulo
                _showText 
                  ? FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        'Control de salmoneras',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(height: 18),
                
                const SizedBox(height: 40),
                
                // Indicador de carga
                _showText 
                  ? FadeIn(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Cargando...',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.1,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(height: 52),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Painter personalizado para dibujar ondas
class WavePainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;
  
  WavePainter({required this.animationValue, this.isDarkMode = false});
  
  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = isDarkMode ? AppColors.navyBlue : AppColors.primaryLightBlue;
    final accentColor = isDarkMode ? AppColors.deepBlue : AppColors.primaryMediumBlue;
    final highlightColor = isDarkMode ? AppColors.primaryMediumBlue : AppColors.primaryExtraLightBlue;
    
    // Fondo con gradiente
    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          baseColor,
          accentColor,
        ],
      ).createShader(gradientRect);
    
    canvas.drawRect(gradientRect, backgroundPaint);
    
    // Dibujar ondas
    _drawWave(
      canvas, 
      size, 
      animationValue, 
      highlightColor.withOpacity(0.3), 
      0.75, 
      15.0,
      1.5
    );
    
    _drawWave(
      canvas, 
      size, 
      animationValue + 0.25, 
      accentColor.withOpacity(0.2), 
      0.85, 
      20.0,
      1.2
    );
    
    _drawWave(
      canvas, 
      size, 
      animationValue + 0.5, 
      Colors.white.withOpacity(0.1), 
      0.95, 
      25.0,
      1.0
    );
  }
  
  void _drawWave(Canvas canvas, Size size, double value, Color color, double heightFactor, double amplitude, double frequency) {
    final Paint wavePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    
    path.moveTo(0, size.height * heightFactor);
    
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(
        i, 
        size.height * heightFactor + 
          amplitude * 
          math.sin((value * 2 * math.pi) + (i / size.width) * frequency * math.pi)
      );
    }
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, wavePaint);
  }
  
  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
} 