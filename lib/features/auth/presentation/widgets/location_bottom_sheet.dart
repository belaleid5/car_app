import 'package:car_app/core/enums/app_states.dart';
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

  @override
  void initState() {
    super.initState();
    // نبدأ بجلب أول صفحة من المواقع
    context.read<AuthCubit>().refreshLocations();
    // نضيف Listener لمراقبة التمرير وجلب المزيد من البيانات
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    // استخدام DraggableScrollableSheet يسمح للمستخدم بسحب الـ sheet لأعلى ولأسفل
    return DraggableScrollableSheet(
      initialChildSize: 0.9, // الارتفاع الأولي عند الفتح
      minChildSize: 0.5, // أقل ارتفاع يمكن الوصول إليه
      maxChildSize: 0.9, // أقصى ارتفاع
      expand: false,
      builder: (_, controller) {
        // استخدام Container لإضافة الحواف الدائرية والخلفية البيضاء
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                // 1. الشريط الرمادي الصغير في الأعلى
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),

                // 2. الهيدر: العنوان وزر الإغلاق
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Location', // يمكنك تغيير هذا النص
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

                // 3. حقل البحث
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for a location...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none, // بدون حدود
                    ),
                  ),
                  // يمكنك إضافة منطق البحث هنا إذا أردت
                ),
                const SizedBox(height: 16),

                // 4. قائمة المواقع (قابلة للتمرير)
                Expanded(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.status == AppStatus.loading &&
                          state.locations!.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.locations!.isEmpty) {
                        return const Center(child: Text('No locations found.'));
                      }
                      // بناء القائمة مع التمرير اللانهائي
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

  // دالة بناء القائمة
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
        // إذا وصلنا لنهاية القائمة الحالية، نعرض مؤشر تحميل
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
          // الأيقونة التي على اليسار (مثل علم الدولة في الصورة)
          leading: const CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(Icons.location_on_outlined, color: Colors.black54),
          ),
          title: Text(
            location.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () {
            // عند اختيار موقع، أغلق الـ BottomSheet وأعد الموقع المختار
            Navigator.pop(context, location);
          },
        );
      },
    );
  }

  // دالة مراقبة التمرير
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // اطلب الصفحة التالية عندما يصل المستخدم إلى 90% من نهاية القائمة
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
