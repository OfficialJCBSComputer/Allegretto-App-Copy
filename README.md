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

## Codemagic CI/CD (cloud builds)

This repo includes `codemagic.yaml` for automatic builds on push.

### Setup

1. Go to [codemagic.io](https://codemagic.io) and sign in with GitHub
2. Add this repository
3. In **Environment variables**, add:

| Variable | Value |
|----------|-------|
| `ENCRYPTION_PASSWORD` | The `.env.enc` password (`Ask Team`) — mark as **encrypted** |
| `EMAIL` | Your email for build notifications |

4. Push to `main` — Codemagic will build APK + IPA automatically

### iOS signing

To produce installable IPAs (not just unsigned), you'll need:

1. An **Apple Developer account** ($99/year)
2. Upload your **App Store Connect API key** or **certificates** in Codemagic > Teams > Apple Developer Portal
3. Update `codemagic.yaml` to add codesigning (remove `--no-codesign` and add the signing config)

Without codesigning, the built `.app` can only run in the iOS simulator.

## Firebase config files

The following files are checked into the repo and required at build time:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

These contain public Firebase configuration (API keys are restricted by app ID, not secrecy).
