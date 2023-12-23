import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helper/message.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendarWidget extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  const ScheduleCalendarWidget({super.key, required this.cancelPressed, required this.okPressed});

  @override
  State<ScheduleCalendarWidget> createState() => _ScheduleCalendarWidgetState();
}

class _ScheduleCalendarWidgetState extends State<ScheduleCalendarWidget> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffe6e2e9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(titleCentered: true),
            availableGestures: AvailableGestures.none,
            calendarFormat: CalendarFormat.month,
            locale: 'pt-BR',
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: ColorsConstants.brown,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: ColorsConstants.brown.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: widget.cancelPressed,
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorsConstants.brown,
                    ),
                  )),
              TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    Messages.showError('Por favor selecione um dia', context);
                    return;
                  }
                  widget.okPressed(selectedDay!);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorsConstants.brown,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
