import 'package:flutter/material.dart';

/// Widget de loading reutilizable
class LoadingIndicator extends StatelessWidget {
  final String? message;
  final bool fullScreen;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.fullScreen = false,
    this.color,
  });

  /// Loading que cubre toda la pantalla con overlay
  const LoadingIndicator.fullScreen({
    super.key,
    this.message,
    this.color,
  }) : fullScreen = true;

  @override
  Widget build(BuildContext context) {
    final indicator = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color ?? Theme.of(context).primaryColor,
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (fullScreen) {
      return Container(
        color: Colors.black.withValues(alpha: 0.5),
        child: Center(child: indicator),
      );
    }

    return Center(child: indicator);
  }
}
