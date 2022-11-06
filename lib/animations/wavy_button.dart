// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, sort_child_properties_last

import 'package:flutter/material.dart';
import 'dart:math' show pi;

import '../theme/colors.dart';

class PlayButton extends StatefulWidget {
  final bool initialIsPlaying;
  final String firstIcon;
  final Icon secondIcon;
  final VoidCallback onPressed;

  const PlayButton({
    super.key,
    required this.onPressed,
    this.initialIsPlaying = false,
    this.firstIcon = "assets/images/avatar.jpg",
    this.secondIcon =
        const Icon(Icons.light_mode_outlined, color: Colors.black),
  }) : assert(onPressed != null);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  static const _kToggleDuration = Duration(milliseconds: 300);
  static const _kRotationDuration = Duration(seconds: 5);

  late bool isPlaying;

  // rotation and scale animations
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  double _rotation = 0;
  double _scale = 0.85;

  bool get _showWaves => !_scaleController.isDismissed;

  void _updateRotation() => _rotation = _rotationController.value * 2 * pi;
  void _updateScale() => _scale = (_scaleController.value * 0.2) + 0.85;

  @override
  void initState() {
    isPlaying = widget.initialIsPlaying;
    _rotationController =
        AnimationController(vsync: this, duration: _kRotationDuration)
          ..addListener(() => setState(_updateRotation))
          ..repeat();

    _scaleController =
        AnimationController(vsync: this, duration: _kToggleDuration)
          ..addListener(() => setState(_updateScale));

    super.initState();
  }

  void _onToggle() {
    setState(() => isPlaying = !isPlaying);

    if (_scaleController.isCompleted) {
      _scaleController.reverse();
    } else {
      _scaleController.forward();
    }

    widget.onPressed();
  }

  Widget _buildIcon(bool isPlaying) {
    return SizedBox.expand(
      key: ValueKey<bool>(isPlaying),
      child: isPlaying
          ? InkWell(
              onTap: _onToggle,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  widget.firstIcon,
                ),
              ),
            )
          : IconButton(
              icon: widget.secondIcon,
              onPressed: _onToggle,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_showWaves) ...[
            Blob(
                color: const Color(0xff0092ff),
                scale: _scale,
                rotation: _rotation),
            Blob(
                color: const Color(0xff4ac7b7),
                scale: _scale,
                rotation: _rotation * 2 - 30),
            Blob(
                color: const Color(0xffa4a6f6),
                scale: _scale,
                rotation: _rotation * 3 - 45),
          ],
          Container(
            constraints: const BoxConstraints.expand(),
            child: AnimatedSwitcher(
              child: _buildIcon(isPlaying),
              duration: _kToggleDuration,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors["primary"],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }
}

class Blob extends StatelessWidget {
  final double rotation;
  final double scale;
  final Color? color;

  const Blob({super.key, this.color, this.rotation = 0, this.scale = 1});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Transform.rotate(
        angle: rotation,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(150),
              topRight: Radius.circular(240),
              bottomLeft: Radius.circular(220),
              bottomRight: Radius.circular(180),
            ),
          ),
        ),
      ),
    );
  }
}
