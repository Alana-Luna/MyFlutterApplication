# Criando projeto no firebase
	tela principal do firebase -> criar projeto

# Adicionando android na aplicação
	clicar no ícone android para adicionar um app android
	app -> android -> src -> main -> AndroidManifest.xml -> copiar package -> registrar app
	faz download do json e copia dentro da pasta android -> app do projeto
	volte pro console -> próximo -> para adicionar o SDK do firebase (abaixo)

		build.gradle no nível do projeto

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

		build.gradle no nível do app

			apply plugin: 'com.android.application'
			apply plugin: 'com.google.gms.google-services' // Add this line

			dependencies {
			  // add SDKs for desired Firebase products
			  // https://firebase.google.com/docs/android/setup#available-libraries
			}


# Conectando IOS na aplicação

	console -> adicionar app -> IOS
	app -> android -> src -> main -> AndroidManifest.xml -> copiar package -> registrar app
	faz download do GoogleService-info.plist e copia dentro da pasta ios -> runner
	volte pro console -> próximo -> próximo

	adicionar no pubspec.yaml
	dependencies:
	  cloud_firestore:


Erros comuns

# build.gradle GradleException not found

 1. File > Project Structure (Command + ;) > Under Project Settings/Project > Set Project SDK to Android API 29 Platform
 2. There should be a notification stating there is an invalid item in the dependencies list under Project Structure/Problems. If there is, go to Project Structure > Under Project Settings/Modules > select app_name_android > Dependencies tab > choose the latest "Android API 29 Platform" in the Module SDK box.
 3. Update GradleException() to FileNotFoundException() under android/app/build_gradle since it's not supported in the Java version of Android API 29

# flutter the number of method references in a .dex file cannot exceed 64k

 1.module/build.gradle
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