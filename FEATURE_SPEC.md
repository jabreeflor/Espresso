# Espresso - Caffeine Tracker iOS App

## Overview
Espresso is a beautifully designed iOS caffeine tracking app that helps users monitor their daily caffeine intake, set limits, and compare consumption with friends via a social leaderboard.

## Design Language
- **Color Palette**: Rich dark brown gradients (#3E2723 to #5D4037), cream/ivory accents (#FFF8E1), warm gold highlights
- **Typography**: Large bold sans-serif for numbers, script/cursive for branding, clean sans-serif for labels
- **Style**: Warm, premium coffee aesthetic with rounded cards, circular progress indicators, and soft shadows
- **Tab Bar**: 3 tabs — Track (clock icon), Friends (people icon), Settings (gear icon)

---

## Screens & Features

### 1. Track Screen (Home)
**Primary screen for logging and viewing caffeine intake.**

#### UI Elements
- **Circular Progress Ring**
  - Large circular gauge filling clockwise
  - Coffee-brown gradient stroke (light tan to dark brown)
  - Center displays current intake in large bold text (e.g., "300 mg")
  - Subtitle: "Daily Limit: 400 mg"
  - Ring fills proportionally to daily limit (300/400 = 75%)

- **Quick-Add Drink Buttons**
  - Row of circular buttons below the progress ring
  - Each button: cream/ivory circle with a coffee cup illustration
  - Default drinks:
    - **Espresso** — 63 mg caffeine
    - **Double Espresso** — 126 mg caffeine
    - **Americano** — 95 mg caffeine
  - Tapping a button instantly adds the caffeine amount and animates the ring

#### Behavior
- Ring color shifts from green → amber → red as user approaches/exceeds limit
- Haptic feedback on drink logging
- Daily reset at midnight (user's local time)
- Undo last entry (shake to undo or swipe)

---

### 2. Friends / Leaderboard Screen
**Social screen showing caffeine consumption rankings among friends.**

#### UI Elements
- **Title**: "Leaderboard" in large bold text
- **Ranked Cards**: Vertically stacked rounded-rectangle cards with:
  - Circular avatar (user profile image or placeholder)
  - Username (bold)
  - Daily caffeine total (e.g., "450 mg")
  - Trend indicator arrow (↑ up in rank, ↓ down in rank)
  - Crown icon on #1 ranked user

#### Card Design
- Brown gradient background matching app theme
- Slight elevation/shadow for depth
- Cards ordered by caffeine consumption (highest first)

#### Sample Data
| Rank | User    | Caffeine | Trend |
|------|---------|----------|-------|
| 1    | Alex    | 450 mg   | ↑     |
| 2    | Ben     | 300 mg   | —     |
| 3    | Charlie | 250 mg   | ↓     |

#### Behavior
- Pull to refresh
- Tap a friend's card to view their detailed history
- Add friends via invite link or username search

---

### 3. Settings Screen
**User preferences and configuration.**

#### Features
- **Daily Caffeine Limit**: Slider or number input (default 400 mg, FDA recommended)
- **Custom Drinks**: Add/edit drinks with custom names and caffeine amounts
- **Notifications**: Toggle reminders ("You haven't logged in a while", "Approaching daily limit")
- **Profile**: Name, avatar, username for leaderboard
- **Units**: mg (default) or oz
- **Theme**: Light/Dark mode toggle
- **Data**: Export caffeine history, clear data
- **About**: App version, credits

---

## Data Model

### User
| Field          | Type     | Description                  |
|----------------|----------|------------------------------|
| id             | UUID     | Unique identifier            |
| username       | String   | Display name                 |
| avatarURL      | String?  | Profile image URL            |
| dailyLimit     | Int      | Caffeine limit in mg         |
| createdAt      | Date     | Account creation date        |

### CaffeineEntry
| Field      | Type     | Description                    |
|------------|----------|--------------------------------|
| id         | UUID     | Unique identifier              |
| userId     | UUID     | Foreign key to User            |
| drinkName  | String   | Name of the drink              |
| caffeineAmg| Int      | Caffeine amount in mg          |
| loggedAt   | Date     | Timestamp of entry             |

### Drink (Template)
| Field       | Type   | Description               |
|-------------|--------|---------------------------|
| id          | UUID   | Unique identifier         |
| name        | String | Drink name                |
| caffeineMg  | Int    | Default caffeine in mg    |
| iconName    | String | SF Symbol or asset name   |
| isDefault   | Bool   | System-provided drink     |

### Friendship
| Field      | Type   | Description              |
|------------|--------|--------------------------|
| id         | UUID   | Unique identifier        |
| userId     | UUID   | Requesting user          |
| friendId   | UUID   | Friend user              |
| status     | Enum   | pending / accepted       |

---

## Technical Stack
- **Platform**: iOS 17+
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Persistence**: SwiftData (local)
- **Animations**: SwiftUI animations + custom ring animation
- **Tab Navigation**: SwiftUI TabView

---

## Project Structure
```
Espresso/
├── EspressoApp.swift              # App entry point
├── Models/
│   ├── User.swift
│   ├── CaffeineEntry.swift
│   ├── Drink.swift
│   └── Friendship.swift
├── Views/
│   ├── ContentView.swift          # TabView container
│   ├── Track/
│   │   ├── TrackView.swift        # Main tracking screen
│   │   ├── CaffeineRingView.swift # Circular progress ring
│   │   └── DrinkButtonView.swift  # Quick-add drink button
│   ├── Friends/
│   │   ├── LeaderboardView.swift  # Friends leaderboard
│   │   └── LeaderboardCard.swift  # Individual rank card
│   └── Settings/
│       └── SettingsView.swift     # Settings screen
├── ViewModels/
│   ├── TrackViewModel.swift
│   ├── LeaderboardViewModel.swift
│   └── SettingsViewModel.swift
├── Services/
│   └── CaffeineService.swift      # Business logic
├── Assets.xcassets/
│   ├── AppIcon.appiconset/
│   └── Colors/
└── Preview Content/
```

---

## Development Phases

### Phase 1: Core Tracking (MVP)
- [ ] Xcode project setup with SwiftUI
- [ ] SwiftData models (User, CaffeineEntry, Drink)
- [ ] Track screen with circular progress ring
- [ ] Quick-add drink buttons (Espresso, Double Espresso, Americano)
- [ ] Daily caffeine calculation and ring animation
- [ ] Tab bar navigation shell

### Phase 2: Leaderboard & Social
- [ ] Leaderboard view with ranked cards
- [ ] Mock friend data for UI development
- [ ] Trend arrows and crown badge
- [ ] Friend profile cards

### Phase 3: Settings & Polish
- [ ] Settings screen (daily limit, custom drinks, profile)
- [ ] App icon and launch screen
- [ ] Haptic feedback
- [ ] Dark brown theme throughout
- [ ] Animations and transitions

### Phase 4: Persistence & Data
- [ ] SwiftData persistence for entries
- [ ] Daily reset logic
- [ ] History view
- [ ] Data export
