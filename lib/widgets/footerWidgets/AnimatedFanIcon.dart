import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedFanIcon extends StatefulWidget {
  final FanSpeed selectedFanSpeed;
  final double rotationSpeed; // Dışarıdan belirlenen dönme hızı (tur/saniye)

  const AnimatedFanIcon({
    Key? key,
    required this.selectedFanSpeed,
    this.rotationSpeed = 0.0,
  }) : super(key: key);

  @override
  State<AnimatedFanIcon> createState() => _AnimatedFanIconState();
}

class _AnimatedFanIconState extends State<AnimatedFanIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Controller'ı başlangıçta maksimum hıza uygun bir süreyle oluşturuyoruz.
    // Süre, 1 / rotationSpeed formülüne göre güncellenecek.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Animasyon değerini 0.0 (başlangıç) ile 1.0 (tam tur) arasında ayarlıyoruz
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Başlangıç hızını ayarla
    _updateAnimationSpeed(widget.rotationSpeed);
  }

  // Yeni rotationSpeed geldiğinde animasyon süresini günceller ve tekrar başlatır.
  void _updateAnimationSpeed(double newSpeed) {
    if (newSpeed <= 0.01) {
      // Hız sıfır veya çok düşükse durdur
      if (_controller.isAnimating) {
        _controller.stop();
        _controller.value = 0.0; // Kapalı konumda durmasını sağlamak için
      }
    } else {
      // Süre = 1 saniye / Hız. Örneğin hız 5.0 ise süre 200ms (0.2s) olmalı.
      int durationInMs = (1000 / newSpeed).round();

      _controller.duration = Duration(milliseconds: durationInMs);

      // Zaten çalışıyorsa durdurup yeni hızla tekrar başlat, yoksa sadece başlat
      if (_controller.isAnimating) {
        _controller.repeat();
      } else {
        _controller.repeat();
      }
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedFanIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    // rotationSpeed değiştiyse animasyon hızını güncelle
    if (widget.rotationSpeed != oldWidget.rotationSpeed) {
      _updateAnimationSpeed(widget.rotationSpeed);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RotationTransition, animasyon değerini kullanarak SvgPicture'ı döndürür.
    return RotationTransition(
      turns: _animation,
      child: SvgPicture.asset(
        widget.selectedFanSpeed.icon,
        width: 40,
        height: 40,
        colorFilter: ColorFilter.mode(
          widget.selectedFanSpeed.color,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class FanSpeed {
  final int id;
  final String icon;
  final String label;
  final Color color;
  final double speed;

  FanSpeed({
    required this.id,
    required this.icon,
    required this.label,
    required this.color,
    this.speed = 0.0,
  });
}
