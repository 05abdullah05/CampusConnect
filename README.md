Campus Connect 
Det är en mobilapp som hjälper studenter på Campus Valla att snabbt hitta studieplatser, kafeer och andra relevanta samlingspunkter i närheten. Appen gör det enklare att upptäcka nya platser, hitta vänner och planera studietid mer effektivt.
Appens huvudsakliga funktion är att visa en karta över campusområdet och markerar ut olika studieplatser och kaféer. Användare kan logga in med sitt Google-konto och se vilka platser som finns i närheten.

Krav jag demonstrerade för på 17/12/2025:

Tekniska krav att välja från:
    Alla sidor (widgets) är självtillräckliga, dvs. det finns inga sidvisa länkar i widget trädet, från en gren till en annan. Varje widget hanterar (lagrar och uppdaterar) sitt eget innehåll och sitt eget tillstånd, istället för att detta hanteras i appens globala tillstånd (app state) -- så långt detta är möjligt. (1 p)
    
    Använder forms och validerar användarinput, så att input är av rätt typ, och är korrekt. T.ex. att lösenord är tillräcklig starka. (2 p)
    
    Enkel inloggning av användare mot Firebase (1 p)
    
    Visar realtidsuppdatering av skärminnehåll från Firestore eller motsvarande backend, så att t.ex. en användare kan se i realtid vad en annan användare har skrivit eller gjort. (1 p)
    Total: 5 technical points 

Entreprenöriella krav att välja från
    Firestore. Använder Cloud Firestore eller Realtime Database som databas. Båda lösningarna är Googles lagringstjänst för mobile- och webb-appar som erbjuder bl.a. databas och autentisering. Dessutom finns en mer generell databas-lösning som heter Firebase Cloud Storage. Cloud Storage accepterar både ljud, bild, och text så i princip alla appar kan utnyttja Cloud Storage på ett eller annat sätt. (2p)

    Sökfunktion i appen, dvs. att användaren kan skriva in ett sökord och få upp relevant information. Oftast krävs att sökningen genomförs på backend-sidan, för att säkerställa att all relevant information kan visas, inte bara det som råkade finnas på skrämen.(2p)
    Total: 4 entrepreneurial points 

## How to get this app running

This project is a Flutter app, so you need the Flutter SDK and the Dart SDK installed on your machine before you can run it.

### Required tools

- Flutter SDK
- Dart SDK (comes with Flutter)
- Android Studio or VS Code with Flutter/Dart extensions
- Android emulator or a physical Android device
- Optional: Xcode for iOS development on macOS
- Git

### Install and verify the tools

1. Install Flutter from the official Flutter website.
2. Add Flutter to your PATH.
3. Verify the installation in a terminal:

```bash
flutter --version
dart --version
```

4. Check if the environment is correctly configured:

```bash
flutter doctor
```

If Flutter Doctor shows missing Android or SDK dependencies, install the required tools and restart the terminal.

### Packages used in this project

This project already declares the following dependencies in the Flutter app configuration:

```yaml
dependencies:
  flutter:
    sdk: flutter
  english_words: ^4.0.0
  provider: ^6.1.5
  firebase_core: ^4.1.1
  cloud_firestore: ^6.0.2

 dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

To install them, run:

```bash
cd /home/abdqa105/LIU/TDP028/flutter_application
flutter pub get
```

This will download all required Flutter and Dart packages for the app.

### Firebase setup

This app uses Firebase, so make sure the following are set up:

- Firebase project created in the Firebase console
- Firebase SDK configured in the app
- `google-services.json` added for Android if required
- Firebase initialization completed in the app code

### Running the project

Open your terminal and go to the app folder:

```bash
cd /home/abdqa105/LIU/TDP028/flutter_application
```

Then start the app with:

```bash
flutter run
```

This command builds the Flutter app and launches it on the connected emulator or device.

### Useful checks before testing

```bash
flutter clean
flutter pub get
flutter doctor
flutter run
```

If the app does not start, check that:

- an emulator is running or a device is connected
- Android licenses are accepted
- Flutter has all required dependencies installed
- the Firebase configuration is correct

### Summary

In short, the main steps are:

1. Install Flutter and Dart
2. Run `flutter doctor`
3. Run `flutter pub get`
4. Start an emulator or connect a device
5. Run `flutter run`

That is the standard way to get this project running and test it locally.




