enum AppStatus {
  initial,        // أول ما الشاشة أو الكيوبت يفتح
  loading,        // جاري تحميل بيانات أو API
  success,        // العملية نجحت
  failure,        // العملية فشلت
  empty,          // مفيش داتا (زي Search مفهوش نتائج)
}
