# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep the MainActivity and other entry points
-keep public class * extends io.flutter.embedding.android.FlutterActivity
-keep public class * extends io.flutter.embedding.android.FlutterFragmentActivity
-keep public class * extends io.flutter.app.FlutterApplication
-keep public class * extends android.app.Service

# Google Mobile Ads (AdMob)
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }
-dontwarn com.google.android.gms.ads.**
-dontwarn com.google.ads.**

# Firebase rules
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Flutter Local Notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Play Core rules
-dontwarn com.google.android.play.core.**

# Support libraries
-keep class androidx.lifecycle.** { *; }
-keep class androidx.annotation.** { *; }

# Prevent R8 from stripping vital Flutter communication code
-keepattributes Signature,Exceptions,*Annotation*,InnerClasses,EnclosingMethod
-keep class io.flutter.plugin.common.** { *; }

# Networking and JSON
-keep class com.google.gson.** { *; }
-keep class com.fasterxml.jackson.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Webview
-keep class android.webkit.** { *; }

# Recommended for production build
-optimizationpasses 5
-allowaccessmodification
