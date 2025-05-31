import 'package:flutter/material.dart';
import 'dart:math' as math;

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({super.key});

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _centrals = ['Copihue', 'Calabozo', 'Trainel'];
  final Map<String, List<Map<String, dynamic>>> _roomsByCentral = {
    'Copihue': [
      {'name': 'Sala 1', 'cameras': 2, 'status': 'Activa'},
      {'name': 'Sala 2', 'cameras': 3, 'status': 'Activa'},
      {'name': 'Sala 3', 'cameras': 2, 'status': 'Inactiva'},
    ],
    'Calabozo': [
      {'name': 'Sala 1', 'cameras': 2, 'status': 'Activa'},
      {'name': 'Sala 2', 'cameras': 2, 'status': 'Activa'},
      {'name': 'Sala 3', 'cameras': 1, 'status': 'Inactiva'},
    ],
    'Trainel': [
      {'name': 'Sala 1', 'cameras': 2, 'status': 'Activa'},
      {'name': 'Sala 2', 'cameras': 2, 'status': 'Activa'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _centrals.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F4C75),
              Color(0xFF2E86AB),
              Color(0xFF85C1E9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/Logo1.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.water_drop,
                                color: Color(0xFF0F4C75),
                                size: 24,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Cámaras',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        // TODO: Implementar configuración
                      },
                    ),
                  ],
                ),
              ),

              // Central Selection Tabs
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  tabs: _centrals.map((central) => Tab(text: central)).toList(),
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: _centrals.map((central) {
                      return _buildCentralContent(central, isSmallScreen);
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCentralContent(String central, bool isSmallScreen) {
    final rooms = _roomsByCentral[central] ?? [];
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1B4F72).withOpacity(0.1),
                const Color(0xFF2E86AB).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // TODO: Implementar vista de cámaras de la sala
              },
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F4C75).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.videocam,
                        color: Color(0xFF0F4C75),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F4C75),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${room['cameras']} Cámaras • ${room['status']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: room['status'] == 'Activa'
                            ? const Color(0xFF4CAF50).withOpacity(0.1)
                            : const Color(0xFFE74C3C).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        room['status'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: room['status'] == 'Activa'
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFE74C3C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 