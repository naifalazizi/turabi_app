# أزرار الرجوع في التطبيق - Back Buttons Guide

## الإضافات الجديدة ✅

### 1. `AppScaffold` محسن
تم تحديث `AppScaffold` لدعم أزرار الرجوع تلقائياً:

```dart
AppScaffold(
  title: 'العنوان',
  showBackButton: true, // افتراضياً true
  body: YourContent(),
)
```

### 2. مكونات أزرار الرجوع الجديدة

#### `AppBackButton` - زر رجوع بسيط
```dart
AppBackButton(
  onPressed: () => context.pop(),
  showText: true, // يظهر كلمة "رجوع"
  text: 'رجوع', // نص مخصص
)
```

#### `AppFloatingBackButton` - زر رجوع عائم
```dart
Stack(
  children: [
    YourContent(),
    AppFloatingBackButton(), // يظهر في أعلى اليسار
  ],
)
```

#### `AppNavigationBar` - شريط تنقل مخصص
```dart
Column(
  children: [
    AppNavigationBar(
      title: 'العنوان',
      showBackButton: true,
      actions: [
        IconButton(icon: Icon(Icons.share), onPressed: () {}),
      ],
    ),
    Expanded(child: YourContent()),
  ],
)
```

### 3. Extension للتنقل المحسن
```dart
// فحص إمكانية الرجوع
if (context.canGoBack) {
  context.goBack();
}

// رجوع أو انتقال لصفحة معينة
context.goBackOr('/home');
```

## الشاشات المحدثة ✅

تم تحديث الشاشات التالية لاستخدام `AppScaffold` مع أزرار الرجوع:

### 1. شاشات المصادقة
- ✅ `LoginScreen` - تسجيل الدخول
- ✅ `RegisterScreen` - التسجيل

### 2. شاشات الحجز
- ✅ `BookingScreen` - حجز جديد

### 3. شاشات الملف الشخصي
- ✅ `ProfileScreen` - الملف الشخصي

## أمثلة الاستخدام 📱

### 1. شاشة بسيطة مع زر رجوع
```dart
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'شاشتي',
      showBackButton: true,
      body: Column(
        children: [
          Text('المحتوى هنا'),
        ],
      ),
    );
  }
}
```

### 2. شاشة بزر رجوع مخصص
```dart
AppScaffold(
  title: 'شاشة مخصصة',
  leading: AppBackButton(
    onPressed: () {
      // إجراء مخصص قبل الرجوع
      showDialog(...);
    },
  ),
  body: YourContent(),
)
```

### 3. شاشة بدون AppBar مع زر عائم
```dart
AppScaffold(
  showAppBar: false,
  body: Stack(
    children: [
      YourFullScreenContent(),
      AppFloatingBackButton(),
    ],
  ),
)
```

### 4. شاشة بشريط تنقل مخصص
```dart
AppScaffold(
  showAppBar: false,
  body: Column(
    children: [
      AppNavigationBar(
        title: 'العنوان',
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      Expanded(child: YourContent()),
    ],
  ),
)
```

## السمات والإعدادات ⚙️

### AppScaffold
- `showBackButton: bool` - إظهار زر الرجوع (افتراضياً `true`)
- `onBackPressed: VoidCallback?` - إجراء مخصص للرجوع
- `leading: Widget?` - زر رجوع مخصص

### AppBackButton
- `onPressed: VoidCallback?` - إجراء مخصص
- `showText: bool` - إظهار نص "رجوع"
- `text: String?` - نص مخصص
- `color: Color?` - لون الزر
- `size: double?` - حجم الأيقونة

### AppFloatingBackButton
- `backgroundColor: Color?` - لون الخلفية
- `iconColor: Color?` - لون الأيقونة
- `onPressed: VoidCallback?` - إجراء مخصص

## المزايا الجديدة 🎯

### 1. تلقائي وذكي
- زر الرجوع يظهر تلقائياً عند الحاجة
- يختفي في الشاشة الرئيسية
- يستخدم `GoRouter.canPop()` للتحقق

### 2. متناسق مع التصميم
- يتبع ألوان التطبيق
- حجم وموضع موحد
- دعم RTL كامل

### 3. مرن وقابل للتخصيص
- إمكانية تخصيص الإجراء
- أشكال مختلفة (عادي، نص، عائم)
- سهولة الاستخدام

### 4. أداء محسن
- لا توجد إعادة بناء غير ضرورية
- فحص ذكي لإمكانية الرجوع
- استخدام فعال للذاكرة

## نصائح للاستخدام 💡

### 1. استخدم AppScaffold دائماً
```dart
// ✅ صحيح
AppScaffold(
  title: 'العنوان',
  body: YourContent(),
)

// ❌ تجنب
Scaffold(
  appBar: AppBar(title: Text('العنوان')),
  body: YourContent(),
)
```

### 2. تخصيص زر الرجوع عند الحاجة
```dart
AppScaffold(
  onBackPressed: () {
    // حفظ البيانات أولاً
    saveData().then((_) => context.pop());
  },
  body: YourForm(),
)
```

### 3. استخدم الزر العائم للشاشات الكاملة
```dart
// للصور والفيديوهات
AppScaffold(
  showAppBar: false,
  body: Stack(
    children: [
      FullScreenImage(),
      AppFloatingBackButton(),
    ],
  ),
)
```

---

**🎉 النتيجة:** التطبيق الآن يحتوي على أزرار رجوع متناسقة وذكية في جميع الشاشات!
