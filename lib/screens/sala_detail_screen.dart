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

    // Datos de ejemplo para los estanques
    final List<Map<String, dynamic>> estanques = [
      {'temp': '22.5°C', 'o2': '7.2', 'ph': '6.8', 'status': 'good'},
      {'temp': '23.1°C', 'o2': '6.8', 'ph': '7.1', 'status': 'warning'},
      {'temp': '22.8°C', 'o2': '7.5', 'ph': '7.0', 'status': 'good'},
    ];

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
                  _buildEstanquesGrid(context, estanques, isSmallScreen),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
      color: const Color(0xFF0F4C75),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          Text(
            salaData['name'],
            style: TextStyle(
              fontSize: isSmallScreen ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$centralName • En línea',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstanquesGrid(BuildContext context, List<Map<String, dynamic>> estanques, bool isSmallScreen) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 400 ? 1 : 2;
    final childAspectRatio = screenWidth < 400 ? 2.8 : 1.6;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            child: Row(
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
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              isSmallScreen ? 16 : 20,
              0,
              isSmallScreen ? 16 : 20,
              isSmallScreen ? 16 : 20,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: isSmallScreen ? 8 : 12,
                mainAxisSpacing: isSmallScreen ? 8 : 12,
              ),
              itemCount: estanques.length,
              itemBuilder: (context, index) {
                final estanque = estanques[index];
                return _buildEstanqueCard(context, estanque, index + 1, isSmallScreen);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstanqueCard(BuildContext context, Map<String, dynamic> estanque, int numero, bool isSmallScreen) {
    final status = estanque['status'] as String;
    Color statusColor;
    String statusText;

    switch (status) {
      case 'good':
        statusColor = const Color(0xFF22C55E);
        statusText = 'GOOD';
        break;
      case 'warning':
        statusColor = const Color(0xFFF97316);
        statusText = 'WARNING';
        break;
      case 'critical':
        statusColor = const Color(0xFFEF4444);
        statusText = 'CRITICAL';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'UNKNOWN';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EstanqueDetailScreen(
              centralName: centralName,
              salaName: salaData['name'],
              estanqueNumber: numero,
              estanqueData: estanque,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: statusColor.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isSmallScreen ? 12 : 16),
                  child: Text(
                    'Estanque $numero',
                    style: TextStyle(
                      color: const Color(0xFF1F2937),
                      fontSize: isSmallScreen ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 6 : 8,
                    vertical: isSmallScreen ? 3 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: isSmallScreen ? 10 : 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 8 : 12),
            _buildParameterRow('🌡', 'Temp', estanque['temp'], isSmallScreen),
            _buildParameterRow('💨', 'O₂', estanque['o2'], isSmallScreen),
            _buildParameterRow('⚗', 'pH', estanque['ph'], isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterRow(String icon, String label, String value, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 1 : 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(icon, style: TextStyle(fontSize: isSmallScreen ? 12 : 14)),
              SizedBox(width: isSmallScreen ? 2 : 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 11 : 12,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isSmallScreen ? 11 : 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }
} 