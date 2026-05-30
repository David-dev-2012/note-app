import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/notes_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import '../widgets/note_alert_dialog.dart';
import '../widgets/note_color_picker.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NotesController>();

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NoteDetailAppBar(ctrl: ctrl),
            SizedBox(height: Dimens.h(4)),
            const NoteColorPicker(),
            Divider(
              height: 1,
              color: AppColors.divider,
              indent: Dimens.paddingL,
              endIndent: Dimens.paddingL,
            ),
            SizedBox(height: Dimens.h(20)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.paddingL),
                child: Column(
                  children: [
                    TextField(
                      controller: ctrl.titleController,
                      style: AppTextStyles.inputTitle.copyWith(
                        fontSize: 28.sp,
                      ),
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: AppStrings.titleHint,
                        hintStyle: AppTextStyles.inputTitle.copyWith(
                          color: AppColors.textHint,
                          fontWeight: FontWeight.w400,
                          fontSize: 28.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(height: Dimens.h(16)),
                    Expanded(
                      child: TextField(
                        controller: ctrl.bodyController,
                        style: AppTextStyles.inputBody,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: AppStrings.bodyHint,
                          hintStyle: AppTextStyles.inputHint,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _NoteBottomToolbar(ctrl: ctrl),
          ],
        ),
      ),
    );
  }
}

class _NoteDetailAppBar extends StatelessWidget {
  final NotesController ctrl;
  const _NoteDetailAppBar({required this.ctrl});

  void _onSave(BuildContext context) async {
    final saved = await ctrl.saveNote();
    if (!saved) {
      NoteAlertDialog.show(
        message: AppStrings.alertTitle,
        onSave: () async => await ctrl.saveNote(),
        onDelete: () {
          if (ctrl.isEditing) {
            ctrl.deleteCurrentNote();
          } else {
            Get.back();
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.paddingM,
        Dimens.paddingS,
        Dimens.paddingM,
        Dimens.paddingS,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: Dimens.w(40),
              height: Dimens.w(40),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppColors.textDark,
                size: Dimens.iconS,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _onSave(context),
            child: Container(
              width: Dimens.w(40),
              height: Dimens.w(40),
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteBottomToolbar extends StatelessWidget {
  final NotesController ctrl;
  const _NoteBottomToolbar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.h(56),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ToolbarButton(
            icon: Icons.format_bold_rounded,
            onTap: () {},
          ),
          _ToolbarButton(
            icon: Icons.format_italic_rounded,
            onTap: () {},
          ),
          _ToolbarButton(
            icon: Icons.strikethrough_s_rounded,
            onTap: () {},
          ),
          _ToolbarButton(
            icon: Icons.format_list_bulleted_rounded,
            onTap: () {},
          ),
          Obx(() => ctrl.isEditing
              ? _ToolbarButton(
                  icon: Icons.delete_outline_rounded,
                  color: AppColors.error,
                  onTap: () {
                    NoteAlertDialog.show(
                      message: 'Delete this note?',
                      onSave: () async => await ctrl.saveNote(),
                      onDelete: ctrl.deleteCurrentNote,
                    );
                  },
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  const _ToolbarButton({
    required this.icon,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimens.w(40),
        height: Dimens.w(40),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          borderRadius: BorderRadius.circular(Dimens.radiusS),
        ),
        child: Icon(
          icon,
          color: color ?? AppColors.textMedium,
          size: Dimens.iconS,
        ),
      ),
    );
  }
}