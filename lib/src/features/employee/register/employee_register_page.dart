import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/core/ui/helper/message.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/loader_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/week_days_panel.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case EEmployeeRegisterState.initial:
          break;
        case EEmployeeRegisterState.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop();
        case EEmployeeRegisterState.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar colaborador')),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar a página', error: error, stackTrace: stackTrace);
          return const Center(child: Text('Erro ao carregar a página'));
        },
        loading: () => const LoaderWidget(),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
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
                                employeeRegisterVM.setRegisterADM(registerAdm);
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
                              controller: nameEC,
                              validator: registerAdm ? null : Validatorless.required('Nome obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: emailEC,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required('Email obrigatório'),
                                      Validatorless.email('Email inválido'),
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: passwordEC,
                              obscureText: true,
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required('Senha obrigatória'),
                                      Validatorless.min(6, 'mínimo 6 caracteres'),
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('Senha'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      WeekDaysPanelWidget(
                        enabledDays: openingDays,
                        onDayPressed: (String value) {
                          employeeRegisterVM.addOdRemoveWorkDays(value);
                        },
                      ),
                      const SizedBox(height: 24),
                      HoursPanelWidget(
                        enabledTimes: openingHours,
                        startTime: 6,
                        endTime: 23,
                        onHourPressed: (int value) {
                          employeeRegisterVM.addOdRemoveWorkHour(value);
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError('Campos inválidos', context);
                            case true:
                              // final EmployeeRegisterState(:workDays, :workHours) = ref.watch(employeeRegisterVmProvider);

                              // if (workDays.isEmpty || workHours.isEmpty) {
                              //   Messages.showError('Por favor, selecione dias da semana e horários de atendimento', context);
                              //   return;
                              // }
                              final EmployeeRegisterState(
                                workDays: List(isNotEmpty: hasWorkDays),
                                workHours: List(isNotEmpty: hasWorkHours),
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (!hasWorkDays || !hasWorkHours) {
                                Messages.showError('Por favor, selecione dias da semana e horários de atendimento', context);
                                return;
                              }
                          }
                          final name = nameEC.text;
                          final email = emailEC.text;
                          final password = passwordEC.text;

                          employeeRegisterVM.register(
                            name: name,
                            email: email,
                            password: password,
                          );
                        },
                        child: const Text('Cadastrar colaborador'),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
