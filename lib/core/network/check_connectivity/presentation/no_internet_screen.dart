import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared_widgets/app_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_config.dart';
import '../cubit/connectivity_cubit.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is DeviceConnectedState && !state.isConnected) {
          return Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Material(
              color: AppColors.red,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        color: AppColors.white,
                        size: 20,
                      ),
                      SizeConfig.horizontalSpace(8),
                      const Expanded(
                        child: AppText(
                          'No Internet Connection',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
