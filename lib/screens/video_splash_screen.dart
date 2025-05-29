import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:video_player/video_player.dart';
import '../constants/colors.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'new_login_screen.dart';
import 'dart:math' as math;

class VideoSplashScreen extends StatefulWidget {
  final String videoPath;
  const VideoSplashScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<VideoSplashScreen> createState() => _VideoSplashScreenState();
}

class _VideoSplashScreenState extends State<VideoSplashScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  bool _showLogo = false;
  bool _showText = false;
  bool _isVideoInitialized = false;
  bool _isVideoError = false;
  late AnimationController _pulseAnimation;
  late AnimationController _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animación de pulso para el logo
    _pulseAnimation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // Intentar inicializar el video
    _initializeVideo();
    
    // Secuencia de animación
    _startAnimationSequence();
  }

  void _initializeVideo() {
    try {
      // Inicializar el controlador de video con calidad máxima
      _controller = VideoPlayerController.asset(
        widget.videoPath,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      
      _controller.initialize().then((_) {
        // Asegurarse de que el video se reproduzca en loop y comience automáticamente
        _controller.setLooping(true);
        _controller.setVolume(0.0); // Silenciar el video
        _controller.play();
        
        // Ajustar la velocidad de reproducción para que coincida con la duración deseada
        if (_controller.value.duration.inSeconds < 5) {
          _controller.setPlaybackSpeed(0.5); // Ralentizar más el video
        }
        
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
          });
        }
      }).catchError((error) {
        print("Error al inicializar el video: $error");
        if (mounted) {
          setState(() {
            _isVideoError = true;
          });
        }
      });
    } catch (e) {
      print("Excepción al crear el controlador de video: $e");
      if (mounted) {
        setState(() {
          _isVideoError = true;
        });
      }
    }
  }

  void _startAnimationSequence() {
    // Mostrar logo después de un breve retraso
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showLogo = true;
        });
      }
    });

    // Mostrar texto después del logo
    Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showText = true;
        });
      }
    });

    // Navegar a la pantalla de login después de 7 segundos para dar tiempo a ver el video
    Timer(const Duration(milliseconds: 7000), () {
      if (mounted) {
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
      }
    });
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    _pulseAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video de fondo o fondo animado si el video no está disponible
          _isVideoInitialized && !_isVideoError
              ? Positioned.fill(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF080B2F),
                          Color(0xFF141852),
                          Color(0xFF080B2F),
                        ],
                      ),
                    ),
                    child: CustomPaint(
                      painter: SplashBackgroundPainter(
                        animationValue: _pulseAnimation.value,
                      ),
                    ),
                  ),
                ),
          
          // Overlay de gradiente para mejorar visibilidad del contenido
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.2),
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          
          // Contenido centrado
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animado mejorado
                  _showLogo 
                    ? FadeInDown(
                        duration: const Duration(milliseconds: 800),
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_pulseAnimation.value * 0.05),
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryLightBlue.withOpacity(0.6),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 10),
                                    ),
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 20,
                                      spreadRadius: -5,
                                      offset: const Offset(0, -5),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(25),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/Logo1.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(height: 180),
                  
                  const SizedBox(height: 40),
                  
                  // Texto animado con mejor contraste
                  _showText 
                    ? FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Fish Monitor',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                              Shadow(
                                color: AppColors.primaryLightBlue.withOpacity(0.7),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(height: 36),
                  
                  const SizedBox(height: 12),
                  
                  // Subtítulo con mejor contraste
                  _showText 
                    ? FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Control de salmoneras',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(height: 20),
                  
                  const SizedBox(height: 50),
                  
                  // Indicador de carga mejorado
                  _showText 
                    ? FadeIn(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryLightBlue.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Clase para el fondo animado cuando el video no está disponible
class SplashBackgroundPainter extends CustomPainter {
  final double animationValue;
  
  SplashBackgroundPainter({required this.animationValue});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar rayos láser para el fondo
    _drawLaser(canvas, size, const Color(0xFFA32BDF).withOpacity(0.3), animationValue, math.pi * 0.25);
    _drawLaser(canvas, size, const Color(0xFF5468FF).withOpacity(0.3), animationValue + 0.3, -math.pi * 0.3);
    _drawLaser(canvas, size, const Color(0xFFE94CEB).withOpacity(0.3), animationValue + 0.6, math.pi * 0.15);
    
    // Dibujar partículas brillantes
    _drawParticles(canvas, size);
  }
  
  // Método para dibujar un rayo láser
  void _drawLaser(Canvas canvas, Size size, Color color, double animValue, double angle) {
    final random = math.Random(42);
    final laserPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);
    
    final path = Path();
    
    // Punto de origen
    final startX = size.width * 0.5 + math.cos(angle) * 50;
    final startY = size.height * 0.4 + math.sin(angle) * 50;
    
    path.moveTo(startX, startY);
    
    // Crear curvas para el láser
    final controlPoint1X = startX + math.cos(angle + animValue * math.pi) * size.width * 0.4;
    final controlPoint1Y = startY + math.sin(angle + animValue * math.pi) * size.height * 0.2;
    
    final controlPoint2X = startX + math.cos(angle - animValue * math.pi) * size.width * 0.5;
    final controlPoint2Y = startY + math.sin(angle - animValue * math.pi) * size.height * 0.3;
    
    final endX = startX + math.cos(angle + math.pi * 0.5) * size.width * 0.6;
    final endY = startY + math.sin(angle + math.pi * 0.5) * size.height * 0.6;
    
    path.cubicTo(controlPoint1X, controlPoint1Y, controlPoint2X, controlPoint2Y, endX, endY);
    
    canvas.drawPath(path, laserPaint);
  }
  
  // Método para dibujar partículas brillantes
  void _drawParticles(Canvas canvas, Size size) {
    final random = math.Random(42);
    
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 0.5 + random.nextDouble() * 1.5;
      
      final particlePaint = Paint()
        ..color = Colors.white.withOpacity(0.1 + random.nextDouble() * 0.4)
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius);
      
      final pulseSize = radius * (1.0 + math.sin(animationValue * math.pi * 2 + i) * 0.3);
      
      canvas.drawCircle(Offset(x, y), pulseSize, particlePaint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 