import 'package:flutter/material.dart';
import 'estanque_detail_screen.dart';

class SalaDetailScreen extends StatelessWidget {
  final String centralName;
  final Map<String, dynamic> salaData;

  const SalaDetailScreen({
    super.key,
    required this.centralName,
    required this.salaData,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isSmallScreen),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                children: [
                  _buildEstanquesList(context, isSmallScreen),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F4C75), Color(0xFF3282B8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: EdgeInsets.only(
            left: isSmallScreen ? 8 : 16,
            right: isSmallScreen ? 8 : 16,
            top: isSmallScreen ? 16 : 32,
            bottom: isSmallScreen ? 16 : 24,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 10 : 16,
                    horizontal: isSmallScreen ? 12 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        salaData['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 22 : 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              centralName,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isSmallScreen ? 12 : 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstanquesList(BuildContext context, bool isSmallScreen) {
    // Datos de ejemplo para los estanques
    final List<Map<String, dynamic>> estanques = [
      {
        'number': 1,
        'temp': '22.5°C',
        'o2': '7.2',
        'ph': '6.8',
        'status': 'good',
        'fish': {
          'species': 'Trucha Arcoíris',
          'count': 1500,
          'weight': '250g',
          'age': '6 meses',
        },
      },
      {
        'number': 2,
        'temp': '23.1°C',
        'o2': '6.8',
        'ph': '7.1',
        'status': 'warning',
        'fish': {
          'species': 'Trucha Arcoíris',
          'count': 1200,
          'weight': '280g',
          'age': '7 meses',
        },
      },
      {
        'number': 3,
        'temp': '22.8°C',
        'o2': '7.5',
        'ph': '7.0',
        'status': 'good',
        'fish': {
          'species': 'Trucha Arcoíris',
          'count': 1800,
          'weight': '220g',
          'age': '5 meses',
        },
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F4C75).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.water, color: Color(0xFF0F4C75)),
            ),
            const SizedBox(width: 12),
            Text(
              'Estanques',
              style: TextStyle(
                color: const Color(0xFF1F2937),
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: isSmallScreen ? 16 : 20),
        ...estanques.map((estanque) => _buildEstanqueCard(context, estanque, isSmallScreen)).toList(),
      ],
    );
  }

  Widget _buildEstanqueCard(BuildContext context, Map<String, dynamic> estanque, bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EstanqueDetailScreen(
                centralName: centralName,
                salaName: salaData['name'],
                estanqueNumber: estanque['number'],
                estanqueData: estanque,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estanque ${estanque['number']}',
                    style: TextStyle(
                      color: const Color(0xFF1F2937),
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
                      color: estanque['status'] == 'good'
                          ? const Color(0xFF22C55E).withOpacity(0.1)
                          : const Color(0xFFF97316).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      estanque['status'] == 'good' ? 'NORMAL' : 'ATENCIÓN',
                      style: TextStyle(
                        color: estanque['status'] == 'good'
                            ? const Color(0xFF22C55E)
                            : const Color(0xFFF97316),
                        fontSize: isSmallScreen ? 10 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Row(
                children: [
                  _buildParameter(
                    Icons.thermostat,
                    'Temp',
                    estanque['temp'],
                    const Color(0xFFF97316),
                    isSmallScreen,
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  _buildParameter(
                    Icons.air,
                    'O₂',
                    '${estanque['o2']} mg/L',
                    const Color(0xFF0F4C75),
                    isSmallScreen,
                  ),
                  SizedBox(width: isSmallScreen ? 12 : 16),
                  _buildParameter(
                    Icons.science,
                    'pH',
                    estanque['ph'],
                    const Color(0xFF7C3AED),
                    isSmallScreen,
                  ),
                ],
              ),
              SizedBox(height: isSmallScreen ? 12 : 16),
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F4C75).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF0F4C75).withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.pets,
                      color: Color(0xFF0F4C75),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${estanque['fish']['species']} • ${estanque['fish']['count']} peces',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isSmallScreen ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParameter(IconData icon, String label, String value, Color color, bool isSmallScreen) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 8 : 12,
          horizontal: isSmallScreen ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: isSmallScreen ? 16 : 20),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: isSmallScreen ? 10 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 12 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 