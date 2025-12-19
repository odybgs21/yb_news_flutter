# YB News 📰

A modern, responsive News Application built with **Flutter** and **GetX**.
Experience real-time news updates, infinite scrolling, and a seamless user experience across mobile and web platforms.

![App Screenshot](https://via.placeholder.com/800x400?text=YB+News+App+Demo)
_(Replace this link with your actual screenshot)_

## ✨ Key Features

### � Advanced Authentication

- **Secure Log In & Sign Up**: Complete validation for email and password.
- **Forgot Password Flow**: Step-by-step recovery process including email input and reset password.
- **OTP Verification**: Interactive 4-digit PIN input with countdown timer and resend functionality.

### 📰 Smart News Discovery

- **Trending & Latest**: Dedicated sections for breaking news and chronological updates.
- **Topic Filtering**: Explore news by categories like _Technology, Business, Health, Science,_ and more.
- **Real-time Search**: Instant filtering of articles by keyword on the Explore page.
- **Infinite Scrolling**: Seamlessly load more articles as you scroll down on Home and Explore pages.

### � User Personalization

- **Bookmarks**: Save interesting articles locally to read later in the dedicated Bookmark tab.
- **Comments System**: Interactive UI for viewing and posting comments (Mock implementation).
- **Profile Management**: User profile overview.

### 💻 Technical Highlights

- **Clean Architecture**: Structured codebase separating Data, Domain, and Presentation layers.
- **Responsive UI**: Adaptive layout that looks great on both Mobile phones and Web browsers.
- **Optimized Performance**: Efficient state management using GetX controllers and bindings.

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
