# Espresso - BDD Test Specification

Behavior-driven test scenarios for the Espresso caffeine tracker iOS app.

---

## Feature: Caffeine Entry Model

`CaffeineEntry` is a SwiftData `@Model` that records a single caffeine intake event.

### Scenario: Create entry with all properties

```
Given a drink name "Espresso", caffeine amount 63, and a specific date
When  I create a CaffeineEntry with those values
Then  the entry's drinkName should be "Espresso"
And   the entry's caffeineMg should be 63
And   the entry's loggedAt should equal the specified date
And   the entry's id should be a valid UUID
```

### Scenario: Default loggedAt is now

```
Given a drink name "Americano" and caffeine amount 95
When  I create a CaffeineEntry without providing a date
Then  the entry's loggedAt should be approximately Date.now
```

---

## Feature: Drink Templates

`Drink` is a plain struct with static default drink options. `DrinkTemplate` in TrackView.swift mirrors the same defaults.

### Scenario: Three default drinks exist

```
Given the static Drink.defaults array
When  I check its count
Then  it should contain exactly 3 drinks
```

### Scenario: Default drinks have correct names

```
Given the static Drink.defaults array
When  I read the name of each drink
Then  the names should be "Espresso", "Double Espresso", and "Americano" in order
```

### Scenario: Default drinks have correct caffeine values

```
Given the static Drink.defaults array
When  I read each drink's caffeineMg
Then  Espresso should have 63 mg
And   Double Espresso should have 126 mg
And   Americano should have 95 mg
```

### Scenario: DrinkTemplate defaults match Drink defaults

```
Given DrinkTemplate.defaults and Drink.defaults
When  I compare names and caffeine values pairwise
Then  every DrinkTemplate should match the corresponding Drink
```

---

## Feature: Caffeine Tracking (TrackViewModel)

`TrackViewModel` is an `@Observable` class that manages today's caffeine entries via a `ModelContext`.

### Scenario: Empty state shows zero caffeine

```
Given a TrackViewModel with an empty ModelContext
When  the view model initializes
Then  todaysCaffeine should be 0
And   todaysEntries should be empty
```

### Scenario: Add a single espresso

```
Given a TrackViewModel with an empty ModelContext
When  I call addDrink with Drink.espresso (63 mg)
Then  todaysCaffeine should be 63
And   todaysEntries should contain 1 entry
And   that entry's drinkName should be "Espresso"
```

### Scenario: Add multiple drinks and sum caffeine

```
Given a TrackViewModel with an empty ModelContext
When  I call addDrink with Drink.espresso (63 mg)
And   I call addDrink with Drink.americano (95 mg)
Then  todaysCaffeine should be 158
And   todaysEntries should contain 2 entries
```

### Scenario: Undo removes the most recent entry

```
Given a TrackViewModel with two entries logged today
When  I call undoLastEntry
Then  todaysEntries should contain 1 entry
And   the removed entry should be the one logged most recently
```

### Scenario: Undo on empty state does nothing

```
Given a TrackViewModel with no entries
When  I call undoLastEntry
Then  todaysEntries should remain empty
And   todaysCaffeine should remain 0
```

### Scenario: fetchTodaysEntries filters by start of day

```
Given a ModelContext containing an entry logged yesterday and an entry logged today
When  I call fetchTodaysEntries
Then  todaysEntries should contain only the entry logged today
And   todaysCaffeine should reflect only today's entry
```

### Scenario: Ring progress calculates correctly

```
Given a TrackViewModel with dailyLimit set to 400
When  todaysCaffeine is 200
Then  ringProgress should be 0.5
```

### Scenario: Ring progress caps at 1.0

```
Given a TrackViewModel with dailyLimit set to 400
When  todaysCaffeine is 600
Then  ringProgress should be 1.0
```

### Scenario: Ring progress is 0.0 when no caffeine consumed

```
Given a TrackViewModel with dailyLimit set to 400
When  todaysCaffeine is 0
Then  ringProgress should be 0.0
```

### Scenario: Add custom drink with valid input

```
Given a TrackViewModel with an empty ModelContext
When  I call addCustomDrink(name: "Matcha", caffeineMg: 70)
Then  todaysCaffeine should be 70
And   the entry's drinkName should be "Matcha"
```

### Scenario: Add custom drink with empty name defaults to "Custom"

```
Given a TrackViewModel with an empty ModelContext
When  I call addCustomDrink(name: "", caffeineMg: 80)
Then  the entry's drinkName should be "Custom"
And   todaysCaffeine should be 80
```

### Scenario: Add custom drink with zero caffeine is rejected

```
Given a TrackViewModel with an empty ModelContext
When  I call addCustomDrink(name: "Water", caffeineMg: 0)
Then  todaysEntries should remain empty
And   todaysCaffeine should remain 0
```

### Scenario: Add custom drink with negative caffeine is rejected

```
Given a TrackViewModel with an empty ModelContext
When  I call addCustomDrink(name: "Bad", caffeineMg: -5)
Then  todaysEntries should remain empty
And   todaysCaffeine should remain 0
```

---

## Feature: Custom Drink Input Validation (CustomDrinkSheet)

The `isValid` computed property in `CustomDrinkSheet` determines whether the Add button is enabled.

### Scenario: Valid numeric caffeine amount

```
Given caffeineAmount is "80"
When  I evaluate isValid
Then  isValid should be true
```

### Scenario: Empty string is invalid

```
Given caffeineAmount is ""
When  I evaluate isValid
Then  isValid should be false
```

### Scenario: Zero is invalid

```
Given caffeineAmount is "0"
When  I evaluate isValid
Then  isValid should be false
```

### Scenario: Non-numeric string is invalid

```
Given caffeineAmount is "abc"
When  I evaluate isValid
Then  isValid should be false
```

### Scenario: Negative number is invalid

```
Given caffeineAmount is "-5"
When  I evaluate isValid
Then  isValid should be false
```

### Scenario: Positive integer string is valid

```
Given caffeineAmount is "150"
When  I evaluate isValid
Then  isValid should be true
```

---

## Feature: Settings (SettingsViewModel)

`SettingsViewModel` is an `@Observable` class that persists user preferences via `UserDefaults`.

### Scenario: Default values on fresh install

```
Given UserDefaults contains no stored values for Espresso
When  I create a SettingsViewModel
Then  username should be "Coffee Lover"
And   dailyLimit should be 400
And   notificationsEnabled should be false
```

### Scenario: Update username persists to UserDefaults

```
Given a SettingsViewModel
When  I set username to "Jabree"
Then  UserDefaults value for key "username" should be "Jabree"
And   reading username again should return "Jabree"
```

### Scenario: Update dailyLimit persists to UserDefaults

```
Given a SettingsViewModel
When  I set dailyLimit to 500
Then  UserDefaults value for key "dailyLimit" should be 500
And   reading dailyLimit again should return 500
```

### Scenario: Update notificationsEnabled persists to UserDefaults

```
Given a SettingsViewModel
When  I set notificationsEnabled to true
Then  UserDefaults value for key "notificationsEnabled" should be true
And   reading notificationsEnabled again should return true
```

### Scenario: dailyLimit zero-guard returns default

```
Given UserDefaults value for key "dailyLimit" is 0
When  I read dailyLimit from a SettingsViewModel
Then  dailyLimit should be 400
```

---

## Feature: Leaderboard (LeaderboardViewModel)

`LeaderboardViewModel` is an `@Observable` class that manages the friend leaderboard, using mock data as a fallback.

### Scenario: Initializes with 5 mock entries

```
Given a freshly created LeaderboardViewModel
When  I check the entries array
Then  it should contain exactly 5 entries
```

### Scenario: Mock entries are ranked in descending caffeine order

```
Given a freshly created LeaderboardViewModel
When  I read the entries in order
Then  entry ranks should be 1, 2, 3, 4, 5
And   caffeine values should be 450, 300, 250, 200, 150 respectively
```

### Scenario: Number one on the leaderboard is Alex

```
Given a freshly created LeaderboardViewModel
When  I read the first entry
Then  the name should be "Alex"
And   caffeineMg should be 450
And   rank should be 1
```

### Scenario: Mock entry names are correct

```
Given a freshly created LeaderboardViewModel
When  I read all entry names
Then  they should be "Alex", "Ben", "Charlie", "Diana", "Eve" in order
```

### Scenario: fetchLeaderboard falls back to mock when CloudKit is unavailable

```
Given CloudKit is not available
When  I call fetchLeaderboard
Then  entries should equal the mock entries
And   isCloudKitAvailable should be false
```

### Scenario: fetchLeaderboard uses CloudKit data when available

```
Given CloudKit is available and returns leaderboard data
When  I call fetchLeaderboard
Then  entries should reflect the CloudKit data
And   isCloudKitAvailable should be true
```

### Scenario: fetchLeaderboard falls back to mock on CloudKit error

```
Given CloudKit is available but throws an error
When  I call fetchLeaderboard
Then  entries should equal the mock entries
And   errorMessage should be "Could not load leaderboard"
```

---

## Feature: Caffeine Trend Enum

`CaffeineTrend` maps trend direction to an SF Symbol name and a SwiftUI color.

### Scenario: Up trend

```
Given a CaffeineTrend of .up
When  I read its symbol
Then  symbol should be "arrow.up"
And   color should be .green
```

### Scenario: Down trend

```
Given a CaffeineTrend of .down
When  I read its symbol
Then  symbol should be "arrow.down"
And   color should be .red
```

### Scenario: Neutral trend

```
Given a CaffeineTrend of .neutral
When  I read its symbol
Then  symbol should be "minus"
And   color should be .gray
```
