import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/searh_car_request_entity.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarFiltersScreen extends StatefulWidget {
  const CarFiltersScreen({super.key});

  @override
  State<CarFiltersScreen> createState() => _CarFiltersScreenState();
}

class _CarFiltersScreenState extends State<CarFiltersScreen> {
  String selectedCarType = 'All Cars';
  int? selectedBrandId;
  int? selectedLocationId;
  int? selectedColorId;
  int selectedCapacity = 4;
  String selectedFuelType = 'Electric';

  // Map للألوان مع IDs (عدّلهم حسب الـ API بتاعك)
  final Map<String, int> colorIds = {
    'White': 1,
    'Gray': 2,
    'Blue': 3,
    'Black': 4,
  };

  @override
  void initState() {
    super.initState();
    selectedColorId = 3; // Blue as default
  }

  void _applyFilters() {
    final searchCubit = context.read<SearchCubit>();

    // بناء الـ request entity
    final request = SearchCarRequestEntity(
      type: selectedCarType == 'All Cars' ? null : selectedCarType.toLowerCase().replaceAll(' ', '_'),
      brandId: selectedBrandId,
      locationId: selectedLocationId,
      colorId: selectedColorId,
      seatingCapacity: selectedCapacity,
      fuelType: selectedFuelType.toLowerCase(),
    );

    // استدعاء الـ search
    searchCubit.searchCars(request);

    // إغلاق الـ Bottom Sheet
    Navigator.pop(context);
  }

  void _clearFilters() {
    setState(() {
      selectedCarType = 'All Cars';
      selectedBrandId = null;
      selectedLocationId = null;
      selectedColorId = 3; // Blue default
      selectedCapacity = 4;
      selectedFuelType = 'Electric';
    });

    // استدعاء getAllCars للرجوع للحالة الأولية
    context.read<SearchCubit>().getAllCars();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          const Divider(height: 1),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Type of Cars
                const Text(
                  'Type of Cars',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildCarTypeChip('All Cars'),
                    const SizedBox(width: 8),
                    _buildCarTypeChip('Regular Cars'),
                    const SizedBox(width: 8),
                    _buildCarTypeChip('Luxury Cars'),
                  ],
                ),

                const SizedBox(height: 30),

                // Brand Selection
                const Text(
                  'Brand',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                _buildBrandSelector(),

                const SizedBox(height: 30),

                // Colors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Colors',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildColorOption('White', Colors.white),
                    const SizedBox(width: 20),
                    _buildColorOption('Gray', Colors.grey),
                    const SizedBox(width: 20),
                    _buildColorOption('Blue', Colors.blue),
                    const SizedBox(width: 20),
                    _buildColorOption('Black', Colors.black),
                  ],
                ),

                const SizedBox(height: 30),

                // Sitting Capacity
                const Text(
                  'Sitting Capacity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildCapacityChip(2),
                    const SizedBox(width: 8),
                    _buildCapacityChip(4),
                    const SizedBox(width: 8),
                    _buildCapacityChip(6),
                    const SizedBox(width: 8),
                    _buildCapacityChip(8),
                  ],
                ),

                const SizedBox(height: 30),

                // Fuel Type
                const Text(
                  'Fuel Type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildFuelTypeChip('Electric'),
                    const SizedBox(width: 8),
                    _buildFuelTypeChip('Petrol'),
                    const SizedBox(width: 8),
                    _buildFuelTypeChip('Diesel'),
                    const SizedBox(width: 8),
                    _buildFuelTypeChip('Hybrid'),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                final isLoading = state.appStatus == AppStatus.loading;

                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: isLoading ? null : _clearFilters,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Show Cars',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarTypeChip(String label) {
    final isSelected = selectedCarType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedCarType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandSelector() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.appStatus != AppStatus.success || state.allCars == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final allCars = state.allCars!;
        final brands = allCars.map((car) => car.brand).toSet().toList();

        if (brands.isEmpty) {
          return const Text('No brands available');
        }

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              final isSelected = selectedBrandId == brand.id;

              return GestureDetector(
                onTap: () => setState(() => selectedBrandId = brand.id),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (brand.image.isNotEmpty)
                        Image.network(
                          brand.image,
                          width: 20,
                          height: 20,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      if (brand.image.isNotEmpty) const SizedBox(width: 8),
                      Text(
                        brand.name,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildColorOption(String label, Color color) {
    final colorId = colorIds[label];
    final isSelected = selectedColorId == colorId;
    return GestureDetector(
      onTap: () => setState(() => selectedColorId = colorId),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: color == Colors.white ? Colors.grey.shade300 : color,
                width: isSelected ? 3 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityChip(int capacity) {
    final isSelected = selectedCapacity == capacity;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedCapacity = capacity),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
            ),
          ),
          child: Text(
            capacity.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFuelTypeChip(String label) {
    final isSelected = selectedFuelType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFuelType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}