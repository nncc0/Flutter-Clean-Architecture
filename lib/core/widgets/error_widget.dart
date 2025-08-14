// ❌ Error Widget
import 'package:flutter/material.dart';

class ErrorWidgetApp extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;
  
  const ErrorWidgetApp({
    required this.message,
    this.onRetry,
    this.retryText,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(retryText ?? 'Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
