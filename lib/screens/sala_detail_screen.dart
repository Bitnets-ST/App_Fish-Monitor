import 'package:flutter/material.dart';
import 'estanque_detail_screen.dart';

class SalaDetailScreen extends StatefulWidget {
  final String centralName;
  final Map<String, dynamic> salaData;

  const SalaDetailScreen({
    super.key,
    required this.centralName,
    required this.salaData,
  });

  @override
  State<SalaDetailScreen> createState() => _SalaDetailScreenState();
}

class _SalaDetailScreenState extends State<SalaDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F4C75), Color(0xFF3282B8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(
        left: isSmallScreen ? 12 : 20,
        right: isSmallScreen ? 12 : 20,
        top: isSmallScreen ? 20 : 32,
        bottom: isSmallScreen ? 20 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 12 : 16,
                    horizontal: isSmallScreen ? 16 : 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(Icons.home_rounded, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.salaData['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.greenAccent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    widget.centralName,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstanquesList(BuildContext context, bool isSmallScreen) {
    final List<Map<String, dynamic>> estanques = [
      {
        'number': 1,
        'temp': '22.5°C',
        'o2': '7.2',
        'ph': '6.8',
        'status': 'good',
      },
      {
        'number': 2,
        'temp': '23.1°C',
        'o2': '6.8',
        'ph': '7.1',
        'status': 'warning',
      },
      {
        'number': 3,
        'temp': '22.8°C',
        'o2': '7.5',
        'ph': '7.0',
        'status': 'good',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F4C75).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.pool_rounded, color: Color(0xFF0F4C75)),
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.95,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: estanques.length,
          itemBuilder: (context, index) {
            final estanque = estanques[index];
            return _buildEstanqueCard(context, estanque, isSmallScreen);
          },
        ),
      ],
    );
  }

  Widget _buildEstanqueCard(BuildContext context, Map<String, dynamic> estanque, bool isSmallScreen) {
    Color statusColor;
    String statusText;
    IconData statusIcon;
    switch (estanque['status']) {
      case 'good':
        statusColor = const Color(0xFF22C55E);
        statusText = 'NORMAL';
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'warning':
        statusColor = const Color(0xFFF97316);
        statusText = 'ATENCIÓN';
        statusIcon = Icons.warning_amber_rounded;
        break;
      default:
        statusColor = const Color(0xFFEF4444);
        statusText = 'CRÍTICO';
        statusIcon = Icons.error_rounded;
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EstanqueDetailScreen(
                  centralName: widget.centralName,
                  salaName: widget.salaData['name'],
                  estanqueNumber: estanque['number'],
                  estanqueData: estanque,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: statusColor.withOpacity(0.25), width: 2),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.water_drop_rounded, size: 18, color: Color(0xFF0F4C75)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Estanque ${estanque['number']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF374151),
                          fontSize: isSmallScreen ? 14 : 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(statusIcon, color: statusColor, size: 18),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.thermostat, color: const Color(0xFFF97316), size: 16),
                    const SizedBox(width: 4),
                    Text(estanque['temp'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.air, color: const Color(0xFF0F4C75), size: 16),
                    const SizedBox(width: 4),
                    Text('${estanque['o2']} mg/L', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.science, color: const Color(0xFF7C3AED), size: 16),
                    const SizedBox(width: 4),
                    Text(estanque['ph'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
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