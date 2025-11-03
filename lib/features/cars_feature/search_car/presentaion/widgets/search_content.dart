
import 'package:car_app/core/constants/filter_constants.dart';
import 'package:car_app/core/shared/location_entity.dart';
import 'package:car_app/features/cars_feature/home/domain/entity/color_entity.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/car_filter.dart';
import 'package:car_app/features/cars_feature/search_car/domain/entities/price_entity.dart';
import 'package:car_app/features/cars_feature/search_car/presentaion/manger/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';














class CarFilterScreen extends StatefulWidget {
  final CarFilterEntity? initialFilter;
  final Function(CarFilterEntity) onApplyFilter;

  const CarFilterScreen({
    super.key,
    this.initialFilter,
    required this.onApplyFilter,
  });

  @override
  State<CarFilterScreen> createState() => _CarFilterScreenState();
}

class _CarFilterScreenState extends State<CarFilterScreen> {
  late CarFilterEntity _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter ?? const CarFilterEntity();
  }

  void _updateFilter(CarFilterEntity newFilter) {
    setState(() => _currentFilter = newFilter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * FilterConstants.filterBottomSheetHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarTypeSection(),
                  const SizedBox(height: 24),
                  _buildPriceRangeSection(),
                  const SizedBox(height: 24),
                  _buildRentalTimeSection(),
                  const SizedBox(height: 24),
                  _buildDatePickerSection(),
                  const SizedBox(height: 24),
                  _buildLocationSection(),
                  const SizedBox(height: 24),
                  _buildColorSection(),
                  const SizedBox(height: 24),
                  _buildSeatingCapacitySection(),
                  const SizedBox(height: 24),
                  _buildFuelTypeSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          const Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildCarTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type of Cars', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: FilterConstants.carTypes.map((type) {
            final isSelected = _currentFilter.carType == type ||
                (_currentFilter.carType == null && type == 'All Cars');
            return _buildChip(
              label: type,
              isSelected: isSelected,
              onTap: () => _updateFilter(
                _currentFilter.copyWith(carType: type == 'All Cars' ? null : type),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection() {
    final currentMin = _currentFilter.priceRange?.min ?? FilterConstants.minPrice;
    final currentMax = _currentFilter.priceRange?.max ?? FilterConstants.maxPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Price range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        RangeSlider(
          values: RangeValues(currentMin, currentMax),
          min: FilterConstants.minPrice,
          max: FilterConstants.maxPrice,
          divisions: 50,
          activeColor: Colors.black,
          inactiveColor: Colors.grey.shade300,
          onChanged: (values) {
            _updateFilter(
              _currentFilter.copyWith(
                priceRange: PriceRangeEntity(min: values.start, max: values.end),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPriceLabel('Minimum', currentMin.toInt()),
              _buildPriceLabel('Maximum', currentMax.toInt()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceLabel(String label, int price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            price >= FilterConstants.maxPrice ? '\$${price}+' : '\$$price',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildRentalTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rental Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: FilterConstants.rentalTimes.map((time) {
            final isSelected = _currentFilter.rentalTime == time;
            return _buildChip(
              label: time,
              isSelected: isSelected,
              onTap: () => _updateFilter(
                _currentFilter.copyWith(rentalTime: isSelected ? null : time),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDatePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pick up and Drop Date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _currentFilter.pickupDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              _updateFilter(_currentFilter.copyWith(pickupDate: picked));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 20, color: Colors.grey.shade600),
                    const SizedBox(width: 12),
                    Text(
                      _currentFilter.pickupDate != null
                          ? _formatDate(_currentFilter.pickupDate!)
                          : 'Select Date',
                    ),
                  ],
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.allCars == null || state.allCars!.isEmpty) {
          return const SizedBox.shrink();
        }

        final locations = <int, LocationEntity>{};
        for (var car in state.allCars!) {
          if (car.location != null) {
            locations[car.location!.id] = car.location!;
          }
        }

        if (locations.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Car Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _currentFilter.locationId,
              hint: const Text('Select Location'),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined, color: Colors.grey.shade600),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: locations.values.map((loc) {
                return DropdownMenuItem(value: loc.id, child: Text(loc.name));
              }).toList(),
              onChanged: (value) {
                _updateFilter(_currentFilter.copyWith(locationId: value));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildColorSection() {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state.allCars == null || state.allCars!.isEmpty) {
          return const SizedBox.shrink();
        }

        final colors = <int, ColorEntity>{};
        for (var car in state.allCars!) {
          colors[car.color.id] = car.color;
        }

        if (colors.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Colors', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: colors.values.map((color) {
                final isSelected = _currentFilter.colorId == color.id;
                return GestureDetector(
                  onTap: () => _updateFilter(
                    _currentFilter.copyWith(colorId: isSelected ? null : color.id),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _parseColor(color.name),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey.shade300,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        color.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSeatingCapacitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sitting Capacity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: FilterConstants.seatingCapacities.map((capacity) {
            final isSelected = _currentFilter.seatingCapacity?.toString() == capacity;
            return _buildChip(
              label: capacity,
              isSelected: isSelected,
              onTap: () => _updateFilter(
                _currentFilter.copyWith(
                  seatingCapacity: isSelected ? null : int.parse(capacity),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFuelTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fuel Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: FilterConstants.fuelTypes.map((fuel) {
            final isSelected = _currentFilter.fuelType == fuel;
            return _buildChip(
              label: fuel,
              isSelected: isSelected,
              onTap: () => _updateFilter(
                _currentFilter.copyWith(fuelType: isSelected ? null : fuel),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _currentFilter.hasActiveFilters
                  ? () {
                      setState(() => _currentFilter = _currentFilter.clear());
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: BorderSide(
                  color: _currentFilter.hasActiveFilters ? Colors.black : Colors.grey.shade300,
                ),
              ),
              child: Text(
                'Clear All',
                style: TextStyle(
                  color: _currentFilter.hasActiveFilters ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                widget.onApplyFilter(_currentFilter);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Show Results',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day}.${months[date.month - 1]}.${date.year}';
  }

  Color _parseColor(String name) {
    switch (name.toLowerCase()) {
      case 'white': return Colors.white;
      case 'gray':
      case 'grey': return Colors.grey;
      case 'blue': return Colors.blue;
      case 'black': return Colors.black;
      case 'red': return Colors.red;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
      default: return Colors.grey;
    }
  }
}

// ====================================================================================
// FILE 6: تحديث search_screen.dart - أضف في أول SearchScreen
// ====================================================================================

/*
في search_screen.dart، غيّر الزر بتاع الفلتر:

GestureDetector(
  onTap: () {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CarFilterScreen(
        initialFilter: context.read<SearchCubit>().state.currentFilter,
        onApplyFilter: (filter) {
          context.read<SearchCubit>().applyFilter(filter);
        },
      ),
    );
  },
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const Icon(Icons.tune, color: Colors.white, size: 24),
  ),
),

وفي CustomListBrand عند الضغط على البراند:

GestureDetector(
  onTap: () {
    setState(() => selectedIndex = isSelected ? null : index);
    if (isSelected) {
      context.read<SearchCubit>().clearFilter();
    } else {
      context.read<SearchCubit>().filterByBrand(brand.id);
    }
  },
  child: // ... باقي الكود
)

وفي BlocBuilder بتاع عرض السيارات:

final cars = state.responseSearchCars ?? state.allCars ?? [];
*/