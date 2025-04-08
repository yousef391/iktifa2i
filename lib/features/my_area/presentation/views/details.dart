import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:greenhood/core/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import 'package:image_picker/image_picker.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _xpAnimation;
  int _earnedXP = 0;
  bool _showXPAnimation = false;

  // Health metrics
  late Map<HealthMetric, double> healthMetrics;

  // Growth tasks
  late List<GrowthTask> growthTasks;

  @override
  void initState() {
    super.initState();

    // Initialize health metrics
    healthMetrics = {
      HealthMetric.water: 0.7,
      HealthMetric.sunlight: 0.6,
      HealthMetric.nutrients: 0.8,
      HealthMetric.pestResistance: 0.5,
    };

    // Initialize growth tasks
    growthTasks = [
      GrowthTask(
        title: 'Water the plant',
        description: 'Add 200ml of water',
        completed: false,
        impactMetric: HealthMetric.water,
        impactValue: 0.2,
        xpReward: 15,
      ),
      GrowthTask(
        title: 'Add fertilizer',
        description: 'Add 5g of organic fertilizer',
        completed: false,
        impactMetric: HealthMetric.nutrients,
        impactValue: 0.3,
        xpReward: 25,
      ),
      GrowthTask(
        title: 'Move to sunnier spot',
        description: 'Place in direct sunlight for 4 hours',
        completed: false,
        impactMetric: HealthMetric.sunlight,
        impactValue: 0.25,
        xpReward: 20,
      ),
      GrowthTask(
        title: 'Check for pests',
        description: 'Inspect leaves for signs of pests',
        completed: false,
        impactMetric: HealthMetric.pestResistance,
        impactValue: 0.15,
        xpReward: 10,
      ),
    ];

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _xpAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _showXPAnimation = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _completeTask(int index) {
    setState(() {
      final task = growthTasks[index];
      task.completed = true;

      // Update health metric
      final currentValue = healthMetrics[task.impactMetric] ?? 0;
      healthMetrics[task.impactMetric] = math.min(
        1.0,
        currentValue + task.impactValue,
      );

      // Show XP animation
      _earnedXP = task.xpReward;
      _showXPAnimation = true;
      _animationController.reset();
      _animationController.forward();
    });
  }

  // Replace the existing _scanPlant() method with this completely new implementation

  IconData _getIconForTask(String verb) {
    switch (verb.toLowerCase()) {
      case "fertilize":
        return Icons.grass;
      case "water":
        return Icons.water_drop;
      case "prune":
        return Icons.content_cut;
      case "repot":
        return Icons.home;
      default:
        return Icons.spa;
    }
  }

  Color _getColorForTask(String verb) {
    switch (verb.toLowerCase()) {
      case "fertilize":
        return Colors.green;
      case "water":
        return Colors.blue;
      case "prune":
        return Colors.purple;
      case "repot":
        return Colors.brown;
      default:
        return Colors.teal;
    }
  }

  void _updateGrowthTasksFromAPI(Map<String, dynamic> apiResponse) {
    if (apiResponse.containsKey('tasks') && apiResponse['tasks'] is List) {
      List<dynamic> tasks = apiResponse['tasks'];

      // Create new growth tasks from API response
      List<GrowthTask> newTasks =
          tasks.map((task) {
            // Determine the appropriate health metric based on the task verb
            HealthMetric metric = HealthMetric.water; // Default
            String taskVerb = task['task'] ?? task['verb'] ?? "";

            if (taskVerb.toLowerCase().contains('water')) {
              metric = HealthMetric.water;
            } else if (taskVerb.toLowerCase().contains('fertilize')) {
              metric = HealthMetric.nutrients;
            } else if (taskVerb.toLowerCase().contains('prune')) {
              metric = HealthMetric.pestResistance;
            } else if (taskVerb.toLowerCase().contains('sun') ||
                taskVerb.toLowerCase().contains('light')) {
              metric = HealthMetric.sunlight;
            }

            return GrowthTask(
              title: task['task'] ?? task['verb'] ?? "Care Task",
              description: task['amount'] ?? "",
              completed: false,
              impactMetric: metric,
              impactValue:
                  double.tryParse(
                    task['effect'].toString().replaceAll(
                      RegExp(r'[^0-9.]'),
                      '',
                    ),
                  ) ??
                  0.1,
              xpReward: int.tryParse(task['xp'].toString()) ?? 10,
              isRecommended: true, // Mark tasks from API as recommended
            );
          }).toList();

      // Update the growth tasks - completely replace with new tasks
      setState(() {
        growthTasks = newTasks;
      });
    }
  }

  Future<void> analyzePlant(BuildContext context, String plantType) async {
    try {
      print(plantType);
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      // Show loading indicator
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Analyzing plant image...')));

      final uri = Uri.parse('http://192.168.231.93:8000/analyze-plant/');

      final request =
          http.MultipartRequest('POST', uri)
            ..fields['plant_type'] = plantType
            ..files.add(
              await http.MultipartFile.fromPath('file', pickedFile.path),
            );

      print('Sending request to: $uri');
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final jsonResult = json.decode(responseBody);
        print('✅ Success: $jsonResult');

        // Update growth tasks with API response
        _updateGrowthTasksFromAPI(jsonResult);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Plant analysis complete! New care tasks added.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('❌ Error ${response.statusCode}: $responseBody');

        // Check if this is the specific "not recognized as a plant" error
        if (responseBody.contains("not recognized as a plant")) {
          // Close any existing SnackBar
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show dialog for this specific error
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Plant Not Recognized'),
                content: Text(
                  'The uploaded image is not recognized as a plant. Please try uploading a clearer image of your plant.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Show generic error SnackBar for other errors
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      print('Exception during image analysis: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network error: $e')));
    }
  }

  Widget _buildIssueItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate overall health percentage
    final overallHealth =
        healthMetrics.values.reduce((a, b) => a + b) / healthMetrics.length;

    // Determine health status based on overall health
    HealthStatus healthStatus;
    if (overallHealth >= 0.85) {
      healthStatus = HealthStatus.thriving;
    } else if (overallHealth >= 0.65) {
      healthStatus = HealthStatus.healthy;
    } else if (overallHealth >= 0.4) {
      healthStatus = HealthStatus.needsAttention;
    } else {
      healthStatus = HealthStatus.critical;
    }

    // Colors
    const primaryGreen = Color(0xFF27AE60);
    const backgroundColor = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              // Top section with plant visualization
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.chevron_left,
                                      color: Colors.white,
                                    ),
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  widget.plant.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Plant visualization and health emoji
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Plant image
                            Image.asset(
                              widget.plant.imageAsset,
                              height: 180,
                              fit: BoxFit.contain,
                            ),

                            // Health emoji
                            Positioned(
                              top: 10,
                              right: 30,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _getHealthEmoji(healthStatus),
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Health metrics and growth tasks
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age and growth stage
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.plant.daysGrowing ~/ 7} weeks old',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getStageName(widget.plant.stage),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Growth timeline
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Growth Timeline',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 70,
                            child: _buildGrowthTimeline(widget.plant.stage),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Health metrics
                      const Text(
                        'Health Metrics',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildHealthMetric(
                        'Water Level',
                        healthMetrics[HealthMetric.water] ?? 0,
                        '💧',
                        Colors.blue,
                      ),
                      const SizedBox(height: 12),
                      _buildHealthMetric(
                        'Sunlight Exposure',
                        healthMetrics[HealthMetric.sunlight] ?? 0,
                        '☀️',
                        Colors.amber,
                      ),
                      const SizedBox(height: 12),
                      _buildHealthMetric(
                        'Nutrient Status',
                        healthMetrics[HealthMetric.nutrients] ?? 0,
                        '🌱',
                        Colors.green,
                      ),
                      const SizedBox(height: 12),
                      _buildHealthMetric(
                        'Pest Resistance',
                        healthMetrics[HealthMetric.pestResistance] ?? 0,
                        '🐞',
                        Colors.red,
                      ),

                      const SizedBox(height: 24),

                      // Growth tasks
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Growth Tasks',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${growthTasks.where((task) => task.completed).length}/${growthTasks.length} completed',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        growthTasks.length,
                        (index) => _buildGrowthTask(index),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Camera scan button
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              backgroundColor: primaryGreen,
              onPressed: () async {
                await analyzePlant(context, widget.plant.name);
              },
              child: const Icon(Icons.camera_alt, color: Colors.white),
            ),
          ),

          // XP animation
          if (_showXPAnimation)
            AnimatedBuilder(
              animation: _xpAnimation,
              builder: (context, child) {
                return Positioned(
                  top:
                      MediaQuery.of(context).size.height / 2 -
                      100 * _xpAnimation.value,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: math.max(0, 1 - _xpAnimation.value),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '+$_earnedXP XP',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(
    String label,
    double value,
    String emoji,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            children: [
              Text(emoji, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              const Spacer(),
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              // Background
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // Value
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthTask(int index) {
    final task = growthTasks[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            task.isRecommended
                ? Border.all(color: Colors.orange, width: 2)
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: task.completed,
              onChanged: (value) {
                if (!task.completed) {
                  _completeTask(index);
                }
              },
              activeColor: const Color(0xFF27AE60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Task details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration:
                              task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                    ),
                    if (task.isRecommended)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    decoration:
                        task.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 8),
                // Impact and reward
                Row(
                  children: [
                    // Impact
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getMetricColor(
                          task.impactMetric,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            _getMetricEmoji(task.impactMetric),
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+${(task.impactValue * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: _getMetricColor(task.impactMetric),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // XP reward
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF27AE60).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Color(0xFF27AE60),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '+${task.xpReward} XP',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF27AE60),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthTimeline(PlantStage currentStage) {
    final stages = PlantStage.values;
    final currentIndex = stages.indexOf(currentStage);

    return Row(
      children: List.generate(stages.length, (index) {
        final stage = stages[index];
        final isCompleted = index <= currentIndex;
        final isCurrent = index == currentIndex;

        return Expanded(
          child: Column(
            children: [
              // Stage indicator
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color:
                      isCompleted
                          ? const Color(0xFF27AE60)
                          : Colors.grey.shade300,
                  shape: BoxShape.circle,
                  border:
                      isCurrent
                          ? Border.all(color: Colors.white, width: 3)
                          : null,
                  boxShadow:
                      isCurrent
                          ? [
                            BoxShadow(
                              color: const Color(0xFF27AE60).withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                          : null,
                ),
                child: Icon(
                  _getStageIcon(stage),
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Stage name
              Text(
                _getStageName(stage),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color:
                      isCurrent
                          ? const Color(0xFF27AE60)
                          : Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
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

  IconData _getStageIcon(PlantStage stage) {
    switch (stage) {
      case PlantStage.seedling:
        return Icons.grass;
      case PlantStage.growing:
        return Icons.spa;
      case PlantStage.flowering:
        return Icons.local_florist;
      case PlantStage.mature:
        return Icons.eco;
    }
  }

  String _getMetricEmoji(HealthMetric metric) {
    switch (metric) {
      case HealthMetric.water:
        return '💧';
      case HealthMetric.sunlight:
        return '☀️';
      case HealthMetric.nutrients:
        return '🌱';
      case HealthMetric.pestResistance:
        return '🐞';
    }
  }

  Color _getMetricColor(HealthMetric metric) {
    switch (metric) {
      case HealthMetric.water:
        return Colors.blue;
      case HealthMetric.sunlight:
        return Colors.amber;
      case HealthMetric.nutrients:
        return Colors.green;
      case HealthMetric.pestResistance:
        return Colors.red;
    }
  }
}

// Enums and Models
enum HealthMetric { water, sunlight, nutrients, pestResistance }

class GrowthTask {
  final String title;
  final String description;
  bool completed;
  final HealthMetric impactMetric;
  final double impactValue;
  final int xpReward;
  final bool isRecommended;

  GrowthTask({
    required this.title,
    required this.description,
    required this.completed,
    required this.impactMetric,
    required this.impactValue,
    required this.xpReward,
    this.isRecommended = false,
  });
}

// These are from the main.dart file
enum PlantStage { seedling, growing, flowering, mature }

enum HealthStatus { critical, needsAttention, healthy, thriving }

enum Season { spring, summer, fall, winter }

class Plant {
  final String name;
  final PlantStage stage;
  final HealthStatus healthStatus;
  final int healthPercentage;
  final int daysGrowing;
  final int careLevel; // 1-5 difficulty
  final Season season;
  final String imageAsset;

  Plant({
    required this.name,
    required this.stage,
    required this.healthStatus,
    required this.healthPercentage,
    required this.daysGrowing,
    required this.careLevel,
    required this.season,
    required this.imageAsset,
  });
}
