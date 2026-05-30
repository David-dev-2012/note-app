import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class NoteAlertDialog extends StatelessWidget {
  final String message;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const NoteAlertDialog({
    super.key,
    required this.message,
    required this.onSave,
    required this.onDelete,
  });

  static void show({
    required String message,
    required VoidCallback onSave,
    required VoidCallback onDelete,
  }) {
    Get.bottomSheet(
      NoteAlertDialog(
        message: message,
        onSave: onSave,
        onDelete: onDelete,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.paddingM,
        vertical: Dimens.paddingM,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimens.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.paddingL,
          vertical: Dimens.paddingL,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Dimens.w(40),
              height: Dimens.h(4),
              decoration: BoxDecoration(
                color: AppColors.textHint.withOpacity(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: Dimens.h(20)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: Dimens.w(28),
                    height: Dimens.w(28),
                    decoration: BoxDecoration(
                      color: AppColors.bgLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: Dimens.iconS,
                      color: AppColors.textMedium,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.h(24)),
            Row(
              children: [
                Expanded(
                  child: _AlertActionButton(
                    label: AppStrings.save,
                    icon: Icons.check_circle_outline_rounded,
                    color: AppColors.accent,
                    onTap: () {
                      Get.back();
                      onSave();
                    },
                  ),
                ),
                SizedBox(width: Dimens.w(12)),
                Expanded(
                  child: _AlertActionButton(
                    label: AppStrings.delete,
                    icon: Icons.delete_outline_rounded,
                    color: AppColors.error,
                    onTap: () {
                      Get.back();
                      onDelete();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimens.h(8)),
          ],
        ),
      ),
    );
  }
}

class _AlertActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AlertActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Dimens.h(52),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(Dimens.radiusM),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: Dimens.iconS),
            SizedBox(width: Dimens.w(6)),
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}