# Extending JSON Widget Builder

This guide explains how to add new widget types to the JSON-driven UI system.

## Overview

The `JsonWidgetBuilder` is a factory that converts JSON configuration into Flutter widgets. To support new widgets, you need to:

1. Define the widget in JSON
2. Create a custom widget class (if needed)
3. Add a build method in `JsonWidgetBuilder`
4. Update `properties.json` with examples

## Step-by-Step Guide

### Step 1: Create the Widget Class

Create a new file in `lib/widgets/` directory:

```dart
// lib/widgets/custom_slider.dart
import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final String? label;
  final double initialValue;
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const CustomSlider({
    Key? key,
    this.label,
    this.initialValue = 0.5,
    this.min = 0,
    this.max = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        Slider(
          value: _value,
          min: widget.min,
          max: widget.max,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
            widget.onChanged?.call(value);
          },
        ),
        Text(
          'Value: ${_value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
```

### Step 2: Add Import in JsonWidgetBuilder

Update `lib/utils/json_widget_builder.dart`:

```dart
import '../widgets/custom_slider.dart';
```

### Step 3: Add Build Method

Add a build method for your widget in `JsonWidgetBuilder`:

```dart
case 'Slider':
  return _buildSlider(properties);
```

Then add the implementation method:

```dart
static Widget _buildSlider(Map<String, dynamic>? props) {
  return CustomSlider(
    label: props?['label'],
    initialValue: (props?['initialValue'] as num?)?.toDouble() ?? 0.5,
    min: (props?['min'] as num?)?.toDouble() ?? 0,
    max: (props?['max'] as num?)?.toDouble() ?? 1,
  );
}
```

### Step 4: Add to properties.json

Update `assets/json/properties.json` to include your widget:

```json
{
  "type": "Slider",
  "label": "Volume",
  "initialValue": 0.7,
  "min": 0,
  "max": 1
}
```

## Example: Switch Toggle Widget

### Full Implementation

**1. Create Widget** (`lib/widgets/custom_switch.dart`):

```dart
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const CustomSwitch({
    Key? key,
    required this.label,
    this.initialValue = false,
    this.onChanged,
    this.activeColor,
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.label),
      trailing: Switch(
        value: _value,
        onChanged: (newValue) {
          setState(() {
            _value = newValue;
          });
          widget.onChanged?.call(newValue);
        },
        activeColor: widget.activeColor,
      ),
    );
  }
}
```

**2. Add to JsonWidgetBuilder** (`lib/utils/json_widget_builder.dart`):

```dart
case 'Switch':
  return _buildSwitch(properties);

// ...

static Widget _buildSwitch(Map<String, dynamic>? props) {
  return CustomSwitch(
    label: props?['label'] ?? 'Toggle',
    initialValue: props?['initialValue'] ?? false,
    activeColor: _parseColor(props?['activeColor'] ?? '#4ECDC4'),
  );
}
```

**3. Use in properties.json**:

```json
{
  "type": "Switch",
  "label": "Enable Notifications",
  "initialValue": true,
  "activeColor": "#4ECDC4"
}
```

## Common Patterns

### Widgets with Children

For widgets that contain child widgets:

```dart
static Widget _buildMyWidget(
  BuildContext context,
  Map<String, dynamic>? props,
  VoidCallback? onNavigate,
) {
  final Map<String, dynamic>? child = props?['child'];
  final Widget childWidget = child != null
      ? buildWidget(context, child, onNavigate)
      : const SizedBox();

  return MyWidget(child: childWidget);
}
```

### Widgets with Multiple Children

```dart
static Widget _buildMyListWidget(
  BuildContext context,
  Map<String, dynamic>? props,
  VoidCallback? onNavigate,
) {
  final List<dynamic> children = props?['children'] ?? [];
  final List<Widget> widgets = children
      .map((child) => buildWidget(context, child, onNavigate))
      .toList();

  return MyListWidget(children: widgets);
}
```

### Parsing Colors

```dart
static Color _parseColor(dynamic colorValue) {
  if (colorValue is String) {
    return ColorUtils.fromHex(colorValue);
  }
  return Colors.white;
}
```

### Parsing Enums

```dart
static Axis _parseAxis(String? axis) {
  return axis?.toLowerCase() == 'horizontal' 
    ? Axis.horizontal 
    : Axis.vertical;
}
```

### Parsing Padding

```dart
static EdgeInsets _parsePadding(Map<String, dynamic>? paddingMap) {
  if (paddingMap == null) return EdgeInsets.zero;

  if (paddingMap.containsKey('all')) {
    final double all = (paddingMap['all'] as num?)?.toDouble() ?? 0;
    return EdgeInsets.all(all);
  }

  final double left = (paddingMap['left'] as num?)?.toDouble() ?? 0;
  final double top = (paddingMap['top'] as num?)?.toDouble() ?? 0;
  final double right = (paddingMap['right'] as num?)?.toDouble() ?? 0;
  final double bottom = (paddingMap['bottom'] as num?)?.toDouble() ?? 0;

  return EdgeInsets.fromLTRB(left, top, right, bottom);
}
```

## JSON Schema Examples

### Simple Widget
```json
{
  "type": "ProgressIndicator",
  "value": 0.75,
  "color": "#4ECDC4"
}
```

### Widget with Properties
```json
{
  "type": "Badge",
  "label": "New",
  "count": 5,
  "backgroundColor": "#FF6B6B",
  "textColor": "#FFFFFF"
}
```

### Widget with Child
```json
{
  "type": "Expansion",
  "title": "Settings",
  "child": {
    "type": "Text",
    "text": "Setting details here"
  }
}
```

### Widget with Multiple Children
```json
{
  "type": "TabView",
  "tabs": [
    {
      "title": "Tab 1",
      "content": {
        "type": "Text",
        "text": "Content 1"
      }
    },
    {
      "title": "Tab 2",
      "content": {
        "type": "Text",
        "text": "Content 2"
      }
    }
  ]
}
```

## Testing Your Widget

1. Create a simple page with your widget in `properties.json`
2. Add the route to `route_config.dart`
3. Test with `flutter run`

Example JSON for testing:

```json
{
  "pages": {
    "widgetTest": {
      "type": "ScaffoldPage",
      "appBarTitle": "Widget Test",
      "children": [
        {
          "type": "SizedBox",
          "height": 20
        },
        {
          "type": "YourNewWidget",
          "property1": "value1",
          "property2": "value2"
        }
      ]
    }
  }
}
```

## Best Practices

1. **Use Meaningful Names**: Follow Flutter naming conventions (PascalCase for classes)

2. **Document Properties**: Include comments explaining all JSON properties

3. **Handle Edge Cases**: Provide sensible defaults for missing properties

4. **Type Safety**: Always validate and cast JSON values appropriately

5. **Reusability**: Create flexible widgets that work with various configurations

6. **Testing**: Test your widget with different JSON configurations

7. **Error Handling**: Gracefully handle invalid JSON properties

8. **Performance**: Consider performance implications for complex widgets

9. **Styling**: Use the app's theme and color system consistently

10. **Documentation**: Document the widget in your properties.json with examples

## Advanced: Conditional Rendering

You can add logic-based rendering:

```dart
static Widget _buildConditionalWidget(
  BuildContext context,
  Map<String, dynamic>? props,
  VoidCallback? onNavigate,
) {
  final String? condition = props?['condition'];
  final Map<String, dynamic>? trueChild = props?['true'];
  final Map<String, dynamic>? falseChild = props?['false'];

  // Your condition logic
  bool shouldShow = condition == 'premium'; // example

  return shouldShow
      ? buildWidget(context, trueChild ?? {}, onNavigate)
      : buildWidget(context, falseChild ?? {}, onNavigate);
}
```

JSON usage:

```json
{
  "type": "ConditionalWidget",
  "condition": "premium",
  "true": {
    "type": "Text",
    "text": "Premium Feature"
  },
  "false": {
    "type": "Text",
    "text": "Free Feature"
  }
}
```

## Troubleshooting

### Widget not rendering
- Check that the `type` in JSON matches your case statement
- Verify the widget is imported in `json_widget_builder.dart`
- Check the Flutter console for errors

### Properties not applying
- Verify property names match between JSON and Dart
- Check type conversions (`num?.toDouble()`, etc.)
- Add logging to debug property values

### Build errors
- Ensure all imports are correct
- Check for typos in method names
- Verify widget constructors match the call

---

For more examples, check the existing widgets in `lib/widgets/` directory.
