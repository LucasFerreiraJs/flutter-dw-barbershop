import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/week_days_panel.dart';
import 'package:flutter/material.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  var registerAdm = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar colaborador')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                const AvatarWidget(),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Checkbox.adaptive(
                      value: registerAdm,
                      onChanged: (value) {
                        setState(() {
                          registerAdm = !registerAdm;
                        });
                      },
                    ),
                    const Expanded(
                        child: Text(
                      'Sou administrador e quero me cadastrar como colaborador',
                      style: TextStyle(fontSize: 14),
                    )),
                  ],
                ),
                Offstage(
                  offstage: registerAdm,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Email'),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Senha'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                WeekDaysPanelWidget(
                  onDayPressed: (value) {},
                ),
                const SizedBox(height: 24),
                HoursPanelWidget(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (value) {},
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {},
                  child: Text('Cadastrar colaborador'),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
