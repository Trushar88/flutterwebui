// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutterwebtest/App/Extensions/uicontext.dart';

class BouncingButton extends StatefulWidget {
  final VoidCallback onPress;
  final Color? buttonColor;
  final Color? hoverColor;
  final Color? radiusColor;
  final double? radius;
  final String? text;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? hoverTextColor;

  const BouncingButton({Key? key, required this.onPress, this.buttonColor, this.hoverColor, this.textColor, this.hoverTextColor, this.radiusColor, this.radius, this.text, this.height, this.width}) : super(key: key);

  @override
  _BouncingState createState() => _BouncingState();
}

class _BouncingState extends State<BouncingButton> with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _controller;
  late Color buttonColor;
  late Color textColor;

  @override
  void initState() {
    super.initState();
    buttonColor = widget.buttonColor ?? Colors.black;
    textColor = widget.textColor ?? Colors.white;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller!.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller!.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller!.reverse();
      },
      child: Transform.scale(
        scale: _scale,
        child: MouseRegion(
          onEnter: _incrementEnter,
          onHover: _updateLocation,
          onExit: _incrementExit,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: widget.radiusColor ?? Colors.lime[100]!,
                  spreadRadius: -2,
                  blurRadius: widget.radius ?? 10,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: widget.onPress,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 30),
                ),
              ),
              child: SizedBox(
                  width: widget.width ?? 50,
                  height: widget.height ?? 50,
                  child: Center(
                      child: Text(
                    widget.text ?? "",
                    style: context.customSemiBold(textColor, 13),
                  ))),
            ),
          ),
        ),
      ),
    );
  }

  void _incrementExit(PointerEvent details) {
    setState(() {
      buttonColor = widget.buttonColor ?? Colors.black;
      textColor = widget.textColor ?? Colors.white;
    });
  }

  void _updateLocation(PointerEvent details) {
    setState(() {
      buttonColor = widget.hoverColor ?? Colors.black87;
      textColor = widget.hoverTextColor ?? Colors.white;
    });
  }

  void _incrementEnter(PointerEvent details) {
    buttonColor = widget.hoverColor ?? Colors.black87;
    textColor = widget.hoverTextColor ?? Colors.white;

    setState(() {});
  }
}
