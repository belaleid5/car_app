import 'package:car_app/core/responsive/responsive_helper.dart';
import 'package:car_app/core/widget/custom_shimmer_card.dart';
import 'package:flutter/widgets.dart';

class CustomListShimmer extends StatelessWidget {
  const CustomListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final res = ResponsiveHelper(context);
    return SizedBox(
      height: res.hp(250),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: res.screenWidth * 0.42,
              child: CustomShimmerCard(res: res,),
            ),
          );
        },
      ),
    );
    
  }
}
