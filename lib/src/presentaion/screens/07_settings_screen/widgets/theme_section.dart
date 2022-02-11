import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/config/enums.dart';
import 'package:movity/src/logic/preferences/theme/app_theme_preferences.dart';
import 'package:movity/src/logic/theme/bloc/theme_bloc.dart';

class ThemeSection extends StatelessWidget {
  ThemeSection({Key? key}) : super(key: key);

  AppTheme dropDownValue = AppTheme.darkBrown;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/sync.png',
                height: 20,
                width: 18,
              ),
              Text(
                '  Theme',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldenColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Choose theme',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appGrey,
                ),
              ),
              // Switch(
              //     activeTrackColor: AppColors.appGrey,
              //     activeColor: AppColors.goldenColor,
              //     inactiveTrackColor: AppColors.appGrey,
              //     value: _friendlyModeSwitch,
              //     onChanged: (value) {
              //       setState(() {
              //         _friendlyModeSwitch = value;
              //       });
              //     })
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              dropDownValue = ThemePreferences.getSavedTheme();

              return DropdownButton<AppTheme>(
                value: dropDownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                items: <AppTheme>[
                  AppTheme.darkBrown,
                  AppTheme.lightBrown,
                  AppTheme.darkBlue,
                  AppTheme.lightBlue
                ]
                    .map(
                      (e) => DropdownMenuItem<AppTheme>(
                        value: e,
                        child: Text(
                          e.toString().split('.').last.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (AppTheme? newValue) {
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ChangeTheme(appTheme: newValue!));

                  dropDownValue = newValue;
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
