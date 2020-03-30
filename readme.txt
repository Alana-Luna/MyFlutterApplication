# Creating project in Firebase
	Firebase main screen -> create project

# Connecting Android in the application

	Click on the android icon to add an android app
	app -> android -> src -> main -> AndroidManifest.xml -> copy package -> register app
	Download json and copy inside the android folder -> project /android/app
	Go back to the console -> next -> to add the firebase SDK (below)

		build.gradle on project level

			buildscript {
			  repositories {
			    // Check that you have the following line (if not, add it):
			    google()  // Google's Maven repository
			  }
			  dependencies {
			    ...
			    // Add this line
			    classpath 'com.google.gms:google-services:4.3.3'
			  }
			}

			allprojects {
			  ...
			  repositories {
			    // Check that you have the following line (if not, add it):
			    google()  // Google's Maven repository
			    ...
			  }
			}

		build.gradle on app level

			apply plugin: 'com.android.application'
			apply plugin: 'com.google.gms.google-services' // Add this line

			dependencies {
			  // add SDKs for desired Firebase products
			  // https://firebase.google.com/docs/android/setup#available-libraries
			}


# Connecting IOS in the application

	console -> add app -> IOS
	app -> android -> src -> main -> AndroidManifest.xml -> copy package -> register app
	download GoogleService-info.plist and copy it into the ios -> runner folder
	go back to the console -> next -> next

	add on pubspec.yaml
	dependencies:
	  firebase_auth:
  	  google_sign_in:
      cloud_firestore:

	in your IDE go to ios → Runner → Info.plist. Here, you have to add a code snippet inside <dict>. Just copy & paste it inside the Info.plist file and save it https://pub.dev/packages/google_sign_in#ios-integration

	Here, you will see that there is a TODO written to replace the value within the string tag with REVERSED_CLIENT_ID. You will find the REVERSED_CLIENT_ID in the file GoogleService-Info.plist


# Google sign in setup

- OAuth

	Go here https://console.developers.google.com/apis/credentials/consent

	Make sure you are signed in with the same account with which you have created the Firebase project.

	Also, make sure that on the top-left corner your project is selected for which you are filling this consent

	Go to Credentials → OAuth consent screen tab and start filling the form.

	Enter Application name, Application logo & Support email.

	Then, scroll down and fill the Application Homepage link, Application Privacy Policy link and Application Terms of Services link.

	In all these places, you have to enter the same link starting with http://, then your app domain name which is inside "authorized domain". Click on Save.

	Go back to Firebase console in Authentication Page → Users tab and click on Set up sign-in method.

	In the sign-in providers page, edit Google sign-in.

	Here, you have to enter the project name and support email, and Enable this by clicking the toggle on the top-right corner. Then, click on Save.

- SHA1

	Add your android debugkey SHA-1 fingerprints in your firebase console and updated google-services.json file after adding them
		debug:
			keytool -list -v -keystore %USERPATH%.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 
		release:
			keytool -list -v -keystore {keystore_name} -alias {alias_name}

	In your Project settings, go to the Your apps card.
	Select the Firebase Android app to which you want to add a SHA fingerprint.
	Click Add fingerprint.
	Enter or paste the SHA fingerprint, then click Save.

- Update json
	
	Go to your android app on Firebase, in the general settings tab and download the latest JSON configuration file to copy again inside project /android/app

#Common error messages

# build.gradle GradleException not found

 1. File > Project Structure (Command + ;) > Under Project Settings/Project > Set Project SDK to Android API 29 Platform
 2. There should be a notification stating there is an invalid item in the dependencies list under Project Structure/Problems. If there is, go to Project Structure > Under Project Settings/Modules > select app_name_android > Dependencies tab > choose the latest "Android API 29 Platform" in the Module SDK box.
 3. Update GradleException() to FileNotFoundException() under android/app/build_gradle since it's not supported in the Java version of Android API 29

# flutter the number of method references in a .dex file cannot exceed 64k

 1.build.gradle on app level
 	defaultConfig {
        ...
        // Enabling multidex support.
        multiDexEnabled true
    }
 2.
	dependencies {
	  implementation 'com.android.support:multidex:1.0.3'  //with support libraries
	  //implementation 'androidx.multidex:multidex:2.0.1'  //with androidx libraries
	}

# Tips

If using Android Studio, these commands help: 	
												File -> Invalidate cache and restart
												Tools -> Flutter -> Flutter clean