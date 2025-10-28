import 'package:flutter/material.dart';

/// Bitişik bir menüyü "kaydırarak" gösteren bir widget.
///
/// `mainContent` (tetikleyici) her zaman görünür.
/// `isOpen` true olduğunda, `menuContent` `mainContent`'in sağında
/// bir animasyonla belirir ve widget'ın toplam genişliği artar.
class SlidingMenuContainer extends StatelessWidget {
  /// Her zaman görünür olan tetikleyici widget (örn. bir ikon butonu).
  final Widget mainContent;

  /// `isOpen` true olduğunda `mainContent`'in sağında belirecek olan widget.
  final Widget menuContent;

  /// Menünün açık mı kapalı mı olduğunu kontrol eder.
  final bool isOpen;

  /// Animasyon süresi.
  final Duration duration;

  /// Animasyon eğrisi.
  final Curve curve;

  const SlidingMenuContainer({
    super.key,
    required this.mainContent,
    required this.menuContent,
    required this.isOpen,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Sadece gereken alanı kapla
      children: [
        // 1. Tetikleyici (Her zaman görünür)
        mainContent,

        // 2. Anlık olarak genişleyen/daralan menü alanı
        AnimatedSize(
          duration: duration,
          curve: curve,
          // Yatayda genişlemesi için bir Row içine alıyoruz
          child: Row(
            children: [
              // isOpen true ise menuContent'i göster, değilse 0 genişlikte bir kutu göster
              if (isOpen)
                menuContent
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

