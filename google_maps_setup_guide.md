# إعداد Google Maps API

## خطوات إعداد Google Maps API Key:

### 1. إنشاء مشروع في Google Cloud Console
1. اذهب إلى [Google Cloud Console](https://console.cloud.google.com/)
2. أنشئ مشروع جديد أو اختر مشروع موجود
3. فعّل Google Maps SDK for iOS و Google Maps SDK for Android

### 2. إنشاء API Key
1. اذهب إلى APIs & Credentials > Credentials
2. اضغط على "Create Credentials" > "API Key"
3. انسخ المفتاح الذي تم إنشاؤه

### 3. إعداد القيود (اختياري لكن مهم للأمان)
1. اضغط على API Key الذي أنشأته
2. في قسم "Application restrictions"، اختر:
   - لـ iOS: "iOS apps" وأضف Bundle ID: `com.turabi.app.turabiApp`
   - لـ Android: "Android apps" وأضف Package name: `com.turabi.app.turabiApp`

### 4. تطبيق المفتاح في التطبيق

#### iOS (ios/Runner/Info.plist):
ابحث عن السطر:
```xml
<key>GMSApiKey</key>
<string>YOUR_GOOGLE_MAPS_API_KEY_HERE</string>
```
واستبدل `YOUR_GOOGLE_MAPS_API_KEY_HERE` بمفتاحك الفعلي.

#### Android (android/app/src/main/AndroidManifest.xml):
ابحث عن السطر:
```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE" />
```
واستبدل `YOUR_GOOGLE_MAPS_API_KEY_HERE` بمفتاحك الفعلي.

## ملاحظات مهمة:
- لا تشارك API Key علنياً
- استخدم القيود لحماية المفتاح
- تأكد من تفعيل الخدمات المطلوبة في Google Cloud Console

## للاختبار بدون Google Maps:
يمكنك تعطيل الخريطة مؤقتاً بتعليق الكود في `home_screen.dart` في `_MapWidget`.
