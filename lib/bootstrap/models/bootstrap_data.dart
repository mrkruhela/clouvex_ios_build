import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../auth/user.dart';
import '../../i18n/backend_locale.dart';
import 'backend_menu.dart';
import 'backend_theme.dart';

part '../../.generated/bootstrap/models/bootstrap_data.freezed.dart';
part '../../.generated/bootstrap/models/bootstrap_data.g.dart';

@freezed
class BootstrapData with _$BootstrapData {
  const BootstrapData._();

  const factory BootstrapData({
    required List<BackendLocale> locales,
    required BackendSettings settings,
    required Map<String, BackendTheme> themes,
    required List<BackendMenu> menus,
    User? user,
  }) = _BootstrapData;

  factory BootstrapData.fromJson(Map<String, dynamic> json) =>
      _$BootstrapDataFromJson(json);

  factory BootstrapData.fromRawJson(String rawJson) =>
      BootstrapData.fromJson(json.decode(rawJson));

  String toRawJson() => json.encode(toJson());

  factory BootstrapData.fromFallbackData(Map<String, dynamic> data) {
    final locale = data['locales']?[0] ?? {};
    return BootstrapData(
      locales: [
        BackendLocale(
          language: locale['language'] ?? 'en',
          name: locale['name'] ?? 'English',
          lines: locale['lines'] ?? {},
          updatedAt: DateTime.now(),
        ),
      ],
      settings: BackendSettings(
        enableGoogleLogin: false,
        disableRegistration: false,
        requireEmailConfirmation: false,
      ),
      themes: (data['themes'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, BackendTheme.fromJson(value)),
      ),
      menus: [],
      user: null,
    );
  }
}

class BackendSettings {
  final bool enableGoogleLogin;
  final bool disableRegistration;
  final bool requireEmailConfirmation;

  BackendSettings({
    required this.enableGoogleLogin,
    required this.disableRegistration,
    required this.requireEmailConfirmation,
  });

  factory BackendSettings.fromJson(Map<String, dynamic> value) =>
      BackendSettings(
        enableGoogleLogin: value['social.google.enable'] ?? false,
        disableRegistration: value['registration.disable'] ?? false,
        requireEmailConfirmation: value['require_email_confirmation'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'social.google.enable': enableGoogleLogin,
      };
}
