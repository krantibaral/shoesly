# Shoesly App

## Project Overview

Shoesly is a mobile application built using Flutter that allows users to browse, filter, and purchase shoes from various brands. The app integrates with Firebase for data storage and analytics.

## Platform & Tech Stack

- **Mobile:** Flutter (for both Android and iOS)
- **Backend:** Firebase (for data storage), 

## Project Setup Instruction

### Prerequisites
- **Flutter SDK:** Make sure you have the Flutter SDK installed. Follow the [official installation guide](https://flutter.dev/docs/get-started/install) if you haven't installed it yet.
- **Firebase Account:** Ensure you have a Firebase account and have set up a new project named "Shoesly" in the [Firebase console](https://console.firebase.google.com/).


### Installation Steps
1. **Clone the Repository:**
   ```sh
   git clone https://github.com/krantibaral/shoesly.git
   cd shoesly

2. **Install Dependencies:**
   flutter pub get

3. **Install Dependencies:**

- **For Android:**
Download the google-services.json file from your Firebase project settings.
Place the google-services.json file in the android/app directory.


- **For iOS:**
Download the GoogleService-Info.plist file from your Firebase project settings.
Open your Flutter project in Xcode, right-click on the Runner directory, and select Add Files to "Runner".
Add the GoogleService-Info.plist file.

4. **Configure Firebase in Flutter:**
   Ensure that the `firebase_core` package is correctly configured in your `pubspec.yaml` file.
   Initialize Firebase in your `main.dart` file:

   ```dart
   import 'package:firebase_core/firebase_core.dart';

   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }

5. **Run the Project:**
   Use the following command to run your project on an emulator or a connected device:

   ```sh
   flutter run

### Assumptions Made During Development
Users have a basic understanding of Flutter and Firebase.
The database is pre-populated with initial shoe data.
The Firebase project named "Shoesly" is correctly configured with Firestore and Firebase Analytics.
Users will follow the standard procedure to set up Firebase.
The app will handle basic e-commerce functionalities without real payment integration.

### Challenges Faced and How You Overcame Them

### Challenge: Handling Asynchronous Operations
- **Problem:** Managing multiple asynchronous operations for fetching data.
- **Solution:** Implemented `async/await` and used `FutureBuilder` and `StreamBuilder` in Flutter to manage asynchronous data fetching and UI updates.

### Challenge: Computing Average Review Scores
- **Problem:** Calculating average review scores efficiently.
- **Solution:** Initially planned to utilize Firebase Cloud Functions to compute and store average review scores whenever a new review is added. However, due to limitations imposed by the project's billing plan, this functionality couldn't be implemented. As an alternative, implemented a client-side solution to calculate the average review scores locally within the app whenever new reviews are fetched from the database.

### Challenge: Dealing with Map Data and Lists
- **Problem:** Handling complex data structures like maps and lists retrieved from Firestore.
- **Solution:** Implemented efficient data parsing techniques in Dart and utilized Flutter widgets such as `ListView.builder`, `GridView.builder` to display lists of data and `ListView`, `GridView` to display grids of data. Used methods like `map` and `forEach` to iterate over and manipulate map data retrieved from Firestore.

### Challenge: Ensuring Responsive UI/UX
- **Problem:**  Creating a responsive UI that adapts to different screen sizes.
- **Solution:** Utilized Flutter’s flexible layout widgets and closely followed the provided Figma design to ensure a consistent and responsive user experience.


## Additional Features or Improvements Added
- **Enhanced UI/UX:** Added responsive design elements for a smoother user experience.
- **Error Handling:** Implemented comprehensive error handling mechanisms to improve app stability. Errors are displayed to users in a user-friendly manner, providing guidance on how to resolve them.
- **Splash Screen:** Added a custom splash screen to enhance the app's branding and provide a better user experience during app startup.
























