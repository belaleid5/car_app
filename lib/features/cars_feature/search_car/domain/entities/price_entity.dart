import 'package:equatable/equatable.dart';

class PriceRangeEntity extends Equatable {
  final double min;
  final double max;

  const PriceRangeEntity({required this.min, required this.max});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceRangeEntity && min == other.min && max == other.max;

  @override
  int get hashCode => min.hashCode ^ max.hashCode;
  
  @override
  List<Object?> get props => [min, max];
} 


