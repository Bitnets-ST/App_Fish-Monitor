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
      {
        'name': 'Sala 1',
        'cameras': [
          {'id': 'C1', 'name': 'Cámara 1', 'status': 'good', 'lastUpdate': '2 min'},
          {'id': 'C2', 'name': 'Cámara 2', 'status': 'warning', 'lastUpdate': '5 min'},
        ],
        'status': 'Activa'
      },
      {
        'name': 'Sala 2',
        'cameras': [
          {'id': 'C3', 'name': 'Cámara 1', 'status': 'good', 'lastUpdate': '1 min'},
          {'id': 'C4', 'name': 'Cámara 2', 'status': 'good', 'lastUpdate': '1 min'},
          {'id': 'C5', 'name': 'Cámara 3', 'status': 'error', 'lastUpdate': '10 min'},
        ],
        'status': 'Activa'
      },
      {
        'name': 'Sala 3',
        'cameras': [
          {'id': 'C6', 'name': 'Cámara 1', 'status': 'warning', 'lastUpdate': '8 min'},
          {'id': 'C7', 'name': 'Cámara 2', 'status': 'error', 'lastUpdate': '15 min'},
        ],
        'status': 'Inactiva'
      },
    ],
    'Calabozo': [
      {
        'name': 'Sala 1',
        'cameras': [
          {'id': 'C8', 'name': 'Cámara 1', 'status': 'good', 'lastUpdate': '1 min'},
          {'id': 'C9', 'name': 'Cámara 2', 'status': 'good', 'lastUpdate': '1 min'},
        ],
        'status': 'Activa'
      },
      {
        'name': 'Sala 2',
        'cameras': [
          {'id': 'C10', 'name': 'Cámara 1', 'status': 'warning', 'lastUpdate': '7 min'},
          {'id': 'C11', 'name': 'Cámara 2', 'status': 'good', 'lastUpdate': '2 min'},
        ],
        'status': 'Activa'
      },
    ],
    'Trainel': [
      {
        'name': 'Sala 1',
        'cameras': [
          {'id': 'C12', 'name': 'Cámara 1', 'status': 'good', 'lastUpdate': '1 min'},
          {'id': 'C13', 'name': 'Cámara 2', 'status': 'good', 'lastUpdate': '1 min'},
        ],
        'status': 'Activa'
      },
      {
        'name': 'Sala 2',
        'cameras': [
          {'id': 'C14', 'name': 'Cámara 1', 'status': 'good', 'lastUpdate': '1 min'},
          {'id': 'C15', 'name': 'Cámara 2', 'status': 'warning', 'lastUpdate': '6 min'},
        ],
        'status': 'Activa'
      },
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
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

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
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Cámaras',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Central Selection
              Container(
                margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _centrals.map((central) {
                    final isSelected = _centrals.indexOf(central) == _tabController.index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _tabController.animateTo(_centrals.indexOf(central));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF42A5F5),
                                      Color(0xFF2E86AB),
                                    ],
                                  )
                                : null,
                            color: isSelected ? null : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                central,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: Colors.white.withOpacity(isSelected ? 1 : 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
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
      padding: const EdgeInsets.all(12),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1B4F72).withOpacity(0.1),
                const Color(0xFF2E86AB).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _showRoomCameras(context, room);
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F4C75).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.videocam,
                            color: Color(0xFF0F4C75),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room['name'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F4C75),
                                ),
                              ),
                              const SizedBox(height: 2),
                      Text(
                                '${(room['cameras'] as List).length} Cámaras • ${room['status']}',
                        style: TextStyle(
                          fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: room['status'] == 'Activa'
                                ? const Color(0xFF4CAF50).withOpacity(0.1)
                                : const Color(0xFFE74C3C).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            room['status'],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: room['status'] == 'Activa'
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFE74C3C),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ...(room['cameras'] as List).map((camera) {
                          Color statusColor;
                          switch (camera['status']) {
                            case 'good':
                              statusColor = const Color(0xFF4CAF50);
                              break;
                            case 'warning':
                              statusColor = const Color(0xFFFFA726);
                              break;
                            case 'error':
                              statusColor = const Color(0xFFE74C3C);
                              break;
                            default:
                              statusColor = Colors.grey;
                          }
                          return Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  camera['name'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: statusColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
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

  void _showRoomCameras(BuildContext context, Map<String, dynamic> room) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.videocam,
                    color: Color(0xFF0F4C75),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    room['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F4C75),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 16 / 9,
                ),
                itemCount: (room['cameras'] as List).length,
                itemBuilder: (context, index) {
                  final camera = room['cameras'][index];
                  Color statusColor;
                  String statusText;
                  switch (camera['status']) {
                    case 'good':
                      statusColor = const Color(0xFF4CAF50);
                      statusText = 'Óptimo';
                      break;
                    case 'warning':
                      statusColor = const Color(0xFFF57C00);
                      statusText = 'Atención';
                      break;
                    case 'error':
                      statusColor = const Color(0xFFE74C3C);
                      statusText = 'Error';
                      break;
                    default:
                      statusColor = Colors.grey;
                      statusText = 'Desconocido';
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.videocam,
                                size: 32,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      camera['name'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0F4C75),
                                      ),
                                    ),
                                    Text(
                                      '$statusText • ${camera['lastUpdate']}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 