import 'package:flutter/material.dart';
import '../../../../core/presentation/styles/app_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Visit Addis',
          style: AppStyles.titleStyle,
        ),
        const SizedBox(height: 8),
        Text(
          'Discover the beauty of Ethiopia\'s capital',
          style: AppStyles.subtitleStyle,
        ),
      ],
    );
  }
} 