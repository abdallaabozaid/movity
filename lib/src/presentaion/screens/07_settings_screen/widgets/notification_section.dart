import 'package:flutter/material.dart';
import 'package:movity/config/colors.dart';
import 'package:movity/src/data/api/notification/notification_api.dart';

class NotificationSection extends StatefulWidget {
  const NotificationSection({Key? key}) : super(key: key);

  @override
  State<NotificationSection> createState() => _NotificationSectionState();
}

class _NotificationSectionState extends State<NotificationSection> {
  bool _allowNotificationSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/notificatingSettings.png',
                height: 20,
                width: 18,
              ),
              Text(
                '  Notifications',
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
                'Allow Notifications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appGrey,
                ),
              ),
              Switch(
                  activeTrackColor: AppColors.appGrey,
                  activeColor: AppColors.goldenColor,
                  inactiveTrackColor: AppColors.appGrey,
                  value: _allowNotificationSwitch,
                  onChanged: (value) {
                    if (value) {
                      NotificationApi.showNotificaton(
                        title: 'Add to watch ',
                        body: 'Home Team movie',
                        payLoad: 'tt14592064',
                      );
                    } else {
                      NotificationApi.showNotificaton(
                        title: 'Movity',
                        body: 'Notifications turnned OFF',
                      );
                    }

                    setState(
                      () {
                        _allowNotificationSwitch = value;
                      },
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
