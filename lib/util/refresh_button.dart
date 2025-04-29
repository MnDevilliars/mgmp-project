import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../appcolors/app_colors.dart';

class RefreshButton extends StatelessWidget {
  final String url;
  final String label;

  const RefreshButton({super.key, required this.url, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push('/$url');
      },
      style: TextButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        backgroundColor: AppColors.primaryBottomBar,
        shadowColor: AppColors.secondaryBottomBar.withOpacity(0.4),
        elevation: 6,
        splashFactory: InkRipple.splashFactory,
      ),
      child: const Icon(
        Icons.refresh,
        color: AppColors.activeBottomIcon,
        size: 28,
      ),
    );
  }
}
