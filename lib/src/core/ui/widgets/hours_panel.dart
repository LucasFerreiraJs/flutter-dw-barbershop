import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanelWidget extends StatefulWidget {
  final List<int>? enabledTimes;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final bool singleSelection;

  const HoursPanelWidget({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledTimes,
  }) : singleSelection = false;

  const HoursPanelWidget.singleSelection({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
    this.enabledTimes,
  }) : singleSelection = true;

  @override
  State<HoursPanelWidget> createState() => _HoursPanelWidgetState();
}

class _HoursPanelWidgetState extends State<HoursPanelWidget> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    var buttonList = <Widget>[];
    for (var i = widget.startTime; i <= widget.endTime; i++) {
      buttonList.add(
        TimeButtonWidget(
          enabledTimes: widget.enabledTimes,
          timeSelected: lastSelection,
          singleSelection: widget.singleSelection,
          onPressed: (timeSelected) {
            setState(() {
              if (widget.singleSelection) {
                if (lastSelection == timeSelected) {
                  lastSelection = null;
                } else {
                  lastSelection = timeSelected;
                }
              }
            });
            widget.onHourPressed(timeSelected);
          },
          value: i,
          label: '${i.toString().padLeft(2, '0')}:00',
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            ...buttonList,
          ],
        ),
      ],
    );
  }
}

class TimeButtonWidget extends StatefulWidget {
  final List<int>? enabledTimes;
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  final bool singleSelection;
  final int? timeSelected;

  const TimeButtonWidget({
    required this.label,
    required this.value,
    required this.onPressed,
    required this.singleSelection,
    this.enabledTimes,
    this.timeSelected,
    super.key,
  });

  @override
  State<TimeButtonWidget> createState() => _TimeButtonWidgetState();
}

class _TimeButtonWidgetState extends State<TimeButtonWidget> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final TimeButtonWidget(:value, :label, :enabledTimes, :singleSelection, :timeSelected) = widget;

    if (singleSelection) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          selected = true;
        } else {
          selected = false;
        }
      }
    }

    Color textColor = selected ? Colors.white : ColorsConstants.grey;
    Color buttonColor = selected ? ColorsConstants.brown : Colors.white;
    Color buttonBorderColor = selected ? ColorsConstants.brown : ColorsConstants.grey;

    final disabledTime = enabledTimes != null && !enabledTimes.contains(value);

    if (disabledTime) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disabledTime
          ? null
          : () {
              widget.onPressed(widget.value);
              setState(() {
                selected = !selected;
              });
            },
      child: Container(
          // margin: EdgeInsets.all(3),
          width: 64,
          height: 36,
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
          )),
    );
  }
}
