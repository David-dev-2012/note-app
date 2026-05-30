import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/screen_util_helper.dart';

class EmptyNotesWidget extends StatelessWidget {
  const EmptyNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Dimens.w(200),
            height: Dimens.h(220),
            child: CustomPaint(painter: _EmptyIllustrationPainter()),
          ),
          SizedBox(height: Dimens.h(28)),
          Text(
            AppStrings.createFirstNote,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: Dimens.h(8)),
          Text(
            'Tap + to create your first note',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final whitePaint = Paint()..color = Colors.white;
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    // Back document (tilted)
    canvas.save();
    canvas.translate(w * 0.5, h * 0.45);
    canvas.rotate(-0.08);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: w * 0.6, height: h * 0.6),
        const Radius.circular(14),
      ),
      shadowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: w * 0.6, height: h * 0.6),
        const Radius.circular(14),
      ),
      whitePaint,
    );
    _drawLines(canvas, w * 0.6, h * 0.6);

    // Accent strip
    final backAccent = Paint()..color = AppColors.accent.withOpacity(0.1);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(-w * 0.28, 0),
          width: w * 0.04,
          height: h * 0.6,
        ),
        const Radius.circular(2),
      ),
      backAccent,
    );
    canvas.restore();

    // Front document
    canvas.save();
    canvas.translate(w * 0.5, h * 0.45);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: w * 0.56, height: h * 0.56),
        const Radius.circular(14),
      ),
      shadowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: w * 0.56, height: h * 0.56),
        const Radius.circular(14),
      ),
      whitePaint,
    );
    _drawLines(canvas, w * 0.56, h * 0.56);

    // Front accent strip
    final frontAccent = Paint()..color = AppColors.accent.withOpacity(0.15);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(-w * 0.26, 0),
          width: w * 0.04,
          height: h * 0.56,
        ),
        const Radius.circular(2),
      ),
      frontAccent,
    );
    canvas.restore();

    // Standing figure
    final skinPaint = Paint()..color = const Color(0xFFFFD5B8);
    final bodyPaint = Paint()..color = AppColors.primary;

    // Head
    canvas.drawCircle(Offset(w * 0.5, h * 0.12), w * 0.08, skinPaint);
    // Body - simplified
    final bodyPath = Path()
      ..moveTo(w * 0.38, h * 0.20)
      ..lineTo(w * 0.62, h * 0.20)
      ..lineTo(w * 0.60, h * 0.44)
      ..lineTo(w * 0.40, h * 0.44)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);
    // Legs
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.39, h * 0.44, w * 0.09, h * 0.22),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFF42487A),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.52, h * 0.44, w * 0.09, h * 0.22),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFF42487A),
    );
    // Arms
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.28, h * 0.20, w * 0.10, h * 0.20),
        const Radius.circular(5),
      ),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.62, h * 0.20, w * 0.10, h * 0.20),
        const Radius.circular(5),
      ),
      bodyPaint,
    );
    // Hands
    canvas.drawCircle(Offset(w * 0.33, h * 0.41), w * 0.045, skinPaint);
    canvas.drawCircle(Offset(w * 0.67, h * 0.41), w * 0.045, skinPaint);

    // Plus icon above
    final plusPaint = Paint()
      ..color = AppColors.accent.withOpacity(0.2)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(w * 0.5, h * 0.02), w * 0.06, plusPaint);
    final plusLine = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(w * 0.47, h * 0.02),
      Offset(w * 0.53, h * 0.02),
      plusLine,
    );
    canvas.drawLine(
      Offset(w * 0.50, h * -0.01),
      Offset(w * 0.50, h * 0.05),
      plusLine,
    );
  }

  void _drawLines(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..color = const Color(0xFFE8E8F0)
      ..strokeWidth = 1.2;
    for (int i = 0; i < 4; i++) {
      final y = -h * 0.2 + i * h * 0.12;
      canvas.drawLine(Offset(-w * 0.36, y), Offset(w * 0.36, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}