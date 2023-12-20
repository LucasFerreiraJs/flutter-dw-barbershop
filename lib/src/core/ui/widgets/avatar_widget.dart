import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 102,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageConstants.avatarImg)),
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorsConstants.brown,
                  width: 3,
                ),
              ),
              child: const Icon(
                BarbershopIcons.addEmployee,
                color: ColorsConstants.brown,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
