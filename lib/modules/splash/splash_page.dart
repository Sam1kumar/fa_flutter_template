import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0;

  dynamic _error;

  bool _initialized = false;

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() => _opacity = 1);

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _error != null
          ? Container(
              child: Text(_error),
            )
          : AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _opacity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                      tag: 'FieldAssistLogo',
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 80,
                        ),
                        child: Container(
                          child: Center(
                            child: Text('Loaded Just enjoy'),
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: 'LaunchingGrowth',
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> init() async {
    try {
      if (!_initialized) {
        await Future.wait([
          Future.delayed(Duration(seconds: 2)),
        ]);
        _initialized = true;
      }
    } catch (e, s) {
      if (mounted) {
        setState(() {
          _error = e;
        });
      }
      rethrow;
    }
  }
}
