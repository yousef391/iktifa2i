import 'package:flutter/material.dart';

import 'package:greenhood/core/widgets/custom_buttom_bar.dart';
import 'package:greenhood/features/auth/presenation/views/profile.dart';
import 'package:greenhood/features/community/community_dz.dart';
import 'package:greenhood/features/market/presebation/market.dart';

import 'package:greenhood/features/my_area/presentation/views/plants_view.dart';
import 'package:greenhood/features/planner/recettes.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const routename = 'root_screen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isFabMenuOpen = false;
  late AnimationController _fabController;

  bool _showExchangeForm = false;
  bool _showSellForm = false;
  bool _showSellConsoleForm = false;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  List<Widget> _widgetOptions() {
    return [
      GrowBoxScreen(),
      MarketplaceGridScreen(),
      SmartMealPlannerScreen(),
      SmartMealPlannerScreen(),
      CommunityScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        _toggleFabMenu();
      } else {
        _selectedIndex = index;
        if (_isFabMenuOpen) {
          _closeFabMenu();
        }
      }
    });
  }

  void _toggleFabMenu() {
    setState(() {
      _isFabMenuOpen = !_isFabMenuOpen;
      if (_isFabMenuOpen) {
        _fabController.forward();
      } else {
        _fabController.reverse();
      }
    });
  }

  void _closeFabMenu() {
    setState(() {
      _isFabMenuOpen = false;
      _fabController.reverse();
    });
  }

  void _handleFabAction(String action) {
    _closeFabMenu();
    setState(() {
      if (action == 'change') _showExchangeForm = true;
      if (action == 'sell') _showSellForm = true;
      if (action == 'sellConsole') _showSellConsoleForm = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF27AE60);
    const backgroundColor = Color(0xFFF5F5F5);
    const userLevel = 'Gardener';
    const userXP = 1250;
    const nextLevelXP = 2000;
    const userXPPercentage = userXP / nextLevelXP;
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('assets/images/logo.png', width: 100),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingsPage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.eco,
                              color: primaryGreen,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      userLevel,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$userXP / $nextLevelXP XP',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Stack(
                                  children: [
                                    Container(
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: userXPPercentage,
                                      child: Container(
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _widgetOptions(),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CustomBottomBar(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
              isFabMenuOpen: _isFabMenuOpen,
              onSellTapped: () => _handleFabAction('sell'),
              onChangeTapped: () => _handleFabAction('change'),
              onSellConsoleTapped: () => _handleFabAction('sellConsole'),
              fabController: _fabController,
            ),
          ),

          // Placeholders for overlays
        ],
      ),
    );
  }
}
