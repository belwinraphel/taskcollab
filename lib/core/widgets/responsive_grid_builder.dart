import 'package:flutter/material.dart';

/// A widget that builds a responsive grid based on the screen width.
///
/// It uses [LayoutBuilder] to get the available width and calculates the
/// number of columns based on [columnCount] breakpoints or default values.
class ResponsiveGridBuilder extends StatelessWidget {
  /// Total number of items to display.
  final int itemCount;

  /// Builder function for each item.
  final IndexedWidgetBuilder itemBuilder;

  /// Map of min-width breakpoints to column counts.
  /// Example: {600: 2, 900: 3, 1200: 4}
  /// If null, defaults to established Material Design breakpoints.
  final Map<double, int>? columnThresholds;

  /// Spacing between items along the main axis.
  final double mainAxisSpacing;

  /// Spacing between items along the cross axis.
  final double crossAxisSpacing;

  /// Aspect ratio of each item (width / height).
  final double childAspectRatio;

  /// Padding around the grid.
  final EdgeInsetsGeometry? padding;

  /// Custom scroll physics.
  final ScrollPhysics? physics;

  /// Whether the grid should wrap its content.
  final bool shrinkWrap;

  /// Viewport cache extent.
  final double? cacheExtent;

  /// Whether to add automatic keep-alives to the children.
  final bool addAutomaticKeepAlives;

  const ResponsiveGridBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.columnThresholds,
    this.mainAxisSpacing = 16.0,
    this.crossAxisSpacing = 16.0,
    this.childAspectRatio = 1.0,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.addAutomaticKeepAlives = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int crossAxisCount = _getCrossAxisCount(constraints.maxWidth);

        return GridView.builder(
          padding: padding,
          physics: physics,
          shrinkWrap: shrinkWrap,
          cacheExtent: cacheExtent,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        );
      },
    );
  }

  int _getCrossAxisCount(double width) {
    if (columnThresholds != null && columnThresholds!.isNotEmpty) {
      // Sort thresholds in descending order to find the first matching range
      final sortedKeys = columnThresholds!.keys.toList()
        ..sort((a, b) => b.compareTo(a));

      for (final threshold in sortedKeys) {
        if (width >= threshold) {
          return columnThresholds![threshold]!;
        }
      }
      // If width is smaller than the smallest threshold, assume 1 column
      // or we could require a 0 key. For now, default to 1.
      return 1;
    }

    // Default breakpoints
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 2;
  }
}
