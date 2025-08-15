// 🔥 Advanced Custom Button
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType { primary, secondary, outline, text, gradient, icon }

enum ButtonSize { small, medium, large, extraLarge }

enum IconPosition { left, right, top, bottom }

class CustomButton extends StatefulWidget {
  // Main Properties
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  
  // Icon Properties
  final Widget? icon;
  final IconPosition iconPosition;
  final double? iconSpacing;
  
  // Size Properties
  final double? width;
  final double? height;
  final ButtonSize buttonSize;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  
  // Style Properties
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  
  // Text Properties
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  
  // Loading Properties
  final Widget? loadingWidget;
  final Color? loadingColor;
  final double? loadingSize;
  
  // Animation Properties
  final Duration? animationDuration;
  final Curve? animationCurve;
  final bool enableHapticFeedback;
  final bool enableSplashEffect;
  
  // State Properties
  final bool isExpanded;
  final double? elevation;
  final MaterialStateProperty<Color?>? overlayColor;
  
  const CustomButton({
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.buttonType = ButtonType.primary,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.iconSpacing,
    this.width,
    this.height,
    this.buttonSize = ButtonSize.medium,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderWidth,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.loadingWidget,
    this.loadingColor,
    this.loadingSize,
    this.animationDuration,
    this.animationCurve,
    this.enableHapticFeedback = true,
    this.enableSplashEffect = true,
    this.isExpanded = false,
    this.elevation,
    this.overlayColor,
    super.key,
  }) : assert(text != null || icon != null, 'Either text or icon must be provided');

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.w,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final button = _buildButton(context);
    
    Widget finalButton = button;
    
    // Apply margin if provided
    if (widget.margin != null) {
      finalButton = Padding(
        padding: widget.margin!,
        child: finalButton,
      );
    }
    
    // Apply expansion if needed
    if (widget.isExpanded) {
      finalButton = SizedBox(
        width: double.infinity,
        child: finalButton,
      );
    }
    
    // Apply custom size if provided
    if (widget.width != null || widget.height != null) {
      finalButton = SizedBox(
        width: widget.width,
        height: widget.height,
        child: finalButton,
      );
    }
    
    // Apply scale animation
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: finalButton,
        );
      },
    );
  }
  
  Widget _buildButton(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final buttonChild = _buildButtonContent(context);
    
    switch (widget.buttonType) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: _handlePress,
          style: buttonStyle,
          child: buttonChild,
        );
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: _handlePress,
          style: buttonStyle,
          child: buttonChild,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: _handlePress,
          style: buttonStyle,
          child: buttonChild,
        );
      case ButtonType.gradient:
        return _buildGradientButton(buttonChild);
      case ButtonType.icon:
        return _buildIconButton();
    }
  }
  
  Widget _buildGradientButton(Widget child) {
    return Container(
      decoration: BoxDecoration(
        gradient: widget.gradient ?? _getDefaultGradient(context),
        borderRadius: widget.borderRadius ?? _getDefaultBorderRadius(),
        boxShadow: widget.boxShadow,
        border: widget.borderColor != null
            ? Border.all(
                color: widget.borderColor!,
                width: widget.borderWidth ?? 1.w,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handlePress,
          onTapDown: widget.enableSplashEffect ? _onTapDown : null,
          onTapUp: widget.enableSplashEffect ? _onTapUp : null,
          onTapCancel: widget.enableSplashEffect ? _onTapCancel : null,
          borderRadius: widget.borderRadius ?? _getDefaultBorderRadius(),
          splashColor: widget.enableSplashEffect ? null : Colors.transparent,
          highlightColor: widget.enableSplashEffect ? null : Colors.transparent,
          child: Container(
            padding: _getPadding(),
            child: child,
          ),
        ),
      ),
    );
  }
  
  Widget _buildIconButton() {
    return IconButton(
      onPressed: _handlePress,
      icon: widget.isLoading ? _buildLoadingWidget() : (widget.icon ?? const Icon(Icons.add)),
      iconSize: _getIconSize(),
      color: widget.foregroundColor,
      disabledColor: widget.disabledForegroundColor,
      style: IconButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        disabledBackgroundColor: widget.disabledBackgroundColor,
        padding: _getPadding(),
      ),
    );
  }
  
  ButtonStyle _getButtonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: _getBackgroundColor(context),
      foregroundColor: _getForegroundColor(context),
      elevation: MaterialStateProperty.all(widget.elevation),
      padding: MaterialStateProperty.all(_getPadding()),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? _getDefaultBorderRadius(),
          side: widget.borderColor != null
              ? BorderSide(
                  color: widget.borderColor!,
                  width: widget.borderWidth ?? 1.w,
                )
              : BorderSide.none,
        ),
      ),
      overlayColor: widget.overlayColor,
      shadowColor: widget.boxShadow != null
          ? MaterialStateProperty.all(widget.boxShadow!.first.color)
          : null,
      animationDuration: widget.animationDuration ?? const Duration(milliseconds: 200),
    );
  }
  
  Widget _buildButtonContent(BuildContext context) {
    if (widget.isLoading) {
      return _buildLoadingWidget();
    }
    
    final textWidget = widget.text != null ? _buildTextWidget(context) : null;
    final iconWidget = widget.icon;
    
    if (textWidget == null && iconWidget == null) {
      return const SizedBox.shrink();
    }
    
    if (textWidget == null) return iconWidget!;
    if (iconWidget == null) return textWidget;
    
    return _buildIconTextLayout(iconWidget, textWidget);
  }
  
  Widget _buildIconTextLayout(Widget iconWidget, Widget textWidget) {
    final spacing = SizedBox(
      width: widget.iconPosition == IconPosition.left || widget.iconPosition == IconPosition.right
          ? (widget.iconSpacing ?? 8.w)
          : 0,
      height: widget.iconPosition == IconPosition.top || widget.iconPosition == IconPosition.bottom
          ? (widget.iconSpacing ?? 4.h)
          : 0,
    );
    
    switch (widget.iconPosition) {
      case IconPosition.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [iconWidget, spacing, textWidget],
        );
      case IconPosition.right:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [textWidget, spacing, iconWidget],
        );
      case IconPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [iconWidget, spacing, textWidget],
        );
      case IconPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [textWidget, spacing, iconWidget],
        );
    }
  }
  
  Widget _buildTextWidget(BuildContext context) {
    return Text(
      widget.text!,
      style: _getTextStyle(context),
      textAlign: TextAlign.center,
    );
  }
  
  Widget _buildLoadingWidget() {
    if (widget.loadingWidget != null) {
      return widget.loadingWidget!;
    }
    
    return SizedBox(
      width: widget.loadingSize ?? _getLoadingSize(),
      height: widget.loadingSize ?? _getLoadingSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.loadingColor ?? _getLoadingColor(),
        ),
      ),
    );
  }
  
  // Event Handlers
  void _handlePress() {
    if (widget.isLoading || widget.onPressed == null) return;
    
    if (widget.enableHapticFeedback) {
      // HapticFeedback.lightImpact();
    }
    
    widget.onPressed!();
  }
  
  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }
  
  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }
  
  void _onTapCancel() {
    _animationController.reverse();
  }
  
  // Style Getters
  MaterialStateProperty<Color?> _getBackgroundColor(BuildContext context) {
    if (widget.backgroundColor != null) {
      return MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return widget.disabledBackgroundColor ?? widget.backgroundColor!.withOpacity(0.5);
        }
        return widget.backgroundColor;
      });
    }
    
    switch (widget.buttonType) {
      case ButtonType.primary:
        return MaterialStateProperty.all(Theme.of(context).colorScheme.primary);
      case ButtonType.secondary:
        return MaterialStateProperty.all(Theme.of(context).colorScheme.secondary);
      default:
        return MaterialStateProperty.all(null);
    }
  }
  
  MaterialStateProperty<Color?> _getForegroundColor(BuildContext context) {
    if (widget.foregroundColor != null) {
      return MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return widget.disabledForegroundColor ?? widget.foregroundColor!.withOpacity(0.5);
        }
        return widget.foregroundColor;
      });
    }
    
    return MaterialStateProperty.all(null);
  }
  
  EdgeInsetsGeometry _getPadding() {
    if (widget.padding != null) return widget.padding!;
    
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h);
      case ButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h);
      case ButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h);
      case ButtonSize.extraLarge:
        return EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h);
    }
  }
  
  BorderRadius _getDefaultBorderRadius() {
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return BorderRadius.circular(6.r);
      case ButtonSize.medium:
        return BorderRadius.circular(8.r);
      case ButtonSize.large:
        return BorderRadius.circular(10.r);
      case ButtonSize.extraLarge:
        return BorderRadius.circular(12.r);
    }
  }
  
  TextStyle _getTextStyle(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: widget.fontSize ?? _getFontSize(),
      fontWeight: widget.fontWeight ?? FontWeight.w500,
      fontFamily: widget.fontFamily,
    );
    
    if (widget.textStyle != null) {
      return baseStyle.merge(widget.textStyle!);
    }
    
    return baseStyle;
  }
  
  double _getFontSize() {
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return 12.sp;
      case ButtonSize.medium:
        return 14.sp;
      case ButtonSize.large:
        return 16.sp;
      case ButtonSize.extraLarge:
        return 18.sp;
    }
  }
  
  double _getIconSize() {
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return 16.w;
      case ButtonSize.medium:
        return 20.w;
      case ButtonSize.large:
        return 24.w;
      case ButtonSize.extraLarge:
        return 28.w;
    }
  }
  
  double _getLoadingSize() {
    switch (widget.buttonSize) {
      case ButtonSize.small:
        return 16.w;
      case ButtonSize.medium:
        return 20.w;
      case ButtonSize.large:
        return 24.w;
      case ButtonSize.extraLarge:
        return 28.w;
    }
  }
  
  Color _getLoadingColor() {
    if (widget.buttonType == ButtonType.outline || 
        widget.buttonType == ButtonType.text) {
      return Theme.of(context).colorScheme.primary;
    }
    return Colors.white;
  }
  
  Gradient _getDefaultGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primary.withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

// 🎨 Pre-defined Button Styles
class ButtonStyles {
  static CustomButton primary({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      buttonType: ButtonType.primary,
      icon: icon,
      buttonSize: size,
    );
  }
  
  static CustomButton success({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      buttonType: ButtonType.primary,
      backgroundColor: Colors.green,
      icon: icon,
      buttonSize: size,
    );
  }
  
  static CustomButton danger({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      buttonType: ButtonType.primary,
      backgroundColor: Colors.red,
      icon: icon,
      buttonSize: size,
    );
  }
  
  static CustomButton gradient({
    required String text,
    required VoidCallback? onPressed,
    required Gradient gradient,
    bool isLoading = false,
    Widget? icon,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      buttonType: ButtonType.gradient,
      gradient: gradient,
      icon: icon,
      buttonSize: size,
    );
  }
  
  static CustomButton iconOnly({
    required Widget icon,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    ButtonSize size = ButtonSize.medium,
  }) {
    return CustomButton(
      icon: icon,
      onPressed: onPressed,
      isLoading: isLoading,
      buttonType: ButtonType.icon,
      backgroundColor: backgroundColor,
      buttonSize: size,
    );
  }
}

// 📱 Usage Examples
class ButtonExamples extends StatelessWidget {
  const ButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Button Examples')),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Basic Buttons
            CustomButton(
              text: 'Primary Button',
              onPressed: () {},
              buttonType: ButtonType.primary,
            ),
            SizedBox(height: 12.h),
            
            // Button with Icon
            CustomButton(
              text: 'Download',
              onPressed: () {},
              icon: const Icon(Icons.download),
              iconPosition: IconPosition.left,
              buttonType: ButtonType.secondary,
            ),
            SizedBox(height: 12.h),
            
            // Gradient Button
            CustomButton(
              text: 'Gradient Button',
              onPressed: () {},
              buttonType: ButtonType.gradient,
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
              ),
            ),
            SizedBox(height: 12.h),
            
            // Loading Button
            CustomButton(
              text: 'Loading...',
              onPressed: () {},
              isLoading: true,
            ),
            SizedBox(height: 12.h),
            
            // Custom Style Button
            CustomButton(
              text: 'Custom Style',
              onPressed: () {},
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              buttonSize: ButtonSize.large,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}