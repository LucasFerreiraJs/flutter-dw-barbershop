import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchadulePage extends StatelessWidget {
  const EmployeeSchadulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: Center(
        child: Column(
          children: [
            Text(
              'Nome e sobrenome',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 44),
            Expanded(
              child: SfCalendar(
                allowViewNavigation: true,
                view: CalendarView.day,
                showNavigationArrow: true,
                todayHighlightColor: ColorsConstants.brown,
                showDatePickerButton: true,
                showTodayButton: true,
                dataSource: AppointmentDs(),
                onTap: (calendarTapDetail) {
                  if (calendarTapDetail.appointments != null && calendarTapDetail.appointments!.isNotEmpty) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final dateFormat = DateFormat('dd/MM/yyy HH:mm:ss');
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('client: ${calendarTapDetail.appointments?.first.subject}'),
                                Text('Horário: ${dateFormat.format(calendarTapDetail.date ?? DateTime.now())}'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                appointmentBuilder: (context, calendarAppointmentDetails) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorsConstants.brown,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      calendarAppointmentDetails.appointments.first.subject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
