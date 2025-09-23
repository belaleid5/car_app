import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/features/auth/domain/entities/location_entity.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/widgets/location_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CustomSelectLocation extends StatelessWidget {
  final TextEditingController locationController;
  final void Function(LocationEntity) onLocationSelected;

  const CustomSelectLocation({
    super.key,
    required this.locationController,
    required this.onLocationSelected, // اجعلها مطلوبة
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: locationController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'اختر موقعك',
        prefixIcon: const Icon(Icons.location_on_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => value == null || value.isEmpty ? 'الموقع مطلوب' : null,
      onTap: () async {
        final result = await showModalBottomSheet<LocationEntity>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<AuthCubit>(context),
            child: const LocationsBottomSheet(), // افترض أن هذا هو الـ BottomSheet
          ),
        );

        if (result != null) {
          onLocationSelected(result);
        }
      },
    );
  }
}
