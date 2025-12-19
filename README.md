# YB News 📰

A modern, responsive News Application built with **Flutter** and **GetX**.
Experience real-time news updates, infinite scrolling, and a seamless user experience across mobile and web platforms.

![App Screenshot](https://via.placeholder.com/800x400?text=YB+News+App+Demo)
_(Replace this link with your actual screenshot)_

## ✨ Features

- **📰 Fresh News Feed**: Stay updated with Top Headlines and Trending news.
- **🔍 Explore & Search**: Find news by categories (Technology, Business, Sports, etc.) or specific keywords.
- **♾️ Infinite Scroll**: Smoothly browse through endless articles on Home and Explore pages.
- **🔖 Bookmarks**: Save articles to read later (stored locally).
- **🔐 Authentication**: Complete Login, Sign Up, Forgot Password, and OTP Verification flows.
- **📱 Responsive Design**: optimized for both Mobile and Web views.
- **⚡ State Management**: Powered by **GetX** for high performance and reactive UI.
- **🌐 Open API**: Utilizes [Saurav.tech NewsAPI](https://saurav.tech/NewsAPI/) (No API Key required).

## 🛠️ Tech Stack

- **Framework:** [Flutter](https://flutter.dev/) (Dart)
- **State Management:** [GetX](https://pub.dev/packages/get)
- **Networking:** `http` package
- **Local Storage:** `GetStorage` / `SharedPreferences` (Simulated)
- **Icons:** Material Icons & Lucide (via package)
- **Deployment:** Vercel (Web)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK installed (version 3.x or newer)
- Dart SDK

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/yb-news.git
    cd yb-news
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    - **Mobile (Android/iOS):**
      ```bash
      flutter run
      ```
    - **Web (Chrome):**
      ```bash
      flutter run -d chrome
      ```

## 🌐 Deploying to Vercel

This project is configured for easy deployment on Vercel.

1.  Push this code to your GitHub repository.
2.  Import the project in [Vercel](https://vercel.com).
3.  **Build Settings:**
    - **Framework Preset:** `Other`
    - **Build Command:** `bash vercel_build.sh`
    - **Output Directory:** `build/web`
4.  Click **Deploy**!

## 📂 Project Structure

```
lib/
├── app/                  # Routes & Bindings
├── data/                 # Providers, Models, Repositories
├── domain/               # Entities & UseCases (Clean Architecture)
├── presentation/         # Pages, Controllers, Widgets
└── main.dart             # Entry point
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
