import 'package:flutter/material.dart';
import 'dart:ui';

class SmartMealPlannerScreen extends StatefulWidget {
  const SmartMealPlannerScreen({super.key});

  @override
  State<SmartMealPlannerScreen> createState() => _SmartMealPlannerScreenState();
}

class _SmartMealPlannerScreenState extends State<SmartMealPlannerScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _vegetarian = false;
  bool _vegan = false;
  bool _glutenFree = false;
  bool _lowCarb = false;
  bool _showIngredients = false;

  // Sample recipe data
  final List<Map<String, dynamic>> _recipes = [
    {
      'id': 1,
      'name': 'Garden Vegetable Pasta',
      'image':
          'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?q=80&w=500',
      'time': '30 min',
      'difficulty': 'Medium',
      'calories': 450,
      'protein': 12,
      'carbs': 65,
      'fat': 15,
      'servings': 4,
      'ingredients': [
        {'name': 'Tomatoes', 'source': 'garden', 'amount': '4 medium'},
        {'name': 'Basil', 'source': 'garden', 'amount': '1/4 cup'},
        {'name': 'Pasta', 'source': 'pantry', 'amount': '12 oz'},
        {'name': 'Olive Oil', 'source': 'pantry', 'amount': '2 tbsp'},
        {'name': 'Garlic', 'source': 'market', 'amount': '3 cloves'},
        {'name': 'Parmesan', 'source': 'shop', 'amount': '1/4 cup'},
      ],
      'steps': [
        'Bring a large pot of salted water to boil.',
        'Add pasta and cook according to package directions.',
        'Meanwhile, dice tomatoes and mince garlic.',
        'Heat olive oil in a large skillet over medium heat.',
        'Add garlic and sauté until fragrant, about 30 seconds.',
        'Add tomatoes and cook until softened, about 5 minutes.',
        'Drain pasta and add to the skillet.',
        'Tear basil leaves and add to the pasta.',
        'Toss everything together and serve with grated parmesan.',
      ],
    },
    {
      'id': 2,
      'name': 'Roasted Vegetable Quinoa Bowl',
      'image':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=500',
      'time': '45 min',
      'difficulty': 'Easy',
      'calories': 380,
      'protein': 14,
      'carbs': 52,
      'fat': 12,
      'servings': 2,
      'ingredients': [
        {'name': 'Quinoa', 'source': 'pantry', 'amount': '1 cup'},
        {'name': 'Bell Peppers', 'source': 'garden', 'amount': '2'},
        {'name': 'Zucchini', 'source': 'garden', 'amount': '1 medium'},
        {'name': 'Carrots', 'source': 'garden', 'amount': '2 medium'},
        {'name': 'Olive Oil', 'source': 'pantry', 'amount': '2 tbsp'},
        {'name': 'Lemon', 'source': 'shop', 'amount': '1'},
        {'name': 'Feta Cheese', 'source': 'shop', 'amount': '1/4 cup'},
      ],
      'steps': [
        'Preheat oven to 425°F (220°C).',
        'Rinse quinoa under cold water and cook according to package directions.',
        'Cut vegetables into bite-sized pieces.',
        'Toss vegetables with olive oil, salt, and pepper.',
        'Spread on a baking sheet and roast for 25-30 minutes, stirring halfway.',
        'Combine cooked quinoa and roasted vegetables in a bowl.',
        'Squeeze lemon juice over the top and sprinkle with feta cheese.',
      ],
    },
    {
      'id': 3,
      'name': 'Fresh Garden Salad with Herb Dressing',
      'image':
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?q=80&w=500',
      'time': '15 min',
      'difficulty': 'Easy',
      'calories': 220,
      'protein': 5,
      'carbs': 18,
      'fat': 16,
      'servings': 2,
      'ingredients': [
        {'name': 'Mixed Greens', 'source': 'garden', 'amount': '4 cups'},
        {'name': 'Cherry Tomatoes', 'source': 'garden', 'amount': '1 cup'},
        {'name': 'Cucumber', 'source': 'garden', 'amount': '1 medium'},
        {'name': 'Radishes', 'source': 'garden', 'amount': '4-5'},
        {
          'name': 'Herbs (Dill, Parsley)',
          'source': 'garden',
          'amount': '1/4 cup',
        },
        {'name': 'Olive Oil', 'source': 'pantry', 'amount': '3 tbsp'},
        {'name': 'Lemon', 'source': 'market', 'amount': '1'},
        {'name': 'Honey', 'source': 'pantry', 'amount': '1 tsp'},
        {'name': 'Walnuts', 'source': 'shop', 'amount': '1/4 cup'},
      ],
      'steps': [
        'Wash and dry all produce.',
        'Slice cucumber and radishes thinly.',
        'Halve cherry tomatoes.',
        'Chop herbs finely.',
        'In a small bowl, whisk together olive oil, lemon juice, honey, salt, and pepper.',
        'Add herbs to the dressing and mix well.',
        'Combine all vegetables in a large bowl.',
        'Pour dressing over salad and toss gently.',
        'Top with toasted walnuts before serving.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar

            // Diet Preferences
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dietary Preferences',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,

                      children: [
                        _buildDietToggle('Vegetarian', _vegetarian, (value) {
                          setState(() {
                            _vegetarian = value;
                            if (value && _vegan) _vegan = false;
                          });
                        }),
                        _buildDietToggle('Vegan', _vegan, (value) {
                          setState(() {
                            _vegan = value;
                            if (value) _vegetarian = true;
                          });
                        }),
                        _buildDietToggle('Gluten-Free', _glutenFree, (value) {
                          setState(() {
                            _glutenFree = value;
                          });
                        }),
                        _buildDietToggle('Low-Carb', _lowCarb, (value) {
                          setState(() {
                            _lowCarb = value;
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search and Ingredients
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search recipes or ingredients',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF10B981),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // My Ingredients Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showIngredients = !_showIngredients;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            _showIngredients
                                ? const Color(0xFF10B981)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.egg_outlined,
                        color:
                            _showIngredients
                                ? Colors.white
                                : const Color(0xFF10B981),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // My Ingredients Panel (Conditionally Shown)
            if (_showIngredients)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Ingredients',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                            color: Color(0xFF10B981),
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildIngredientChip('Tomatoes', 'garden'),
                        _buildIngredientChip('Basil', 'garden'),
                        _buildIngredientChip('Bell Peppers', 'garden'),
                        _buildIngredientChip('Zucchini', 'garden'),
                        _buildIngredientChip('Carrots', 'garden'),
                        _buildIngredientChip('Mixed Greens', 'garden'),
                        _buildIngredientChip('Pasta', 'pantry'),
                        _buildIngredientChip('Olive Oil', 'pantry'),
                        _buildIngredientChip('Quinoa', 'pantry'),
                        _buildIngredientChip('Honey', 'pantry'),
                        _buildIngredientChip('Garlic', 'market'),
                        _buildIngredientChip('Lemon', 'market'),
                      ],
                    ),
                  ],
                ),
              ),

            // Recipe List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return _buildRecipeCard(recipe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDietToggle(String label, bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              value
                  ? const Color(0xFF10B981).withOpacity(0.1)
                  : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border:
              value
                  ? Border.all(color: const Color(0xFF10B981))
                  : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              value ? Icons.check_circle : Icons.circle_outlined,
              size: 16,
              color: value ? const Color(0xFF10B981) : Colors.grey.shade500,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: value ? FontWeight.w600 : FontWeight.w500,
                color: value ? const Color(0xFF10B981) : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientCategory(String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChip(String name, String source) {
    Color color;
    IconData icon;

    switch (source) {
      case 'garden':
        color = const Color(0xFF10B981);
        icon = Icons.spa;
        break;
      case 'pantry':
        color = const Color(0xFFF97316);
        icon = Icons.kitchen;
        break;
      case 'market':
        color = const Color(0xFF3B82F6);
        icon = Icons.store;
        break;
      default:
        color = Colors.grey;
        icon = Icons.circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    return Dismissible(
      key: Key(recipe['id'].toString()),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerLeft,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.bookmark, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => _showRecipeDetails(recipe),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      recipe['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Time and Difficulty
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe['time'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Difficulty
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0EA47A), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        recipe['difficulty'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // Servings
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.people_outline,
                            size: 14,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe['servings']} servings',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Recipe Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Nutritional Information
                    Row(
                      children: [
                        _buildNutrientIndicator(
                          'Calories',
                          recipe['calories'].toString(),
                          const Color(0xFFF97316),
                        ),
                        _buildNutrientIndicator(
                          'Protein',
                          '${recipe['protein']}g',
                          const Color(0xFF10B981),
                        ),
                        _buildNutrientIndicator(
                          'Carbs',
                          '${recipe['carbs']}g',
                          const Color(0xFF3B82F6),
                        ),
                        _buildNutrientIndicator(
                          'Fat',
                          '${recipe['fat']}g',
                          const Color(0xFFF59E0B),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Ingredients Source
                    Text(
                      'Ingredients Source:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        _buildIngredientSourceIndicator(
                          'Garden',
                          Icons.spa,
                          const Color(0xFF10B981),
                          recipe['ingredients']
                              .where((i) => i['source'] == 'garden')
                              .length,
                        ),
                        const SizedBox(width: 8),
                        _buildIngredientSourceIndicator(
                          'Pantry',
                          Icons.kitchen,
                          const Color(0xFFF97316),
                          recipe['ingredients']
                              .where((i) => i['source'] == 'pantry')
                              .length,
                        ),
                        const SizedBox(width: 8),
                        _buildIngredientSourceIndicator(
                          'Market',
                          Icons.store,
                          const Color(0xFF3B82F6),
                          recipe['ingredients']
                              .where((i) => i['source'] == 'market')
                              .length,
                        ),
                        const SizedBox(width: 8),
                        _buildIngredientSourceIndicator(
                          'Shop',
                          Icons.shopping_cart,
                          const Color(0xFFEF4444),
                          recipe['ingredients']
                              .where((i) => i['source'] == 'shop')
                              .length,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 18,
                            ),
                            label: const Text('Add Missing'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF10B981),
                              side: const BorderSide(color: Color(0xFF10B981)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showRecipeDetails(recipe),
                            icon: const Icon(
                              Icons.restaurant_outlined,
                              size: 18,
                            ),
                            label: const Text('Cook Now'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF10B981),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
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
        ),
      ),
    );
  }

  Widget _buildNutrientIndicator(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor:
                    0.7, // This would be dynamic based on the nutrient value
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientSourceIndicator(
    String label,
    IconData icon,
    Color color,
    int count,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF10B981).withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  void _showRecipeDetails(Map<String, dynamic> recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // Drag Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Recipe Details
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(20),
                      children: [
                        // Recipe Title and Actions
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                recipe['name'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined),
                              onPressed: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Recipe Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            recipe['image'],
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Recipe Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildRecipeInfoItem(
                              Icons.access_time,
                              recipe['time'],
                              'Time',
                            ),
                            _buildRecipeInfoItem(
                              Icons.restaurant_menu,
                              recipe['difficulty'],
                              'Difficulty',
                            ),
                            _buildRecipeInfoItem(
                              Icons.people_outline,
                              '${recipe['servings']}',
                              'Servings',
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Portion Adjuster
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Adjust Portions',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    color: const Color(0xFF10B981),
                                    onPressed: () {},
                                  ),
                                  Text(
                                    '${recipe['servings']} servings',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    color: const Color(0xFF10B981),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Nutritional Information
                        Text(
                          'Nutritional Information',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildDetailedNutrientIndicator(
                              'Calories',
                              recipe['calories'].toString(),
                              const Color(0xFFF97316),
                            ),
                            _buildDetailedNutrientIndicator(
                              'Protein',
                              '${recipe['protein']}g',
                              const Color(0xFF10B981),
                            ),
                            _buildDetailedNutrientIndicator(
                              'Carbs',
                              '${recipe['carbs']}g',
                              const Color(0xFF3B82F6),
                            ),
                            _buildDetailedNutrientIndicator(
                              'Fat',
                              '${recipe['fat']}g',
                              const Color(0xFFF59E0B),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Ingredients
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(recipe['ingredients'].length, (index) {
                          final ingredient = recipe['ingredients'][index];
                          return _buildIngredientItem(
                            ingredient['name'],
                            ingredient['amount'],
                            ingredient['source'],
                          );
                        }),

                        const SizedBox(height: 24),

                        // Instructions
                        Text(
                          'Instructions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(recipe['steps'].length, (index) {
                          return _buildInstructionStep(
                            index + 1,
                            recipe['steps'][index],
                          );
                        }),

                        const SizedBox(height: 32),

                        // Cook Now Button
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.restaurant_outlined),
                          label: const Text('Start Cooking'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRecipeInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF10B981), size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildDetailedNutrientIndicator(
    String label,
    String value,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientItem(String name, String amount, String source) {
    Color color;
    IconData icon;

    switch (source) {
      case 'garden':
        color = const Color(0xFF10B981);
        icon = Icons.spa;
        break;
      case 'pantry':
        color = const Color(0xFFF97316);
        icon = Icons.kitchen;
        break;
      case 'market':
        color = const Color(0xFF3B82F6);
        icon = Icons.store;
        break;
      case 'shop':
        color = const Color(0xFFEF4444);
        icon = Icons.shopping_cart;
        break;
      default:
        color = Colors.grey;
        icon = Icons.circle;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(int number, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
