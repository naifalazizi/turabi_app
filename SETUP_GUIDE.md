# دليل إعداد وتشغيل تطبيق ترابي

## متطلبات النظام

### Flutter SDK
- إصدار 3.24.5 أو أحدث
- Dart 3.5.4 أو أحدث

### بيئة التطوير
- Android Studio أو VS Code
- Git للتحكم في الإصدارات

### أجهزة الاختبار
- جهاز Android (API 21+) أو iOS (12.0+)
- محاكي Android أو iOS Simulator

## خطوات الإعداد

### 1. تثبيت Flutter

#### على Windows:
```bash
# تحميل Flutter SDK
# من https://docs.flutter.dev/get-started/install/windows

# إضافة Flutter إلى PATH
set PATH=%PATH%;C:\flutter\bin

# فحص التثبيت
flutter doctor
```

#### على macOS:
```bash
# تثبيت باستخدام Homebrew
brew install --cask flutter

# أو تحميل مباشر
# من https://docs.flutter.dev/get-started/install/macos

# فحص التثبيت
flutter doctor
```

#### على Linux:
```bash
# تحميل وتثبيت Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz
tar xf flutter_linux_3.24.5-stable.tar.xz

# إضافة إلى PATH
export PATH="$PATH:`pwd`/flutter/bin"
echo 'export PATH="$PATH:'`pwd`'/flutter/bin"' >> ~/.bashrc

# فحص التثبيت
flutter doctor
```

### 2. إعداد بيئة التطوير

#### Android Studio:
1. تحميل وتثبيت Android Studio
2. تثبيت Android SDK
3. تثبيت إضافة Flutter و Dart
4. إنشاء Android Virtual Device (AVD)

#### VS Code:
1. تثبيت إضافة Flutter
2. تثبيت إضافة Dart
3. تثبيت إضافة Android iOS Emulator

### 3. استنساخ المشروع

```bash
# استنساخ المشروع
git clone <repository-url>
cd turabi_app

# أو إنشاء مجلد جديد ونسخ الملفات
mkdir turabi_app
cd turabi_app
# نسخ جميع ملفات المشروع هنا
```

### 4. تثبيت التبعيات

```bash
# تثبيت packages
flutter pub get

# فحص المشروع
flutter analyze

# تشغيل الاختبارات
flutter test
```

## تشغيل التطبيق

### 1. تشغيل على المحاكي

```bash
# عرض الأجهزة المتاحة
flutter devices

# تشغيل على Android
flutter run

# تشغيل على iOS (macOS فقط)
flutter run -d ios

# تشغيل في وضع التطوير
flutter run --debug

# تشغيل في وضع الإنتاج
flutter run --release
```

### 2. تشغيل على جهاز حقيقي

#### Android:
1. تفعيل وضع المطور في الجهاز
2. تفعيل USB Debugging
3. توصيل الجهاز بالكمبيوتر
4. تشغيل `flutter run`

#### iOS:
1. توصيل الجهاز بـ Mac
2. الوثوق بالكمبيوتر في الجهاز
3. فتح المشروع في Xcode
4. تشغيل من Xcode أو `flutter run`

## بناء التطبيق للإنتاج

### Android APK:
```bash
# بناء APK
flutter build apk

# بناء APK مقسم حسب المعمارية
flutter build apk --split-per-abi

# الملف سيكون في: build/app/outputs/flutter-apk/
```

### Android App Bundle:
```bash
# بناء AAB للنشر في Google Play
flutter build appbundle

# الملف سيكون في: build/app/outputs/bundle/release/
```

### iOS:
```bash
# بناء للجهاز
flutter build ios

# بناء IPA
flutter build ipa

# الملف سيكون في: build/ios/ipa/
```

## حل المشاكل الشائعة

### 1. مشاكل Flutter Doctor

```bash
# فحص المشاكل
flutter doctor -v

# حل مشاكل Android
flutter doctor --android-licenses

# تحديث Flutter
flutter upgrade
```

### 2. مشاكل التبعيات

```bash
# تنظيف المشروع
flutter clean

# إعادة تثبيت التبعيات
flutter pub get

# إعادة بناء المشروع
flutter run
```

### 3. مشاكل الأداء

```bash
# تشغيل في وضع Profile
flutter run --profile

# تحليل الأداء
flutter run --trace-startup --profile
```

### 4. مشاكل الشاشات

```bash
# إعادة تشغيل التطبيق
r (في terminal أثناء التشغيل)

# إعادة تشغيل كاملة
R (في terminal أثناء التشغيل)

# إيقاف التطبيق
q (في terminal أثناء التشغيل)
```

## اختبار التطبيق

### 1. اختبار الوحدة
```bash
flutter test
```

### 2. اختبار التكامل
```bash
flutter drive --target=test_driver/app.dart
```

### 3. اختبار الأداء
```bash
flutter run --profile
```

## نصائح التطوير

### 1. Hot Reload
- استخدم `r` لإعادة تحميل سريعة
- استخدم `R` لإعادة تشغيل كاملة

### 2. التصحيح
- استخدم `print()` للتصحيح البسيط
- استخدم `debugPrint()` للرسائل المفصلة
- استخدم Flutter Inspector في IDE

### 3. الأداء
- تجنب `setState()` المفرط
- استخدم `const` constructors
- استخدم `ListView.builder` للقوائم الطويلة

## الدعم والمساعدة

### الوثائق الرسمية:
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)

### المجتمع:
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

### الأدوات المفيدة:
- [Flutter Inspector](https://docs.flutter.dev/development/tools/flutter-inspector)
- [Dart DevTools](https://dart.dev/tools/dart-devtools)

---

**ملاحظة:** هذا الدليل يغطي الإعداد الأساسي. لمتطلبات خاصة أو مشاكل محددة، يرجى الرجوع للوثائق الرسمية أو طلب المساعدة من المجتمع.

