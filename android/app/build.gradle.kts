import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Play Market kaliti: android/key.properties (git'da YO'Q). Bo'lmasa — sinov kaliti.
val releaseKeystore = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) file.inputStream().use { load(it) }
}

android {
    namespace = "uz.eslat"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "uz.eslat"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        // Sinov kaliti git'da: hamma kompyuterda SHA-1 bir xil, shuning uchun
        // Firebase'dagi Gmail kirish sozlamasi buzilmaydi.
        // SHA-1: 3B:DF:34:9F:3D:2F:DC:17:C9:9C:35:92:A2:C6:B1:9B:0A:1A:6F:3A
        // DIQQAT: Play Market'ga bu kalit bilan EMAS, key.properties bilan.
        create("eslatTest") {
            storeFile = file("eslat-test.keystore")
            storePassword = "eslat-test"
            keyAlias = "eslat"
            keyPassword = "eslat-test"
        }
        if (!releaseKeystore.isEmpty) {
            create("release") {
                storeFile = file(releaseKeystore.getProperty("storeFile"))
                storePassword = releaseKeystore.getProperty("storePassword")
                keyAlias = releaseKeystore.getProperty("keyAlias")
                keyPassword = releaseKeystore.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("eslatTest")
        }
        release {
            signingConfig = signingConfigs.findByName("release")
                ?: signingConfigs.getByName("eslatTest")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
