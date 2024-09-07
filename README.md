# GoodPlace
The Habit Tracker project is a comprehensive Flutter application designed to help users in effectively tracking their habits and staying motivated. 
## Quick Navigation
- [GoodPlace](#goodplace)
- [Features](#features)
- [Plugins](#plugins)
- [Usage](#usage)

## Features
Authentication is managed through **Firebase Authentication**, with both email and Google Sign-In options integrated, and user login status is overseen by an **Auth Manager**. Upon their first use, users are introduced to the application through **onboarding** and **tutorial** screens.

**CRUD (Create, Read, Update, Delete)** operations for habits are implemented using **Firestore**. Habit management is dynamically handled across all pages with the **Provider** package. A congratulatory **animation** has been added to celebrate when users complete their habits.

**Main Calendar**: At the top of the home page, you can use the calendar feature to get a visual summary of your daily habits. Clicking on any date displays all habits completed on that day in a pop-up view. This calendar helps you quickly review and track your past achievements and progress.

**Habit Detail Calendar**: On each habit's detail page, there is a specialized calendar showing only the days on which that specific habit was completed. This allows you to monitor the progress of individual habits more closely and see your consistency over time.

The app integrates the Dio package to fetch random motivational quotes from an **[API](https://github.com/lukePeavey/quotable)**, keeping users inspired.

GoodPlace features an **AI-based** tool. **GoodPlaceT**, that provides real-time, personalized habit motivation and support through **streaming**. AI-generated responses are displayed live, offering motivational quotes based on the user's habit progress, such as whether they've completed their habit for the day. During habit creation, GoodPlaceT can also generate a meaningful purpose using the user’s input, like the habit's **image or title**. 

Additionally, with **GoodPlaceT**, you can engage in conversations about your habits. The AI assistant offers personalized guidance and suggestions based on your **chat history**, helping you improve your habit-building process. Whether you're looking for advice, feedback, or motivation, GoodPlaceT is there to support you. It answers questions related to your habit goals, provides relevant tips, and ensures you stay on track with consistent progress.

**Firebase Notifications** are utilized to send motivational reminders to users, ensuring they remain engaged and stay on track with their habits.


<details>
    <summary><h2>Plugins</h2></summary>

The Flutter plugins used in this project are as follows:

### Core Packages
- **[cupertino_icons](https://pub.dev/packages/cupertino_icons)**
- **[google_fonts](https://pub.dev/packages/google_fonts)**

### UI Components
- **[gap](https://pub.dev/packages/gap)**
- **[carousel_slider](https://pub.dev/packages/carousel_slider)**
- **[toastification](https://pub.dev/packages/toastification)**
- **[skeletonizer](https://pub.dev/packages/skeletonizer)**
- **[table_calendar](https://pub.dev/packages/table_calendar)**
- **[flutter_slidable](https://pub.dev/packages/flutter_slidable)**

### State Management & Utilities
- **[provider](https://pub.dev/packages/provider)**
- **[intl](https://pub.dev/packages/intl)**
- **[dio](https://pub.dev/packages/dio)**
- **[email_validator](https://pub.dev/packages/email_validator)**

### Firebase Integration
- **[cloud_firestore](https://pub.dev/packages/cloud_firestore)**
- **[firebase_core](https://pub.dev/packages/firebase_core)**.
- **[firebase_auth](https://pub.dev/packages/firebase_auth)**
- **[google_sign_in](https://pub.dev/packages/google_sign_in)**
- **[firebase_messaging](https://pub.dev/packages/firebase_messaging)**

### Animations & Visuals
- **[lottie](https://pub.dev/packages/lottie)**
- **[flutter_animate](https://pub.dev/packages/flutter_animate)**
- **[animated_text_kit](https://pub.dev/packages/animated_text_kit)**

### Debugging
- **[logger](https://pub.dev/packages/logger)**

### Chat & AI Integration
- **[http](https://pub.dev/packages/http)**
- **[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)**
- **[showcaseview](https://pub.dev/packages/showcaseview)**
- **[flutter_chat_bubble](https://pub.dev/packages/flutter_chat_bubble)**

### Other Utilities
- **[flutter_markdown](https://pub.dev/packages/flutter_markdown)**
- **[grock](https://pub.dev/packages/grock)**

</details>

## Usage

In order to run this project, you have to follow the steps below:

1. Clone the project:

   ```bash
   git clone https://github.com/havva-nur-ezginci/GoodPlace.git
   ```

2. Complete Firebase project setup for both **Android** & **iOS** platforms by going to the [Firebase console](https://console.firebase.google.com/).

3. For Android, replace your google-services.json file with an existing file. 

   ```bash
   android -> app -> google-services.json
   ```
4. For running on **iOS**, you have to do some configurations from Xcode. Follow the official [iOS setup guide](https://docs.flutter.dev/get-started/install/macos#deploy-to-ios-devices).

- [Firebase iOS setup guide](https://firebase.google.com/docs/ios/setup)
- [Google Sign-In setup guide for iOS](https://developers.google.com/identity/sign-in/ios/start)

5. Get Flutter packages:

   ```bash
   flutter pub get
   ```

6. Run the app:

   ```bash
   flutter run
   ```

## Acknowledgements

Thanks for taking the time to read through this README! 🦸‍♂️🦸‍♀️ 

Feel free to dive into the code, break things, fix things, and have fun. If you encounter any bugs or just want to share your thoughts, don’t hesitate to reach out.☕💻

Happy coding and good luck with your habit tracking adventures!
