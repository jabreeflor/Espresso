# Espresso - Caffeine Tracker

A beautifully designed iOS app for tracking daily caffeine intake, setting limits, and comparing consumption with friends via a social leaderboard.

## Screenshots

| Track | Tracking Caffeine | Leaderboard | Settings |
|:---:|:---:|:---:|:---:|
| ![Track Screen](screenshots/01-track-screen.png) | ![After Drinks](screenshots/03-track-multiple-drinks.png) | ![Leaderboard](screenshots/04-leaderboard.png) | ![Settings](screenshots/05-settings.png) |

## Features

### Track Your Caffeine
- Circular progress ring showing real-time caffeine intake vs daily limit
- Quick-add buttons for Espresso (63mg), Double Espresso (126mg), and Americano (95mg)
- Animated ring fill with coffee-brown gradient
- SwiftData persistence across sessions

### Friends Leaderboard
- Ranked cards showing friends' caffeine consumption
- Crown badge for the #1 consumer
- Trend indicators (up/down/neutral arrows)
- Dark brown themed cards with avatars

### Settings
- Adjustable daily caffeine limit (100-800mg slider)
- Profile customization
- Notification toggles
- Clean card-based dark UI

## Tech Stack

- **Platform**: iOS 17+
- **Language**: Swift
- **UI**: SwiftUI
- **Architecture**: MVVM
- **Persistence**: SwiftData
- **Animations**: SwiftUI spring animations

## Project Structure

```
Espresso/
├── EspressoApp.swift
├── Models/
│   ├── CaffeineEntry.swift
│   ├── Drink.swift
│   └── User.swift
├── Views/
│   ├── ContentView.swift
│   ├── Track/
│   │   ├── TrackView.swift
│   │   ├── CaffeineRingView.swift
│   │   └── DrinkButtonView.swift
│   ├── Friends/
│   │   ├── LeaderboardView.swift
│   │   └── LeaderboardCard.swift
│   └── Settings/
│       └── SettingsView.swift
└── ViewModels/
    ├── TrackViewModel.swift
    ├── LeaderboardViewModel.swift
    └── SettingsViewModel.swift
```

## Getting Started

1. Open `Espresso.xcodeproj` in Xcode 15+
2. Select an iOS 17+ simulator
3. Build and run

## License

MIT
