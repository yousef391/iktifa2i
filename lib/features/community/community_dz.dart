import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:greenhood/constants.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _filters = [
    'El Kol',
    'As\'ila',
    'Nasaih',
    'Mounasbat',
    'Souk',
  ];
  String _selectedFilter = 'El Kol';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            _buildFilterChips(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(),
                  _buildLocalEventsTab(),
                  _buildGroupsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show post creation dialog
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Constants.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.flag, color: Color(0xFF0F5738), size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Majmou3at Iktifa2i Djazairia',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              Text(
                '5,234 3adou • 128 moutawassel',
                style: TextStyle(
                  fontSize: 12,
                  color: Constants.textSecondaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF666666)),
            onPressed: () {
              // Show search
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Constants.borderColor, width: 1),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Constants.primaryColor,
        unselectedLabelColor: Constants.textSecondaryColor,
        indicatorColor: Constants.primaryColor,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Jadid'),
          Tab(text: 'Mounasbat'),
          Tab(text: 'Majmou3at'),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;

          return Padding(
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Colors.white,
              selectedColor: Constants.primaryColor.withOpacity(0.1),
              checkmarkColor: Constants.primaryColor,
              labelStyle: TextStyle(
                color:
                    isSelected
                        ? Constants.primaryColor
                        : Constants.textSecondaryColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color:
                      isSelected
                          ? Constants.primaryColor
                          : Constants.borderColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFeaturedPost(),
        const SizedBox(height: 16),
        _buildCommunityPost(
          username: 'Amina Benali',
          timeAgo: 'sa3tayn',
          content:
              'Hsadna awel tamatim ta3na! Naw3 Biskra yenbet mezyan f manakhna. Wach kayen li 3ando tajriba m3a anwa3 mahaliya?',
          imageUrl:
              'https://images.unsplash.com/photo-1592841200221-a6898f307baa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          likes: 48,
          comments: 12,
          isVerified: true,
        ),
        _buildCommunityPost(
          username: 'Karim Hadj',
          timeAgo: '5 sa3at',
          content:
              'Soual: Chajrat zitouni 3andhom wra9 safra. Wach hada normal f waqt Ramdan wela lazem nbadel tari9at s9i? #mosa3ada #zitoun',
          imageUrl: null,
          likes: 15,
          comments: 23,
          isVerified: false,
        ),
        _buildCommunityPost(
          username: 'Leila Messaoudi',
          timeAgo: 'youm wahad',
          content:
              'Npartagé m3akoum setup ta3i li zra3t a3chab dakhel dar f Dzayer. Moura9ib rtouba 3awen bezzaf! Chouf ta9adoum ta3 na3na3 w habaq.',
          imageUrl:
              'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          likes: 89,
          comments: 34,
          isVerified: true,
        ),
        _buildMarketPost(
          username: 'Youcef Khelifi',
          timeAgo: 'youmayn',
          title: 'Nbi3 Smad 3adwi',
          description:
              'Smad 3adwi msnou3 f dar, mliha lel khodra. Msnou3 men nfayat lmatbakh. Mawjoud f 9santina. 500 DA lkis 5kg.',
          price: '500 DA',
          imageUrl:
              'https://images.unsplash.com/photo-1585314540237-13cb52fa9c12?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
        ),
      ],
    );
  }

  Widget _buildFeaturedPost() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF0F5738).withOpacity(0.05),
        border: Border.all(
          color: const Color(0xFF0F5738).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F5738).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFF0F5738), size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Tahaddi Majmou3a',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F5738),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F5738),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Charek',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tahaddi Zra3at Nabatat Djazairia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Charek f tahaddi chehri li zra3at w tawthiq nabatat djazairia. Had chhar nrekezou 3la anwa3 saharawiya. Charek ta9adoumek w rbah jawaiz!',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildProgressIndicator(
                      label: 'Ayam Baqiya',
                      value: '12',
                      icon: Icons.calendar_today,
                    ),
                    const SizedBox(width: 16),
                    _buildProgressIndicator(
                      label: 'Moucharikine',
                      value: '342',
                      icon: Icons.people,
                    ),
                    const SizedBox(width: 16),
                    _buildProgressIndicator(
                      label: 'Manacir',
                      value: '128',
                      icon: Icons.photo_library,
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

  Widget _buildProgressIndicator({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: const Color(0xFF0F5738)),
              const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0F5738),
                ),
              ),
            ],
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Constants.textSecondaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityPost({
    required String username,
    required String timeAgo,
    required String content,
    String? imageUrl,
    required int likes,
    required int comments,
    required bool isVerified,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Constants.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Constants.primaryColor.withOpacity(0.2),
                  child: Icon(Icons.person, color: Constants.primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (isVerified)
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.verified,
                                size: 16,
                                color: Constants.primaryColor,
                              ),
                            ),
                        ],
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: Constants.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Color(0xFF666666)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(content, style: const TextStyle(fontSize: 14)),
          ),
          if (imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.error)),
                    ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Constants.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      likes.toString(),
                      style: TextStyle(color: Constants.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                      color: Constants.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      comments.toString(),
                      style: TextStyle(color: Constants.textSecondaryColor),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.share,
                  size: 20,
                  color: Constants.textSecondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketPost({
    required String username,
    required String timeAgo,
    required String title,
    required String description,
    required String price,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Constants.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Constants.highlightColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 16,
                  color: Constants.highlightColor,
                ),
                const SizedBox(width: 4),
                Text(
                  'Souk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Constants.highlightColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Constants.highlightColor.withOpacity(0.2),
                  child: Icon(Icons.person, color: Constants.highlightColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 12,
                          color: Constants.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[200],
                          child: const Center(child: Icon(Icons.error)),
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Constants.highlightColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Constants.highlightColor,
                      side: BorderSide(color: Constants.highlightColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Rasel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.highlightColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Chouf Tafasil'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocalEventsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEventCard(
          title: 'Mahrajan Hadaiq Dzayer',
          date: '15-17 May, 2023',
          location: 'Jardin d\'Essai du Hamma, Dzayer',
          imageUrl:
              'https://images.unsplash.com/photo-1585320806297-9794b3e4eeae?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          attendees: 156,
          description:
              'Mahrajan sanawi li 3ard nabatat djazairia w t9niyat zra3a moustadama. Warach 3amal, mousaba9at, w bi3 nabatat.',
        ),
        _buildEventCard(
          title: 'Warcha Nabatat Saharawiya',
          date: '5 Juin, 2023',
          location: 'Hadiqat Nabatiya, Biskra',
          imageUrl:
              'https://images.unsplash.com/photo-1509222796416-4a1fef025e92?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          attendees: 42,
          description:
              'T3alem kifach tzra3 w t3tani b nabatat saharawiya f dar. Tarkiz khas 3la tawfir lma w anwa3 li t9awem lharara.',
        ),
        _buildEventCard(
          title: 'Liqa\' Tbadol Bzour',
          date: '12 Juin, 2023',
          location: 'Markaz Thaqafi, Wahran',
          imageUrl:
              'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          attendees: 89,
          description:
              'Jib bzourek bach tbadelhom m3a falahine khrine. Tarkiz 3la anwa3 9dima w mahasil djazairia t9lidiya.',
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String location,
    required String imageUrl,
    required int attendees,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Constants.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.error)),
                      ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.event, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        const Text(
                          'Mounasbat',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Constants.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(color: Constants.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Constants.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(color: Constants.textSecondaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Constants.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$attendees yahdhrou',
                      style: TextStyle(color: Constants.textSecondaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Constants.primaryColor,
                          side: BorderSide(color: Constants.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Mazid Ma3loumat'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Saheb Makan'),
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

  Widget _buildGroupsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildGroupCard(
          name: 'Falahine Madaniyine Djazairiyine',
          members: 1245,
          description:
              'Lel falahine f manatiq madaniya f kol Djazair. Partagé nasaih 3la zra3a f balkon, stah, w mahal sghira.',
          imageUrl:
              'https://images.unsplash.com/photo-1518012312832-96aea3c91144?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          isJoined: true,
        ),
        _buildGroupCard(
          name: 'Mouhebine Nabatat Saharawiya',
          members: 876,
          description:
              'Moukhasas li zra3a f manakh sahara s3ib. Anwa3 saharawiya, tawfir lma, w tadbir lharara.',
          imageUrl:
              'https://images.unsplash.com/photo-1509223197845-458d87318791?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          isJoined: false,
        ),
        _buildGroupCard(
          name: 'A3chab Djazairiya Taqlidiiya',
          members: 1532,
          description:
              'Zra3at w isti3mal a3chab djazairiya taqlidiiya lel tbikh, dawa, w atay. Hifadh ma3rifa thaqafiya lel nabatat mahaliya.',
          imageUrl:
              'https://images.unsplash.com/photo-1515586000433-45406d8e6662?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          isJoined: true,
        ),
        _buildGroupCard(
          name: 'Zawiyat Lmobtadi\'ine - الزاوية للمبتدئين',
          members: 2341,
          description:
              'Majmou3a bi loughatayn lel mobtadi\'ine f falaha. Makayen hata soual basit! Khod mosa3ada b 3arabiya wela fransawiya men falahine khabrine.',
          imageUrl:
              'https://images.unsplash.com/photo-1526565782131-a13074f0df52?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
          isJoined: false,
        ),
      ],
    );
  }

  Widget _buildGroupCard({
    required String name,
    required int members,
    required String description,
    required String imageUrl,
    required bool isJoined,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Constants.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 100,
              height: 120,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    width: 100,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    width: 100,
                    height: 120,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.error)),
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$members 3adou',
                    style: TextStyle(
                      fontSize: 12,
                      color: Constants.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isJoined ? Colors.white : Constants.primaryColor,
                      foregroundColor:
                          isJoined ? Constants.primaryColor : Colors.white,
                      side:
                          isJoined
                              ? BorderSide(color: Constants.primaryColor)
                              : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 36),
                    ),
                    child: Text(isJoined ? 'Mchatek' : 'Ncharek'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
