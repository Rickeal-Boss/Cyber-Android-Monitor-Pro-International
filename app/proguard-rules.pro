# ============================================================
#  ProGuard / R8  — Device Info Viewer
#  minifyEnabled true + shrinkResources true 
# ============================================================

# ===== Kotlin  =====
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}
-keepclassmembernames class kotlinx.coroutines.** {
    volatile <fields>;
}

# ===== Kotlin  =====
-keep class kotlin.** { *; }
-keep class kotlin.reflect.** { *; }
-keepclassmembers class kotlin.reflect.** { *; }
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# ===== Compose  =====
-keep class androidx.compose.** { *; }
-dontwarn androidx.compose.**

# ===== Koin DI  =====
-keep class org.koin.** { *; }
-keep class * extends org.koin.core.module.Module { *; }
-keepclassmembers class * {
    @org.koin.core.annotation.* <fields>;
    @org.koin.core.annotation.* <methods>;
}

# ===== R8  ViewModel  =====
-keepclassmembers class * extends androidx.lifecycle.ViewModel {
    <init>(...);
}

# ===== Gson =====
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn com.google.gson.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# =====  =====
-keep class com.example.deviceinfoviewer.data.model.** { *; }
-keep class com.example.deviceinfoviewer.AppSettings { *; }
-keep class com.example.deviceinfoviewer.FormatUtils { *; }

# =====  BuildConfig =====
-keep class com.example.deviceinfoviewer.BuildConfig { *; }

# =====  Crash  =====
-keep class com.example.deviceinfoviewer.DeviceApplication { *; }

# =====  ViewModel ) =====
-keep class com.example.deviceinfoviewer.ui.**ViewModel { *; }

# =====  Repository 和 DataSource  =====
-keep class com.example.deviceinfoviewer.data.repository.** { *; }
-keep class com.example.deviceinfoviewer.data.source.** { *; }

# ===== 保留 Service 类 =====
-keep class com.example.deviceinfoviewer.service.** { *; }

# ===== 保留 UI 组件 (Compose 可能通过反射访问) =====
-keep class com.example.deviceinfoviewer.ui.components.** { *; }
-keep class com.example.deviceinfoviewer.ui.theme.** { *; }

# ===== 保留 util 工具类 =====
-keep class com.example.deviceinfoviewer.util.** { *; }

# ===== 保留整个项目包  =====
# 项目大量使用反射 (SystemProperties/BatteryManager hidden field/GnssStatus/
# VMRuntime/MobileNetwork getter 等) + Compose Composable lambda 元数据,
# 整体 keep 项目包避免 shrink 误删。R8 仍可缩减第三方库 (kotlinx.coroutines/gson/koin) 死代码。
-keep class com.example.deviceinfoviewer.** { *; }
-keepclassmembers class com.example.deviceinfoviewer.** { *; }

# ===== 不混淆枚举 =====
-keepclassmembers enum * { public static **[] values(); public static ** valueOf(java.lang.String); }

# ===== 保留 R 类内部类 (防止 shrinkResources 误删) =====
-keepclassmembers class **.R$* { public static <fields>; }

# ===== WebView (如有使用) =====
-keepclassmembers class * extends android.webkit.WebView {
   public <init>(android.content.Context);
   public <init>(android.content.Context, android.util.AttributeSet);
   public <init>(android.content.Context, android.util.AttributeSet, int);
}

# ===== 启用代码缩减 (shrink) 移除第三方库死代码，但禁用混淆 (obfuscate) 保护反射 =====
# -dontshrink 已移除 → 允许 R8 移除未引用代码
-dontobfuscate
# 保留泛型签名 (Gson 反序列化需要)
-keepattributes Signature, *Annotation*, InnerClasses, EnclosingMethod
