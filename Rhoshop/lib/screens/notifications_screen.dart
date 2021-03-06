import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rhoshop/api/queries/all.dart' as Queries;
import 'package:rhoshop/components/primary_button.dart';
import 'package:rhoshop/dto/all.dart';
import 'package:rhoshop/localization/app_localization.dart';
import 'package:rhoshop/styles/app_colors.dart' as AppColors;
import 'package:rhoshop/styles/dimens.dart' as Dimens;

/// Displays notifications like a list.
class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  QueryOptions _notificationsQueryOptions;

  @override
  Widget build(BuildContext context) {
    if (_notificationsQueryOptions == null) {
      _notificationsQueryOptions = QueryOptions(
        documentNode: gql(Queries.notifications),
        variables: {"language": Localizations.localeOf(context).languageCode},
      );
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
              child: _buildNotificationsSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Query(
      options: _notificationsQueryOptions,
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException || result.loading) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors.secondary),
          ));
        } else {
          List<NotificationDto> notifications = result.data['notifications']
              .map<NotificationDto>((n) => NotificationDto.fromJson(n))
              .toList();

          return ListView.separated(
            padding: EdgeInsets.only(bottom: 20),
            separatorBuilder: (context, index) => Divider(),
            itemCount: notifications.length,
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.all(0),
              onTap: () {
                _showNotificationInAlert(context, notifications[index]);
              },
              title: Text(
                notifications[index].message,
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
                  notifications[index].date,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _showNotificationInAlert(
      BuildContext context, NotificationDto notification) {
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
            notification.message,
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
}
