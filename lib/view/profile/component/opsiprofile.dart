import 'package:flutter/material.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class OpsiProfile extends StatelessWidget {
  final String text;
  final String notif;
  final Function onPressed;
  const OpsiProfile({
    super.key,
    required this.text,
    required this.notif,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: primaryTextStyle3.copyWith(
                        fontSize: 18, color: bg6color),
                  ),
                  Text(
                    notif,
                    style: primaryTextStyle2.copyWith(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: bg6color,
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 1 / 100,
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
