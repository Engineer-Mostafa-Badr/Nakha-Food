# Nakha (EltayebTrans)

## نظرة عامة

`EltayebTrans` هو تطبيق Flutter لإدارة خدمات النقل والتوصيل. مصمم لدعم السائقين والممثلين في متابعة الرحلات، المصروفات، وصيانة المركبات من خلال واجهة عربية سلسة تعتمد على معمارية نظيفة.

## الخدمات الأساسية

- **إدارة الرحلات**: استلام الرحلات، عرض المسارات، وتأكيد تنفيذ الرحلات مع تتبع الحالة في الوقت الحقيقي.
- **إدارة المصروفات**: تسجيل المصروفات اليومية، رفع إيصالات، وطلب صيانة مباشرة داخل التطبيق.
- **الملف الشخصي**: تخصيص بيانات السائق أو الممثل وإدارة الوسائل المقبولة للتواصل.
- **الإشعارات الفورية**: تنبيهات للرحلات، المصروفات، ورسائل الدعم الفني عبر Firebase + Pusher.
- **الدعم الفني**: نظام تذاكر يربط المستخدم بفريق الدعم لحل أية مشاكل بسرعة.

## بنية المشروع

ينفذ المشروع Clean Architecture مع فصل واضح بين الطبقات:

```
lib/
├── config/          # إعدادات عامة (Themes, Routing, Firebase)
├── core/
│   ├── api/         # طبقة الشبكة (Dio و API Consumer)
│   ├── components/  # مكونات واجهة قابلة لإعادة الاستخدام
│   ├── extensions/  # Extensions مساعدة
│   ├── services/    # خدمات مشتركة (Notifications, Pusher)
│   └── utils/       # Helpers و utilities
└── features/        # الوحدات الوظيفية (Features)
    ├── auth/        # المصادقة
    ├── home/        # إدارة الرحلات
    ├── profile/     # الملف الشخصي
    ├── expenses/    # المصروفات
    ├── notifications/ # الإشعارات
    └── onboarding/  # شاشات التعريف
```

## التقنيات المستخدمة

- **Flutter 3.8.1+**
- **State Management**: `flutter_bloc`
- **DI**: `GetIt`
- **Localization**: `easy_localization`
- **Network**: `Dio`
- **Storage محلي**: `flutter_secure_storage`
- **Firebase**: Core، Messaging
- **Real-Time**: `pusher_channels_flutter`

## خطوات الإعداد

```bash
# تنظيف المشروع
flutter clean

# تثبيت الحزم
flutter pub get

# تشغيل التطبيق
flutter run
```

### بناء نسخة إنتاج

```bash
flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols
```

## اللغات المدعومة

- العربية (ar) – الإفتراضي
- الإنجليزية (en)
- الأردية (ur)

## ملاحظات تطويرية

- بنية نظيفة لكل Feature (data/domain/presentation).
- الكود منظم بمستوى Senior Developer مع فصل واضح للثوابت، الألوان، والـ widgets القابلة لإعادة الاستخدام.
- الترجمة من ملفات JSON داخل `assets/translation/`.
- اعتمد على ملفات التكوين الخاصة بـ Firebase قبل التشغيل (الدخول لـ `google-services.json` و`GoogleService-Info.plist`).

## الترخيص

جميع الحقوق محفوظة. هذا مشروع خاص ولا يُستخدم بدون إذن.
