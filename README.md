# CareerVerse

CareerVerse is a Flutter app (Android / iOS) that helps students discover technology careers through interactive career labs. Users take real question-based simulations, get computed scores, and receive career recommendations based on their results and interests.

## Features

- **Accounts**: register and log in with email and password. Accounts are stored on the device, and passwords are saved as salted SHA-256 hashes. The session persists between launches, and forms are validated.
- **Editable profile**: name, photo (gallery or camera), study level, university, specialty, bio and interests. The profile screen shows how complete it is, your stats and your top skills.
- **Career explorer**: search, category tabs (Infrastructure / Development / Security) and detail pages (Hero animation) covering salary, education, outlook, typical day and tools.
  - Careers covered: Cloud Engineer, DevOps Engineer, Backend Developer and Cybersecurity Analyst.
- **Real simulations**: each career has 3 labs (Beginner → Advanced) of real scenario questions (single and multi-select). The flow is: select answers → *Check answer* → feedback with explanation → *Next question* / *Finish lab*. A timer runs, and there is an exit confirmation.
- **Real results**: score ring, correct answers, time, comparison with your previous best, per-skill scores and the updated career match.
  - **Next Lab** opens the next lab of the same career. When a career is finished, it moves on to the best-matching unfinished career.
- **Recommendations**: the top match, all matches with explanations, and a history of past recommendations.
- **Progress & learning path**: completed labs per career, skill averages, full attempt history and a timeline for each career.
- **Notifications center**: finishing a lab creates "Your recommendations are ready!". Tapping it opens the matching results. Notifications can be marked as read or cleared.
- **Settings**: light/dark theme, FR / EN / AR languages with RTL support, reset progress and logout. All of these are saved with SharedPreferences.
- **Fully translated (FR / EN / AR)**: every interface string, plus all career content: titles, descriptions, labs, questions, answers, explanations, skills and levels. Switching the language in Settings updates the whole app instantly. Arabic is displayed right to left.

### Localization

- Interface strings come from Flutter `gen-l10n`: `lib/l10n/app_en.arb` (template), `app_fr.arb` and `app_ar.arb`. They are accessed with `context.l10n.key`, and plurals use ICU syntax.
- Career content is written in English in `data/catalog.dart`. It is translated through `lib/l10n/content_fr.dart` and `content_ar.dart`, and `setCatalogLanguage()` selects the active catalog.
- Stored values (skills, levels, interests) stay in English and are displayed with `tc()`, so results remain valid after a language change.
- To add a string, add it to all three ARB files, then run `flutter gen-l10n` (or `flutter pub get`).

### Scoring

- `correctness` = percentage of questions answered exactly right.
- `timeScore` = 100 within the expected time (60 s per question). After that it drops linearly to 40 at twice the expected time.
- `overall` = round(0.8 × correctness + 0.2 × timeScore). A lab is passed when `overall` ≥ 60.
- Career match = 0.75 × best lab performance + 0.25 × interest fit for tested careers, and 0.6 × interest fit for untested careers.

## Architecture

```
lib/
├── main.dart / app.dart        providers + named routes
├── data/catalog.dart           careers, labs and questions (EN source + translated catalogs)
├── l10n/                       ARB files (en/fr/ar), generated AppLocalizations, content translations
├── models/                     Career, Lab, LabQuestion, LabResult, UserProfile, AppNotification
├── providers/                  AppState (auth, persistence, scoring, recommendations), Theme, Locale
├── screens/                    welcome, login, register, home, explore, career detail, simulation,
│                               results, recommendations, learning path, progress, profile,
│                               edit profile, notifications, settings
├── widgets/                    design system (career_ui), avatar, form helpers
└── utils/validators.dart
```

## Run locally

```bash
flutter pub get
flutter run
```

## Validate

```bash
flutter analyze
flutter test
flutter build apk --debug   # build/app/outputs/flutter-apk/app-debug.apk
```

The tests cover scoring, authentication, persistence, recommendations and next-lab logic. A full widget flow goes from register → lab → results → Next Lab → second lab, and another test covers profile editing. The localization tests check three things: every career string has a FR/AR translation, the UI renders in French, and a complete lab plus every screen renders in Arabic (RTL) without layout errors.

## Not configured yet

These services need your own project keys, so they are not connected:

- Firebase (Auth, Firestore, Cloud Messaging)
- Google Sign-In
- AdMob test ads
- Stripe test mode

The app works fully offline with local storage. The Google button explains that it requires Firebase, and notifications are in-app.
