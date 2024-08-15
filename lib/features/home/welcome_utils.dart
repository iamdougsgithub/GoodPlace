import 'package:good_place/core/constants/app_assets.dart';
import 'package:good_place/core/utils/widgets/image_container.dart';

class WelcomeUtils {
  static Map<String, dynamic> getWelcomeData() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return {
        'icon': AssetImageContainer(
          path: AppAssets.goodMorningIcon,
        ),
        'message': 'Good Morning!',
      };
    } else if (hour >= 12 && hour < 18) {
      return {
        'icon': AssetImageContainer(
          path: AppAssets.goodAfternoonIcon,
        ),
        'message': 'Good Afternoon!',
      };
    } else {
      return {
        'icon': AssetImageContainer(
          path: AppAssets.goodNightIcon,
        ),
        'message': 'Good Night!',
      };
    }
  }
}
