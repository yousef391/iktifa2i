import 'package:flutter/material.dart';

class MarketplaceGridScreen extends StatefulWidget {
  const MarketplaceGridScreen({super.key});

  @override
  State<MarketplaceGridScreen> createState() => _MarketplaceGridScreenState();
}

class _MarketplaceGridScreenState extends State<MarketplaceGridScreen> {
  final List<Map<String, dynamic>> _marketPosts = [
    {
      "id": 1,
      "title": "Tomates Biologiques Premium",
      "price": "600 DZD/kg",
      "image":
          "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?q=80&w=500",
      "location": "Alger, Wilaya d'Alger",
      "distance": "1.2 km",
      "description":
          "Tomates biologiques fraîchement récoltées de mon jardin, parfaites pour les salades et la cuisine. Aucun pesticide utilisé.",
      "isOrganic": true,
      "timePosted": "Il y a 2h",
      "seller": {
        "name": "Amine Benali",
        "image":
            "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=100",
        "rating": 4.9,
        "reviews": 128,
        "isVerified": true,
      },
    },
    {
      "id": 2,
      "title": "Courgettes Fraîches du Jardin",
      "price": "350 DZD/kg",
      "image":
          "https://images.unsplash.com/photo-1583687355032-89b902b7335f?q=80&w=500",
      "location": "Oran, Wilaya d'Oran",
      "distance": "2 km",
      "description":
          "Courgettes fraîchement récoltées ce matin, idéales pour le gril ou la cuisson.",
      "isOrganic": true,
      "timePosted": "Il y a 4h",
      "seller": {
        "name": "Khaled Boudjema",
        "image":
            "https://images.unsplash.com/photo-1566492031773-4f4e44671857?q=80&w=100",
        "rating": 4.7,
        "reviews": 93,
        "isVerified": true,
      },
    },
    {
      "id": 3,
      "title": "Carottes Héritage",
      "price": "450 DZD/bouquet",
      "image":
          "https://images.unsplash.com/photo-1447175008436-054170c2e979?q=80&w=500",
      "location": "Constantine, Wilaya de Constantine",
      "distance": "3.5 km",
      "description":
          "Carottes héritage colorées avec des variétés violettes, orange et jaunes.",
      "isOrganic": true,
      "timePosted": "Il y a 1 jour",
      "seller": {
        "name": "Sofia Dahmani",
        "image":
            "https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=100",
        "rating": 4.8,
        "reviews": 156,
        "isVerified": true,
      },
    },
    {
      "id": 4,
      "title": "Fraises Fraîches",
      "price": "700 DZD/pinte",
      "image":
          "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?q=80&w=500",
      "location": "Blida, Wilaya de Blida",
      "distance": "5.5 km",
      "description":
          "Fraises sucrées et juteuses cueillies à leur maturité parfaite. Idéales pour les desserts ou les encas.",
      "isOrganic": false,
      "timePosted": "Il y a 6h",
      "seller": {
        "name": "Mohamed Tebboul",
        "image":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=100",
        "rating": 4.6,
        "reviews": 87,
        "isVerified": false,
      },
    },
    {
      "id": 5,
      "title": "Plantes de Basilic Frais",
      "price": "500 DZD/plant",
      "image":
          "https://images.unsplash.com/photo-1600880292203-757bb62b4baf?q=80&w=500",
      "location": "Tizi Ouzou, Wilaya de Tizi Ouzou",
      "distance": "2.5 km",
      "description":
          "Plantes de basilic en pot, pour cultiver vos propres herbes fraîches à la maison !",
      "isOrganic": true,
      "timePosted": "Il y a 1 jour",
      "seller": {
        "name": "Yasmina Saidi",
        "image":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=100",
        "rating": 4.9,
        "reviews": 112,
        "isVerified": true,
      },
    },
    {
      "id": 6,
      "title": "Miel - Brut & Non Filtré",
      "price": "1000 DZD/pot",
      "image":
          "https://images.unsplash.com/photo-1587049352851-8d4e89133924?q=80&w=500",
      "location": "Setif, Wilaya de Sétif",
      "distance": "6.8 km",
      "description":
          "Miel local des fleurs sauvages, brut et non filtré. Directement de notre rucher.",
      "isOrganic": true,
      "timePosted": "Il y a 3 jours",
      "seller": {
        "name": "Rachid Belkacem",
        "image":
            "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=100",
        "rating": 5.0,
        "reviews": 203,
        "isVerified": true,
      },
    },
  ];

  final List<String> _categories = [
    'All',
    'Vegetables',
    'Fruits',
    'Herbs',
    'Dairy',
    'Honey',
    'Seeds',
    'Plants',
  ];

  String _selectedCategory = 'All';
  final bool _showFilters = false;
  double _maxDistance = 10.0;

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    final isLargeScreen = screenSize.width >= 900;

    // Determine number of grid columns based on screen width
    int gridColumns = isSmallScreen ? 2 : (isMediumScreen ? 3 : 4);

    // Adjust padding based on screen size
    final horizontalPadding = isSmallScreen ? 12.0 : 16.0;
    final verticalPadding = isSmallScreen ? 12.0 : 16.0;

    // Adjust font sizes based on screen size
    final titleFontSize = isSmallScreen ? 20.0 : 22.0;
    final cardTitleFontSize = isSmallScreen ? 13.0 : 14.0;

    // Adjust grid spacing based on screen size
    final gridSpacing = isSmallScreen ? 12.0 : 16.0;

    // Calculate aspect ratio for grid items
    final cardAspectRatio = isSmallScreen ? 0.65 : 0.55;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar

            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: gridSpacing * 0.75),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 12.0 : 16.0,
                      ),
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFF0EA47A),
                                    Color(0xFF10B981),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                : null,
                        color: isSelected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: isSmallScreen ? 13.0 : 14.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Filters (Conditional)
            if (_showFilters)
              Container(
                margin: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  verticalPadding,
                  horizontalPadding,
                  0,
                ),
                padding: EdgeInsets.all(horizontalPadding),
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
                      'Filters',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 15.0 : 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Responsive filter chips layout
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterChip('Organic Only', true, isSmallScreen),
                        _buildFilterChip(
                          'Within 5 miles',
                          false,
                          isSmallScreen,
                        ),
                        _buildFilterChip('Available Now', false, isSmallScreen),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Distance',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13.0 : 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        Text(
                          'Max ${_maxDistance.toInt()} miles',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13.0 : 14.0,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _maxDistance,
                      min: 1,
                      max: 50,
                      divisions: 49,
                      activeColor: const Color(0xFF10B981),
                      inactiveColor: const Color(0xFF10B981).withOpacity(0.2),
                      onChanged: (value) {
                        setState(() {
                          _maxDistance = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

            // Grid of Market Posts
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Dynamically adjust grid based on available width
                    final availableWidth = constraints.maxWidth;
                    // For very small screens, force 1 column
                    final dynamicColumns =
                        availableWidth < 300
                            ? 1
                            : (availableWidth < 600
                                ? 2
                                : (availableWidth < 900 ? 3 : 4));

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: dynamicColumns,
                        childAspectRatio: cardAspectRatio,
                        crossAxisSpacing: gridSpacing,
                        mainAxisSpacing: gridSpacing,
                      ),
                      itemCount: _marketPosts.length,
                      itemBuilder: (context, index) {
                        final post = _marketPosts[index];
                        return _buildMarketPostCard(
                          post,
                          isSmallScreen,
                          cardTitleFontSize,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostModal(context),
        backgroundColor: const Color(0xFF10B981),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddPostModal(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    // Form controllers
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();

    // Form state
    bool isOrganic = false;
    String? selectedCategory = 'Vegetables';
    String? selectedUnit = 'kg';
    String? imagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.92,
              maxChildSize: 0.95,
              minChildSize: 0.5,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
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

                      // Header
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 16.0 : 24.0,
                          vertical: 12.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade700,
                                  size: 20,
                                ),
                              ),
                            ),
                            Text(
                              'Add New Listing',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18.0 : 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Validate and submit form
                                if (titleController.text.isEmpty ||
                                    priceController.text.isEmpty ||
                                    locationController.text.isEmpty ||
                                    descriptionController.text.isEmpty) {
                                  // Show error
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please fill all required fields',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                // Add new post logic would go here
                                Navigator.pop(context);

                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Listing added successfully!',
                                    ),
                                    backgroundColor: const Color(0xFF10B981),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF10B981),
                                padding: EdgeInsets.zero,
                              ),
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16.0 : 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),

                      // Form
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 16.0 : 24.0,
                            vertical: 16.0,
                          ),
                          children: [
                            // Image Upload
                            GestureDetector(
                              onTap: () {
                                // Image picker logic would go here
                                setState(() {
                                  // For demo, we'll just toggle between null and a placeholder
                                  imagePath =
                                      imagePath == null
                                          ? 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?q=80&w=500'
                                          : null;
                                });
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child:
                                    imagePath == null
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFF10B981,
                                                ).withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.camera_alt_outlined,
                                                color: Color(0xFF10B981),
                                                size: 32,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'Add Photos',
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 16.0 : 18.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Up to 5 photos',
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 12.0 : 14.0,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ],
                                        )
                                        : Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                imagePath!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 8,
                                              right: 8,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    imagePath = null;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Title
                            _buildFormField(
                              label: 'Title',
                              hint: 'What are you selling?',
                              controller: titleController,
                              isSmallScreen: isSmallScreen,
                            ),

                            const SizedBox(height: 20),

                            // Category
                            Text(
                              'Category',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14.0 : 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedCategory,
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xFF10B981),
                                  ),
                                  items:
                                      _categories.where((c) => c != 'All').map((
                                        String category,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: category,
                                          child: Text(category),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCategory = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Price
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: _buildFormField(
                                    label: 'Price',
                                    hint: 'Enter price',
                                    controller: priceController,
                                    isSmallScreen: isSmallScreen,
                                    keyboardType: TextInputType.number,
                                    prefixText: 'DZD ',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Unit',
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 14.0 : 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade50,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade200,
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: selectedUnit,
                                            isExpanded: true,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xFF10B981),
                                            ),
                                            items:
                                                [
                                                  'kg',
                                                  'g',
                                                  'piece',
                                                  'bunch',
                                                  'pot',
                                                  'pinte',
                                                ].map((String unit) {
                                                  return DropdownMenuItem<
                                                    String
                                                  >(
                                                    value: unit,
                                                    child: Text(unit),
                                                  );
                                                }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedUnit = newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Location
                            _buildFormField(
                              label: 'Location',
                              hint: 'Where is your item located?',
                              controller: locationController,
                              isSmallScreen: isSmallScreen,
                              suffixIcon: Icons.location_on_outlined,
                            ),

                            const SizedBox(height: 20),

                            // Description
                            _buildFormField(
                              label: 'Description',
                              hint: 'Describe what you are selling...',
                              controller: descriptionController,
                              isSmallScreen: isSmallScreen,
                              maxLines: 5,
                            ),

                            const SizedBox(height: 20),

                            // Organic Toggle
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.eco_outlined,
                                    color: Color(0xFF10B981),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Organic Product',
                                          style: TextStyle(
                                            fontSize:
                                                isSmallScreen ? 14.0 : 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Mark if your product is organic',
                                          style: TextStyle(
                                            fontSize:
                                                isSmallScreen ? 12.0 : 14.0,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: isOrganic,
                                    onChanged: (value) {
                                      setState(() {
                                        isOrganic = value;
                                      });
                                    },
                                    activeColor: const Color(0xFF10B981),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 40),
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
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isSmallScreen,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    int maxLines = 1,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 14.0 : 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: isSmallScreen ? 14.0 : 16.0,
            ),
            prefixText: prefixText,
            prefixStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: isSmallScreen ? 14.0 : 16.0,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon:
                suffixIcon != null
                    ? Icon(suffixIcon, color: Colors.grey.shade500)
                    : null,
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: maxLines > 1 ? 16 : 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF10B981)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10.0 : 12.0,
        vertical: isSmallScreen ? 6.0 : 8.0,
      ),
      decoration: BoxDecoration(
        color:
            isSelected
                ? const Color(0xFF10B981).withOpacity(0.1)
                : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border:
            isSelected
                ? Border.all(color: const Color(0xFF10B981))
                : Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            size: isSmallScreen ? 14.0 : 16.0,
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade500,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 11.0 : 12.0,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color:
                  isSelected ? const Color(0xFF10B981) : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketPostCard(
    Map<String, dynamic> post,
    bool isSmallScreen,
    double titleFontSize,
  ) {
    return GestureDetector(
      onTap: () => _showPostDetails(post),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                // Main Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      post['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
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
                ),

                // Organic Badge
                if (post['isOrganic'])
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 6.0 : 8.0,
                        vertical: isSmallScreen ? 3.0 : 4.0,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0EA47A), Color(0xFF10B981)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco_outlined,
                            color: Colors.white,
                            size: isSmallScreen ? 8.0 : 10.0,
                          ),
                          SizedBox(width: isSmallScreen ? 1.0 : 2.0),
                          Text(
                            'Organic',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 9.0 : 10.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Time Posted
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 5.0 : 6.0,
                      vertical: isSmallScreen ? 3.0 : 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post['timePosted'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 9.0 : 10.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Price Tag
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 6.0 : 8.0,
                      vertical: isSmallScreen ? 3.0 : 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      post['price'],
                      style: TextStyle(
                        color: const Color(0xFF10B981),
                        fontSize: isSmallScreen ? 11.0 : 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isSmallScreen ? 10.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      post['title'],
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: isSmallScreen ? 2.0 : 4.0),

                    // Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: isSmallScreen ? 10.0 : 12.0,
                          color: const Color(0xFF64748B),
                        ),
                        SizedBox(width: isSmallScreen ? 1.0 : 2.0),
                        Expanded(
                          child: Text(
                            post['location'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 10.0 : 11.0,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isSmallScreen ? 3.0 : 4.0,
                            vertical: isSmallScreen ? 1.0 : 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            post['distance'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 9.0 : 10.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 4.0 : 6.0),

                    // Seller Info
                    Row(
                      children: [
                        Container(
                          width: isSmallScreen ? 18.0 : 20.0,
                          height: isSmallScreen ? 18.0 : 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              post['seller']['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: isSmallScreen ? 10.0 : 12.0,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 3.0 : 4.0),
                        Expanded(
                          child: Text(
                            post['seller']['name'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 10.0 : 11.0,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (post['seller']['isVerified'])
                          Container(
                            padding: const EdgeInsets.all(1),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: isSmallScreen ? 7.0 : 8.0,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 3.0 : 4.0),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: isSmallScreen ? 10.0 : 12.0,
                          color: const Color(0xFFFBBF24),
                        ),
                        SizedBox(width: isSmallScreen ? 1.0 : 2.0),
                        Text(
                          post['seller']['rating'].toString(),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 10.0 : 11.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 1.0 : 2.0),
                        Text(
                          '(${post['seller']['reviews']})',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 9.0 : 10.0,
                            color: Colors.grey.shade500,
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
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label, {
    bool isSelected = false,
    bool isSmallScreen = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(isSmallScreen ? 8.0 : 10.0),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF10B981).withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: isSmallScreen ? 22.0 : 24.0,
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 11.0 : 12.0,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF10B981) : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  void _showPostDetails(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        // Get screen size for responsive layout
        final screenSize = MediaQuery.of(context).size;
        final isSmallScreen = screenSize.width < 600;

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

                  // Post Details
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.zero,
                      children: [
                        // Image
                        Stack(
                          children: [
                            Image.network(
                              post['image'],
                              height: isSmallScreen ? 250 : 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Gradient overlay for better text visibility
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Back button
                            Positioned(
                              top: 16,
                              left: 16,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            // Share and Save buttons
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.bookmark_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Title and price
                            Positioned(
                              bottom: 16,
                              left: 16,
                              right: 16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post['title'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                isSmallScreen ? 20.0 : 24.0,
                                            fontWeight: FontWeight.bold,
                                            shadows: const [
                                              Shadow(
                                                offset: Offset(0, 1),
                                                blurRadius: 3,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              post['location'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(0, 1),
                                                    blurRadius: 3,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                post['distance'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 10.0 : 12.0,
                                      vertical: isSmallScreen ? 6.0 : 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      post['price'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isSmallScreen ? 14.0 : 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Content
                        Padding(
                          padding: EdgeInsets.all(isSmallScreen ? 14.0 : 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badges
                              Row(
                                children: [
                                  if (post['isOrganic'])
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 8.0 : 10.0,
                                        vertical: isSmallScreen ? 5.0 : 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF10B981,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color(
                                            0xFF10B981,
                                          ).withOpacity(0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.eco_outlined,
                                            size: isSmallScreen ? 12.0 : 14.0,
                                            color: const Color(0xFF10B981),
                                          ),
                                          SizedBox(
                                            width: isSmallScreen ? 3.0 : 4.0,
                                          ),
                                          Text(
                                            'Organic',
                                            style: TextStyle(
                                              color: const Color(0xFF10B981),
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  isSmallScreen ? 12.0 : 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isSmallScreen ? 8.0 : 10.0,
                                      vertical: isSmallScreen ? 5.0 : 6.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: isSmallScreen ? 12.0 : 14.0,
                                          color: Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: isSmallScreen ? 3.0 : 4.0,
                                        ),
                                        Text(
                                          post['timePosted'],
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500,
                                            fontSize:
                                                isSmallScreen ? 12.0 : 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: isSmallScreen ? 14.0 : 16.0),

                              // Description
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16.0 : 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 6.0 : 8.0),
                              Text(
                                post['description'],
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14.0 : 16.0,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),

                              SizedBox(height: isSmallScreen ? 20.0 : 24.0),

                              // Seller Info
                              Text(
                                'Seller',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 16.0 : 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 10.0 : 12.0),
                              Row(
                                children: [
                                  Container(
                                    width: isSmallScreen ? 50.0 : 60.0,
                                    height: isSmallScreen ? 50.0 : 60.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        post['seller']['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: isSmallScreen ? 12.0 : 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              post['seller']['name'],
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 16.0 : 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (post['seller']['isVerified']) ...[
                                              SizedBox(
                                                width:
                                                    isSmallScreen ? 4.0 : 6.0,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  2,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF10B981),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  size:
                                                      isSmallScreen
                                                          ? 10.0
                                                          : 12.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        SizedBox(
                                          height: isSmallScreen ? 3.0 : 4.0,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: List.generate(5, (
                                                index,
                                              ) {
                                                double rating =
                                                    post['seller']['rating'];
                                                IconData iconData;
                                                if (index < rating.floor()) {
                                                  iconData = Icons.star;
                                                } else if (index < rating) {
                                                  iconData = Icons.star_half;
                                                } else {
                                                  iconData = Icons.star_border;
                                                }
                                                return Icon(
                                                  iconData,
                                                  size:
                                                      isSmallScreen
                                                          ? 14.0
                                                          : 16.0,
                                                  color: const Color(
                                                    0xFFFBBF24,
                                                  ),
                                                );
                                              }),
                                            ),
                                            SizedBox(
                                              width: isSmallScreen ? 4.0 : 6.0,
                                            ),
                                            Text(
                                              '${post['seller']['rating']} (${post['seller']['reviews']} reviews)',
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 12.0 : 14.0,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: isSmallScreen ? 20.0 : 24.0),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.message_outlined,
                                        size: isSmallScreen ? 16.0 : 18.0,
                                      ),
                                      label: const Text('Message'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: const Color(
                                          0xFF10B981,
                                        ),
                                        side: const BorderSide(
                                          color: Color(0xFF10B981),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: isSmallScreen ? 14.0 : 16.0,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: isSmallScreen ? 10.0 : 12.0),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.call_outlined,
                                        size: isSmallScreen ? 16.0 : 18.0,
                                      ),
                                      label: const Text('Call'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF10B981,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          vertical: isSmallScreen ? 14.0 : 16.0,
                                        ),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                ],
              ),
            );
          },
        );
      },
    );
  }
}
