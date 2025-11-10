# 📚 BookHive – Smart Book Management System

**BookHive** is a cross-platform book management application built using **Flutter**, **SQLite**, and **Firebase**.  
It helps users organize, track, and analyze their reading habits through a modern, interactive interface.

---

## 🚀 Features

- 🔐 **Login / Signup** via Firebase Authentication  
- 📖 **Add, Edit, Delete Books** with details and cover image  
- 🎯 **Track Reading Progress** using an interactive slider  
- 📊 **Reading Statistics Dashboard** using FL Chart  
- 💾 **Offline Storage** using SQLite Database  
- 🧠 **State Management** with Provider  
- 🧑‍💻 **Profile Management** (Display name, profile image, theme mode)  
- 🌗 **Dark / Light Mode** support  
- 📱 Works seamlessly on Android, iOS, and Web  

---

## 🧩 Tech Stack

| Component | Technology Used |
|------------|------------------|
| Framework | Flutter (Dart) |
| Database | SQLite + sqflite_common_ffi |
| Authentication | Firebase Auth |
| State Management | Provider |
| UI Components | Material Design, FL Chart, BottomSheet, DatePicker, Slider |
| Storage | SharedPreferences |

---

## 🧠 Project Flow

1. **Login/Register** – User authentication via Firebase.  
2. **Library Screen** – Displays all books from SQLite.  
3. **Add Book (BottomSheet)** – Add title, author, and cover image.  
4. **Progress Slider** – Update reading progress interactively.  
5. **Stats Screen** – Visual analytics using bar and pie charts.  
6. **Profile Page** – Edit profile details and toggle theme.

---

## 🧰 Installation & Setup

```bash
# Clone this repository
git clone https://github.com/parmar-gauravrobot/BookHive.git

# Navigate into the project folder
cd BookHive

# Get dependencies
flutter pub get

# Run the app
flutter run
