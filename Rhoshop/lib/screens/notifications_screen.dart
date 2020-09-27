import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/mock/db.dart' as MockDb;
import 'package:rhoshop/mock/models/norification.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;

/// Displays notifications as a list.
class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Future<List<AppNotification>> notifications;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (notifications == null) {
      notifications = MockDb.fetchNotifications(
          Localizations.localeOf(context).languageCode);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/left-arrow.svg",
            color: AppColors.primaryText,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
        color: AppColors.primary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalization.of(context).notificationsScreenTitle,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildNotifications(),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationInAlert(
      BuildContext context, AppNotification notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            DateFormat.MMMMd(
              Localizations.localeOf(
                context,
              ).toString(),
            ).format(
              notification.date,
            ),
            style: Theme.of(context).textTheme.headline4,
          ),
          content: Text(
            notification.content,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            SizedBox(
              width: 140,
              height: 40,
              child: PrimaryButton(
                child: Text(
                  AppLocalization.of(context).close,
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontSize: 16,
                      ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNotifications() {
    Widget child;

    return FutureBuilder<List<AppNotification>>(
      future: notifications,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          child = ListView.separated(
            padding: EdgeInsets.only(bottom: 20),
            separatorBuilder: (context, index) => Divider(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(0),
              onTap: () {
                _showNotificationInAlert(context, snapshot.data[index]);
              },
              title: Text(
                snapshot.data[index].content,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              subtitle: Text(
                DateFormat.MMMMd(
                  Localizations.localeOf(
                    context,
                  ).toString(),
                ).format(
                  snapshot.data[index].date,
                ),
              ),
            ),
          );
        } else {
          // This indicator will be also shown in case of error.
          child = Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.secondary),
            ),
          );
        }

        return Container(
          child: child,
        );
      },
    );
  }
}
