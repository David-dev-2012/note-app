import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/screen_util_helper.dart';
import '../../model/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback? onPinTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    this.onPinTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorIndex = note.colorIndex % AppColors.noteColors.length;
    final baseColor = AppColors.noteColors[colorIndex];
    final gradColor = AppColors.noteGradients[
        (colorIndex * 2 + 1) % AppColors.noteGradients.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radiusL),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [baseColor, gradColor],
          ),
          boxShadow: [
            BoxShadow(
              color: baseColor.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimens.radiusL),
          child: Padding(
            padding: EdgeInsets.all(Dimens.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        note.title,
                        style: AppTextStyles.noteTitle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (note.isPinned)
                      Padding(
                        padding: EdgeInsets.only(left: Dimens.w(4)),
                        child: Icon(
                          Icons.push_pin_rounded,
                          color: Colors.white.withOpacity(0.7),
                          size: Dimens.w(14),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: Dimens.h(8)),
                Expanded(
                  child: Text(
                    note.body,
                    style: AppTextStyles.noteBody,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: Dimens.h(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormatter.formatRelative(note.updatedAt),
                      style: AppTextStyles.noteDate,
                    ),
                    GestureDetector(
                      onTap: onPinTap,
                      child: Container(
                        width: Dimens.w(28),
                        height: Dimens.w(28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          note.isPinned
                              ? Icons.push_pin_rounded
                              : Icons.push_pin_outlined,
                          color: Colors.white.withOpacity(0.7),
                          size: Dimens.w(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}