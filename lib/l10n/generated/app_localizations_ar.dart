// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'نور القرآن';

  @override
  String get navQuran => 'القرآن';

  @override
  String get navPrayer => 'الصلاة';

  @override
  String get navQibla => 'القبلة';

  @override
  String get navMosques => 'المساجد';

  @override
  String get menuTasbih => 'التسبيح';

  @override
  String get menuHijri => 'التقويم الهجري';

  @override
  String get menuPrayerMode => 'وضع الصلاة';

  @override
  String get menuDuaa => 'الأدعية';

  @override
  String get menuSettings => 'الإعدادات';

  @override
  String get quranTitle => 'القرآن الكريم';

  @override
  String get prayerTitle => 'مواقيت الصلاة';

  @override
  String get qiblaTitle => 'اتجاه القبلة';

  @override
  String get mosquesTitle => 'المساجد القريبة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsDailyReminder => 'تذكير يومي';

  @override
  String get settingsDailyReminderSubtitle => 'احصل على إشعار كل يوم';

  @override
  String get settingsReminderTime => 'وقت التذكير';

  @override
  String get settingsAdhan => 'الأذان';

  @override
  String get settingsAdhanSubtitle => 'احصل على إشعار عند كل وقت صلاة';

  @override
  String get settingsAdhkar => 'أذكار الصباح والمساء';

  @override
  String get settingsAdhkarSubtitle => 'تذكير الساعة 6:00 صباحًا و6:00 مساءً';

  @override
  String get tasbihTitle => 'التسبيح';

  @override
  String get tasbihReset => 'إعادة تعيين';

  @override
  String get tasbihTarget => 'الهدف';

  @override
  String get tasbihCount => 'العدد';

  @override
  String get hijriTitle => 'التقويم الهجري';

  @override
  String get hijriToday => 'اليوم';

  @override
  String get hijriUpcoming => 'المناسبات القادمة';

  @override
  String get prayerModeTitle => 'وضع الصلاة';

  @override
  String get prayerModeSubtitle => 'شاشة صامتة أثناء صلاتك';

  @override
  String get prayerModeExit => 'إنهاء الصلاة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get errorGeneric => 'حدث خطأ ما';

  @override
  String get searchSurah => 'ابحث عن سورة (مثال: الفاتحة، الإخلاص)';

  @override
  String get searchNoResults => 'لم يتم العثور على أي سورة';

  @override
  String get tasbihTapToCount => 'المس الدائرة للعد';

  @override
  String tasbihTotal(int count) {
    return 'المجموع الكلي: $count';
  }

  @override
  String get mosqueEmpty => 'لم يتم العثور على مسجد قريب.';

  @override
  String get mosqueNoName => 'مسجد بدون اسم';

  @override
  String get toggleTranslationTooltip => 'إظهار/إخفاء الترجمة';

  @override
  String get qiblaCompassUnavailable =>
      'حساس البوصلة غير متوفر على هذا الجهاز.';

  @override
  String get qiblaAligned => '✅ متجه نحو القبلة';

  @override
  String get qiblaTurnTowards => 'توجه نحو القبلة';

  @override
  String qiblaDistance(String km) {
    return 'المسافة إلى الكعبة: $km كم';
  }

  @override
  String get qiblaInstructions =>
      'أمسك هاتفك بشكل مسطح. يشير الرمز 🕋 نحو الكعبة.';

  @override
  String get hijriEventNewYear => 'رأس السنة الهجرية (محرم)';

  @override
  String get hijriEventAshura => 'عاشوراء';

  @override
  String get hijriEventMawlid => 'المولد النبوي الشريف ﷺ';

  @override
  String get hijriEventRamadanStart => 'بداية رمضان';

  @override
  String get hijriEventLaylatAlQadr => 'ليلة القدر (تقديرًا، الليلة 27)';

  @override
  String get hijriEventEidAlFitr => 'عيد الفطر';

  @override
  String get hijriEventDayOfArafah => 'يوم عرفة';

  @override
  String get hijriEventEidAlAdha => 'عيد الأضحى';
}
