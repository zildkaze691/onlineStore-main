import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _selectedPeriod = 'All';
  String _sortBy = 'name';
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = MockData.products;
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = MockData.products.where((product) {
        final matchesCategory =
            _selectedCategory == 'All' || product.category == _selectedCategory;
        final matchesPeriod =
            _selectedPeriod == 'All' || product.period == _selectedPeriod;
        final matchesSearch = _searchController.text.isEmpty ||
            product.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());
        return matchesCategory && matchesPeriod && matchesSearch;
      }).toList();

      switch (_sortBy) {
        case 'name':
          _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'price':
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'rating':
          _filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TimePieces'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search timepieces...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (_) => _filterProducts(),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                          'All Categories', _selectedCategory == 'All', () {
                        setState(() {
                          _selectedCategory = 'All';
                          _filterProducts();
                        });
                      }),
                      const SizedBox(width: 8),
                      ...MockData.categories.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildFilterChip(
                              category, _selectedCategory == category, () {
                            setState(() {
                              _selectedCategory = category;
                              _filterProducts();
                            });
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      // ← Changed from Expanded to Flexible
                      child: DropdownButtonFormField<String>(
                        value: _selectedPeriod,
                        items: ['All', ...MockData.periods]
                            .map((period) => DropdownMenuItem(
                                  value: period,
                                  child: Text(
                                    period.length > 12
                                        ? '${period.substring(0, 10)}...' // Truncate long names
                                        : period,
                                    overflow: TextOverflow
                                        .ellipsis, // Add ellipsis if truncated
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) => setState(() {
                          _selectedPeriod = value!;
                          _filterProducts();
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Period',
                          border: OutlineInputBorder(),
                          isDense: true, // Reduces internal padding
                        ),
                        style: const TextStyle(fontSize: 12), // Smaller font
                      ),
                    ),
                    const SizedBox(width: 8), // Reduced spacing
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: _sortBy,
                        items: const [
                          DropdownMenuItem(
                              value: 'name', child: Text('Sort by Name')),
                          DropdownMenuItem(
                              value: 'price', child: Text('Sort by Price')),
                          DropdownMenuItem(
                              value: 'rating', child: Text('Sort by Rating')),
                        ],
                        onChanged: (value) => setState(() {
                          _sortBy = value!;
                          _filterProducts();
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Sort By',
                          border: OutlineInputBorder(),
                          isDense: true, // Reduces padding
                        ),
                        style: const TextStyle(fontSize: 12), // Smaller font
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.86,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return _buildProductCard(_filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      String label, bool selected, VoidCallback onSelected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryColor,
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(
        color: selected ? AppTheme.primaryColor : Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₱${product.price.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 15),
                      const SizedBox(width: 10),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
