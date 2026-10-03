// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'CareerVerse';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجّل الدخول لمواصلة رحلتك';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordInfo =>
      'الحسابات مخزّنة على هذا الجهاز. أنشئ حسابًا جديدًا إذا نسيت كلمة المرور.';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get or => 'أو';

  @override
  String get googleSignInInfo =>
      'تسجيل الدخول عبر Google متاح في تطبيق Android وiOS.';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get validationRequired => 'هذا الحقل مطلوب';

  @override
  String get validationNameLength => 'يجب أن يحتوي الاسم على حرفين على الأقل';

  @override
  String get validationEmail => 'أدخل بريدًا إلكترونيًا صالحًا';

  @override
  String get validationPasswordLength =>
      'يجب أن تحتوي كلمة المرور على 6 أحرف على الأقل';

  @override
  String get errorEmailTaken => 'يوجد حساب بهذا البريد الإلكتروني بالفعل.';

  @override
  String get errorNoAccount => 'لا يوجد حساب لهذا البريد الإلكتروني.';

  @override
  String get errorWrongPassword => 'كلمة المرور غير صحيحة.';

  @override
  String get notifWelcomeTitle => 'مرحبًا بك في CareerVerse 🎉';

  @override
  String get notifWelcomeBody =>
      'أكمل ملفك الشخصي وابدأ أول مختبر مهني للحصول على توصيات مخصّصة.';

  @override
  String get notifResultTitle => 'توصياتك جاهزة!';

  @override
  String notifResultBody(String lab, int score, String career, int topScore) {
    return '$lab: ‏$score٪. أفضل مهنة: $career ‏($topScore٪).';
  }

  @override
  String get notifNewBest => 'رقم قياسي شخصي جديد!';

  @override
  String reasonScored(int score, int done, int total) {
    return 'حصلت على $score٪ في $done/$total مختبرات.';
  }

  @override
  String reasonStrongest(String skill) {
    return 'أقوى مهارة: $skill.';
  }

  @override
  String get reasonNotTested =>
      'لم تُختبر بعد: جرّب مختبرًا لتأكيد هذه المهنة.';

  @override
  String reasonInterests(String interests) {
    return 'تتوافق مع اهتماماتك: $interests.';
  }

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int count) {
    return 'منذ $count دقيقة';
  }

  @override
  String timeHoursAgo(int count) {
    return 'منذ $count ساعة';
  }

  @override
  String timeDaysAgo(int count) {
    return 'منذ $count يوم';
  }

  @override
  String get acceptTermsError => 'يرجى قبول الشروط للمتابعة.';

  @override
  String get createYourAccount => 'أنشئ حسابك';

  @override
  String get registerSubtitle => 'ابدأ استكشاف المهن عبر محاكاة حقيقية';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get passwordHint => '6 أحرف على الأقل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get acceptTerms => 'أوافق على شروط الاستخدام وسياسة الخصوصية';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get haveAccount => 'لديك حساب بالفعل؟';

  @override
  String get welcomeTagline => 'استكشف  ·  تعلّم  ·  ابنِ\nمستقبلك';

  @override
  String get cybersecurity => 'الأمن السيبراني';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get home => 'الرئيسية';

  @override
  String get labs => 'المختبرات';

  @override
  String get explore => 'استكشاف';

  @override
  String get progress => 'التقدّم';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String helloName(String name) {
    return 'مرحبًا، $name 👋';
  }

  @override
  String get homeSubtitle => 'استكشف مسارك المهني';

  @override
  String get homeSearchHint => 'ابحث عن مهن أو مختبرات أو مهارات...';

  @override
  String get yourAiProfile => 'ملفك بالذكاء الاصطناعي';

  @override
  String labsPracticed(int done, int total, int minutes) {
    return '$done/$total مختبرات · $minutes دقيقة تدريب';
  }

  @override
  String get viewProgress => 'عرض التقدّم  ←';

  @override
  String get avg => 'متوسط';

  @override
  String get startFirstLab => 'ابدأ أول مختبر';

  @override
  String get upNext => 'التالي';

  @override
  String get quickAccess => 'وصول سريع';

  @override
  String get aiMatch => 'توافق الذكاء الاصطناعي';

  @override
  String get path => 'المسار';

  @override
  String get recommendedCareers => 'مهن موصى بها';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get recentActivity => 'النشاط الأخير';

  @override
  String get noActivity => 'لم تُكمل أي مختبر بعد. ستظهر نتائجك وتوصياتك هنا.';

  @override
  String get basedOnLabs => 'بناءً على مختبراتك';

  @override
  String get basedOnInterests => 'بناءً على اهتماماتك';

  @override
  String get careerLabs => 'المختبرات المهنية';

  @override
  String get exploreCareers => 'استكشاف المهن';

  @override
  String get aiRecommendations => 'توصيات الذكاء الاصطناعي';

  @override
  String get learningPath => 'مسار التعلّم';

  @override
  String get myProgress => 'تقدّمي';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get settings => 'الإعدادات';

  @override
  String get about => 'حول التطبيق';

  @override
  String get aboutText => 'اكتشف المهن من خلال محاكاة عملية.';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get exploreCareersTitle => 'استكشاف المهن';

  @override
  String get exploreSearchHint => 'ابحث عن مهن أو أدوات أو مختبرات...';

  @override
  String get all => 'الكل';

  @override
  String get categoryInfrastructure => 'البنية التحتية';

  @override
  String get categoryDevelopment => 'التطوير';

  @override
  String get categorySecurity => 'الأمن';

  @override
  String get noCareerFound => 'لم يتم العثور على مهنة';

  @override
  String get noCareerFoundMessage =>
      'جرّب كلمة أخرى، مثل \"AWS\" أو \"Docker\".';

  @override
  String labsProgress(int done, int total) {
    return '$done/$total مختبرات';
  }

  @override
  String get toDo => 'للإنجاز';

  @override
  String get completed => 'مكتملة';

  @override
  String labsCount(int count) {
    return '$count مختبرات';
  }

  @override
  String completedCount(int done, int total) {
    return '$done/$total مكتملة';
  }

  @override
  String get noLabHere => 'لا توجد مختبرات هنا';

  @override
  String get noLabHereMessage =>
      'غيّر عوامل التصفية لرؤية المزيد من المختبرات.';

  @override
  String get start => 'ابدأ';

  @override
  String minutesShort(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String labsCompletedOf(int done, int total) {
    return '$done/$total مختبرات مكتملة';
  }

  @override
  String get match => 'توافق';

  @override
  String get salaryFrance => 'الراتب (فرنسا)';

  @override
  String get education => 'التعليم';

  @override
  String get aboutTheJob => 'عن المهنة';

  @override
  String get typicalDay => 'يوم نموذجي';

  @override
  String get toolsYouWillUse => 'الأدوات التي ستستخدمها';

  @override
  String get replayFirstLab => 'إعادة المختبر الأول';

  @override
  String startLabNamed(String title) {
    return 'ابدأ المختبر: $title';
  }

  @override
  String continueLabNamed(String title) {
    return 'متابعة: $title';
  }

  @override
  String tasksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مهام',
      two: 'مهمتان',
      one: 'مهمة واحدة',
    );
    return '$_temp0';
  }

  @override
  String attemptsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count محاولات',
      two: 'محاولتان',
      one: 'محاولة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get leaveLabTitle => 'مغادرة المختبر؟';

  @override
  String get leaveLabMessage => 'سيضيع تقدّمك في هذا المختبر.';

  @override
  String get stay => 'البقاء';

  @override
  String get leave => 'مغادرة';

  @override
  String questionOf(int index, int total) {
    return 'السؤال $index من $total';
  }

  @override
  String correctCount(int count) {
    return '$count صحيحة';
  }

  @override
  String selectAnswers(int count) {
    return 'اختر $count إجابات';
  }

  @override
  String get checkAnswer => 'تحقّق من الإجابة';

  @override
  String get finishLab => 'إنهاء المختبر';

  @override
  String get nextQuestion => 'السؤال التالي';

  @override
  String get scenario => 'السيناريو';

  @override
  String get correct => 'صحيح!';

  @override
  String get notQuite => 'ليس تمامًا';

  @override
  String get resultNotFound => 'النتيجة غير موجودة';

  @override
  String get resultNotFoundMessage => 'هذه النتيجة لم تعد متاحة.';

  @override
  String get labResults => 'نتائج المختبر';

  @override
  String get labCompleted => 'اكتمل المختبر!';

  @override
  String get keepPracticing => 'واصل التدريب!';

  @override
  String get overall => 'إجمالي';

  @override
  String get correctAnswers => 'الإجابات الصحيحة';

  @override
  String timeTarget(String time) {
    return 'الوقت (الهدف $time)';
  }

  @override
  String get accuracyWeight => 'الدقة (80٪)';

  @override
  String get speedWeight => 'السرعة (20٪)';

  @override
  String newPersonalBest(int gain, int previous) {
    return 'رقم قياسي جديد! +$gain نقطة مقارنة بـ $previous٪.';
  }

  @override
  String stillBest(int best) {
    return 'أفضل نتيجة لك في هذا المختبر لا تزال $best٪.';
  }

  @override
  String get skillsBreakdown => 'تفاصيل المهارات';

  @override
  String matchNow(String career, int score, int done, int total) {
    return 'توافقك مع $career أصبح $score٪. $done/$total مختبرات مكتملة في هذه المهنة.';
  }

  @override
  String nextLabNamed(String title) {
    return 'المختبر التالي: $title';
  }

  @override
  String tryCareerLab(String career, String lab) {
    return 'جرّب $career: $lab';
  }

  @override
  String get viewRecommendations => 'عرض التوصيات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get matches => 'المهن';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get bestMatch => 'أفضل توافق';

  @override
  String get matchesInterestsOnly =>
      'تعتمد هذه النتائج على اهتماماتك فقط. أكمل المختبرات للحصول على توصيات مبنية على أدائك الحقيقي.';

  @override
  String matchesAnalysis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تحليل $count مهن مُختبرة',
      two: 'تحليل مهنتين مُختبرتين',
      one: 'تحليل مهنة واحدة مُختبرة',
    );
    return '$_temp0: التوافق = 75٪ أداء المختبرات + 25٪ الاهتمامات.';
  }

  @override
  String get allMatches => 'جميع المهن';

  @override
  String get recommendationHistory => 'سجل التوصيات';

  @override
  String get noRecommendationYet => 'لا توجد توصيات حاليًا';

  @override
  String get noRecommendationYetMessage =>
      'يتم إنشاء توصية جديدة بعد كل مختبر مكتمل.';

  @override
  String get learningPathTitle => 'مسار التعلّم';

  @override
  String becomeCareer(String career) {
    return 'كن $career';
  }

  @override
  String pathSteps(int done, int total, int minutes) {
    return '$done من $total خطوات · ~$minutes دقيقة إجمالًا';
  }

  @override
  String get later => 'لاحقًا';

  @override
  String get startThePath => 'ابدأ المسار';

  @override
  String pathCompleted(String career, int average) {
    return 'اكتمل المسار! متوسطك في $career هو $average٪. أعد المختبرات لتحسينه.';
  }

  @override
  String get myProgressTitle => 'تقدّمي';

  @override
  String get labsDone => 'المختبرات المنجزة';

  @override
  String get avgScore => 'متوسط النتيجة';

  @override
  String get minutes => 'الدقائق';

  @override
  String get careerProgress => 'التقدّم حسب المهنة';

  @override
  String get skills => 'المهارات';

  @override
  String get noSkillsYet => 'أكمل مختبرًا لقياس مهاراتك.';

  @override
  String get history => 'السجل';

  @override
  String get noAttemptsYet => 'لا توجد محاولات بعد';

  @override
  String get noAttemptsYetMessage => 'ستظهر مختبراتك المكتملة هنا.';

  @override
  String get markAllRead => 'تعليم الكل كمقروء';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get noNotifications => 'لا توجد إشعارات';

  @override
  String get noNotificationsMessage =>
      'سيتم إشعارك عندما تصبح نتائجك وتوصياتك جاهزة.';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get profileCompleteness => 'اكتمال الملف الشخصي';

  @override
  String get completeProfileHint => 'الملف الشخصي الكامل يحسّن توصياتك.';

  @override
  String get topMatch => 'أفضل مهنة';

  @override
  String get aboutMe => 'نبذة عني';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get studyLevel => 'المستوى الدراسي';

  @override
  String get university => 'الجامعة';

  @override
  String get specialty => 'التخصص';

  @override
  String get bio => 'نبذة';

  @override
  String get interests => 'الاهتمامات';

  @override
  String get noInterestsYet => 'لا توجد اهتمامات بعد. أضف بعضها لتخصيص نتائجك.';

  @override
  String get topSkills => 'أفضل المهارات';

  @override
  String get noTopSkills => 'أكمل المختبرات لاكتشاف نقاط قوتك.';

  @override
  String memberSince(String date) {
    return 'عضو منذ $date';
  }

  @override
  String get notSet => 'غير محدد';

  @override
  String get editProfileTitle => 'تعديل الملف الشخصي';

  @override
  String photoLoadError(String error) {
    return 'تعذّر تحميل الصورة: $error';
  }

  @override
  String get chooseFromGallery => 'اختيار من المعرض';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get removePhoto => 'حذف الصورة';

  @override
  String get profileUpdated => 'تم تحديث الملف الشخصي';

  @override
  String get universitySchool => 'الجامعة / المدرسة';

  @override
  String get specialtyHint => 'مثال: هندسة البرمجيات';

  @override
  String get bioHint => 'حدّثنا عن أهدافك';

  @override
  String get interestsHint =>
      'يستخدمها الذكاء الاصطناعي لحساب المهن المناسبة لك.';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get theme => 'المظهر';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get language => 'اللغة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get resetProgress => 'إعادة تعيين تقدّمي';

  @override
  String get resetProgressSubtitle => 'حذف جميع نتائج المختبرات والسجل';

  @override
  String get resetProgressTitle => 'إعادة تعيين التقدّم؟';

  @override
  String get resetProgressMessage => 'سيتم حذف جميع نتائج مختبراتك وتوصياتك.';

  @override
  String get progressReset => 'تمت إعادة تعيين التقدّم';

  @override
  String get googleSignInUnavailable =>
      'تسجيل الدخول عبر Google غير متاح حاليًا. استخدم بريدك الإلكتروني.';

  @override
  String get errorInvalidCredentials =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get errorWeakPassword => 'كلمة المرور هذه ضعيفة جدًا.';

  @override
  String get errorNetwork =>
      'لا يوجد اتصال بالإنترنت. تحقق من الشبكة وحاول مرة أخرى.';

  @override
  String get errorTooManyRequests =>
      'محاولات كثيرة جدًا. يرجى المحاولة لاحقًا.';

  @override
  String get errorProviderDisabled =>
      'طريقة تسجيل الدخول هذه غير مفعّلة في التطبيق.';

  @override
  String get errorUnknown => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get passwordResetEnterEmail =>
      'أدخل بريدك الإلكتروني أعلاه، ثم اضغط مرة أخرى على «نسيت كلمة المرور؟».';

  @override
  String passwordResetSent(String email) {
    return 'تم إرسال رابط إعادة تعيين كلمة المرور إلى $email.';
  }

  @override
  String get pushNotifications => 'الإشعارات الفورية';

  @override
  String get pushNotificationsSubtitle =>
      'تنبيهات عندما تكون نتائجك وتوصياتك جاهزة';

  @override
  String get premium => 'بريميوم';

  @override
  String get premiumTitle => 'CareerVerse بريميوم';

  @override
  String get premiumSubtitle =>
      'افتح جميع المختبرات المتقدمة وتعمّق أكثر في توجيهك المهني.';

  @override
  String get premiumBenefitLabs =>
      'جميع المختبرات المتقدمة (سيناريوهات الخبراء)';

  @override
  String get premiumBenefitSkills => 'أسئلة أصعب لتحليل أدق لمهاراتك';

  @override
  String get premiumBenefitSync => 'الوصول من جميع أجهزتك بحسابك';

  @override
  String premiumPrice(String price, int days) {
    return '$price / $days يومًا';
  }

  @override
  String premiumBuy(String price) {
    return 'اشترك مقابل $price';
  }

  @override
  String premiumExtend(String price) {
    return 'مدّد مقابل $price';
  }

  @override
  String premiumActiveUntil(String date) {
    return 'بريميوم مفعّل حتى $date';
  }

  @override
  String premiumExpired(String date) {
    return 'انتهى بريميوم في $date';
  }

  @override
  String get premiumFree => 'الخطة المجانية';

  @override
  String get premiumTestMode =>
      'Stripe في وضع الاختبار: لا يتم خصم أي أموال حقيقية.';

  @override
  String get premiumTestCard =>
      'بطاقة الاختبار: 4242 4242 4242 4242، أي تاريخ مستقبلي، أي رمز CVC.';

  @override
  String premiumSuccess(String date) {
    return 'تم تأكيد الدفع! بريميوم مفعّل حتى $date.';
  }

  @override
  String get paymentCancelled => 'تم إلغاء الدفع.';

  @override
  String paymentFailed(String message) {
    return 'فشل الدفع: $message';
  }

  @override
  String get paymentNotConfigured =>
      'الدفع غير متاح في هذه النسخة (مفاتيح اختبار Stripe مفقودة أو المنصة غير مدعومة).';

  @override
  String get transactionHistory => 'سجل المعاملات';

  @override
  String get noTransactions => 'لا توجد معاملات حتى الآن.';

  @override
  String get premiumLabTitle => 'مختبر بريميوم';

  @override
  String premiumLabMessage(String title) {
    return '«$title» مختبر متقدم. اشترك في بريميوم لفتحه.';
  }

  @override
  String get unlockPremium => 'افتح مع بريميوم';

  @override
  String get notifPremiumTitle => 'مرحبًا بك في بريميوم!';

  @override
  String notifPremiumBody(String date) {
    return 'المختبرات المتقدمة مفتوحة حتى $date.';
  }

  @override
  String get courseLabel => 'الدرس';

  @override
  String get labLabel => 'المختبر';

  @override
  String lessonProgress(int current, int total) {
    return 'الدرس $current/$total';
  }

  @override
  String get keyPoints => 'النقاط الأساسية';

  @override
  String get exampleLabel => 'مثال';

  @override
  String get takeaways => 'ما يجب تذكره';

  @override
  String get summaryLabel => 'الملخص';

  @override
  String get previous => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get finishCourse => 'إنهاء';

  @override
  String get finishAndStartLab => 'إنهاء وبدء المختبر';

  @override
  String readCourseNamed(String title) {
    return 'اقرأ الدرس: $title';
  }

  @override
  String get courseCompleted => 'اكتمل الدرس';

  @override
  String get reviewCourse => 'مراجعة الدرس';

  @override
  String get readCourse => 'اقرأ الدرس';

  @override
  String get courseRead => 'تمت قراءة الدرس';

  @override
  String get courseThenLab =>
      'كل خطوة: درس مع شروحات، ثم مختبر تطبيقي للتدرّب.';

  @override
  String coursesDone(int done, int total) {
    return '$done/$total دروس مقروءة';
  }
}
