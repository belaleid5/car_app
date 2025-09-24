import 'package:car_app/core/enums/app_states.dart';
import 'package:car_app/core/extention/adaptive_input_field.dart';
import 'package:car_app/core/utils/app_color.dart';
import 'package:car_app/core/utils/validators.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_cubit.dart';
import 'package:car_app/features/auth/presentation/blocs/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsBottomSheet extends StatefulWidget {
  const LocationsBottomSheet({super.key});

  @override
  State<LocationsBottomSheet> createState() => _LocationsBottomSheetState();
}

class _LocationsBottomSheetState extends State<LocationsBottomSheet> {
  final _scrollController = ScrollController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().refreshLocations();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),
                AdaptiveInputField(
                  controller: _locationController,
                  readOnly: true,
                  context: context,
                  hintText: 'Select Location',
                  validate: (value) => Validators.validateFullName(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.status == AppStatus.loading &&
                          state.locations!.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.neutral900,
                          ),
                        );
                      }
                      if (state.locations!.isEmpty) {
                        return const Center(child: Text('No locations found.'));
                      }
                      return _buildLocationsList(state, controller);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationsList(
    AuthState state,
    ScrollController scrollController,
  ) {
    return ListView.separated(
      controller: scrollController,
      itemCount: state.hasReachedMax
          ? state.locations!.length
          : state.locations!.length + 1,
      separatorBuilder: (context, index) =>
          const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (context, index) {
        if (index >= state.locations!.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final location = state.locations![index];
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(Icons.location_on_outlined, color: Colors.black54),
          ),
          title: Text(
            location.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () {
            Navigator.pop(context, location);
          },
        );
      },
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<AuthCubit>().getNextLocationsPage();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
