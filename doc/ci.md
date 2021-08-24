# CI - GitHub Actions

Стандартный флоу который используется в наших проектах

### Dev Action

```yaml
name: Test

on:
  push:
    branches:
      - '*'
      - '*/*'
      - '!main'
      - '!stage'

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-java@v1
        with:
          java-version: '12.x'
      - uses: subosito/flutter-action@v1
        with:
          channel: 'stable'
      - run: flutter pub get
      - run: flutter pub run build_runner build
      - run: flutter analyze
      - run: flutter test
```

### Stage Action

Выгружает билд для Android в Firebase App Distribution, для Apple в Test Flight

Используемые env находятся в документации к Actions:

1. **Android:**
    1. [r0adkll/sign-android-release](https://github.com/r0adkll/sign-android-release)
    1. [wzieba/Firebase-Distribution-Github-Action](https://github.com/wzieba/Firebase-Distribution-Github-Action)
1. **iOS:**
    1. [yukiarrr/ios-build-action](https://github.com/yukiarrr/ios-build-action)
    1. [apple-actions/upload-testflight-build](https://github.com/Apple-Actions/upload-testflight-build)

```yaml
name: Stage Action

on:
  push:
    branches:
      - 'stage'

jobs:
  android:
    name: 'Release stage build (Android)'
    runs-on: ubuntu-latest
    if: "!contains(github.event.head_commit.message, '[ci skip]')"
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2

      - name: 'Setup Java'
        uses: actions/setup-java@v1
        with:
          java-version: '12.x'

      - name: 'Install Flutter'
        uses: subosito/flutter-action@v1
        with:
          channel: 'stable'

      - name: 'Get dependencies'
        run: flutter pub get

      - name: 'Generate code'
        run: flutter pub run build_runner build

      - name: 'Build APK'
        run: flutter build apk --target-platform android-arm,android-arm64 -t lib/main_stage.dart

      - name: 'Sign APK'
        id: sign_apk
        uses: r0adkll/sign-android-release@v1
        with:
          releaseDirectory: build/app/outputs/apk/release/
          signingKeyBase64: ${{ secrets.ANDROID_SIGNING_KEY }}
          alias: ${{ secrets.ANDROID_KEY_ALIAS }}
          keyStorePassword: ${{ secrets.ANDROID_KEY_STORE_PASSWORD }}
          keyPassword: ${{ secrets.ANDROID_KEY_PASSWORD }}

      - name: 'Upload Build to Firebase'
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{secrets.FIREBASE_ANDROID_APP_ID}}
          token: ${{secrets.FIREBASE_TOKEN}}
          groups: all
          file: ${{steps.sign_apk.outputs.signedReleaseFile}}

  build_ios:
    name: 'Release stage build (iOS)'
    runs-on: macOS-latest
    if: "!contains(github.event.head_commit.message, '[ci skip]')"
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2

      - name: 'Setup Java'
        uses: actions/setup-java@v1
        with:
          java-version: '12.x'

      - name: 'Install Flutter'
        uses: subosito/flutter-action@v1
        with:
          channel: 'stable'
          
      - name: 'Get dependencies'
        run: flutter pub get

      - name: 'Generate code'
        run: flutter pub run build_runner build

      - name: 'Build IPA'
        run: flutter build ios --release --no-codesign -t lib/main_stage.dart

      - name: 'Sign IPA'
        uses: yukiarrr/ios-build-action@v1.4.0
        with:
          export-method: 'app-store'
          project-path: ios/Runner.xcodeproj
          p12-base64: ${{ secrets.DISTRIBUTION_P12_BASE64 }}
          mobileprovision-base64: ${{ secrets.DISTRIBUTION_MOBILEPROVISION_BASE64 }}
          code-signing-identity: ${{ secrets.DISTRIBUTION_CODE_SIGNING_IDENTITY }}
          team-id: ${{ secrets.TEAM_ID }}
          workspace-path: ios/Runner.xcworkspace
          output-path: 'Runner.ipa'

      - name: 'Upload IPA to TestFlight'
        uses: apple-actions/upload-testflight-build@v1
        with:
          app-path: 'Runner.ipa'
          issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
          api-key-id: ${{ secrets.APPSTORE_API_KEY_ID }}
          api-private-key: ${{ secrets.APPSTORE_API_PRIVATE_KEY }}
```

В случае когда необходимо выгружать билд в Firebase App Distribution для Apple

```yaml
  build_ios:
    name: Build Flutter (iOS)
    runs-on: macOS-latest
    needs: [delete_artifacts]
    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-java@v1
      with:
        java-version: '12.x'
    - uses: subosito/flutter-action@v1
      with:
        channel: 'stable'
    - run: flutter pub get
    - run: flutter pub run build_runner build
    - run: flutter build ios --release --no-codesign -t lib/main_stage.dart
    - uses: yukiarrr/ios-build-action@v1.4.0
      with:
        export-method: "ad-hoc"
        project-path: ios/Runner.xcodeproj
        p12-base64: ${{ secrets.DISTRIBUTION_P12_BASE64 }}
        mobileprovision-base64: ${{ secrets.FIREBASE_DISTRIBUTION_MOBILEPROVISION }}
        code-signing-identity: ${{ secrets.FIREBASE_DISTRIBUTION_CODE_SIGNING_IDENTITY }}
        team-id: ${{ secrets.TEAM_ID }}
        workspace-path: ios/Runner.xcworkspace
        output-path: "Runner.ipa"
    - name: Upload iPA
      uses: actions/upload-artifact@v2
      with:
        name: ios-build
        path: Runner.ipa

  deploy_stage_ios:
    name: Upload iOS Stage to Firebase App Distribution
    needs: [build_ios]
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: set up JDK 1.8
      uses: actions/setup-java@v1
      with:
        java-version: 1.8
    - name: Download Artifact
      uses: actions/download-artifact@master
      with:
        name: ios-build
    - name: Upload IPA
      uses: wzieba/Firebase-Distribution-Github-Action@v1.0.0
      with:
        appId: ${{secrets.FIREBASE_IOS_APPID}}
        token: ${{secrets.FIREBASE_TOKEN}}
        groups: all
        file: Runner.ipa
```

### Production Action

Выгружает билд для Apple в Test Flight собранный в production, для Android собирается aab для загрузки вручную

Происходит в два этапа:

#### 1. Автоматически при мердже в main производится инкремент build.

```yaml
name: Production Version Changer

on:
  push:
    branches:
      - 'main'

jobs:
  update_version:
    runs-on: ubuntu-latest
    if: "!contains(github.event.head_commit.message, '[ci skip]')"
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2
      - name: 'Bump build'
        run: perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
      - name: 'Commit files'
        run: |
          git config --local user.email "github-actions[bot]@users.noreply.github.com"
          git config --local user.name "github-actions[bot]"
          git commit -m "Bump Version [ci skip]" -a
      - name: 'Push changes'
        uses: ad-m/github-push-action@master
        with:
          tags: true
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: ${{ github.ref }}
```

#### 2. При создании релиза нужно делать тег, release/x.x.x ГДЕ x.x.x версия

1. **Android:**
    1. [r0adkll/sign-android-release](https://github.com/r0adkll/sign-android-release)
1. **iOS:**
    1. [yukiarrr/ios-build-action](https://github.com/yukiarrr/ios-build-action)
    1. [apple-actions/upload-testflight-build](https://github.com/Apple-Actions/upload-testflight-build)

```yaml
name: Production Action

on:
  release:
    types: [published]

jobs:
  delete_artifacts:
    name: Delete Artifacts
    runs-on: ubuntu-latest
    steps:
      - uses: kolpav/purge-artifacts-action@v1
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          expire-in: 14days

  android:
    name: 'Release production build (Android)'
    runs-on: ubuntu-latest
    needs: [delete_artifacts]
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2

      - name: 'Setup Java'
        uses: actions/setup-java@v1
        with:
          java-version: '12.x'

      - name: 'Install Flutter'
        uses: subosito/flutter-action@v1
        with:
           channel: 'stable'

      - name: 'Get dependencies'
        run: flutter pub get

      - name: 'Generate code'
        run: flutter pub run build_runner build

      - name: 'Build AAB'
        run: flutter build appbundle --release

      - name: 'Sign AAB'
        id: sign_aab
        uses: r0adkll/sign-android-release@v1
        with:
          releaseDirectory: build/app/outputs/bundle/release/
          signingKeyBase64: ${{ secrets.ANDROID_SIGNING_KEY }}
          alias: ${{ secrets.ANDROID_KEY_ALIAS }}
          keyStorePassword: ${{ secrets.ANDROID_KEY_STORE_PASSWORD }}
          keyPassword: ${{ secrets.ANDROID_KEY_PASSWORD }}

      - name: Upload AAB
        uses: actions/upload-artifact@v2
        with:
          name: aab-build
          path: ${{steps.sign_aab.outputs.signedReleaseFile}}

  build_ios:
    name: 'Release production build (iOS)'
    runs-on: macOS-latest
    needs: [delete_artifacts]
    steps:
      - name: 'Checkout'
        uses: actions/checkout@v2

      - name: 'Setup Java'
        uses: actions/setup-java@v1
        with:
          java-version: '12.x'

      - name: 'Install Flutter'
        uses: subosito/flutter-action@v1
        with:
          channel: 'stable'

      - name: 'Get dependencies'
        run: flutter pub get

      - name: 'Generate code'
        run: flutter pub run build_runner build

      - name: 'Build IPA'
        run: flutter build ios --release --no-codesign

      - name: 'Sign IPA'
        uses: yukiarrr/ios-build-action@v1.3.1
        with:
          export-method: 'app-store'
          project-path: ios/Runner.xcodeproj
          p12-base64: ${{ secrets.DISTRIBUTION_P12_BASE64 }}
          mobileprovision-base64: ${{ secrets.DISTRIBUTION_MOBILEPROVISION_BASE64 }}
          code-signing-identity: ${{ secrets.DISTRIBUTION_CODE_SIGNING_IDENTITY }}
          team-id: ${{ secrets.TEAM_ID }}
          workspace-path: ios/Runner.xcworkspace
          output-path: 'Runner.ipa'

      - name: 'Upload IPA to TestFlight'
        uses: apple-actions/upload-testflight-build@v1
        with:
          app-path: 'Runner.ipa'
          issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
          api-key-id: ${{ secrets.APPSTORE_API_KEY_ID }}
          api-private-key: ${{ secrets.APPSTORE_API_PRIVATE_KEY }}

```