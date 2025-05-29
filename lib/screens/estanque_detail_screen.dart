import 'package:flutter/material.dart';

class EstanqueDetailScreen extends StatelessWidget {
  final String centralName;
  final String salaName;
  final int estanqueNumber;
  final Map<String, dynamic> estanqueData;

  const EstanqueDetailScreen({
    super.key,
    required this.centralName,
    required this.salaName,
    required this.estanqueNumber,
    required this.estanqueData,
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
                  _buildAlertSystem(isSmallScreen),
                  _buildCameraSection(isSmallScreen),
                  _buildWaterParameters(isSmallScreen),
                  _buildChemicalAnalysis(isSmallScreen),
                  _buildFishInfo(isSmallScreen),
                  _buildActionButtons(context, isSmallScreen),
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
            'Estanque $estanqueNumber',
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
                '$centralName • $salaName',
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

  Widget _buildAlertSystem(bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.warning, color: Color(0xFFEF4444)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Sistema de Alertas',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            _buildAlertItem(
              'Temperatura',
              '24.5°C',
              'Alta',
              const Color(0xFFF97316),
              isSmallScreen,
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildAlertItem(
              'Oxígeno',
              '6.8 mg/L',
              'Normal',
              const Color(0xFF22C55E),
              isSmallScreen,
            ),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildAlertItem(
              'pH',
              '7.2',
              'Normal',
              const Color(0xFF22C55E),
              isSmallScreen,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(String label, String value, String status, Color statusColor, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8 : 12,
              vertical: isSmallScreen ? 4 : 6,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraSection(bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F4C75).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.videocam, color: Color(0xFF0F4C75)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Cámara de Monitoreo',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            Container(
              width: double.infinity,
              height: isSmallScreen ? 140 : 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0F4C75).withOpacity(0.3)),
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
                  Icon(
                    Icons.videocam_rounded,
                    color: const Color(0xFF0F4C75),
                    size: isSmallScreen ? 48 : 64,
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  Text(
                    'Vista general del estanque',
                    style: TextStyle(
                      color: const Color(0xFF1F2937),
                      fontSize: isSmallScreen ? 13 : 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cámara en vivo',
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: isSmallScreen ? 11 : 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterParameters(bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
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
                  'Parámetros del Agua',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            Wrap(
              spacing: isSmallScreen ? 8 : 12,
              runSpacing: isSmallScreen ? 8 : 12,
              children: [
                _buildParameterCard(
                  'Temperatura',
                  '24.5°C',
                  Icons.thermostat,
                  const Color(0xFFF97316),
                  isSmallScreen,
                ),
                _buildParameterCard(
                  'Oxígeno',
                  '6.8 mg/L',
                  Icons.air,
                  const Color(0xFF0F4C75),
                  isSmallScreen,
                ),
                _buildParameterCard(
                  'pH',
                  '7.2',
                  Icons.science,
                  const Color(0xFF7C3AED),
                  isSmallScreen,
                ),
                _buildParameterCard(
                  'Turbidez',
                  '2.1 NTU',
                  Icons.blur_on,
                  const Color(0xFF22C55E),
                  isSmallScreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterCard(String label, String value, IconData icon, Color color, bool isSmallScreen) {
    return Container(
      width: isSmallScreen ? 140 : 160,
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: isSmallScreen ? 20 : 24),
          SizedBox(height: isSmallScreen ? 6 : 8),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isSmallScreen ? 18 : 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isSmallScreen ? 11 : 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChemicalAnalysis(bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.science, color: Color(0xFF7C3AED)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Análisis Químico',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            _buildChemicalItem('Amonio', '0.5 mg/L', 'Normal', const Color(0xFF22C55E), isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildChemicalItem('Nitritos', '0.1 mg/L', 'Normal', const Color(0xFF22C55E), isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildChemicalItem('Nitratos', '5.0 mg/L', 'Normal', const Color(0xFF22C55E), isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildChemicalItem(String label, String value, String status, Color statusColor, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: isSmallScreen ? 12 : 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: isSmallScreen ? 16 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8 : 12,
              vertical: isSmallScreen ? 4 : 6,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFishInfo(bool isSmallScreen) {
    return Card(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 16 : 24),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.pets, color: Color(0xFF22C55E)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Información de Peces',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmallScreen ? 16 : 20),
            _buildFishItem('Especie', 'Trucha Arcoíris', isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildFishItem('Cantidad', '1,500', isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildFishItem('Peso Promedio', '250g', isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 16),
            _buildFishItem('Edad', '6 meses', isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildFishItem(String label, String value, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF0F4C75).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isSmallScreen) {
    return Wrap(
      spacing: isSmallScreen ? 8 : 12,
      runSpacing: isSmallScreen ? 8 : 12,
      children: [
        _buildActionButton(
          'Alimentar',
          Icons.restaurant,
          const Color(0xFF0F4C75),
          () {},
          isSmallScreen,
        ),
        _buildActionButton(
          'Limpiar',
          Icons.cleaning_services,
          const Color(0xFF22C55E),
          () {},
          isSmallScreen,
        ),
        _buildActionButton(
          'Reporte',
          Icons.assessment,
          const Color(0xFF7C3AED),
          () {},
          isSmallScreen,
        ),
        _buildActionButton(
          'Configurar',
          Icons.settings,
          const Color(0xFFF97316),
          () {},
          isSmallScreen,
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onPressed, bool isSmallScreen) {
    return Container(
      width: isSmallScreen ? 140 : 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Column(
              children: [
                Icon(icon, color: color, size: isSmallScreen ? 24 : 32),
                SizedBox(height: isSmallScreen ? 8 : 12),
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 