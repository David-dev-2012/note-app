import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/notes_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/screen_util_helper.dart';

class NoteColorPicker extends StatelessWidget {
  const NoteColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NotesController>();

    return Obx(() {
      return Container(
        height: Dimens.h(48),
        padding: EdgeInsets.symmetric(vertical: Dimens.h(4)),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Dimens.paddingL),
          itemCount: AppColors.noteColors.length,
          separatorBuilder: (_, __) => SizedBox(width: Dimens.w(10)),
          itemBuilder: (_, index) {
            final isSelected = ctrl.selectedColorIndex.value == index;
            final color = AppColors.noteColors[index];
            return GestureDetector(
              onTap: () => ctrl.selectColor(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: Dimens.w(28),
                height: Dimens.w(28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      AppColors.noteGradients[
                          (index * 2 + 1) % AppColors.noteGradients.length],
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 2.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: Dimens.w(14),
                      )
                    : null,
              ),
            );
          },
        ),
      );
    });
  }
}