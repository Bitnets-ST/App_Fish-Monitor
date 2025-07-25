import 'package:flutter/material.dart';
import 'sala_detail_screen.dart';

class CentralesScreen extends StatefulWidget {
  const CentralesScreen({super.key});

  @override
  State<CentralesScreen> createState() => _CentralesScreenState();
}

class _CentralesScreenState extends State<CentralesScreen> with SingleTickerProviderStateMixin {
  String _selectedCentral = 'Copihue';
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Map<String, Map<String, dynamic>> _centralesData = {
    'Copihue': {
      'name': 'Copihue',
      'color': const Color(0xFF00B4D8), // Azul principal
      'salas': [
        {'name': 'Sala 1', 'status': 'active'},
        {'name': 'Sala 2', 'status': 'active'},
      ]
    },
    'Calabozo': {
      'name': 'Calabozo',
      'color': const Color(0xFF0077B6), // Azul medio
      'salas': [
        {'name': 'Sala A', 'status': 'active'},
        {'name': 'Sala B', 'status': 'active'},
      ]
    },
    'Trainel': {
      'name': 'Trainel',
      'color': const Color(0xFF0096C7), // Azul claro
      'salas': [
        {'name': 'Sala Norte', 'status': 'active'},
        {'name': 'Sala Sur', 'status': 'active'},
      ]
    },
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(isSmallScreen),
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FA),
                child: ListView(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  children: [
                    Text(
                      'Central ${_centralesData[_selectedCentral]!['name']}',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 20),
                    ...(_centralesData[_selectedCentral]!['salas'] as List).map((sala) {
                      return _buildSalaCard(context, sala, isSmallScreen);
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      color: const Color(0xFF0F4C75),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: isSmallScreen ? 32 : 40,
                height: isSmallScreen ? 32 : 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/Logo1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: isSmallScreen ? 8 : 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Centrales',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallScreen ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Monitoreo de Estaciones',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _centralesData.keys.map((central) {
                final isSelected = central == _selectedCentral;
                final centralColor = _centralesData[central]!['color'] as Color;
                return Padding(
                  padding: EdgeInsets.only(right: isSmallScreen ? 6 : 8),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCentral = central;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? centralColor : Colors.white.withOpacity(0.1),
                      foregroundColor: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 16 : 20,
                        vertical: isSmallScreen ? 8 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: isSelected ? 4 : 0,
                    ),
                    child: Text(
                      central,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaCard(BuildContext context, Map<String, dynamic> sala, bool isSmallScreen) {
    // Datos de ejemplo para los estanques
    final List<Map<String, dynamic>> estanques = [
      {'temp': '22.5°C', 'o2': '7.2', 'ph': '6.8', 'status': 'good'},
      {'temp': '23.1°C', 'o2': '6.8', 'ph': '7.1', 'status': 'warning'},
      {'temp': '22.8°C', 'o2': '7.5', 'ph': '7.0', 'status': 'good'},
    ];

    // Lista de colores en tonos azules
    final List<Color> borderColors = [
      const Color(0xFF00B4D8), // Azul principal
      const Color(0xFF0077B6), // Azul medio
      const Color(0xFF0096C7), // Azul claro
      const Color(0xFF023E8A), // Azul oscuro
      const Color(0xFF48CAE4), // Azul cielo
      const Color(0xFF90E0EF), // Azul pastel
    ];

    // Seleccionar un color aleatorio para el borde
    final Color borderColor = borderColors[sala['name'].hashCode % borderColors.length];

    // Gradientes en tonos azules para cada color
    final Map<Color, List<Color>> colorGradients = {
      const Color(0xFF00B4D8): [
        const Color(0xFF00B4D8),
        const Color(0xFF48CAE4),
        const Color(0xFF90E0EF),
      ],
      const Color(0xFF0077B6): [
        const Color(0xFF0077B6),
        const Color(0xFF0096C7),
        const Color(0xFF00B4D8),
      ],
      const Color(0xFF0096C7): [
        const Color(0xFF0096C7),
        const Color(0xFF00B4D8),
        const Color(0xFF48CAE4),
      ],
      const Color(0xFF023E8A): [
        const Color(0xFF023E8A),
        const Color(0xFF0077B6),
        const Color(0xFF0096C7),
      ],
      const Color(0xFF48CAE4): [
        const Color(0xFF48CAE4),
        const Color(0xFF90E0EF),
        const Color(0xFFCAF0F8),
      ],
      const Color(0xFF90E0EF): [
        const Color(0xFF90E0EF),
        const Color(0xFFCAF0F8),
        const Color(0xFFE0F7FF),
      ],
    };

    final List<Color> gradientColors = colorGradients[borderColor] ?? [
      borderColor,
      borderColor.withOpacity(0.7),
      borderColor.withOpacity(0.4),
    ];

    int totalEstanques = estanques.length;
    int estanquesActivos = estanques.where((e) => e['status'] == 'good').length;
    int estanquesWarning = estanques.where((e) => e['status'] == 'warning').length;
    int estanquesCritical = estanques.where((e) => e['status'] == 'critical').length;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalaDetailScreen(
              centralName: _centralesData[_selectedCentral]!['name'],
              salaData: sala,
            ),
          ),
        );
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors.map((color) => 
                  color.withOpacity(0.8 + (_animation.value * 0.2))
                ).toList(),
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: borderColor.withOpacity(0.3 + (_animation.value * 0.2)),
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                      decoration: BoxDecoration(
                        color: borderColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            sala['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 12,
                              vertical: isSmallScreen ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              sala['status'] == 'active' ? 'ACTIVO' : 'INACTIVO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 10 : 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Resumen de Estanques',
                            style: TextStyle(
                              color: const Color(0xFF1F2937),
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 12),
                          Wrap(
                            spacing: isSmallScreen ? 8 : 12,
                            runSpacing: isSmallScreen ? 8 : 12,
                            children: [
                              _buildInfoCard(
                                'Total',
                                totalEstanques.toString(),
                                Icons.water,
                                const Color(0xFF0F4C75),
                                isSmallScreen,
                              ),
                              _buildInfoCard(
                                'Activos',
                                estanquesActivos.toString(),
                                Icons.check_circle,
                                const Color(0xFF22C55E),
                                isSmallScreen,
                              ),
                              _buildInfoCard(
                                'Atención',
                                estanquesWarning.toString(),
                                Icons.warning,
                                const Color(0xFFF97316),
                                isSmallScreen,
                              ),
                              _buildInfoCard(
                                'Críticos',
                                estanquesCritical.toString(),
                                Icons.error,
                                const Color(0xFFEF4444),
                                isSmallScreen,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon, Color color, bool isSmallScreen) {
    return Container(
      width: isSmallScreen ? 70 : 80,
      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: isSmallScreen ? 16 : 20),
          SizedBox(height: isSmallScreen ? 4 : 6),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isSmallScreen ? 10 : 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}