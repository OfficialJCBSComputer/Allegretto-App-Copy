# Allegretto App

Allegretto Eisteddfod mobile app (Android/iOS).

## License

This software is **All Rights Reserved**. See [LICENSE](./LICENSE) for terms.

## Prerequisites

- Flutter SDK (see `.fvm/flutter_sdk` version or use latest stable)
- A Firebase project with Authentication, Firestore, Storage, and Cloud Messaging enabled
- An AdMob account (for ad units)

## Setup

### 1. Clone & decrypt secrets

**Windows:**
```powershell
scripts\decrypt.ps1
# Password: ask the team
```

**macOS / Linux:**
```bash
chmod +x scripts/decrypt.sh
./scripts/decrypt.sh
# Password: ask the team
```

This creates `.env` (gitignored) with the API keys needed at build time.

### 2. Get dependencies

```bash
flutter pub get
```

### 3. Run or build

```bash
# Run on connected device
flutter run

# Build APK (Android)
flutter build apk --debug

# Build IPA (iOS — requires Apple Developer account)
flutter build ios --debug
```

### 4. Update encrypted secrets

Edit `.env`, then re-encrypt:
```powershell
scripts\encrypt.ps1
# Enter new password or keep the same one
```

Commit the updated `.env.enc`.

## Firebase config files

The following files are checked into the repo and required at build time:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

These contain public Firebase configuration (API keys are restricted by app ID, not secrecy).
