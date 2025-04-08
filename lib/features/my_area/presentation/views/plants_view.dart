import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greenhood/features/my_area/presentation/views/details.dart';

class GrowBoxScreen extends StatefulWidget {
  const GrowBoxScreen({super.key});

  @override
  State<GrowBoxScreen> createState() => _GrowBoxScreenState();
}

class _GrowBoxScreenState extends State<GrowBoxScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Plant> plants = [];
  bool _isLoading = true;
  bool _showAddPlantMenu = false;

  @override
  void initState() {
    super.initState();
    _fetchPlants();
  }

  Future<void> _fetchPlants() async {
    try {
      final querySnapshot = await _firestore.collection('plants').get();
      print('Fetched ${querySnapshot.docs.length} plants from Firestore.');
      final List<Plant> fetchedPlants = [];

      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        // Extract plant name from plantId (e.g., "monstera_123" -> "Monstera")
        final plantId = data['plantId'] as String? ?? 'mint plant';
        final name = data['name'] as String? ?? 'Mint Plant';
        final capitalizedName = name[0].toUpperCase() + name.substring(1);

        fetchedPlants.add(
          Plant(
            name: capitalizedName,
            stage: _determineGrowthStage(data['daysGrowing'] ?? 0),
            healthStatus: _determineHealthStatus(
              data['healthStatus'] ?? 'healthy',
            ),
            healthPercentage: data['healthPercentage'] ?? 0,
            daysGrowing: data['daysGrowing'] ?? 0,
            careLevel: data['careLevel'] ?? 1,
            season: Season.summer, // Default season, adjust as needed
            imageAsset: data['imageAsset'] ?? 'assets/images/lol.png',
          ),
        );
      }

      // Sort plants by health status (critical first, thriving last)
      fetchedPlants.sort(
        (a, b) => a.healthStatus.index.compareTo(b.healthStatus.index),
      );

      setState(() {
        plants = fetchedPlants;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching plants: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addLocalPlant(String vegetableName) {
    const String defaultImage = 'assets/images/lol.png';

    final Map<String, Season> vegetableSeasons = {
      'Tomato': Season.summer,
      'Lettuce': Season.winter,
      'Carrot': Season.spring,
      'Strawberry': Season.spring,
    };

    final List<GrowthTask> basicTasks = [
      GrowthTask(
        title: 'Water your plant',
        description: 'Give it some fresh water.',
        completed: false,
        impactMetric: HealthMetric.water,
        impactValue: 10,
        xpReward: 5,
        isRecommended: true,
      ),
      GrowthTask(
        title: 'Expose to Sunlight',
        description: 'Place the plant where it gets sunlight.',
        completed: false,
        impactMetric: HealthMetric.sunlight,
        impactValue: 15,
        xpReward: 8,
        isRecommended: true,
      ),
      GrowthTask(
        title: 'Check Soil',
        description: 'Ensure the soil is moist, not dry.',
        completed: false,
        impactMetric: HealthMetric.sunlight,
        impactValue: 10,
        xpReward: 5,
        isRecommended: false,
      ),
    ];

    final newPlant = Plant(
      name: vegetableName,
      stage: PlantStage.seedling,
      healthStatus: HealthStatus.healthy,
      healthPercentage: 100,
      daysGrowing: 0,
      careLevel: 2,
      season: vegetableSeasons[vegetableName] ?? Season.spring,
      imageAsset: defaultImage,
    );

    setState(() {
      plants.insert(0, newPlant);
    });
  }

  HealthStatus _determineHealthStatus(String status) {
    switch (status) {
      case 'thriving':
        return HealthStatus.thriving;
      case 'healthy':
        return HealthStatus.healthy;
      case 'needsAttention':
        return HealthStatus.needsAttention;
      case 'critical':
        return HealthStatus.critical;
      default:
        return HealthStatus.healthy;
    }
  }

  PlantStage _determineGrowthStage(int daysGrowing) {
    if (daysGrowing < 10) return PlantStage.seedling;
    if (daysGrowing < 30) return PlantStage.growing;
    if (daysGrowing < 60) return PlantStage.flowering;
    return PlantStage.mature;
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF27AE60);
    const backgroundColor = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Plants',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Plants needing attention are shown first',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            _isLoading
                                ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                                : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.75,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                      ),
                                  itemCount: plants.length,
                                  itemBuilder: (context, index) {
                                    final plant = plants[index];
                                    return _buildPlantCard(plant, context);
                                  },
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (_showAddPlantMenu)
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Add New Plant',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        _buildPlantMenuItem('Tomato', Season.summer, 3),
                        _buildPlantMenuItem('Lettuce', Season.spring, 1),
                        _buildPlantMenuItem('Carrot', Season.fall, 2),
                        _buildPlantMenuItem('Strawberry', Season.spring, 4),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'See all plants',
                            style: TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                FloatingActionButton(
                  backgroundColor: primaryGreen,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Select a Vegetable'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                [
                                  'Tomato',
                                  'Lettuce',
                                  'Carrot',
                                  'Strawberry',
                                ].map((vegetable) {
                                  return ListTile(
                                    title: Text(vegetable),
                                    onTap: () {
                                      Navigator.of(
                                        dialogContext,
                                      ).pop(); // Close dialog
                                      _addLocalPlant(
                                        vegetable,
                                      ); // Add plant locally
                                    },
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    _showAddPlantMenu ? Icons.close : Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(Plant plant, BuildContext context) {
    Color healthColor;
    switch (plant.healthStatus) {
      case HealthStatus.thriving:
        healthColor = Colors.green;
        break;
      case HealthStatus.healthy:
        healthColor = Colors.lightGreen;
        break;
      case HealthStatus.needsAttention:
        healthColor = Colors.orange;
        break;
      case HealthStatus.critical:
        healthColor = Colors.red;
        break;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantDetailScreen(plant: plant),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
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
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F8F0),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Image.asset(
                        plant.imageAsset,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: plant.healthPercentage / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: healthColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            _getHealthEmoji(plant.healthStatus),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${plant.daysGrowing} days',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.eco,
                            size: 12,
                            color:
                                index < plant.careLevel
                                    ? const Color(0xFF27AE60)
                                    : Colors.grey.shade300,
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F8F0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStageName(plant.stage),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF27AE60),
                      ),
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

  Widget _buildPlantMenuItem(String name, Season season, int difficulty) {
    return InkWell(
      onTap: () {
        setState(() {
          _showAddPlantMenu = false;
        });
        // Add plant logic here
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.spa, color: Color(0xFF27AE60), size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        _getSeasonName(season),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(difficulty, (index) {
                          return const Icon(
                            Icons.eco,
                            size: 10,
                            color: Color(0xFF27AE60),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getHealthEmoji(HealthStatus status) {
    switch (status) {
      case HealthStatus.thriving:
        return '😀';
      case HealthStatus.healthy:
        return '🙂';
      case HealthStatus.needsAttention:
        return '😐';
      case HealthStatus.critical:
        return '😟';
    }
  }

  String _getStageName(PlantStage stage) {
    switch (stage) {
      case PlantStage.seedling:
        return 'Seedling';
      case PlantStage.growing:
        return 'Growing';
      case PlantStage.flowering:
        return 'Flowering';
      case PlantStage.mature:
        return 'Mature';
    }
  }

  String _getSeasonName(Season season) {
    switch (season) {
      case Season.spring:
        return 'Spring';
      case Season.summer:
        return 'Summer';
      case Season.fall:
        return 'Fall';
      case Season.winter:
        return 'Winter';
    }
  }
}
