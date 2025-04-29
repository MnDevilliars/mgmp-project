import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../components/my_card_button.dart';
import '../../handler/request_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final RequestHandler requestHandler = RequestHandler();
  int eventCount = 0;
  int managerCount = 0;
  int artistCount = 0;
  bool isLoading = true;
  String selectedChart = 'Pie';

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    setState(() => isLoading = true);

    try {
      final data = await requestHandler.dashboardPageData();
      if (data != null) {
        setState(() {
          eventCount = data[0]['totalEvents'] ?? 0;
          managerCount = data[0]['totalEventManagers'] ?? 0;
          artistCount = data[0]['totalArtists'] ?? 0;
        });
      }
    } catch (e) {
      debugPrint("Error fetching dashboard data: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildPieChart() {
    final total = eventCount + managerCount + artistCount;

    double toPercentage(int count) => total == 0 ? 0 : (count / total) * 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 80,
                  sections: [
                    PieChartSectionData(
                      value: eventCount.toDouble(),
                      color: Colors.blue,
                      radius: 35,
                      title: '${toPercentage(eventCount).toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: managerCount.toDouble(),
                      color: Colors.green,
                      radius: 35,
                      title:
                          '${toPercentage(managerCount).toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: artistCount.toDouble(),
                      color: Colors.orange,
                      radius: 35,
                      title: '${toPercentage(artistCount).toStringAsFixed(1)}%',
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(Colors.blue, "Events", eventCount),
                const SizedBox(height: 10),
                _buildLegendItem(Colors.green, "Managers", managerCount),
                const SizedBox(height: 10),
                _buildLegendItem(Colors.orange, "Artists", artistCount),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, int count) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: $count',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget buildBarChart() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine:
                        (value) =>
                            FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget:
                            (value, meta) => Text(
                              value.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Events',
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            case 1:
                              return const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Managers',
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            case 2:
                              return const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Artists',
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: eventCount.toDouble(),
                          color: Colors.blue,
                          width: 22,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 40,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: managerCount.toDouble(),
                          color: Colors.green,
                          width: 22,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 40,
                            color: Colors.green.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: artistCount.toDouble(),
                          color: Colors.orange,
                          width: 22,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 40,
                            color: Colors.orange.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              MyCardButton(
                label: "Events We Organise",
                navigateUrl: '/events',
                backgroundImageUrl: 'assets/images/mgmp-event.jpg',
                icon: Icons.event,
                count: eventCount,
              ),
              const SizedBox(height: 16),
              MyCardButton(
                label: "Verified Event Managers",
                navigateUrl: '/event-manager',
                backgroundImageUrl: 'assets/images/mgmp-event-manager.png',
                icon: Icons.manage_accounts,
                count: managerCount,
              ),
              const SizedBox(height: 16),
              MyCardButton(
                label: "Verified Artists",
                navigateUrl: '/artists',
                backgroundImageUrl: 'assets/images/mgmp-artist.webp',
                icon: Icons.person,
                count: artistCount,
              ),
              const SizedBox(height: 25),
              ToggleButtons(
                isSelected: [selectedChart == 'Pie', selectedChart == 'Bar'],
                onPressed: (index) {
                  setState(() {
                    selectedChart = index == 0 ? 'Pie' : 'Bar';
                  });
                },
                borderRadius: BorderRadius.circular(12),
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                color: Colors.black,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Pie Chart',
                      style: TextStyle(
                        fontWeight:
                            selectedChart == 'Pie'
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Bar Chart',
                      style: TextStyle(
                        fontWeight:
                            selectedChart == 'Bar'
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child:
                    selectedChart == 'Pie' ? buildPieChart() : buildBarChart(),
              ),
            ],
          ),
        );
  }
}
