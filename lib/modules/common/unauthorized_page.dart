
import 'package:fa_flutter_template/app/app.dart';
import 'package:fa_flutter_ui_kit/fa_flutter_ui_kit.dart';
import 'package:flutter/material.dart';

class UnauthorizedPage extends StatefulWidget {
  @override
  _UnauthorizedPageState createState() => _UnauthorizedPageState();
}

class _UnauthorizedPageState extends State<UnauthorizedPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FieldAssistLogo(
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '401 Unauthorized. Please login again!',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
