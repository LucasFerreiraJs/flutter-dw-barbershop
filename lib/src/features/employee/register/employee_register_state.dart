enum EEmployeeRegisterState {
  initial,
  success,
  error,
}

class EmployeeRegisterState {
  final EEmployeeRegisterState status;
  final bool registerADM;
  final List<String> workDays;
  final List<int> workHours;

  EmployeeRegisterState.initial()
      : this(
          status: EEmployeeRegisterState.initial,
          registerADM: false,
          workDays: <String>[],
          workHours: <int>[],
        );

  EmployeeRegisterState({required this.status, required this.registerADM, required this.workDays, required this.workHours});

  EmployeeRegisterState copyWith({
    EEmployeeRegisterState? status,
    bool? registerADM,
    List<String>? workDays,
    List<int>? workHours,
  }) {
    return EmployeeRegisterState(
      status: status ?? this.status,
      registerADM: registerADM ?? this.registerADM,
      workDays: workDays ?? this.workDays,
      workHours: workHours ?? this.workHours,
    );
  }
}
