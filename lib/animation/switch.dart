import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notizapp/cubit/theme_cubit/theme_cubit.dart';
import 'package:rive/rive.dart';

class SwitchAnimation extends StatefulWidget {
  const SwitchAnimation({super.key});

  @override
  State<SwitchAnimation> createState() => _SwitchAnimationState();
}

class _SwitchAnimationState extends State<SwitchAnimation> {
  StateMachineController? controller;
  SMIInput<bool>? switchInput;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (switchInput == null) {
              return;
            }
            final isDark = switchInput?.value ?? false;
            context.read<ThemeCubit>().changeTheme(
                  switchInput?.value == true ? false : true,
                );
            switchInput?.change(!isDark);
          },
          borderRadius: BorderRadius.circular(120),
          child: SizedBox(
            height: 60,
            width: 80,
            child: RiveAnimation.asset(
              'assets/switch_theme.riv',
              fit: BoxFit.fill,
              stateMachines: const ['Switch Theme'],
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(artboard, 'Switch Theme');

                if (controller == null) {
                  return;
                }
                artboard.addController(controller!);
                switchInput = controller?.findInput('isDark');

                final mode = context.read<ThemeCubit>().state.switchValue;
                switchInput?.change(mode);
              },
            ),
          ),
        );
      },
    );
  }
}
