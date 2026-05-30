# 🎬 Movies App - Flutter Movie Application

Welcome to the **Movies App** repository! This is a fully-featured, production-ready Flutter movie application designed with top-tier modern app architecture and state management. 

Whether you're looking for the latest trending movies, searching for a specific title, or saving your favorites for later, this app has got you covered!

---

## ✨ Key Features

- **🏠 Home Dashboard:** Discover trending, popular, and upcoming movies right on the home screen.
- **🔎 Deep Search:** A robust search functionality to help you find exactly what you're looking for in seconds.
- **📁 Browse & Categories:** Filter movies by genres and categories with an intuitive browse section.
- **🔖 Cloud Bookmarks:** Save your favorite movies using **Firebase Firestore** for real-time syncing.
- **⚡ Smart 24H Caching:** Uses **SQFLite** to cache API responses locally for 24 hours. This minimizes network requests, saves API tokens, and speeds up screen reloads without calling the API unnecessarily.
- **🌍 Bilingual Support:** Full localization support out of the box with English and Arabic (`easy_localization`).
- **📱 Responsive UI:** Perfectly scaled across different device sizes using `sizer`.
- **🎥 Video Player:** Watch movie trailers directly in the app using `youtube_player_flutter`.
- **📶 Network Awareness:** Real-time internet connectivity checking that automatically alerts users when they go offline.
- **🔒 Secure Application:** Built-in screen blurring and security features when the app goes into the background.

---

## 📸 Screenshots

*(Replace the placeholder links below with your actual in-app screenshots once they are ready!)*

| Home Screen | Search Screen | Movie Details | Bookmarks |
| :---: | :---: | :---: | :---: |
| <img src="[Insert Home Screen Screenshot URL here]" width="200"/> | <img src="[Insert Search Screen Screenshot URL here]" width="200"/> | <img src="[Insert Details Screen Screenshot URL here]" width="200"/> | <img src="[Insert Bookmarks Screenshot URL here]" width="200"/> |

| Browse Categories | Localization (Arabic) | No Internet State | Trailer Player |
| :---: | :---: | :---: | :---: |
| <img src="[Insert Browse Screenshot URL here]" width="200"/> | <img src="[Insert Arabic Localization Screenshot URL here]" width="200"/> | <img src="[Insert No Internet Screenshot URL here]" width="200"/> | <img src="[Insert Video Player Screenshot URL here]" width="200"/> |

---

## 🏗 Architecture & Tech Stack

This project is built using industry standards to ensure high performance, maintainability, and scalability. It strictly follows the **Clean Architecture / Feature-First** approach with robust data separation.

### Core Technologies:
- **Framework:** Flutter (Bilingual support with English & Arabic via `easy_localization`)
- **State Management:** BLoC (`flutter_bloc`) & Cubit
- **Dependency Injection:** `get_it` for registering Repositories, DataSources, and UseCases.
- **Network Interface:** `dio` configured with custom interceptors (`SlowNetworkInterceptor`, `LoggerInterceptor`) to hit the TMDB API.
- **Data Persistence:** 
  - **Firebase Firestore:** For cloud-syncing user Bookmarks/Favorites.
  - **SQFLite:** Powers the 24-hour API caching system.
  - **SharedPreferences (`CashHelper`):** Handles lightweight localized key-value storage.
- **Responsive Design:** Utilizes `sizer` and a custom `SizeConfig` to seamlessly scale across `mobile`, `tablet`, and `web` layouts.

### UI & Custom Packages:
- **Video Playback:** `youtube_player_flutter` for in-app movie trailers.
- **Security:** `secure_application` to blur the UI when the app moves to the background.
- **Network State:** `connectivity_plus` combined with `overlay_support` to immediately block the UI with a `NoInternetScreen` upon disconnection.
- **Custom Components:** Includes custom-built, locally injected packages (`dropdown_search_edited`, `flutter_toggle_tab_edited`) specifically tailored for this project's theme.

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites
- Flutter SDK (`>=3.3.0 <4.0.0`)
- Dart SDK
- An IDE (VSCode, Android Studio, etc.)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/movies_app.git
   cd movies_app
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Environment Setup:**
   - Create a `.env` file in the root directory.
   - The app relies heavily on `flutter_dotenv` for securely loading Firebase credentials and TMDB API keys. You MUST populate the `.env` file with the following exact variables for the app to compile and run properly:

   ```env
   # TMDB API Configuration
   MOVIE_HEADER_API_KEY=your_tmdb_bearer_token
   HTTP_API_KEY_BROWSER=your_tmdb_http_api_key

   # Firebase Configuration
   FIREBASE_API_KEY_ANDROID=your_android_api_key
   FIREBASE_API_KEY_IOS=your_ios_api_key
   FIREBASE_API_KEY_BROWSER=your_browser_api_key
   FIREBASE_APP_ID=your_android_app_id
   FIREBASE_APP_ID_IOS=your_ios_app_id
   FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   FIREBASE_PROJECT_ID=your_project_id
   FIREBASE_STORAGE_BUCKET=your_storage_bucket
   IOS_BUNDLE_ID=your_ios_bundle_id
   ```

4. **Run the App:**
   ```bash
   flutter run
   ```

---

## 🛠 Project Structure

The codebase is organized by features to keep things modular and clean:
- `lib/core/`: Contains network configurations, services, theme, utils, and shared widgets.
- `lib/feature/`: Contains isolated features (`auth`, `bookmarks`, `browse`, `home`, `search`). Each feature typically contains its own `presentation` (UI & business logic) and data layers.
- `lib/config/`: App configuration including routing and language settings.

---

*Made with ❤️ and Flutter.*
