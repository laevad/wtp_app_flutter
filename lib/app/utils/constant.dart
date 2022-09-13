import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../screens/profile/profile_screen.dart';

class Constant {
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFf4325c),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFD9E0),
    onPrimaryContainer: Color(0xFF3F0016),
    secondary: Color(0xFFC5A9B4),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFD9E0),
    onSecondaryContainer: Color(0xFF2B151A),
    tertiary: Color(0xFF9299A5),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFFDCB9),
    onTertiaryContainer: Color(0xFF2C1600),
    error: Color(0xFFBA1B1B),
    errorContainer: Color(0xFFFFDAD4),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410001),
    background: Color(0xFFFCFCFC),
    onBackground: Color(0xFF201A1B),
    surface: Color(0xFFFCFCFC),
    onSurface: Color(0xFF201A1B),
    surfaceVariant: Color(0xFFF3DDE0),
    onSurfaceVariant: Color(0xFF514345),
    outline: Color(0xFF847376),
    onInverseSurface: Color(0xFFFAEEEF),
    inverseSurface: Color(0xFF362F30),
    inversePrimary: Color(0xFFFFB1C3),
    shadow: Color(0xFF000000),
  );

  static const List<GButton> _icons = [
    GButton(
      icon: Icons.home_outlined,
      text: 'Home',
    ),
    GButton(
      icon: Icons.drive_eta_outlined,
      text: 'Deliveries',
    ),
    GButton(
      icon: Icons.history,
      text: 'History',
    ),
    GButton(
      icon: Icons.settings_outlined,
      text: 'Settings',
    ),
  ];

  static const List<Widget> _pages = [
    Center(
      child: Text('Hello 1'),
    ),
    Center(
      child: Text('Hello 2'),
    ),
    Center(
      child: Text('Hello 3'),
    ),
    ProfileScreen(),
  ];

  static int _selectedIndex = 0;

  static int get selectedIndex => _selectedIndex;

  static List<GButton> get icons => _icons;

  static set setSelectedIndex(int selected) => _selectedIndex = selected;

  static List<Widget> get pages => _pages;
}