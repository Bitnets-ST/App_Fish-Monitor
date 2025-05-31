import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CentralStatisticsScreen extends StatefulWidget {
  final String centralName;

  const CentralStatisticsScreen({
    super.key,
    required this.centralName,
  });

  @override
  State<CentralStatisticsScreen> createState() => _CentralStatisticsScreenState();
}

class _CentralStatisticsScreenState extends State<CentralStatisticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTimeRange = 0;
  final List<String> _timeRanges = ['Día', 'Semana', 'Mes', 'Año'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.centralName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Análisis Detallado',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        // TODO: Implementar compartir estadísticas
                      },
                    ),
                  ],
                ),
              ),

              // Time Range Selector
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _timeRanges.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTimeRange = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                          color: _selectedTimeRange == index
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            _timeRanges[index],
                            style: TextStyle(
                              color: _selectedTimeRange == index
                                  ? const Color(0xFF0F4C75)
                                  : Colors.white,
                              fontWeight: _selectedTimeRange == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFF0F4C75),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color(0xFF0F4C75),
                        tabs: const [
                          Tab(text: 'Rendimiento'),
                          Tab(text: 'Tendencias'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildPerformanceTab(isSmallScreen),
                            _buildTrendsTab(isSmallScreen),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceTab(bool isSmallScreen) {
    return ListView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      children: [
        _buildEfficiencyChart(isSmallScreen),
        const SizedBox(height: 20),
        _buildOxygenDistributionChart(isSmallScreen),
        const SizedBox(height: 20),
        _buildTemperatureDistributionChart(isSmallScreen),
      ],
    );
  }

  Widget _buildTrendsTab(bool isSmallScreen) {
    return ListView(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      children: [
        _buildOxygenTrendChart(isSmallScreen),
        const SizedBox(height: 20),
        _buildTemperatureTrendChart(isSmallScreen),
        const SizedBox(height: 20),
        _buildFishGrowthChart(isSmallScreen),
      ],
    );
  }

  Widget _buildEfficiencyChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eficiencia General',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F4C75),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: const Color(0xFF4CAF50),
                    value: 40,
                    title: 'Óptimo',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFF42A5F5),
                    value: 30,
                    title: 'Bueno',
                    radius: 45,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFFFFA726),
                    value: 20,
                    title: 'Regular',
                    radius: 40,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    color: const Color(0xFFE74C3C),
                    value: 10,
                    title: 'Mejorar',
                    radius: 35,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOxygenDistributionChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Distribución de Oxígeno',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F4C75),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 5,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const labels = ['Mín', 'Prom', 'Máx'];
                        return Text(
                          labels[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()} ppm',
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF0F4C75).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 2.8,
                        color: const Color(0xFFE74C3C),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 3.5,
                        color: const Color(0xFF42A5F5),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 4.2,
                        color: const Color(0xFF4CAF50),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
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
    );
  }

  Widget _buildTemperatureDistributionChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Distribución de Temperatura',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F4C75),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF0F4C75).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}°C',
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 22),
                      FlSpot(1, 23),
                      FlSpot(2, 22.5),
                      FlSpot(3, 23.5),
                      FlSpot(4, 22.8),
                      FlSpot(5, 23.2),
                      FlSpot(6, 22.9),
                    ],
                    isCurved: true,
                    color: const Color(0xFFFFA726),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFFFA726).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFishGrowthChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Crecimiento de Peces',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4C75),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Crecimiento Normal',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF0F4C75).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'];
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()} cm',
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 5),
                      FlSpot(1, 7),
                      FlSpot(2, 9),
                      FlSpot(3, 11),
                      FlSpot(4, 13),
                      FlSpot(5, 15),
                    ],
                    isCurved: true,
                    color: const Color(0xFF4CAF50),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Calcular la tasa de crecimiento
                        double growthRate = index > 0 ? spot.y - barData.spots[index - 1].y : 0;
                        if (growthRate < 1.5) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: const Color(0xFFFFA726),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF4CAF50),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color(0xFF0F4C75),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        String status = '';
                        if (spot.y < 7) {
                          status = '\n⚠️ Crecimiento lento';
                        } else if (spot.y > 13) {
                          status = '\n✅ Crecimiento óptimo';
                        } else {
                          status = '\n📈 Crecimiento normal';
                        }
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)} cm$status',
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAlertItem(
                  'Febrero - 7 cm',
                  'Crecimiento más lento de lo esperado',
                  const Color(0xFFFFA726),
                ),
                const SizedBox(height: 8),
                _buildAlertItem(
                  'Mayo - 13 cm',
                  'Crecimiento óptimo alcanzado',
                  const Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOxygenTrendChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tendencia de Oxígeno',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4C75),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE74C3C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  '2 Alertas',
                  style: TextStyle(
                    color: Color(0xFFE74C3C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF0F4C75).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toStringAsFixed(1)} ppm',
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3.2),
                      FlSpot(1, 3.5),
                      FlSpot(2, 2.8), // Punto de alerta
                      FlSpot(3, 3.8),
                      FlSpot(4, 3.4),
                      FlSpot(5, 2.9), // Punto de alerta
                      FlSpot(6, 3.3),
                    ],
                    isCurved: true,
                    color: const Color(0xFF42A5F5),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        // Personalizar puntos según el valor
                        if (spot.y < 3.0) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: const Color(0xFFE74C3C),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFF42A5F5),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF42A5F5).withOpacity(0.1),
                      spotsLine: BarAreaSpotsLine(
                        show: true,
                        flLineStyle: FlLine(
                          color: const Color(0xFFE74C3C),
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                        checkToShowSpotLine: (spot) => spot.y < 3.0,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color(0xFF0F4C75),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        String status = '';
                        if (spot.y < 3.0) {
                          status = '\n⚠️ Nivel crítico';
                        } else if (spot.y > 4.0) {
                          status = '\n✅ Nivel óptimo';
                        }
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)} ppm$status',
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAlertItem(
                  'Miércoles - 2.8 ppm',
                  'Nivel de oxígeno bajo detectado',
                  const Color(0xFFE74C3C),
                ),
                const SizedBox(height: 8),
                _buildAlertItem(
                  'Sábado - 2.9 ppm',
                  'Nivel de oxígeno bajo detectado',
                  const Color(0xFFE74C3C),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(String title, String description, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTemperatureTrendChart(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tendencia de Temperatura',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4C75),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFA726).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  '1 Alerta',
                  style: TextStyle(
                    color: Color(0xFFFFA726),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xFF0F4C75).withOpacity(0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}°C',
                          style: const TextStyle(
                            color: Color(0xFF0F4C75),
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 22),
                      FlSpot(1, 23),
                      FlSpot(2, 22.5),
                      FlSpot(3, 24.5), // Punto de alerta
                      FlSpot(4, 22.8),
                      FlSpot(5, 23.2),
                      FlSpot(6, 22.9),
                    ],
                    isCurved: true,
                    color: const Color(0xFFFFA726),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        if (spot.y > 24.0) {
                          return FlDotCirclePainter(
                            radius: 6,
                            color: const Color(0xFFE74C3C),
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        }
                        return FlDotCirclePainter(
                          radius: 4,
                          color: const Color(0xFFFFA726),
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFFFA726).withOpacity(0.1),
                      spotsLine: BarAreaSpotsLine(
                        show: true,
                        flLineStyle: FlLine(
                          color: const Color(0xFFE74C3C),
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                        checkToShowSpotLine: (spot) => spot.y > 24.0,
                      ),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color(0xFF0F4C75),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((spot) {
                        String status = '';
                        if (spot.y > 24.0) {
                          status = '\n⚠️ Temperatura elevada';
                        } else if (spot.y < 22.0) {
                          status = '\n⚠️ Temperatura baja';
                        } else {
                          status = '\n✅ Temperatura óptima';
                        }
                        return LineTooltipItem(
                          '${spot.y.toStringAsFixed(1)}°C$status',
                          const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildAlertItem(
              'Jueves - 24.5°C',
              'Temperatura elevada detectada',
              const Color(0xFFE74C3C),
            ),
          ),
        ],
      ),
    );
  }
} 