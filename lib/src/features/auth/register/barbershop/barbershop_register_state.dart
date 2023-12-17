// ignore_for_file: public_member_api_docs, sort_constructors_first
enum EBarbershopRegisterStateStatus {
  initial,
  success,
  error,
}

class BarbershopRegisterState {
  final EBarbershopRegisterStateStatus status;
  final List<String> openingDays;
  final List<int> openingHours;

  BarbershopRegisterState({
    required this.status,
    required this.openingDays,
    required this.openingHours,
  });

  BarbershopRegisterState.initial()
      : this(
          status: EBarbershopRegisterStateStatus.initial,
          openingDays: <String>[],
          openingHours: <int>[],
        );

  BarbershopRegisterState copyWith({
    EBarbershopRegisterStateStatus? status,
    List<String>? openingDays,
    List<int>? openingHours,
  }) {
    return BarbershopRegisterState(
      status: status ?? this.status,
      openingDays: openingDays ?? this.openingDays,
      openingHours: openingHours ?? this.openingHours,
    );
  }
}
