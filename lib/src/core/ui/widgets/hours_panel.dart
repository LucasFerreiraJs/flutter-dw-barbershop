import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HoursPanelWidget extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  const HoursPanelWidget({
    super.key,
    required this.onHourPressed,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    var buttonList = <Widget>[];
    for (var i = startTime; i <= endTime; i++) {
      buttonList.add(
        TimeButtonWidget(
          onPressed: onHourPressed,
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
  final String label;
  final int value;
  final ValueChanged<int> onPressed;
  const TimeButtonWidget({
    required this.label,
    required this.value,
    required this.onPressed,
    super.key,
  });

  @override
  State<TimeButtonWidget> createState() => _TimeButtonWidgetState();
}

class _TimeButtonWidgetState extends State<TimeButtonWidget> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    Color textColor = selected ? Colors.white : ColorsConstants.grey;
    Color buttonColor = selected ? ColorsConstants.brown : Colors.white;
    Color buttonBorderColor = selected ? ColorsConstants.brown : ColorsConstants.grey;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        widget.onPressed(widget.value);
        setState(() {
          selected = !selected;
          print(selected);
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