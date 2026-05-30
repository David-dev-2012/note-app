import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0, 0.6, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0, 0.5, curve: Curves.easeOutBack),
      ),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _getStarted() {
    final box = Hive.box(AppConstants.settingsBox);
    box.put(AppConstants.isFirstOpen, false);
    Get.offNamed(AppConstants.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimens.paddingL),
          child: Column(
            children: [
              SizedBox(height: Dimens.h(32)),
              Expanded(
                flex: 5,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: _OnboardingIllustration(),
                  ),
                ),
              ),
              SizedBox(height: Dimens.h(24)),
              Expanded(
                flex: 3,
                child: SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Column(
                      children: [
                        Text(
                          AppStrings.onboardingTitle,
                          style: AppTextStyles.displayLarge.copyWith(
                            fontSize: 38.sp,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimens.h(16)),
                        Text(
                          AppStrings.onboardingSubtitle,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _slideAnim,
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: _GetStartedButton(onTap: _getStarted),
                ),
              ),
              SizedBox(height: Dimens.h(40)),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.w(16)),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(Dimens.radiusXL),
        border: Border.all(
          color: AppColors.divider,
          width: 1.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _NotebookPainter()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PersonIllustration(),
            ],
          ),
        ],
      ),
    );
  }
}

class _PersonIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimens.w(200),
      height: Dimens.h(240),
      child: CustomPaint(painter: _PersonPainter()),
    );
  }
}

class _PersonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final docPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final docShadow = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.18, h * 0.18, w * 0.64, h * 0.68),
        const Radius.circular(12),
      ),
      docShadow,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.64, h * 0.68),
        const Radius.circular(12),
      ),
      docPaint,
    );

    // Accent strip on the note
    final accentPaint = Paint()..color = AppColors.accent.withOpacity(0.15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.15, h * 0.15, w * 0.06, h * 0.68),
        const Radius.circular(3),
      ),
      accentPaint,
    );

    final linePaint = Paint()
      ..color = const Color(0xFFE8E8F0)
      ..strokeWidth = 1.5;
    for (int i = 0; i < 5; i++) {
      final y = h * 0.32 + i * h * 0.08;
      canvas.drawLine(
        Offset(w * 0.22, y),
        Offset(w * 0.72, y),
        linePaint,
      );
    }

    final skinPaint = Paint()..color = const Color(0xFFFFD5B8);
    final bodyPaint = Paint()..color = AppColors.primary;
    final pantsPaint = Paint()..color = const Color(0xFF42487A);

    canvas.drawCircle(Offset(w * 0.5, h * 0.22), w * 0.1, skinPaint);

    final bodyPath = Path()
      ..moveTo(w * 0.36, h * 0.33)
      ..lineTo(w * 0.64, h * 0.33)
      ..lineTo(w * 0.62, h * 0.58)
      ..lineTo(w * 0.38, h * 0.58)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.24, h * 0.33, w * 0.12, h * 0.26),
        const Radius.circular(6),
      ),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.64, h * 0.33, w * 0.12, h * 0.26),
        const Radius.circular(6),
      ),
      bodyPaint,
    );

    canvas.drawCircle(Offset(w * 0.30, h * 0.60), w * 0.055, skinPaint);
    canvas.drawCircle(Offset(w * 0.70, h * 0.60), w * 0.055, skinPaint);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.38, h * 0.58, w * 0.1, h * 0.28),
        const Radius.circular(5),
      ),
      pantsPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.52, h * 0.58, w * 0.1, h * 0.28),
        const Radius.circular(5),
      ),
      pantsPaint,
    );

    final shoePaint = Paint()..color = const Color(0xFF333333);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.35, h * 0.83, w * 0.14, h * 0.07),
        const Radius.circular(4),
      ),
      shoePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.51, h * 0.83, w * 0.14, h * 0.07),
        const Radius.circular(4),
      ),
      shoePaint,
    );

    final notePaint = Paint()..color = Colors.white;
    final noteShadow = Paint()
      ..color = Colors.black.withOpacity(0.10)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.63, h * 0.46, w * 0.18, h * 0.22),
        const Radius.circular(4),
      ),
      noteShadow,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.45, w * 0.18, h * 0.22),
        const Radius.circular(4),
      ),
      notePaint,
    );

    // Accent strip on small note
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.45, w * 0.025, h * 0.22),
        const Radius.circular(1),
      ),
      Paint()..color = AppColors.accent.withOpacity(0.2),
    );

    final smallLine = Paint()
      ..color = const Color(0xFFE8E8F0)
      ..strokeWidth = 1;
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(w * 0.65, h * 0.50 + i * h * 0.05),
        Offset(w * 0.77, h * 0.50 + i * h * 0.05),
        smallLine,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent.withOpacity(0.06)
      ..strokeWidth = 1;
    const spacing = 20.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GetStartedButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GetStartedButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimens.w(64),
        height: Dimens.w(64),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.accent, AppColors.primary],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: Dimens.iconM,
        ),
      ),
    );
  }
}