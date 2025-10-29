# Copilot instructions for hizliflutter

Short, focused guidance to help AI coding agents contribute safely and productively.

1) Project overview
- Flutter mobile app (Android/iOS) using GetX for state/navigation and Firebase for messaging. Entry point: `lib/main.dart`.
- Backend API: REST endpoints at `AppString.webUrl` + `AppString.webDataUrl` (see `lib/app_string.dart`). API client lives in `lib/data/data.dart` which extends `lib/data/api.dart`.

2) Architecture & key patterns
- State + controllers: uses GetX controllers in `lib/controllers/*` (examples: `post_controller.dart`, `auth/auth_controller.dart`). Controllers expose `Rx` fields and use `update()` to refresh UI.
- Networking: `Data.get` and `Data.post` map `DataType` enums to endpoint paths. Use `MainModel.toJson()` when sending bodies (see `lib/models/*`). Token handling uses `SharedPreferences` and the `isToken` flag in `Data.post`.
- UI: pages under `lib/pages/*` are composed with `GetMaterialApp` (routing via GetX). The bottom nav and main pages are in `lib/main.dart`.

3) Developer workflows (commands)
- Standard Flutter flows apply: `flutter pub get`, `flutter run`, `flutter build apk` / `flutter build ios`.
- Firebase initialization is required; `lib/main.dart` calls `Firebase.initializeApp()` at startup.
- Local web API: code expects API at `http://api.hizliflutter.yazilimmotoru.com/api/` (see `lib/app_string.dart`). When testing without the real API, mock `Data.get` / `Data.post` or run a local HTTP mock that matches the `DataType` paths.

4) Project-specific conventions
- DataType-driven API: Add new endpoints by extending `DataType` enum and updating switches in `Data.get`/`Data.post` in `lib/data/data.dart`.
- Controllers frequently call `Get.snackbar` for user-facing messages. Preserve this pattern for consistent UX.
- Persistent auth: token + user are stored in `SharedPreferences` keys `userLoginToken` and `user` (see `lib/controllers/auth/auth_controller.dart`). Use these keys when implementing auth-related features.

5) Integration points & external deps
- Firebase Messaging: `firebase_messaging` is used in `lib/main.dart` to handle push messages.
- Shared Preferences: `shared_preferences` used for auth/session (see `AuthController`).
- HTTP: `package:http` used in `Data` class.

6) Examples to copy-paste
- Add a new API entry in `DataType` and wire it:
- In `lib/data/data.dart` add a case for the enum mapping to the path and reuse existing `http.get`/`http.post` patterns.
- Use controller pattern: create a GetxController with Rx fields, add `onInit()` to init controllers, and call `update()` after data changes (see `lib/controllers/post_controller.dart`).

7) Safety & tests
- Avoid changing `lib/app_string.dart` URLs without coordinating with backend owners.
- Prefer small, focused PRs that include a one-line test or manual QA instructions (how to exercise the change via the app UI).

If anything in this file is unclear or you want more examples (routing, model shapes, auth flows), tell me which area to expand and I will update the instructions.
