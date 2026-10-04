import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'CareerVerse'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get loginSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordInfo.
  ///
  /// In en, this message translates to:
  /// **'Accounts are stored on this device. Create a new account if you forgot your password.'**
  String get forgotPasswordInfo;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @googleSignInInfo.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is available in the Android and iOS app.'**
  String get googleSignInInfo;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// No description provided for @validationNameLength.
  ///
  /// In en, this message translates to:
  /// **'Name must contain at least 2 characters'**
  String get validationNameLength;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmail;

  /// No description provided for @validationPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 6 characters'**
  String get validationPasswordLength;

  /// No description provided for @errorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get errorEmailTaken;

  /// No description provided for @errorNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account found for this email.'**
  String get errorNoAccount;

  /// No description provided for @errorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get errorWrongPassword;

  /// No description provided for @notifWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to CareerVerse 🎉'**
  String get notifWelcomeTitle;

  /// No description provided for @notifWelcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile and start your first Career Lab to get personalized recommendations.'**
  String get notifWelcomeBody;

  /// No description provided for @notifResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recommendations are ready!'**
  String get notifResultTitle;

  /// No description provided for @notifResultBody.
  ///
  /// In en, this message translates to:
  /// **'{lab}: {score}%. Top match: {career} ({topScore}%).'**
  String notifResultBody(String lab, int score, String career, int topScore);

  /// No description provided for @notifNewBest.
  ///
  /// In en, this message translates to:
  /// **'New personal best!'**
  String get notifNewBest;

  /// No description provided for @reasonScored.
  ///
  /// In en, this message translates to:
  /// **'You scored {score}% on {done}/{total} labs.'**
  String reasonScored(int score, int done, int total);

  /// No description provided for @reasonStrongest.
  ///
  /// In en, this message translates to:
  /// **'Strongest skill: {skill}.'**
  String reasonStrongest(String skill);

  /// No description provided for @reasonNotTested.
  ///
  /// In en, this message translates to:
  /// **'Not tested yet: try a lab to confirm this match.'**
  String get reasonNotTested;

  /// No description provided for @reasonInterests.
  ///
  /// In en, this message translates to:
  /// **'Matches your interests: {interests}.'**
  String reasonInterests(String interests);

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} h ago'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} d ago'**
  String timeDaysAgo(int count);

  /// No description provided for @acceptTermsError.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue.'**
  String get acceptTermsError;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get createYourAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start exploring careers through real simulations'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms of use and privacy policy'**
  String get acceptTerms;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Explore  ·  Learn  ·  Build\nYour Future'**
  String get welcomeTagline;

  /// No description provided for @cybersecurity.
  ///
  /// In en, this message translates to:
  /// **'Cybersecurity'**
  String get cybersecurity;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @labs.
  ///
  /// In en, this message translates to:
  /// **'Labs'**
  String get labs;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @helloName.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name} 👋'**
  String helloName(String name);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore your career journey'**
  String get homeSubtitle;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for careers, labs, or skills...'**
  String get homeSearchHint;

  /// No description provided for @yourAiProfile.
  ///
  /// In en, this message translates to:
  /// **'Your AI Profile'**
  String get yourAiProfile;

  /// No description provided for @labsPracticed.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} labs · {minutes} min practiced'**
  String labsPracticed(int done, int total, int minutes);

  /// No description provided for @viewProgress.
  ///
  /// In en, this message translates to:
  /// **'View progress  →'**
  String get viewProgress;

  /// No description provided for @avg.
  ///
  /// In en, this message translates to:
  /// **'avg'**
  String get avg;

  /// No description provided for @startFirstLab.
  ///
  /// In en, this message translates to:
  /// **'Start your first lab'**
  String get startFirstLab;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get upNext;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick access'**
  String get quickAccess;

  /// No description provided for @aiMatch.
  ///
  /// In en, this message translates to:
  /// **'AI Match'**
  String get aiMatch;

  /// No description provided for @path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get path;

  /// No description provided for @recommendedCareers.
  ///
  /// In en, this message translates to:
  /// **'Recommended careers'**
  String get recommendedCareers;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get recentActivity;

  /// No description provided for @noActivity.
  ///
  /// In en, this message translates to:
  /// **'No lab completed yet. Your scores and recommendations will appear here.'**
  String get noActivity;

  /// No description provided for @basedOnLabs.
  ///
  /// In en, this message translates to:
  /// **'Based on your labs'**
  String get basedOnLabs;

  /// No description provided for @basedOnInterests.
  ///
  /// In en, this message translates to:
  /// **'Based on interests'**
  String get basedOnInterests;

  /// No description provided for @careerLabs.
  ///
  /// In en, this message translates to:
  /// **'Career Labs'**
  String get careerLabs;

  /// No description provided for @exploreCareers.
  ///
  /// In en, this message translates to:
  /// **'Explore careers'**
  String get exploreCareers;

  /// No description provided for @aiRecommendations.
  ///
  /// In en, this message translates to:
  /// **'AI Recommendations'**
  String get aiRecommendations;

  /// No description provided for @learningPath.
  ///
  /// In en, this message translates to:
  /// **'Learning path'**
  String get learningPath;

  /// No description provided for @myProgress.
  ///
  /// In en, this message translates to:
  /// **'My progress'**
  String get myProgress;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutText.
  ///
  /// In en, this message translates to:
  /// **'Discover careers through hands-on simulations.'**
  String get aboutText;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @exploreCareersTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Careers'**
  String get exploreCareersTitle;

  /// No description provided for @exploreSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search careers, tools or labs...'**
  String get exploreSearchHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @categoryInfrastructure.
  ///
  /// In en, this message translates to:
  /// **'Infrastructure'**
  String get categoryInfrastructure;

  /// No description provided for @categoryDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get categoryDevelopment;

  /// No description provided for @categorySecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get categorySecurity;

  /// No description provided for @categoryMobileWeb.
  ///
  /// In en, this message translates to:
  /// **'Mobile & Web'**
  String get categoryMobileWeb;

  /// No description provided for @categoryDataAi.
  ///
  /// In en, this message translates to:
  /// **'Data & AI'**
  String get categoryDataAi;

  /// No description provided for @noCareerFound.
  ///
  /// In en, this message translates to:
  /// **'No career found'**
  String get noCareerFound;

  /// No description provided for @noCareerFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'Try another keyword, e.g. \"AWS\" or \"Docker\".'**
  String get noCareerFoundMessage;

  /// No description provided for @labsProgress.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} labs'**
  String labsProgress(int done, int total);

  /// No description provided for @toDo.
  ///
  /// In en, this message translates to:
  /// **'To do'**
  String get toDo;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @labsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} labs'**
  String labsCount(int count);

  /// No description provided for @completedCount.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} completed'**
  String completedCount(int done, int total);

  /// No description provided for @noLabHere.
  ///
  /// In en, this message translates to:
  /// **'No lab here'**
  String get noLabHere;

  /// No description provided for @noLabHereMessage.
  ///
  /// In en, this message translates to:
  /// **'Change the filters to see more labs.'**
  String get noLabHereMessage;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @labsCompletedOf.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} labs completed'**
  String labsCompletedOf(int done, int total);

  /// No description provided for @match.
  ///
  /// In en, this message translates to:
  /// **'match'**
  String get match;

  /// No description provided for @salaryFrance.
  ///
  /// In en, this message translates to:
  /// **'Salary (France)'**
  String get salaryFrance;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @aboutTheJob.
  ///
  /// In en, this message translates to:
  /// **'About the job'**
  String get aboutTheJob;

  /// No description provided for @typicalDay.
  ///
  /// In en, this message translates to:
  /// **'A typical day'**
  String get typicalDay;

  /// No description provided for @toolsYouWillUse.
  ///
  /// In en, this message translates to:
  /// **'Tools you will use'**
  String get toolsYouWillUse;

  /// No description provided for @replayFirstLab.
  ///
  /// In en, this message translates to:
  /// **'Replay first lab'**
  String get replayFirstLab;

  /// No description provided for @startLabNamed.
  ///
  /// In en, this message translates to:
  /// **'Start lab: {title}'**
  String startLabNamed(String title);

  /// No description provided for @continueLabNamed.
  ///
  /// In en, this message translates to:
  /// **'Continue: {title}'**
  String continueLabNamed(String title);

  /// No description provided for @tasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 task} other{{count} tasks}}'**
  String tasksCount(int count);

  /// No description provided for @attemptsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 attempt} other{{count} attempts}}'**
  String attemptsCount(int count);

  /// No description provided for @leaveLabTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave the lab?'**
  String get leaveLabTitle;

  /// No description provided for @leaveLabMessage.
  ///
  /// In en, this message translates to:
  /// **'Your progress in this lab will be lost.'**
  String get leaveLabMessage;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @questionOf.
  ///
  /// In en, this message translates to:
  /// **'Question {index} of {total}'**
  String questionOf(int index, int total);

  /// No description provided for @correctCount.
  ///
  /// In en, this message translates to:
  /// **'{count} correct'**
  String correctCount(int count);

  /// No description provided for @selectAnswers.
  ///
  /// In en, this message translates to:
  /// **'Select {count} answers'**
  String selectAnswers(int count);

  /// No description provided for @checkAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get checkAnswer;

  /// No description provided for @finishLab.
  ///
  /// In en, this message translates to:
  /// **'Finish lab'**
  String get finishLab;

  /// No description provided for @nextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get nextQuestion;

  /// No description provided for @scenario.
  ///
  /// In en, this message translates to:
  /// **'Scenario'**
  String get scenario;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct!'**
  String get correct;

  /// No description provided for @notQuite.
  ///
  /// In en, this message translates to:
  /// **'Not quite'**
  String get notQuite;

  /// No description provided for @resultNotFound.
  ///
  /// In en, this message translates to:
  /// **'Result not found'**
  String get resultNotFound;

  /// No description provided for @resultNotFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'This result is no longer available.'**
  String get resultNotFoundMessage;

  /// No description provided for @labResults.
  ///
  /// In en, this message translates to:
  /// **'Lab Results'**
  String get labResults;

  /// No description provided for @labCompleted.
  ///
  /// In en, this message translates to:
  /// **'Lab Completed!'**
  String get labCompleted;

  /// No description provided for @keepPracticing.
  ///
  /// In en, this message translates to:
  /// **'Keep practicing!'**
  String get keepPracticing;

  /// No description provided for @overall.
  ///
  /// In en, this message translates to:
  /// **'overall'**
  String get overall;

  /// No description provided for @correctAnswers.
  ///
  /// In en, this message translates to:
  /// **'Correct answers'**
  String get correctAnswers;

  /// No description provided for @timeTarget.
  ///
  /// In en, this message translates to:
  /// **'Time (target {time})'**
  String timeTarget(String time);

  /// No description provided for @accuracyWeight.
  ///
  /// In en, this message translates to:
  /// **'Accuracy (80%)'**
  String get accuracyWeight;

  /// No description provided for @speedWeight.
  ///
  /// In en, this message translates to:
  /// **'Speed (20%)'**
  String get speedWeight;

  /// No description provided for @newPersonalBest.
  ///
  /// In en, this message translates to:
  /// **'New personal best! +{gain} pts vs {previous}%.'**
  String newPersonalBest(int gain, int previous);

  /// No description provided for @stillBest.
  ///
  /// In en, this message translates to:
  /// **'Your best on this lab is still {best}%.'**
  String stillBest(int best);

  /// No description provided for @skillsBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Skills breakdown'**
  String get skillsBreakdown;

  /// No description provided for @matchNow.
  ///
  /// In en, this message translates to:
  /// **'{career} match is now {score}%. {done}/{total} labs completed in this career.'**
  String matchNow(String career, int score, int done, int total);

  /// No description provided for @nextLabNamed.
  ///
  /// In en, this message translates to:
  /// **'Next Lab: {title}'**
  String nextLabNamed(String title);

  /// No description provided for @tryCareerLab.
  ///
  /// In en, this message translates to:
  /// **'Try {career}: {lab}'**
  String tryCareerLab(String career, String lab);

  /// No description provided for @viewRecommendations.
  ///
  /// In en, this message translates to:
  /// **'View recommendations'**
  String get viewRecommendations;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @matches.
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get matches;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;

  /// No description provided for @bestMatch.
  ///
  /// In en, this message translates to:
  /// **'Best match'**
  String get bestMatch;

  /// No description provided for @matchesInterestsOnly.
  ///
  /// In en, this message translates to:
  /// **'These matches are based only on your interests. Complete labs to get recommendations based on real performance.'**
  String get matchesInterestsOnly;

  /// No description provided for @matchesAnalysis.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Analysis of 1 tested career} other{Analysis of {count} tested careers}}: match = 75% lab performance + 25% interests.'**
  String matchesAnalysis(int count);

  /// No description provided for @allMatches.
  ///
  /// In en, this message translates to:
  /// **'All matches'**
  String get allMatches;

  /// No description provided for @recommendationHistory.
  ///
  /// In en, this message translates to:
  /// **'Recommendation history'**
  String get recommendationHistory;

  /// No description provided for @noRecommendationYet.
  ///
  /// In en, this message translates to:
  /// **'No recommendation yet'**
  String get noRecommendationYet;

  /// No description provided for @noRecommendationYetMessage.
  ///
  /// In en, this message translates to:
  /// **'A new recommendation is generated after every completed lab.'**
  String get noRecommendationYetMessage;

  /// No description provided for @learningPathTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Path'**
  String get learningPathTitle;

  /// No description provided for @becomeCareer.
  ///
  /// In en, this message translates to:
  /// **'Become a {career}'**
  String becomeCareer(String career);

  /// No description provided for @pathSteps.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} steps · ~{minutes} min total'**
  String pathSteps(int done, int total, int minutes);

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @startThePath.
  ///
  /// In en, this message translates to:
  /// **'Start the path'**
  String get startThePath;

  /// No description provided for @pathCompleted.
  ///
  /// In en, this message translates to:
  /// **'Path completed! Your average on {career} is {average}%. Replay labs to improve it.'**
  String pathCompleted(String career, int average);

  /// No description provided for @myProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'My Progress'**
  String get myProgressTitle;

  /// No description provided for @labsDone.
  ///
  /// In en, this message translates to:
  /// **'Labs done'**
  String get labsDone;

  /// No description provided for @avgScore.
  ///
  /// In en, this message translates to:
  /// **'Avg score'**
  String get avgScore;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @careerProgress.
  ///
  /// In en, this message translates to:
  /// **'Career progress'**
  String get careerProgress;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @noSkillsYet.
  ///
  /// In en, this message translates to:
  /// **'Complete a lab to measure your skills.'**
  String get noSkillsYet;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @noAttemptsYet.
  ///
  /// In en, this message translates to:
  /// **'No attempts yet'**
  String get noAttemptsYet;

  /// No description provided for @noAttemptsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'Your completed labs will be listed here.'**
  String get noAttemptsYetMessage;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllRead;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @noNotificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'You will be notified when your lab results and recommendations are ready.'**
  String get noNotificationsMessage;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @profileCompleteness.
  ///
  /// In en, this message translates to:
  /// **'Profile completeness'**
  String get profileCompleteness;

  /// No description provided for @completeProfileHint.
  ///
  /// In en, this message translates to:
  /// **'A complete profile improves your recommendations.'**
  String get completeProfileHint;

  /// No description provided for @topMatch.
  ///
  /// In en, this message translates to:
  /// **'Top match'**
  String get topMatch;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @studyLevel.
  ///
  /// In en, this message translates to:
  /// **'Study level'**
  String get studyLevel;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @specialty.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get specialty;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @interests.
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// No description provided for @noInterestsYet.
  ///
  /// In en, this message translates to:
  /// **'No interests yet. Add some to personalize your matches.'**
  String get noInterestsYet;

  /// No description provided for @topSkills.
  ///
  /// In en, this message translates to:
  /// **'Top skills'**
  String get topSkills;

  /// No description provided for @noTopSkills.
  ///
  /// In en, this message translates to:
  /// **'Complete labs to reveal your strongest skills.'**
  String get noTopSkills;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String memberSince(String date);

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @photoLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the photo: {error}'**
  String photoLoadError(String error);

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @universitySchool.
  ///
  /// In en, this message translates to:
  /// **'University / School'**
  String get universitySchool;

  /// No description provided for @specialtyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Software engineering'**
  String get specialtyHint;

  /// No description provided for @bioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your goals'**
  String get bioHint;

  /// No description provided for @interestsHint.
  ///
  /// In en, this message translates to:
  /// **'Used by the AI to compute your career matches.'**
  String get interestsHint;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset my progress'**
  String get resetProgress;

  /// No description provided for @resetProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delete all lab results and history'**
  String get resetProgressSubtitle;

  /// No description provided for @resetProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset progress?'**
  String get resetProgressTitle;

  /// No description provided for @resetProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'All your lab results and recommendations will be deleted.'**
  String get resetProgressMessage;

  /// No description provided for @progressReset.
  ///
  /// In en, this message translates to:
  /// **'Progress reset'**
  String get progressReset;

  /// No description provided for @googleSignInUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is not available right now. Please use your email.'**
  String get googleSignInUnavailable;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'This password is too weak.'**
  String get errorWeakPassword;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get errorNetwork;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get errorTooManyRequests;

  /// No description provided for @errorProviderDisabled.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled for the app.'**
  String get errorProviderDisabled;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @passwordResetEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address above, then tap “Forgot password?” again.'**
  String get passwordResetEnterEmail;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'A password reset link was sent to {email}.'**
  String passwordResetSent(String email);

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Alerts when your results and recommendations are ready'**
  String get pushNotificationsSubtitle;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'CareerVerse Premium'**
  String get premiumTitle;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock every Advanced lab and go further in your orientation.'**
  String get premiumSubtitle;

  /// No description provided for @premiumBenefitLabs.
  ///
  /// In en, this message translates to:
  /// **'All Advanced labs (expert scenarios)'**
  String get premiumBenefitLabs;

  /// No description provided for @premiumBenefitSkills.
  ///
  /// In en, this message translates to:
  /// **'Harder questions for a sharper skill analysis'**
  String get premiumBenefitSkills;

  /// No description provided for @premiumBenefitSync.
  ///
  /// In en, this message translates to:
  /// **'Access on all your devices with your account'**
  String get premiumBenefitSync;

  /// No description provided for @premiumPrice.
  ///
  /// In en, this message translates to:
  /// **'{price} / {days} days'**
  String premiumPrice(String price, int days);

  /// No description provided for @premiumBuy.
  ///
  /// In en, this message translates to:
  /// **'Subscribe for {price}'**
  String premiumBuy(String price);

  /// No description provided for @premiumExtend.
  ///
  /// In en, this message translates to:
  /// **'Extend for {price}'**
  String premiumExtend(String price);

  /// No description provided for @premiumActiveUntil.
  ///
  /// In en, this message translates to:
  /// **'Premium active until {date}'**
  String premiumActiveUntil(String date);

  /// No description provided for @premiumExpired.
  ///
  /// In en, this message translates to:
  /// **'Premium expired on {date}'**
  String premiumExpired(String date);

  /// No description provided for @premiumFree.
  ///
  /// In en, this message translates to:
  /// **'Free plan'**
  String get premiumFree;

  /// No description provided for @premiumTestMode.
  ///
  /// In en, this message translates to:
  /// **'Stripe test mode: no real money is charged.'**
  String get premiumTestMode;

  /// No description provided for @premiumTestCard.
  ///
  /// In en, this message translates to:
  /// **'Test card: 4242 4242 4242 4242, any future date, any CVC.'**
  String get premiumTestCard;

  /// No description provided for @premiumSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed! Premium is active until {date}.'**
  String premiumSuccess(String date);

  /// No description provided for @paymentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled.'**
  String get paymentCancelled;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {message}'**
  String paymentFailed(String message);

  /// No description provided for @paymentNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Payments are not available on this build (missing Stripe test keys or unsupported platform).'**
  String get paymentNotConfigured;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get transactionHistory;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.'**
  String get noTransactions;

  /// No description provided for @premiumLabTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium lab'**
  String get premiumLabTitle;

  /// No description provided for @premiumLabMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" is an Advanced lab. Subscribe to Premium to unlock it.'**
  String premiumLabMessage(String title);

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Premium'**
  String get unlockPremium;

  /// No description provided for @notifPremiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Premium!'**
  String get notifPremiumTitle;

  /// No description provided for @notifPremiumBody.
  ///
  /// In en, this message translates to:
  /// **'Advanced labs are unlocked until {date}.'**
  String notifPremiumBody(String date);

  /// No description provided for @courseLabel.
  ///
  /// In en, this message translates to:
  /// **'Course'**
  String get courseLabel;

  /// No description provided for @labLabel.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get labLabel;

  /// No description provided for @lessonProgress.
  ///
  /// In en, this message translates to:
  /// **'Lesson {current}/{total}'**
  String lessonProgress(int current, int total);

  /// No description provided for @keyPoints.
  ///
  /// In en, this message translates to:
  /// **'Key points'**
  String get keyPoints;

  /// No description provided for @exampleLabel.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get exampleLabel;

  /// No description provided for @takeaways.
  ///
  /// In en, this message translates to:
  /// **'Key takeaways'**
  String get takeaways;

  /// No description provided for @summaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryLabel;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finishCourse.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishCourse;

  /// No description provided for @finishAndStartLab.
  ///
  /// In en, this message translates to:
  /// **'Finish and start the lab'**
  String get finishAndStartLab;

  /// No description provided for @readCourseNamed.
  ///
  /// In en, this message translates to:
  /// **'Read the course: {title}'**
  String readCourseNamed(String title);

  /// No description provided for @courseCompleted.
  ///
  /// In en, this message translates to:
  /// **'Course completed'**
  String get courseCompleted;

  /// No description provided for @reviewCourse.
  ///
  /// In en, this message translates to:
  /// **'Review the course'**
  String get reviewCourse;

  /// No description provided for @readCourse.
  ///
  /// In en, this message translates to:
  /// **'Read the course'**
  String get readCourse;

  /// No description provided for @courseRead.
  ///
  /// In en, this message translates to:
  /// **'Course read'**
  String get courseRead;

  /// No description provided for @courseThenLab.
  ///
  /// In en, this message translates to:
  /// **'Each step: a course with explanations, then a hands-on lab to practise.'**
  String get courseThenLab;

  /// No description provided for @coursesDone.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} courses read'**
  String coursesDone(int done, int total);

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'CareerVerse Assistant'**
  String get chatTitle;

  /// No description provided for @chatShort.
  ///
  /// In en, this message translates to:
  /// **'Assistant'**
  String get chatShort;

  /// No description provided for @chatModeAi.
  ///
  /// In en, this message translates to:
  /// **'AI · Gemini'**
  String get chatModeAi;

  /// No description provided for @chatModeLocal.
  ///
  /// In en, this message translates to:
  /// **'Offline assistant'**
  String get chatModeLocal;

  /// No description provided for @chatHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about careers, labs, your progress…'**
  String get chatHint;

  /// No description provided for @chatWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}! I\'m your career assistant. Ask me which career suits you, what a job pays, or what to do next.'**
  String chatWelcome(String name);

  /// No description provided for @chatSuggestRecommend.
  ///
  /// In en, this message translates to:
  /// **'Which career suits me?'**
  String get chatSuggestRecommend;

  /// No description provided for @chatSuggestNext.
  ///
  /// In en, this message translates to:
  /// **'What should I do next?'**
  String get chatSuggestNext;

  /// No description provided for @chatSuggestProgress.
  ///
  /// In en, this message translates to:
  /// **'How am I doing?'**
  String get chatSuggestProgress;

  /// No description provided for @chatSuggestCareer.
  ///
  /// In en, this message translates to:
  /// **'Tell me about the Data Scientist job'**
  String get chatSuggestCareer;

  /// No description provided for @chatClear.
  ///
  /// In en, this message translates to:
  /// **'Clear conversation'**
  String get chatClear;

  /// No description provided for @chatThinking.
  ///
  /// In en, this message translates to:
  /// **'Thinking…'**
  String get chatThinking;

  /// No description provided for @chatFallbackNotice.
  ///
  /// In en, this message translates to:
  /// **'Gemini is unavailable: answer from the offline assistant.'**
  String get chatFallbackNotice;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @chatOpenCareer.
  ///
  /// In en, this message translates to:
  /// **'Open {career}'**
  String chatOpenCareer(String career);

  /// No description provided for @chatStartLab.
  ///
  /// In en, this message translates to:
  /// **'Start: {lab}'**
  String chatStartLab(String lab);

  /// No description provided for @chatReadCourse.
  ///
  /// In en, this message translates to:
  /// **'Course: {course}'**
  String chatReadCourse(String course);

  /// No description provided for @chatOpenRecommendations.
  ///
  /// In en, this message translates to:
  /// **'My recommendations'**
  String get chatOpenRecommendations;

  /// No description provided for @chatOpenPremium.
  ///
  /// In en, this message translates to:
  /// **'See Premium'**
  String get chatOpenPremium;

  /// No description provided for @chatLocalGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello {name}! 👋 How can I help you with your career orientation?'**
  String chatLocalGreeting(String name);

  /// No description provided for @chatLocalHelp.
  ///
  /// In en, this message translates to:
  /// **'I can recommend careers for your profile, describe a career (salary, skills, studies, outlook), tell you how you are doing and suggest your next course or lab. Try one of the suggestions below.'**
  String get chatLocalHelp;

  /// No description provided for @chatLocalRecommendIntro.
  ///
  /// In en, this message translates to:
  /// **'Based on your interests and lab results, here are your best matches:'**
  String get chatLocalRecommendIntro;

  /// No description provided for @chatLocalRecommendLine.
  ///
  /// In en, this message translates to:
  /// **'{rank}. {career}: {score}% match'**
  String chatLocalRecommendLine(int rank, String career, int score);

  /// No description provided for @chatLocalRecommendTip.
  ///
  /// In en, this message translates to:
  /// **'Do a lab in each career to make these results more accurate.'**
  String get chatLocalRecommendTip;

  /// No description provided for @chatLocalProgress.
  ///
  /// In en, this message translates to:
  /// **'You have completed {done} of {total} labs ({minutes} min of practice).'**
  String chatLocalProgress(int done, int total, int minutes);

  /// No description provided for @chatLocalAverage.
  ///
  /// In en, this message translates to:
  /// **'Your average score is {score}%.'**
  String chatLocalAverage(int score);

  /// No description provided for @chatLocalStrongest.
  ///
  /// In en, this message translates to:
  /// **'Your strongest skill: {skill}.'**
  String chatLocalStrongest(String skill);

  /// No description provided for @chatLocalNoProgress.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t completed a lab yet. Let\'s start with one!'**
  String get chatLocalNoProgress;

  /// No description provided for @chatLocalNextCourse.
  ///
  /// In en, this message translates to:
  /// **'Next step in {career}: read the course “{course}”, then do its lab.'**
  String chatLocalNextCourse(String course, String career);

  /// No description provided for @chatLocalNextLab.
  ///
  /// In en, this message translates to:
  /// **'Next step in {career}: start the lab “{lab}”.'**
  String chatLocalNextLab(String lab, String career);

  /// No description provided for @chatLocalPathDone.
  ///
  /// In en, this message translates to:
  /// **'You have completed every lab of {career}! Try another career to compare.'**
  String chatLocalPathDone(String career);

  /// No description provided for @chatLocalSalary.
  ///
  /// In en, this message translates to:
  /// **'Average salary for {career}: {salary}.'**
  String chatLocalSalary(String career, String salary);

  /// No description provided for @chatLocalTools.
  ///
  /// In en, this message translates to:
  /// **'Key tools: {tools}.'**
  String chatLocalTools(String tools);

  /// No description provided for @chatLocalSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills tested in the labs: {skills}.'**
  String chatLocalSkills(String skills);

  /// No description provided for @chatLocalEducation.
  ///
  /// In en, this message translates to:
  /// **'Studies: {education}'**
  String chatLocalEducation(String education);

  /// No description provided for @chatLocalOutlook.
  ///
  /// In en, this message translates to:
  /// **'Outlook: {outlook}'**
  String chatLocalOutlook(String outlook);

  /// No description provided for @chatLocalLabs.
  ///
  /// In en, this message translates to:
  /// **'{count} labs to practise (Beginner → Advanced), each with a course.'**
  String chatLocalLabs(int count);

  /// No description provided for @chatLocalDaily.
  ///
  /// In en, this message translates to:
  /// **'A typical day: {tasks}.'**
  String chatLocalDaily(String tasks);

  /// No description provided for @chatLocalCareerProgress.
  ///
  /// In en, this message translates to:
  /// **'Your progress: {done}/{total} labs, average {score}%.'**
  String chatLocalCareerProgress(int done, int total, int score);

  /// No description provided for @chatLocalPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium unlocks the Advanced labs of every career. Payment uses Stripe in test mode (card 4242 4242 4242 4242, no real charge).'**
  String get chatLocalPremium;

  /// No description provided for @chatLocalPremiumActive.
  ///
  /// In en, this message translates to:
  /// **'Your Premium is active: all Advanced labs are unlocked.'**
  String get chatLocalPremiumActive;

  /// No description provided for @chatLocalCareersList.
  ///
  /// In en, this message translates to:
  /// **'CareerVerse covers {count} careers: {list}.'**
  String chatLocalCareersList(int count, String list);

  /// No description provided for @chatLocalThanks.
  ///
  /// In en, this message translates to:
  /// **'You\'re welcome! Good luck with your orientation 🚀'**
  String get chatLocalThanks;

  /// No description provided for @chatLocalUnknown.
  ///
  /// In en, this message translates to:
  /// **'I\'m not sure I understood. Ask me about a career (for example Java, Data Science or Cloud), your progress or what to do next.'**
  String get chatLocalUnknown;

  /// No description provided for @escoMoreCareers.
  ///
  /// In en, this message translates to:
  /// **'More careers from ESCO'**
  String get escoMoreCareers;

  /// No description provided for @escoMoreCareersDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover occupations from the European Commission\'s multilingual ESCO catalogue.'**
  String get escoMoreCareersDescription;

  /// No description provided for @escoRemoteSource.
  ///
  /// In en, this message translates to:
  /// **'European Commission · ESCO'**
  String get escoRemoteSource;

  /// No description provided for @escoNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Could not load careers from ESCO. Check your connection and try again.'**
  String get escoNetworkError;

  /// No description provided for @escoRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get escoRetry;

  /// No description provided for @escoNoResults.
  ///
  /// In en, this message translates to:
  /// **'No additional careers found. Try another search.'**
  String get escoNoResults;

  /// No description provided for @escoNoCareerDescription.
  ///
  /// In en, this message translates to:
  /// **'No description is available for this occupation.'**
  String get escoNoCareerDescription;

  /// No description provided for @escoCareerSkills.
  ///
  /// In en, this message translates to:
  /// **'Essential skills'**
  String get escoCareerSkills;

  /// No description provided for @escoOptionalCareerSkills.
  ///
  /// In en, this message translates to:
  /// **'Optional skills'**
  String get escoOptionalCareerSkills;

  /// No description provided for @escoCareerLabsNote.
  ///
  /// In en, this message translates to:
  /// **'Courses and interactive labs are currently available for the 9 CareerVerse careers in the local catalogue.'**
  String get escoCareerLabsNote;

  /// No description provided for @escoLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more careers'**
  String get escoLoadMore;

  /// No description provided for @escoOccupationCode.
  ///
  /// In en, this message translates to:
  /// **'ESCO code: {code}'**
  String escoOccupationCode(String code);

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @noCountrySelected.
  ///
  /// In en, this message translates to:
  /// **'No country selected (show EUR)'**
  String get noCountrySelected;

  /// No description provided for @salaryConverted.
  ///
  /// In en, this message translates to:
  /// **'Converted estimate · {country}'**
  String salaryConverted(String country);

  /// No description provided for @salaryConvertedNote.
  ///
  /// In en, this message translates to:
  /// **'Converted from France estimates; not local-market data.'**
  String get salaryConvertedNote;

  /// No description provided for @salaryRange.
  ///
  /// In en, this message translates to:
  /// **'{min} – {max} {currency} / {period}'**
  String salaryRange(String min, String max, String currency, String period);

  /// No description provided for @salaryPerYear.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get salaryPerYear;

  /// No description provided for @exchangeRateLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading exchange rate…'**
  String get exchangeRateLoading;

  /// No description provided for @exchangeRateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Exchange rate unavailable'**
  String get exchangeRateUnavailable;

  /// No description provided for @countryTunisia.
  ///
  /// In en, this message translates to:
  /// **'Tunisia'**
  String get countryTunisia;

  /// No description provided for @countryAlgeria.
  ///
  /// In en, this message translates to:
  /// **'Algeria'**
  String get countryAlgeria;

  /// No description provided for @countryMorocco.
  ///
  /// In en, this message translates to:
  /// **'Morocco'**
  String get countryMorocco;

  /// No description provided for @countryEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get countryEgypt;

  /// No description provided for @countryFrance.
  ///
  /// In en, this message translates to:
  /// **'France'**
  String get countryFrance;

  /// No description provided for @countryGermany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get countryGermany;

  /// No description provided for @countryUnitedStates.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get countryUnitedStates;

  /// No description provided for @countryCanada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get countryCanada;

  /// No description provided for @countryUnitedKingdom.
  ///
  /// In en, this message translates to:
  /// **'United Kingdom'**
  String get countryUnitedKingdom;

  /// No description provided for @countrySwitzerland.
  ///
  /// In en, this message translates to:
  /// **'Switzerland'**
  String get countrySwitzerland;

  /// No description provided for @countryUae.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates'**
  String get countryUae;

  /// No description provided for @countrySaudiArabia.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get countrySaudiArabia;

  /// No description provided for @countryIndia.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get countryIndia;

  /// No description provided for @countryJapan.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get countryJapan;

  /// No description provided for @countryAustralia.
  ///
  /// In en, this message translates to:
  /// **'Australia'**
  String get countryAustralia;

  /// No description provided for @countrySenegal.
  ///
  /// In en, this message translates to:
  /// **'Senegal'**
  String get countrySenegal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
