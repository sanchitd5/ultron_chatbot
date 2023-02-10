import 'package:flutter/material.dart';

class DevEnvironmentListTile extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const DevEnvironmentListTile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
