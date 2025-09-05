import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextSpanServices {
  /// Creates a simple TextSpan with given text and style
  static TextSpan createTextSpan({
    required String text,
    required TextStyle style,
  }) {
    return TextSpan(text: text, style: style);
  }

  /// Creates a clickable TextSpan with an action
  static TextSpan createClickableTextSpan({
    required String text,
    required TextStyle style,
    required VoidCallback onTap,
  }) {
    return TextSpan(
      text: text,
      style: style,
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  /// Combines multiple TextSpans into a single parent TextSpan
  static TextSpan combineTextSpans(List<TextSpan> textSpans) {
    return TextSpan(children: textSpans);
  }

  /// Applies a common style to all children TextSpans
  static TextSpan applyStyleToChildren({
    required List<TextSpan> children,
    required TextStyle style,
  }) {
    return TextSpan(
      children:
          children.map((span) {
            return TextSpan(
              text: span.text,
              style: span.style?.merge(style) ?? style,
              recognizer: span.recognizer,
            );
          }).toList(),
    );
  }

  /// Generates a Text.rich widget directly from a list of TextSpans
  static Text richTextFromSpans({
    required List<TextSpan> textSpans,
    TextAlign textAlign = TextAlign.start,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    return Text.rich(
      TextSpan(children: textSpans),
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: TextScaler.linear(1.0),
    );
  }

  /// Parses text into spans with links and normal text
  /// Example: "Hello [Link](https://example.com) World"
  static List<TextSpan> parseTextWithLinks({
    required String text,
    Color? lightColor,
    double? fontSize,
    required void Function(String url) onLinkTap,
    required TextStyle style,
  }) {
    final RegExp linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');
    final matches = linkRegex.allMatches(text);
    final List<TextSpan> spans = [];

    int currentIndex = 0;
    for (final match in matches) {
      if (currentIndex < match.start) {
        spans.add(
          createTextSpan(
            text: text.substring(currentIndex, match.start),
            style: style,
          ),
        );
      }

      final linkText = match.group(1)!;
      final linkUrl = match.group(2)!;

      spans.add(
        createClickableTextSpan(
          text: linkText,
          style: style,
          onTap: () => onLinkTap(linkUrl),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(
        createTextSpan(text: text.substring(currentIndex), style: style),
      );
    }

    return spans;
  }
}
