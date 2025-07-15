# مرجع سريع للمطور - Turabi App

## أوامر سريعة 🚀

```bash
# تنظيف وإعادة تثبيت
flutter clean && flutter pub get

# تشغيل التطبيق
flutter run --debug

# فحص حالة Flutter
flutter doctor

# بناء للإنتاج
flutter build ios --release
flutter build apk --release
```

## مكونات UI الجاهزة 🎨

### الأزرار
```dart
// زر عادي
AppButton(
  text: 'إرسال',
  onPressed: () {},
)

// زر مع تحميل
AppButton(
  text: 'حفظ',
  onPressed: isLoading ? null : _save,
  isLoading: isLoading,
)

// زر محدد الحواف
AppButton(
  text: 'إلغاء',
  isOutlined: true,
  onPressed: () {},
)
```

### النصوص
```dart
AppText.headlineLarge('عنوان كبير')
AppText.bodyMedium('نص عادي')
AppText.labelSmall('تسمية صغيرة')
```

### الحقول النصية
```dart
AppTextField(
  label: 'الاسم',
  hint: 'أدخل اسمك',
  controller: nameController,
)

AppPasswordField(
  label: 'كلمة المرور',
  controller: passwordController,
)
```

### التخطيط
```dart
AppScaffold(
  title: 'الشاشة الرئيسية',
  showBackButton: true, // زر رجوع تلقائي
  body: AppContainer(
    child: Column(
      children: [
        // المحتوى
      ],
    ),
  ),
)
```

### أزرار الرجوع
```dart
// زر رجوع بسيط
AppBackButton()

// زر رجوع مع نص
AppBackButton(
  showText: true,
  text: 'رجوع',
)

// زر رجوع عائم للشاشات الكاملة
AppFloatingBackButton()

// فحص إمكانية الرجوع
if (context.canGoBack) {
  context.goBack();
}
```

## إدارة الحالة 📊

### استخدام Provider
```dart
// في build method
Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    if (authProvider.isLoading) {
      return AppLoading();
    }
    
    return YourWidget();
  },
)

// للوصول بدون listening
Provider.of<AuthProvider>(context, listen: false)
  .login(email, password);
```

### تحديث الحالة
```dart
class MyProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  Future<void> doSomething() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      // العمل هنا
    } catch (e) {
      // معالجة الخطأ
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

## التنقل 🧭

```dart
// الانتقال لصفحة جديدة
context.go('/home');

// الانتقال مع بيانات
context.go('/booking?id=123');

// العودة للخلف
context.pop();
```

## التصميم المتجاوب 📱

```dart
// فحص نوع الجهاز
if (ResponsiveHelper.isMobile(context)) {
  // تصميم الموبايل
} else if (ResponsiveHelper.isTablet(context)) {
  // تصميم التابلت
}

// حجم خط متجاوب
fontSize: ResponsiveHelper.responsiveFontSize(context, 16)

// padding متجاوب
padding: ResponsiveHelper.responsivePadding(context)
```

## معالجة الأخطاء 🐛

```dart
// widget للأخطاء
AppErrorWidget(
  message: 'حدث خطأ',
  onRetry: () => _retry(),
)

// حالة فارغة
AppEmptyState(
  title: 'لا توجد بيانات',
  subtitle: 'لم نجد أي نتائج',
  action: AppButton(
    text: 'إعادة المحاولة',
    onPressed: _reload,
  ),
)
```

## نصائح مهمة ⚡

### 1. تجنب أخطاء setState
```dart
// ❌ خطأ
void initState() {
  super.initState();
  provider.initData(); // يسبب مشاكل
}

// ✅ صحيح
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    provider.initData();
  });
}
```

### 2. استخدام Colors المحددة
```dart
// ✅ استخدم ألوان التطبيق
color: AppColors.primary
color: AppColors.textSecondary

// ❌ تجنب الألوان المباشرة
color: Colors.blue
```

### 3. النصوص مع الخطوط المناسبة
```dart
// ✅ استخدم AppText
AppText.bodyMedium('النص')

// ❌ تجنب Text العادي مع Google Fonts
Text('النص', style: GoogleFonts.cairo())
```

## الألوان المتاحة 🎨

```dart
AppColors.primary          // البرتقالي الأساسي
AppColors.secondary        // الأزرق الثانوي
AppColors.background       // خلفية فاتحة
AppColors.surface          // أبيض للكروت
AppColors.textPrimary      // نص أساسي داكن
AppColors.textSecondary    // نص ثانوي رمادي
AppColors.error            // أحمر للأخطاء
AppColors.success          // أخضر للنجاح
```

## أحجام النصوص 📏

```dart
// العناوين
AppText.headlineLarge()    // 32px
AppText.headlineMedium()   // 28px
AppText.headlineSmall()    // 24px

// العناوين الفرعية
AppText.titleLarge()       // 22px
AppText.titleMedium()      // 16px
AppText.titleSmall()       // 14px

// النصوص العادية
AppText.bodyLarge()        // 16px
AppText.bodyMedium()       // 14px
AppText.bodySmall()        // 12px
```

## حل المشاكل الشائعة 🔧

### مشكلة Hot Reload لا يعمل
```bash
flutter clean
flutter pub get
# ثم أعد تشغيل التطبيق
```

### مشكلة بناء iOS
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

### مشكلة مساحة القرص
```bash
flutter clean
flutter pub cache clean
```

---

**💡 نصيحة:** احفظ هذا الملف كمرجع سريع أثناء التطوير!
