import 'package:intl/intl.dart';

class DateHelper {
  /// تحويل DateTime إلى صيغة نصية (مثال: "٢٠ أكتوبر ٢٠٢٣")
  static String formatToArabicDate(DateTime date) {
    final format = DateFormat('d MMMM y', 'ar');
    return format.format(date);
  }

  /// تحويل التاريخ إلى صيغة ISO 8601 (مثال: "2023-10-20")
  static String toIsoDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// التحقق إذا كان التاريخ هو اليوم
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// حساب الفرق بين تاريخين بالأيام
  static int daysBetween(DateTime from, DateTime to) {
    return (to.difference(from).inDays).abs();
  }

  /// تحويل التاريخ إلى وقت (مثال: "١٠:٣٠ ص")
  static String formatToArabicTime(DateTime date) {
    final format = DateFormat('h:mm a', 'ar');
    return format.format(date);
  }

  /// إنشاء تاريخ من سلسلة نصية
  static DateTime? parseFromString(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// الحصول على اسم اليوم بالعربية (مثال: "السبت")
  static String getArabicDayName(DateTime date) {
    final format = DateFormat('EEEE', 'ar');
    return format.format(date);
  }

  /// التحقق إذا كان التاريخ في المستقبل
  static bool isFutureDate(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// إضافة أيام إلى تاريخ
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// تنسيق التاريخ لعرضه في UI (مثال: "٢٠/١٠/٢٠٢٣")
  static String formatForDisplay(DateTime date) {
    final format = DateFormat('dd/MM/yyyy', 'ar');
    return format.format(date);
  }
}