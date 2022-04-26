import 'package:flutter/material.dart';

class Environment {
  const Environment._({
    required this.flavor,
    required this.appTitle,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });

  factory Environment.prod() {
    return const Environment._(
      flavor: Flavor.PROD,
      appTitle: 'FA MT',
      appStoreUrl: '',
      playStoreUrl: '',
    );
  }

  factory Environment.dev() {
    return const Environment._(
      flavor: Flavor.DEV,
      appTitle: 'FA MT Dev',
      appStoreUrl: '',
      playStoreUrl: '',
    );
  }

  factory Environment.beta() {
    return const Environment._(
      flavor: Flavor.BETA,
      appTitle: 'FA MT beta',
      appStoreUrl: '',
      playStoreUrl: '',
    );
  }
  final Flavor flavor;
  final String appTitle;
  final String appStoreUrl;
  final String playStoreUrl;
}

enum Flavor { PROD, DEV, BETA }

extension FlavorX on Flavor {
  // ignore: missing_return
  String get name {
    switch (this) {
      case Flavor.PROD:
        return 'Prod';
      case Flavor.DEV:
        return 'Dev';
      case Flavor.BETA:
        return 'Beta';
    }
  }

  // ignore: missing_return
  Color get color {
    switch (this) {
      case Flavor.PROD:
        return Colors.blue;
      case Flavor.DEV:
        return Colors.red;
      case Flavor.BETA:
        return Colors.yellow;
    }
  }
}
