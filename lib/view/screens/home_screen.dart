import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../controller/notes_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import '../widgets/empty_notes_widget.dart';
import '../widgets/note_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<NotesController>();

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HomeHeader(ctrl: ctrl),
            Obx(() => ctrl.isSearching.value
                ? _SearchBar(ctrl: ctrl)
                : const SizedBox.shrink()),
            Expanded(
              child: Obx(() {
                if (ctrl.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accent,
                      strokeWidth: 3,
                    ),
                  );
                }

                final notes = ctrl.isSearching.value
                    ? ctrl.filteredNotes
                    : ctrl.notes;

                if (notes.isEmpty) {
                  return const EmptyNotesWidget();
                }

                return AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.fromLTRB(
                      Dimens.paddingM,
                      Dimens.paddingS,
                      Dimens.paddingM,
                      Dimens.h(100),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimens.w(12),
                      mainAxisSpacing: Dimens.h(14),
                      childAspectRatio: 0.82,
                    ),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: 2,
                        child: ScaleAnimation(
                          scale: 0.9,
                          child: FadeInAnimation(
                            child: NoteCard(
                              note: notes[index],
                              onTap: () {
                                ctrl.prepareEditNote(notes[index]);
                                Get.toNamed(AppConstants.noteDetailRoute);
                              },
                              onPinTap: () => ctrl.togglePin(notes[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ctrl.prepareNewNote();
          Get.toNamed(AppConstants.noteDetailRoute);
        },
        backgroundColor: AppColors.primary,
        elevation: 6,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final NotesController ctrl;
  const _HomeHeader({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.paddingL,
        Dimens.paddingL,
        Dimens.paddingL,
        Dimens.paddingS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.appName,
                style: AppTextStyles.h1.copyWith(fontSize: 28.sp),
              ),
              Obx(() {
                final count = ctrl.notes.length;
                return Text(
                  count > 0
                      ? '$count ${count == 1 ? 'note' : 'notes'}'
                      : 'No notes yet',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textLight,
                    fontSize: 13.sp,
                  ),
                );
              }),
            ],
          ),
          Row(
            children: [
              _HeaderIconButton(
                icon: Icons.search_rounded,
                onTap: () => ctrl.toggleSearch(),
              ),
              SizedBox(width: Dimens.w(8)),
              _HeaderIconButton(
                icon: Icons.more_horiz_rounded,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimens.w(40),
        height: Dimens.w(40),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: AppColors.textDark,
          size: Dimens.iconS,
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final NotesController ctrl;
  const _SearchBar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.paddingM,
        0,
        Dimens.paddingM,
        Dimens.paddingS,
      ),
      child: Container(
        height: Dimens.h(48),
        decoration: BoxDecoration(
          color: AppColors.bgLight,
          borderRadius: BorderRadius.circular(Dimens.radiusXL),
          border: Border.all(color: AppColors.divider),
        ),
        child: TextField(
          autofocus: true,
          onChanged: ctrl.updateSearch,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: AppStrings.searchHint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textHint,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColors.textLight,
              size: Dimens.iconS,
            ),
            suffixIcon: GestureDetector(
              onTap: ctrl.toggleSearch,
              child: Icon(
                Icons.close_rounded,
                color: AppColors.textLight,
                size: Dimens.iconS,
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: Dimens.h(14),
            ),
          ),
        ),
      ),
    );
  }
}