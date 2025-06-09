buildscript {

  repositories {
    google() // Google's Maven repository for Android dependencies
    mavenCentral() // Central repository for Java and Kotlin libraries
    gradlePluginPortal() // For resolving Gradle plugin
   //    maven { url = uri("https://jitpack.io")   }     <<<<<<<<<<
}

dependencies {
      classpath("com.android.tools.build:gradle:8.9.1")

      //  classpath("com.android.tools.build:gradle:7.3.1")


      classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20")

   //   classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20")

  }
}


plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
//    id("org.jetbrains.kotlin.jvm")     // version "1.9.20" // 
 //     id:("org.gradle.kotlin.kotlin-dsl")       // , version: "2.1.7"
}


android {


namespace = "com.example.flutter_application_1"
  compileSdk = 35


  //  compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.2.12479018" 



    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17" 
        languageVersion = "1.9" 

    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_application_1"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        
          minSdk =  21
      //  minSdk = flutter.minSdkVersion

          targetSdk = 34
      //  targetSdk = flutter.targetSdkVersion


        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
  buildToolsVersion = "35"
}

flutter {
    source = "../.."
}


dependencies {
  testImplementation("junit:junit:4.12")
  androidTestImplementation("androidx.test:runner:1.1.1")
  androidTestImplementation("androidx.test.espresso:espresso-core:3.1.1")
  implementation("com.google.firebase:firebase-core:16.0.1")
  implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.20")
}



