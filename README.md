# Nakha (نخْعَة)

Nakha هو تطبيق خدمات عالي الجودة يبني منصة موثوقة لربط العملاء بالمُقدّمين المعتمدين في مجالات متعددة. يعتمد المشروع على هندسة نظيفة (Clean Architecture) لمنح كل ميزة حدود تفصيلية (feature modules) منطق خاص بها، ويُوظّف BLoC للتعامل مع الحالة، وسهّل الوصول عبر دعم اللغات المتعددة، والإخطارات الفورية، وخصائص الدفع والمحفظة.

## الهدف والرؤية

مشروع Nakha يُصمم ليكون وجهة موحدة لطلبات الخدمات والمنتجات، ويُوفر:

- تجربة دخول مرنة للعميل مع تسجيل عبر الهاتف أو البريد، والتحقق بالرموز.
- لوحة محادثة داخل التطبيق للتواصل بين العملاء والمُقدّمين والدعم.
- إدارة بيانات المستخدم، المحفظة، الطلبات، المفضلات، والإشعارات بواجهة واحدة.
- نظام دعم فني ومركز إشعارات متصل بـ Firebase / Pusher لتجربة واقعية.

التركيز على الأداء في الأجهزة ذات الشاشات المختلفة، إلى جانب دعم العربية (ar-SA)، الإنجليزية (en-US)، والأردية (ur-PK)، مع استخدام `flutter_screenutil` للتكيّف مع الأحجام.

## نظرة على البنية

يُطبق المشروع مبدأ الفصل بين القواعد العامة والوظائف الخاصة داخل `lib`:

```
lib/
├── config/          # إعدادات عامة (Themes, Routing, Firebase)
├── core/
│   ├── api/         # طبقة الشبكة (Dio، BaseResponse)
│   ├── components/  # مكونات قابلة لإعادة الاستخدام (AppBar، Buttons، Screen Status)
│   ├── cubit/       # AppCubit + حالات عامة
│   ├── extensions/  # Extensions مساعدة
│   ├── res/         # صور وأيقونات المشروع
│   ├── services/    # خدمات مشتركة (Notifications، Pusher، Firebase)
│   ├── storage/     # التخزين الآمن (Hive، SecureStorage)
│   ├── usecase/     # قواعد UseCase مشتركة
│   └── utils/       # Helpers، Validations، Responsive
└── features/        # الوحدات الوظيفية (Features)
    ├── auth/        # المصادقة والتسجيل
    ├── chat/        # المحادثات والدردشة
    ├── home/        # لوحة التسوّق الرئيسية
    ├── profile/     # الملف الشخصي وإدارة البيانات
    ├── orders/      # الطلبات والمبيعات
    ├── providers/   # مقدّمي الخدمة
    ├── favourite/   # المفضلات (منتجات/مقدمي خدمة)
    ├── wallet/      # المحفظة والدفع
    ├── notifications/ # الإشعارات الفورية
    ├── support/     # دعم العملاء
    └── onboarding/  # شاشات التعريف
```

كل مجلد ميزة يتبع التركيبة الثلاثية: `data` (نماذج، مصادر بيانات، مستودعات) → `domain` (كيانات، واجهات، use cases) → `presentation` (صفحات، وحدات BLoC، تصميم واجهة).

### `assets`

- الأيقونات: PNG و SVG متعددة الدقة.
- الخطوط: عائلة Tajawal مع كامل الأوزان.
- الترجمة داخل `assets/translation` لدعم اللغات المستهدفة.

## التقنيات البارزة

- **State Management**: `flutter_bloc` مع `bloc` و`cubit` للمزامنة.
- **الترجمة**: `easy_localization` مع ملفات JSON مهيأة مسبقًا.
- **شبكات**: `dio`, `pretty_dio_logger`, `internet_connection_checker_plus`.
- **إشعارات و Realtime**: `firebase_messaging`, `pusher_channels_flutter`, `flutter_local_notifications`.
- **أدوات إضافية**: `flutter_secure_storage`, `file_picker`, `flutter_image_compress`, `cached_network_image`, `flutter_svg`, `calendar_date_picker2`.
- **تصميم واجهة**: `flutter_screenutil`, `smooth_page_indicator`, `carousel_slider`, `page_transition`.

## خطوات الإعداد

1. تثبيت Flutter 3.17+ و Dart 3.8+.
2. نسخ ملفات إعداد Firebase (`android/google-services.json`، `ios/Runner/GoogleService-Info.plist`) إن لم تكن موجودة.
3. تشغيل:
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. توليد الأيقونات والشاشة الافتتاحية إذا تم تعديلها:
   ```bash
   dart run flutter_launcher_icons:main
   dart run flutter_native_splash:create
   ```
5. تنفيذ التطبيق:
   ```bash
   flutter run
   ```

## تشغيل الإختبارات

- الامر العام:
  ```bash
  flutter test
  ```

## ملاحظات ذكية

- تكامل التخزين الآمن عبر `MainSecureStorage` يُسمح بالتحقق من حالة التفعيل وتخزين التوكنات محليًا.
- الشاشة الابتدائية تحدد تلقائيًا بين Onboarding / Login / Landing بناءً على الحالة المحفوظة.
- كل المجلدات الممررة تحتوي على خطط BLoC خاصة بها لتسهيل الاختبار واستبدال أجزاء من المنطق دون تأثير على باقي التطبيق.

## خطوات مقترحة لاحقة

- توسيع التغطية الاختبارية (unit + widget).
- مراقبة الأداء عبر Logs وبيانات Firebase، خاصة لمزودين متعددين.
- أتمتة CI باستخدام `flutter test` + `flutter analyze` ورفع البنى عبر مشغل تلقائي.
