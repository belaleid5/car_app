
// ============================================
// 1. Models & Entities
// ============================================

import 'package:flutter/material.dart';

/// Filter State Model - Single Responsibility
class FilterState {
  final String carType;
  final RangeValues priceRange;
  final String? rentalTime;
  final DateTime? pickupDate;
  final String? location;
  final int? selectedColorId;
  final int sittingCapacity;
  final String fuelType;

  const FilterState({
    this.carType = 'All Cars',
    this.priceRange = const RangeValues(10, 230),
    this.rentalTime,
    this.pickupDate,
    this.location,
    this.selectedColorId = 3, // Blue default
    this.sittingCapacity = 4,
    this.fuelType = 'Electric',
  });

  FilterState copyWith({
    String? carType,
    RangeValues? priceRange,
    String? rentalTime,
    DateTime? pickupDate,
    String? location,
    int? selectedColorId,
    int? sittingCapacity,
    String? fuelType,
  }) {
    return FilterState(
      carType: carType ?? this.carType,
      priceRange: priceRange ?? this.priceRange,
      rentalTime: rentalTime ?? this.rentalTime,
      pickupDate: pickupDate ?? this.pickupDate,
      location: location ?? this.location,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      sittingCapacity: sittingCapacity ?? this.sittingCapacity,
      fuelType: fuelType ?? this.fuelType,
    );
  }

  bool get hasActiveFilters =>
      carType != 'All Cars' ||
      priceRange.start != 10 ||
      priceRange.end != 230 ||
      rentalTime != null ||
      selectedColorId != 3 ||
      sittingCapacity != 4 ||
      fuelType != 'Electric';
}

/// Color Option Model
class ColorOption {
  final int id;
  final String name;
  final Color color;

  const ColorOption({
    required this.id,
    required this.name,
    required this.color,
  });
}

// ============================================
// 2. Constants - Dependency Inversion
// ============================================

abstract class FilterConstants {
  static const List<String> carTypes = ['All Cars', 'Regular Cars', 'Luxury Cars'];
  static const List<String> rentalTimes = ['Hour', 'Day', 'Weekly', 'Monthly'];
  static const List<int> capacities = [2, 4, 6, 8];
  static const List<String> fuelTypes = ['Electric', 'Petrol', 'Diesel', 'Hybrid'];
  
  static const List<ColorOption> colors = [
    ColorOption(id: 1, name: 'White', color: Colors.white),
    ColorOption(id: 2, name: 'Gray', color: Colors.grey),
    ColorOption(id: 3, name: 'Blue', color: Colors.blue),
    ColorOption(id: 4, name: 'Black', color: Colors.black),
  ];

  static const double minPrice = 0;
  static const double maxPrice = 250;
  static const RangeValues defaultPriceRange = RangeValues(10, 230);
}

// ============================================
// 3. Main Screen - Single Responsibility
// ============================================


class CarFiltersScreen extends StatefulWidget {
  final Function(FilterState)? onApplyFilters;
  final Function()? onClearFilters;

  const CarFiltersScreen({
    super.key,
    this.onApplyFilters,
    this.onClearFilters,
  });

  @override
  State<CarFiltersScreen> createState() => _CarFiltersScreenState();
}

class _CarFiltersScreenState extends State<CarFiltersScreen> {
  late FilterState _filterState;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filterState = const FilterState();
  }

  void _updateFilter(FilterState newState) {
    setState(() => _filterState = newState);
  }

  void _handleApplyFilters() {
    setState(() => _isLoading = true);
    widget.onApplyFilters?.call(_filterState);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
      }
    });
  }

  void _handleClearFilters() {
    setState(() {
      _filterState = const FilterState();
      _isLoading = true;
    });
    widget.onClearFilters?.call();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isLoading = false);
    });
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
          FilterHeader(onClose: () => Navigator.pop(context)),
          const Divider(height: 1),
          Expanded(
            child: FilterContent(
              filterState: _filterState,
              onFilterChanged: _updateFilter,
            ),
          ),
          FilterBottomActions(
            isLoading: _isLoading,
            hasActiveFilters: _filterState.hasActiveFilters,
            onClear: _handleClearFilters,
            onApply: _handleApplyFilters,
          ),
        ],
      ),
    );
  }
}

// ============================================
// 4. Header Component - Single Responsibility
// ============================================

class FilterHeader extends StatelessWidget {
  final VoidCallback onClose;

  const FilterHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onClose,
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
    );
  }
}

// ============================================
// 5. Content Component - Open/Closed Principle
// ============================================

class FilterContent extends StatelessWidget {
  final FilterState filterState;
  final Function(FilterState) onFilterChanged;

  const FilterContent({
    super.key,
    required this.filterState,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FilterSection(
          title: 'Type of Cars',
          child: CarTypeSelector(
            selectedType: filterState.carType,
            onTypeSelected: (type) => onFilterChanged(
              filterState.copyWith(carType: type),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Price range',
          child: PriceRangeSelector(
            priceRange: filterState.priceRange,
            onPriceChanged: (range) => onFilterChanged(
              filterState.copyWith(priceRange: range),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Rental Time',
          child: RentalTimeSelector(
            selectedTime: filterState.rentalTime,
            onTimeSelected: (time) => onFilterChanged(
              filterState.copyWith(rentalTime: time),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Pick up and Drop Date',
          child: DatePickerField(
            selectedDate: filterState.pickupDate,
            onDateSelected: (date) => onFilterChanged(
              filterState.copyWith(pickupDate: date),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Car Location',
          child: LocationField(
            location: filterState.location,
            onLocationChanged: (loc) => onFilterChanged(
              filterState.copyWith(location: loc),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Colors',
          titleAction: TextButton(
            onPressed: () {},
            child: const Text(
              'See All',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          child: ColorSelector(
            selectedColorId: filterState.selectedColorId,
            onColorSelected: (id) => onFilterChanged(
              filterState.copyWith(selectedColorId: id),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Siting Capacity',
          child: CapacitySelector(
            selectedCapacity: filterState.sittingCapacity,
            onCapacitySelected: (capacity) => onFilterChanged(
              filterState.copyWith(sittingCapacity: capacity),
            ),
          ),
        ),
        const SizedBox(height: 30),
        FilterSection(
          title: 'Fuel Type',
          child: FuelTypeSelector(
            selectedFuelType: filterState.fuelType,
            onFuelTypeSelected: (type) => onFilterChanged(
              filterState.copyWith(fuelType: type),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ============================================
// 6. Filter Section Wrapper - DRY Principle
// ============================================

class FilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? titleAction;

  const FilterSection({
    super.key,
    required this.title,
    required this.child,
    this.titleAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (titleAction != null) titleAction!,
          ],
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

// ============================================
// 7. Selectors - Interface Segregation
// ============================================

class CarTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const CarTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FilterConstants.carTypes.map((type) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SelectableChip(
              label: type,
              isSelected: selectedType == type,
              onTap: () => onTypeSelected(type),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class PriceRangeSelector extends StatelessWidget {
  final RangeValues priceRange;
  final Function(RangeValues) onPriceChanged;

  const PriceRangeSelector({
    super.key,
    required this.priceRange,
    required this.onPriceChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Histogram
        SizedBox(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(30, (index) {
              final heights = [
                10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 55, 50, 45, 40,
                50, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 15, 20, 25
              ];
              return Container(
                width: 8,
                height: heights[index].toDouble(),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
        RangeSlider(
          values: priceRange,
          min: FilterConstants.minPrice,
          max: FilterConstants.maxPrice,
          divisions: 50,
          activeColor: Colors.black,
          inactiveColor: Colors.grey.shade300,
          onChanged: onPriceChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceLabel(
                label: 'Minimum',
                value: '\$${priceRange.start.round()}',
              ),
              PriceLabel(
                label: 'Maximum',
                value: '\$${priceRange.end.round()}+',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceLabel extends StatelessWidget {
  final String label;
  final String value;

  const PriceLabel({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class RentalTimeSelector extends StatelessWidget {
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const RentalTimeSelector({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FilterConstants.rentalTimes.map((time) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SelectableChip(
              label: time,
              isSelected: selectedTime == time,
              isOutlined: true,
              onTap: () => onTimeSelected(time),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) onDateSelected(date);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  selectedDate != null
                      ? _formatDate(selectedDate!)
                      : '05,Jun,2024',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day},${months[date.month - 1]},${date.year}';
  }
}

class LocationField extends StatelessWidget {
  final String? location;
  final Function(String) onLocationChanged;

  const LocationField({
    super.key,
    required this.location,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(
            location ?? 'Shore Dr, Chicago 0062 Usa',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  final int? selectedColorId;
  final Function(int) onColorSelected;

  const ColorSelector({
    super.key,
    required this.selectedColorId,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FilterConstants.colors.map((colorOption) {
        final isSelected = selectedColorId == colorOption.id;
        return Expanded(
          child: GestureDetector(
            onTap: () => onColorSelected(colorOption.id),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorOption.color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorOption.color == Colors.white
                          ? Colors.grey.shade300
                          : colorOption.color,
                      width: isSelected ? 3 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: colorOption.color.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ]
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  colorOption.name,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.black : Colors.grey,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CapacitySelector extends StatelessWidget {
  final int selectedCapacity;
  final Function(int) onCapacitySelected;

  const CapacitySelector({
    super.key,
    required this.selectedCapacity,
    required this.onCapacitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FilterConstants.capacities.map((capacity) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SelectableChip(
              label: capacity.toString(),
              isSelected: selectedCapacity == capacity,
              onTap: () => onCapacitySelected(capacity),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class FuelTypeSelector extends StatelessWidget {
  final String selectedFuelType;
  final Function(String) onFuelTypeSelected;

  const FuelTypeSelector({
    super.key,
    required this.selectedFuelType,
    required this.onFuelTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: FilterConstants.fuelTypes.map((type) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SelectableChip(
              label: type,
              isSelected: selectedFuelType == type,
              onTap: () => onFuelTypeSelected(type),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ============================================
// 8. Reusable Components - DRY Principle
// ============================================

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isOutlined;
  final VoidCallback onTap;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.isOutlined = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected && !isOutlined ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? Colors.black
                : Colors.grey.shade300,
            width: isSelected && isOutlined ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected && !isOutlined ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ============================================
// 9. Bottom Actions - Single Responsibility
// ============================================

class FilterBottomActions extends StatelessWidget {
  final bool isLoading;
  final bool hasActiveFilters;
  final VoidCallback onClear;
  final VoidCallback onApply;

  const FilterBottomActions({
    super.key,
    required this.isLoading,
    required this.hasActiveFilters,
    required this.onClear,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: isLoading ? null : onClear,
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
              onPressed: isLoading ? null : onApply,
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
                      'Show 100+ Cars',
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
}