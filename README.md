# CareerVerse

CareerVerse is a Flutter app (Android / iOS) that helps students discover technology careers through interactive career labs. Users take real question-based simulations, get computed scores, and receive career recommendations based on their results and interests.

## Features

- **Accounts (Firebase Auth)**: register and log in with email and password, **Google Sign-In**, and password reset by email. The session persists between launches, forms are validated, and Firebase errors are translated (wrong password, email already used, network...). On platforms without Firebase (desktop, tests) the app falls back to local accounts stored on the device (salted SHA-256).
- **Cloud sync (Cloud Firestore)**: profile, lab results, recommendation history and notifications are saved to the user's Firestore document, so logging in on another device restores everything.
- **Editable profile**: name, photo (gallery or camera), study level, university, specialty, bio and interests. The profile screen shows how complete it is, your stats and your top skills.
- **Country-based salary display**: select a supported country in the profile to convert the app's France-based euro ranges into local currency using current EUR exchange rates from a public API. Rates are cached for offline use and refreshed every 24 hours. With no country selected, salaries remain in euros. Converted values are labelled as France-based currency conversions, not local-market salaries. Supported choices include Tunisia (DT), Algeria, Morocco, Egypt, France, Germany, United States, Canada, United Kingdom, Switzerland, UAE, Saudi Arabia, India, Japan, Australia and Senegal.
- **Career explorer**: search, category tabs (Infrastructure / Development / Security) and detail pages (Hero animation) covering salary, education, outlook, typical day and tools.
  - The 9 CareerVerse careers have curated courses and interactive labs. Searching also queries the European Commission's multilingual ESCO API for additional occupations; their official descriptions, occupation codes and essential/optional skills are displayed in a separate profile. Search results are paginated. Existing career discovery and simulations remain available offline.
- **Real simulations**: each career has 3 labs (Beginner → Advanced) of real scenario questions (single and multi-select). The flow is: select answers → *Check answer* → feedback with explanation → *Next question* / *Finish lab*. A timer runs, and there is an exit confirmation.
- **Real results**: Lottie animation (success / keep practicing), score ring, correct answers, time, comparison with your previous best, per-skill scores and the updated career match.
  - **Next Lab** opens the next lab of the same career. When a career is finished, it moves on to the best-matching unfinished career.
- **Recommendations**: the top match, all matches with explanations, and a history of past recommendations.
- **Progress & learning path**: completed labs per career, skill averages, full attempt history and a timeline for each career.
- **Courses before every lab**: each step of the learning path is *Course → Lab*. The 27 courses (FR/EN/AR) have an introduction, 3 lessons (explanation, key points and a code or command example) and a summary. "Finish and start the lab" marks the course as read and opens the lab. The course can be reopened from the career detail or the results screen. Read courses are saved offline (Hive) and in Firestore (`users/{uid}/courses`).
- **Notifications center**: finishing a lab creates "Your recommendations are ready!". Tapping it opens the matching results. Notifications can be marked as read or cleared.
- **Push notifications (firebase_messaging)**: received in the foreground (shown as a local notification) and in the background. Finishing a lab also shows a system notification; tapping any notification opens the related results screen. Push can be turned off in Settings.
- **Settings**: light/dark theme, FR / EN / AR languages with RTL support, reset progress and logout. All of these are saved with SharedPreferences.
- **Fully translated (FR / EN / AR)**: every interface string, plus all career content: titles, descriptions, labs, questions, answers, explanations, skills and levels. Switching the language in Settings updates the whole app instantly. Arabic is displayed right to left.
- **Offline database (Hive)**: profile, lab results, recommendation history and notifications are stored per user in Hive boxes. Results and history can be consulted without network. Data saved by older versions (SharedPreferences) is migrated automatically.
- **Premium subscription (Stripe test mode)**: Advanced labs are locked (padlock) for free users; opening one shows a paywall. Premium (4.99 € / 30 days) is paid with the Stripe Payment Sheet, then the lab unlocks immediately. A new payment extends the current period. Every payment is saved offline (Hive) and in Firestore (`users/{uid}/transactions`), and the Premium screen (drawer or Settings) shows the status and transaction history.
- **Ads (AdMob, test IDs only)**: an adaptive banner at the bottom of the Home and Explore tabs, and an interstitial after each finished simulation, before the results. If no ad is ready, the results open immediately.
- **Career assistant (chatbot)**: open it with the *Assistant* button (Home and Explore) or from the drawer. It answers in FR / EN / AR about careers (salary, skills, studies, outlook, typical day), your progress and your next course or lab, and recommends careers from your profile and results. Answers come with buttons that open the career, the course, the lab or the recommendations. The engine is hybrid:
  - **Gemini (AI)** when a `GEMINI_API_KEY` is configured. The assistant sends your profile, your career matches and the catalog as context.
  - **Offline assistant** (keyword-based, no network) otherwise, or automatically when Gemini fails. Such answers are labelled as offline.
  - Conversations are saved on the device per user (last 60 messages) and can be cleared.

### Dynamic career catalogue (ESCO)

In Explore, searches of at least two characters query the public [ESCO web service](https://esco.ec.europa.eu/en/use-esco/use-esco-services-api/esco-web-service-api) in the selected FR / EN / AR language. Results are debounced, paginated and can be opened to view the occupation description, ESCO code and essential/optional skills. No API key is required. The user's search text is sent to the European Commission's ESCO service.

ESCO profiles do not contain CareerVerse's simulations or salary fields. The 9 built-in careers therefore keep their existing locally authored courses/labs and detailed salary information; additional ESCO occupations are informational profiles only. If the network is unavailable, the 9 local careers remain searchable and usable, while ESCO search displays an error and retry action.

### Administration (Firestore only, no Cloud Functions)

An authorized account sees **Administration** in the drawer. The named `/admin`
route and editors also check the role, including when it is revoked during a
session. Server-side Firestore rules enforce the permissions independently of
the UI; an email address or a profile field never grants administrator access.

The administration interface uses themed content/student cards, availability
badges and responsive statistics panels. It supports dark mode and Arabic RTL.
The career editor groups simulations into expandable sections, provides a
English-only authoring and keeps the save action visible at the bottom of the screen.

Administrators can:

- List student profiles and edit names, universities, study levels, specialties
  and biographies, with individual simulation counts and average scores.
- Add careers or edit existing careers, salary ranges, discovery tags and
  recommendation interests. Use canonical English interests from the profile
  choices (for example `Security`, `Networks`, `Data`) for matching.
- Create simulations and quiz tasks, edit answer choices, correct answers,
  assessed skills, scenarios and feedback explanations.
- Author the associated courses: introductions, lessons, key points,
  practical examples and takeaways.
- Set seconds per question, correctness/time weighting and passing thresholds.
  These criteria are used in scoring and saved with each result, so later edits
  do not recalculate historical results.
- Archive/restore careers when history should be retained. Archived careers disappear
  from discovery, active learning-path choices and recommendations, but their
  courses, labs and previous results remain resolvable.
- Permanently delete careers and their related student results, course progress,
  recommendations and notifications after confirmation. This also works for
  built-in careers. Minimal deletion markers retain only IDs (not educational
  content), preventing offline clients or the built-in catalogue from restoring
  the deleted career. These IDs cannot be reused.
- Delete a student's Firestore profile and all known subcollections, including
  payment records, after confirmation. Administrator profiles are protected.
  The Firebase Auth account is not deleted or disabled.
- Consult aggregate simulation counts, student counts and average scores.

Content is stored in `catalog/{careerId}` with a required complete `en` variant.
New careers are authored in English only; French and Arabic student screens
use the English career, labs and courses when a translation is absent.
Existing translated variants are preserved when editing existing careers.
Canonical IDs, skills, interests, answer keys, levels and assessment
criteria stay aligned across languages. Each lab needs a course and a valid
quiz. Existing lab IDs and order cannot be removed or changed from the editor.
Firestore snapshots update the student catalogue, learning paths, courses and
chatbot context. Validated content is cached locally for offline use; the
built-in catalogue remains the baseline. ESCO entries remain informational and
are not edited here.

**Scope limitation:** this version manages Firestore profiles, not Firebase
Auth accounts. It does not create, disable or delete login accounts, reset
another user's password, or grant roles from inside the application. Profile
changes are picked up by the existing cloud-sync flow on the student's next
sign-in. Operations use the current Firestore rules and quotas; no paid
Functions backend is required.

#### Granting or revoking access

Deletion runs in batches of at most 400 documents, not one atomic transaction.
If a network/permission failure interrupts cleanup, the error is displayed and
**Resume interrupted deletions** retries pending work. Deletion markers block
re-upload while cleanup is pending. A removed student's Auth login still exists,
but Firestore writes are blocked; the app clears that device's Hive data and
signs out when it detects the marker during cloud sync. Other offline devices
cannot be remotely wiped, and their local copies persist until they synchronize.
Only the app's known Firestore subcollections are covered; Auth and external
payment-provider data are not deleted.

1. Register the intended administrator normally in CareerVerse (or use an
   existing Firebase Auth user).
2. In Firebase Console → Authentication → Users, copy that user's **UID**.
3. Using the trusted Firebase Console, create `admins/{UID}` with
   `active: true` (boolean). Clients, including administrators, cannot write
   these role documents.
4. Deploy the rules: `firebase deploy --only firestore:rules --project careerverse-3057`.
5. Sign in with that account. To revoke access, set `active` to `false` or remove
   the role document through the console.

For a future public release, use a privileged backend for full Auth-account
management. Never put an administrator password or a service-account key in
the Flutter application.

**Texte adapté au cahier des charges :** « L'administrateur gère les profils
étudiants, ajoute et modifie les métiers, archive les métiers retirés du
catalogue, crée les simulations et tâches QCM, définit les critères
d'évaluation, consulte les statistiques et gère les cours et contenus
pédagogiques en français, anglais et arabe. La gestion des comptes de connexion
Firebase Auth reste réservée à la console Firebase. »

#### Administration tests

Run `flutter test test/admin_test.dart` for content validation, publication UI,
role guards, archive/history compatibility and scoring criteria.

The permission tests run only against a local demo Firestore emulator (Node.js,
Java and the Firebase CLI required):

```powershell
npm --prefix test\firestore ci
firebase emulators:exec --only firestore --project demo-careerverse "npm --prefix test\firestore test"
```

They check role self-promotion, revoked accounts, student privacy, profile-write
restrictions, catalogue writes/archiving and read-only statistics. The demo
project cannot access the production Firebase database.

### Chatbot (Gemini, optional)

1. Create a free API key at [Google AI Studio](https://aistudio.google.com/app/apikey).
2. Add it to `stripe_keys.json` (ignored by Git; see `stripe_keys.example.json`):

   ```json
   "GEMINI_API_KEY": "AIza...",
   "GEMINI_MODEL": "gemini-2.5-flash"
   ```

3. Run with `--dart-define-from-file=stripe_keys.json` (same command as for Stripe). The chat header then shows *AI · Gemini*; without a key it shows *Offline assistant*.

The client is `lib/services/chat_service.dart` (Gemini `generateContent` REST API, 30 s timeout, last 12 turns sent). The offline engine and the Gemini system prompt are in `lib/services/career_assistant.dart`.

> A key compiled into the app can be extracted from the APK. For a public release, call Gemini from a server (e.g. Cloud Functions) instead.

### Ads (Google test IDs only)

| | Android | iOS |
|---|---|---|
| App ID | `ca-app-pub-3940256099942544~3347511713` | `ca-app-pub-3940256099942544~1458002511` |
| Banner | `ca-app-pub-3940256099942544/9214589741` | `ca-app-pub-3940256099942544/2435281174` |
| Interstitial | `ca-app-pub-3940256099942544/1033173712` | `ca-app-pub-3940256099942544/4411468910` |

The app IDs are declared in `AndroidManifest.xml` and `Info.plist`; the unit IDs are in `lib/services/ad_service.dart`. Ads are disabled on web, desktop and in tests.

### Firebase

Project: `careerverse-3057` (config generated by `flutterfire configure`: `lib/firebase_options.dart`, `android/app/google-services.json`).

- **Auth**: Email/Password and Google providers are enabled in the console. The debug keystore SHA-1/SHA-256 are registered for Google Sign-In on Android; add your release SHA-1 before publishing.
- **Firestore layout**:

  ```
  users/{uid}                       profile, email, updatedAt, fcmToken, platform, pushEnabled
  users/{uid}/results/{id}          lab results (score, answers, time)
  users/{uid}/recommendations/{id}  recommendation history
  users/{uid}/notifications/{id}    notification history
  users/{uid}/transactions/{id}     Stripe payments (write-once), premiumUntil on users/{uid}
  users/{uid}/courses/{labId}       courses read (completedAt)
  ```

- **Security rules** (`firestore.rules`): each user can only read and write their own document and subcollections. Deploy with `firebase deploy --only firestore`.
- **Offline first**: data is written to Hive first, then to Firestore. On login, the local and cloud data are merged (union of results, history and notifications; the newest profile wins), and local data created offline is uploaded.
- **Cloud Messaging**: every device subscribes to the topic `careerverse` and stores its token in `users/{uid}.fcmToken`. To test, open Firebase Console → Messaging → *New campaign* → *Notifications*, target the topic `careerverse` (or a token), and optionally add the custom data `resultId` (opens these results) or `route` (e.g. `/recommendations`). Without data, the tap opens the notifications screen.
- **iOS (manual, needs a Mac)**: run `flutterfire configure` on the Mac to add `GoogleService-Info.plist`, upload an APNs key in Firebase project settings, and enable *Push Notifications* and *Background Modes → Remote notifications* in Xcode. `Info.plist` already contains the background mode and the Google Sign-In URL scheme.

### Stripe (test mode only)

1. Create a free account on https://dashboard.stripe.com and stay in **Test mode**.
2. Copy `stripe_keys.example.json` to `stripe_keys.json` (ignored by Git) and paste your keys from *Developers → API keys*:

   ```json
   {
     "STRIPE_PUBLISHABLE_KEY": "pk_test_...",
     "STRIPE_SECRET_KEY": "sk_test_..."
   }
   ```

3. Run or build with the keys:

   ```bash
   flutter run --dart-define-from-file=stripe_keys.json
   flutter build apk --debug --dart-define-from-file=stripe_keys.json
   ```

4. Pay with the test card `4242 4242 4242 4242`, any future expiry date and any CVC (`4000 0000 0000 0002` tests a declined card). Payments appear in the Stripe dashboard (*Payments*, test mode) and in Firestore.

How it works (`lib/services/payment_service.dart`): the app creates a PaymentIntent with the Stripe API, shows the Payment Sheet, then reads the PaymentIntent back and only grants Premium when its status is `succeeded`. Only `pk_test_` / `sk_test_` keys are accepted, so a real card can never be charged. Without keys (or on desktop) the Premium screen explains that payment is not configured.

> Creating PaymentIntents from the app with a secret key is acceptable only in test mode. A production app must do it on a server (e.g. Cloud Functions) and verify payments with webhooks. The Firestore rules make transactions write-once (no edit or delete).

On iOS, Stripe requires iOS 13+ (already required by Firebase).

### Localization

- Interface strings come from Flutter `gen-l10n`: `lib/l10n/app_en.arb` (template), `app_fr.arb` and `app_ar.arb`. They are accessed with `context.l10n.key`, and plurals use ICU syntax.
- Career content is written in English in `data/catalog.dart`. It is translated through `lib/l10n/content_fr.dart` and `content_ar.dart`, and `setCatalogLanguage()` selects the active catalog.
- Newer careers are self-contained `CareerPack`s in `data/careers/<id>_career.dart` (career, interests, FR/AR translations, courses and examples), registered in `careerPacks` (`catalog.dart`). To add a career, write a pack, add it to `careerPacks` and to an Explore category, and add a test calling `checkCareerPack()`.
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
├── data/careers/               career packs (Flutter, Java, Data, AI, Frontend)
├── data/courses.dart           course for each lab (EN source, code examples, courseFor())
├── data/salary_countries.dart supported country/currency choices
├── models/esco_occupation.dart ESCO search results and occupation profiles
├── l10n/                       ARB files (en/fr/ar), generated AppLocalizations, content and
│                               course translations (courses_fr.dart, courses_ar.dart)
├── models/                     Career, Lab, LabQuestion, LabResult, UserProfile, AppNotification,
│                               PaymentTransaction / PremiumPlan, Course / CourseSection, ChatMessage
├── providers/                  AppState (auth, scoring, recommendations), Theme, Locale,
│                               ChatProvider (conversation, Gemini → offline fallback),
│                               SalaryCurrencyProvider (cached exchange rates)
├── services/                   AuthService (Firebase/local), FirestoreService (cloud sync),
│                               EscoCareerService (dynamic occupation search and profiles),
│                               ExchangeRateService (public EUR exchange rates),
│                               PaymentService (Stripe test mode),
│                               ChatService (Gemini), CareerAssistant (offline chatbot),
│                               NotificationService (FCM + local notifications),
│                               LocalStore (Hive offline database), AdService (AdMob test ads)
├── firebase_options.dart       generated by flutterfire configure
├── screens/                    welcome, login, register, home, explore, career detail, simulation,
│                               results, recommendations, learning path, course, progress, profile,
│                               edit profile, notifications, settings, premium, chat
├── widgets/                    design system (career_ui), ad banner, avatar, form helpers
└── utils/validators.dart
assets/lottie/                  success.json, retry.json (results animations)
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

The tests cover scoring, authentication, persistence, recommendations and next-lab logic. A full widget flow goes from register → lab → results → Next Lab → second lab, and another test covers profile editing, including country selection. The localization tests check translations and Arabic RTL screens. Other tests check Hive persistence, legacy data migration, Lottie files and unavailable interstitials. Firebase sync tests use fake Auth/Firestore services. Premium tests use a fake payment service. Course tests cover three-language course data and the learning path → course → lab flow. Chatbot tests cover offline FR/EN/AR replies, Gemini with mocked HTTP, fallback, persistence and widget flow. ESCO tests cover localized search, profile details, errors and navigation. Currency tests cover EUR defaults, TND conversion, cached exchange rates and profile country persistence.

## Limitations

Sending a push from the app itself requires a server (Cloud Functions need the Blaze plan), so the in-app trigger is a local system notification; real FCM pushes are sent from the Firebase console. Profile photos are stored on the device (Firebase Storage also needs Blaze); Google accounts use their Google photo.
