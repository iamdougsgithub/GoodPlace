# GoodPlace
The **Habit Tracker** project is a comprehensive **Flutter** application designed to help users in effectively tracking their habits and staying motivated. 

GoodPlace - Get inspired by yesterday, focus on tomorrow!

## Quick Navigation
- [GoodPlace](#goodplace)
- [Features](#features)
- [App Teaser](#app-teaser)
- [Application Screenshots](#application-screenshots)
- [Plugins](#plugins)
- [Usage](#usage)

## Features
Authentication is managed through **Firebase Authentication**, with both email and Google Sign-In options integrated, and user login status is overseen by an **Auth Manager**. Upon their first use, users are introduced to the application through **onboarding** and **tutorial** screens.

**CRUD (Create, Read, Update, Delete)** operations for habits are implemented using **Firestore**. Habit management is dynamically handled across all pages with the **Provider** package. A congratulatory **animation** has been added to celebrate when users complete their habits.

**Unsplash Image** Selection: Users can enhance their habits by selecting high-quality images from Unsplash when creating or updating them.

**Main Calendar**: At the top of the home page, you can use the calendar feature to get a visual summary of your daily habits. Clicking on any date displays all habits completed on that day in a pop-up view. This calendar helps you quickly review and track your past achievements and progress.

**Habit Detail Calendar**: On each habit's detail page, there is a specialized calendar showing only the days on which that specific habit was completed. This allows you to monitor the progress of individual habits more closely and see your consistency over time.

The app integrates the Dio package to fetch random motivational quotes from an **[API](https://github.com/lukePeavey/quotable)**, keeping users inspired.

GoodPlace features an **AI-based** tool (using **OpenAI**). **GoodPlaceT**, that provides real-time, personalized habit motivation and support through **streaming**. AI-generated responses are displayed live, offering motivational quotes based on the user's habit progress, such as whether they've completed their habit for the day. During habit creation, GoodPlaceT can also generate a meaningful purpose using the user’s input, like the habit's **image or title**. 

Additionally, with **GoodPlaceT**, you can engage in conversations about your habits. The AI assistant offers personalized guidance and suggestions based on your **chat history**, helping you improve your habit-building process. Whether you're looking for advice, feedback, or motivation, GoodPlaceT is there to support you. It answers questions related to your habit goals, provides relevant tips, and ensures you stay on track with consistent progress.

**Firebase Notifications** are utilized to send motivational reminders to users, ensuring they remain engaged and stay on track with their habits.

## App Teaser
[![App Teaser](https://img.youtube.com/vi/x11NhJtpc4I/maxresdefault.jpg)](https://www.youtube.com/watch?v=x11NhJtpc4I)
<details>
  <summary><h2>Application Screenshots</h2></summary> 

  <div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/user-attachments/assets/16489848-82a0-476b-aa18-a76ba01a6fea" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/80b549ba-6f50-422c-8ba9-5d2da9c33d4a" width="200" style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/af3a7f8a-42b3-478e-b249-56bd31680db3" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/dca53611-65cb-4f18-9389-221fdc107703" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/dd1e0ee2-0fb4-498a-8551-889f547e2618" width="200" style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/de226b50-6122-41cf-bd2a-f553796e23d1" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/7139228a-4270-4757-8d81-654da3307743" width="200" style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/5d4bd10b-f38e-4e63-b403-4d80638e84f0" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/3acade66-f663-47c7-b451-7c88bbbcd2e0" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/1ba8e3c5-0e6f-44ec-b48d-a3940515a380" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/f75bbe4b-eed1-4dc6-9983-ddd174185401" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/94d00158-fdcb-4f3c-b292-a9ebd15e5cda" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/8da4da95-3001-4fae-8016-edf3fe5ebdb1" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/0080fec0-dc9c-41f8-8890-b0a807363d94" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/7e37c387-c66a-4d56-a687-f7a9392f5baa" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/c67600fe-141b-465f-9ad7-0f53feea355d" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/8d95d7e3-d121-49fc-a2d9-0bf83ec8b7ec" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/271413eb-5c79-4144-871a-e7a6127f9b10" width="200" style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/c1276ac8-881e-46ea-8e15-9022c4c1d4d3" width="200" style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/dfd03ac9-0d20-467c-8a4d-3e02ee7f37a7" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/6b19990b-0a01-4601-ba03-e9eafd5ebdfc" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/8524f32c-77e1-4122-a482-e964730acb10" width="200"  style="margin: 5px;" />
    <img src="https://github.com/user-attachments/assets/0b04d830-84e9-47b3-9511-5f779a4be50e" width="200"  style="margin: 5px;" />
  </div>

</details>



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

1. **Clone** the project:

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

5. Create a **.env file** in the root of your project and add your OpenAI API keys and endpoint URL:
   
```bash
API_KEY=your_api_key_here
API_URL=https://your-endpoint-here
```

6. Get Flutter packages:

   ```bash
   flutter pub get
   ```

7. Run the app:

   ```bash
   flutter run
   ```

## Acknowledgements

Thanks for taking the time to read through this README! 🦸‍♂️🦸‍♀️ 

Feel free to dive into the code, break things, fix things, and have fun. If you encounter any bugs or just want to share your thoughts, don’t hesitate to reach out.☕💻

Happy coding and good luck with your habit tracking adventures!
