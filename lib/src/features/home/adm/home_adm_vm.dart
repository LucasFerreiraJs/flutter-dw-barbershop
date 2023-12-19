import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exception/respository_exceptions.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/features/home/adm/home_adm_state.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final IUserRepository repository = ref.read<IUserRepository>(userRepositoryProvider);
    final BarbershopModel(id: barbershopId) = await ref.read<FutureOr<BarbershopModel>>(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);
    final employeeResult = await repository.getEmployee(barbershopId);

    switch (employeeResult) {
      case Success(value: var employeesData):
        final employees = <UserModel>[];

        // * check if prop has value
        // if (me case UserModelADM(getWorkDays: _?, getWorkHours: _?)) {
        if (me is UserModelADM && me.getWorkDays == null && me.getWorkDays == null) {
          employees.add(me);
        }

        employees.addAll(employeesData);
        return HomeAdmState(status: EHomeAdmStateStatus.loaded, employees: employees);
      case Failure():
        return HomeAdmState(status: EHomeAdmStateStatus.error, employees: <UserModel>[]);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future);
}
