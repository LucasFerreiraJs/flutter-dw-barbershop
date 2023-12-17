import 'package:dw_barbershop/src/core/ui/helper/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helper/message.dart';
import 'package:dw_barbershop/src/features/auth/register/user/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);
    // Navigator.of(context).pushNamedAndRemoveUntil('/auth/register/barbershop', (route) => false);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case EUserRegisterStateStatus.initial:
          break;
        case EUserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');

          break;
        case EUserRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar usuário administrador', context);
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator: Validatorless.required('Nome é obrigatório'),
                  decoration: const InputDecoration(label: Text('Nome')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Email é obrigatório'),
                    Validatorless.email('Email inválido'),
                  ]),
                  decoration: const InputDecoration(label: Text('E-email')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatório'),
                    Validatorless.min(6, 'Senha deve conter no mínimo 6 caracteres'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(label: Text('Senha')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar senha é obrigatório'),
                    Validatorless.compare(passwordEC, 'Senhas devem ser identicas'),
                  ]),
                  decoration: const InputDecoration(label: Text('Confirmar senha')),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);
                        break;
                      case true:
                        userRegisterVm.register(
                          name: nameEC.text,
                          email: emailEC.text,
                          password: passwordEC.text,
                        );
                        break;
                    }
                  },
                  child: const Text('CRIAR CONTA'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
