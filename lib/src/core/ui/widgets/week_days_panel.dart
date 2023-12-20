import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekDaysPanelWidget extends StatelessWidget {
  final List<String>? enabledDays;

  final ValueChanged<String> onDayPressed;
  const WeekDaysPanelWidget({super.key, required this.onDayPressed, this.enabledDays});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDayWidget(label: 'Seg', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Ter', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Qua', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Qui', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Sex', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Sáb', onDayPressed: onDayPressed, enabledDays: enabledDays),
                ButtonDayWidget(label: 'Dom', onDayPressed: onDayPressed, enabledDays: enabledDays),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonDayWidget extends StatefulWidget {
  final List<String>? enabledDays;
  final String label;
  final ValueChanged<String> onDayPressed;

  const ButtonDayWidget({
    required this.label,
    required this.onDayPressed,
    this.enabledDays,
    super.key,
  });

  @override
  State<ButtonDayWidget> createState() => _ButtonDayWidgetState();
}

class _ButtonDayWidgetState extends State<ButtonDayWidget> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = selected ? Colors.white : ColorsConstants.grey;
    Color buttonColor = selected ? ColorsConstants.brown : Colors.white;
    Color buttonBorderColor = selected ? ColorsConstants.brown : ColorsConstants.grey;

    final ButtonDayWidget(:enabledDays, :label) = widget;

    final disabledDay = enabledDays != null && !enabledDays.contains(label);
    if (disabledDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disabledDay
            ? null
            : () {
                widget.onDayPressed(widget.label);
                setState(() {
                  selected = !selected;
                });
              },
        child: Container(
          // margin: const EdgeInsets.all(3),
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
