// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'CareerVerse';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get loginSubtitle => 'Sign in to continue your journey';

  @override
  String get emailAddress => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get forgotPasswordInfo =>
      'Accounts are stored on this device. Create a new account if you forgot your password.';

  @override
  String get logIn => 'Log In';

  @override
  String get or => 'or';

  @override
  String get googleSignInInfo =>
      'Google Sign-In is available in the Android and iOS app.';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationNameLength => 'Name must contain at least 2 characters';

  @override
  String get validationEmail => 'Enter a valid email address';

  @override
  String get validationPasswordLength =>
      'Password must contain at least 6 characters';

  @override
  String get errorEmailTaken => 'An account already exists with this email.';

  @override
  String get errorNoAccount => 'No account found for this email.';

  @override
  String get errorWrongPassword => 'Incorrect password.';

  @override
  String get notifWelcomeTitle => 'Welcome to CareerVerse 🎉';

  @override
  String get notifWelcomeBody =>
      'Complete your profile and start your first Career Lab to get personalized recommendations.';

  @override
  String get notifResultTitle => 'Your recommendations are ready!';

  @override
  String notifResultBody(String lab, int score, String career, int topScore) {
    return '$lab: $score%. Top match: $career ($topScore%).';
  }

  @override
  String get notifNewBest => 'New personal best!';

  @override
  String reasonScored(int score, int done, int total) {
    return 'You scored $score% on $done/$total labs.';
  }

  @override
  String reasonStrongest(String skill) {
    return 'Strongest skill: $skill.';
  }

  @override
  String get reasonNotTested =>
      'Not tested yet: try a lab to confirm this match.';

  @override
  String reasonInterests(String interests) {
    return 'Matches your interests: $interests.';
  }

  @override
  String get timeJustNow => 'just now';

  @override
  String timeMinutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count h ago';
  }

  @override
  String timeDaysAgo(int count) {
    return '$count d ago';
  }

  @override
  String get acceptTermsError => 'Please accept the terms to continue.';

  @override
  String get createYourAccount => 'Create your account';

  @override
  String get registerSubtitle =>
      'Start exploring careers through real simulations';

  @override
  String get fullName => 'Full name';

  @override
  String get passwordHint => 'At least 6 characters';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get acceptTerms => 'I accept the terms of use and privacy policy';

  @override
  String get createAccount => 'Create account';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get welcomeTagline => 'Explore  ·  Learn  ·  Build\nYour Future';

  @override
  String get cybersecurity => 'Cybersecurity';

  @override
  String get getStarted => 'Get Started';

  @override
  String get home => 'Home';

  @override
  String get labs => 'Labs';

  @override
  String get explore => 'Explore';

  @override
  String get progress => 'Progress';

  @override
  String get profile => 'Profile';

  @override
  String helloName(String name) {
    return 'Hello, $name 👋';
  }

  @override
  String get homeSubtitle => 'Explore your career journey';

  @override
  String get homeSearchHint => 'Search for careers, labs, or skills...';

  @override
  String get yourAiProfile => 'Your AI Profile';

  @override
  String labsPracticed(int done, int total, int minutes) {
    return '$done/$total labs · $minutes min practiced';
  }

  @override
  String get viewProgress => 'View progress  →';

  @override
  String get avg => 'avg';

  @override
  String get startFirstLab => 'Start your first lab';

  @override
  String get upNext => 'Up next';

  @override
  String get quickAccess => 'Quick access';

  @override
  String get aiMatch => 'AI Match';

  @override
  String get path => 'Path';

  @override
  String get recommendedCareers => 'Recommended careers';

  @override
  String get seeAll => 'See all';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get noActivity =>
      'No lab completed yet. Your scores and recommendations will appear here.';

  @override
  String get basedOnLabs => 'Based on your labs';

  @override
  String get basedOnInterests => 'Based on interests';

  @override
  String get careerLabs => 'Career Labs';

  @override
  String get exploreCareers => 'Explore careers';

  @override
  String get aiRecommendations => 'AI Recommendations';

  @override
  String get learningPath => 'Learning path';

  @override
  String get myProgress => 'My progress';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get aboutText => 'Discover careers through hands-on simulations.';

  @override
  String get logout => 'Log out';

  @override
  String get exploreCareersTitle => 'Explore Careers';

  @override
  String get exploreSearchHint => 'Search careers, tools or labs...';

  @override
  String get all => 'All';

  @override
  String get categoryInfrastructure => 'Infrastructure';

  @override
  String get categoryDevelopment => 'Development';

  @override
  String get categorySecurity => 'Security';

  @override
  String get categoryMobileWeb => 'Mobile & Web';

  @override
  String get categoryDataAi => 'Data & AI';

  @override
  String get noCareerFound => 'No career found';

  @override
  String get noCareerFoundMessage =>
      'Try another keyword, e.g. \"AWS\" or \"Docker\".';

  @override
  String labsProgress(int done, int total) {
    return '$done/$total labs';
  }

  @override
  String get toDo => 'To do';

  @override
  String get completed => 'Completed';

  @override
  String labsCount(int count) {
    return '$count labs';
  }

  @override
  String completedCount(int done, int total) {
    return '$done/$total completed';
  }

  @override
  String get noLabHere => 'No lab here';

  @override
  String get noLabHereMessage => 'Change the filters to see more labs.';

  @override
  String get start => 'Start';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String labsCompletedOf(int done, int total) {
    return '$done/$total labs completed';
  }

  @override
  String get match => 'match';

  @override
  String get salaryFrance => 'Salary (France)';

  @override
  String get education => 'Education';

  @override
  String get aboutTheJob => 'About the job';

  @override
  String get typicalDay => 'A typical day';

  @override
  String get toolsYouWillUse => 'Tools you will use';

  @override
  String get replayFirstLab => 'Replay first lab';

  @override
  String startLabNamed(String title) {
    return 'Start lab: $title';
  }

  @override
  String continueLabNamed(String title) {
    return 'Continue: $title';
  }

  @override
  String tasksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tasks',
      one: '1 task',
    );
    return '$_temp0';
  }

  @override
  String attemptsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count attempts',
      one: '1 attempt',
    );
    return '$_temp0';
  }

  @override
  String get leaveLabTitle => 'Leave the lab?';

  @override
  String get leaveLabMessage => 'Your progress in this lab will be lost.';

  @override
  String get stay => 'Stay';

  @override
  String get leave => 'Leave';

  @override
  String questionOf(int index, int total) {
    return 'Question $index of $total';
  }

  @override
  String correctCount(int count) {
    return '$count correct';
  }

  @override
  String selectAnswers(int count) {
    return 'Select $count answers';
  }

  @override
  String get checkAnswer => 'Check answer';

  @override
  String get finishLab => 'Finish lab';

  @override
  String get nextQuestion => 'Next question';

  @override
  String get scenario => 'Scenario';

  @override
  String get correct => 'Correct!';

  @override
  String get notQuite => 'Not quite';

  @override
  String get resultNotFound => 'Result not found';

  @override
  String get resultNotFoundMessage => 'This result is no longer available.';

  @override
  String get labResults => 'Lab Results';

  @override
  String get labCompleted => 'Lab Completed!';

  @override
  String get keepPracticing => 'Keep practicing!';

  @override
  String get overall => 'overall';

  @override
  String get correctAnswers => 'Correct answers';

  @override
  String timeTarget(String time) {
    return 'Time (target $time)';
  }

  @override
  String get accuracyWeight => 'Accuracy (80%)';

  @override
  String get speedWeight => 'Speed (20%)';

  @override
  String newPersonalBest(int gain, int previous) {
    return 'New personal best! +$gain pts vs $previous%.';
  }

  @override
  String stillBest(int best) {
    return 'Your best on this lab is still $best%.';
  }

  @override
  String get skillsBreakdown => 'Skills breakdown';

  @override
  String matchNow(String career, int score, int done, int total) {
    return '$career match is now $score%. $done/$total labs completed in this career.';
  }

  @override
  String nextLabNamed(String title) {
    return 'Next Lab: $title';
  }

  @override
  String tryCareerLab(String career, String lab) {
    return 'Try $career: $lab';
  }

  @override
  String get viewRecommendations => 'View recommendations';

  @override
  String get retry => 'Retry';

  @override
  String get matches => 'Matches';

  @override
  String get backToHome => 'Back to home';

  @override
  String get bestMatch => 'Best match';

  @override
  String get matchesInterestsOnly =>
      'These matches are based only on your interests. Complete labs to get recommendations based on real performance.';

  @override
  String matchesAnalysis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Analysis of $count tested careers',
      one: 'Analysis of 1 tested career',
    );
    return '$_temp0: match = 75% lab performance + 25% interests.';
  }

  @override
  String get allMatches => 'All matches';

  @override
  String get recommendationHistory => 'Recommendation history';

  @override
  String get noRecommendationYet => 'No recommendation yet';

  @override
  String get noRecommendationYetMessage =>
      'A new recommendation is generated after every completed lab.';

  @override
  String get learningPathTitle => 'Learning Path';

  @override
  String becomeCareer(String career) {
    return 'Become a $career';
  }

  @override
  String pathSteps(int done, int total, int minutes) {
    return '$done of $total steps · ~$minutes min total';
  }

  @override
  String get later => 'Later';

  @override
  String get startThePath => 'Start the path';

  @override
  String pathCompleted(String career, int average) {
    return 'Path completed! Your average on $career is $average%. Replay labs to improve it.';
  }

  @override
  String get myProgressTitle => 'My Progress';

  @override
  String get labsDone => 'Labs done';

  @override
  String get avgScore => 'Avg score';

  @override
  String get minutes => 'Minutes';

  @override
  String get careerProgress => 'Career progress';

  @override
  String get skills => 'Skills';

  @override
  String get noSkillsYet => 'Complete a lab to measure your skills.';

  @override
  String get history => 'History';

  @override
  String get noAttemptsYet => 'No attempts yet';

  @override
  String get noAttemptsYetMessage => 'Your completed labs will be listed here.';

  @override
  String get markAllRead => 'Mark all as read';

  @override
  String get clearAll => 'Clear all';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get noNotificationsMessage =>
      'You will be notified when your lab results and recommendations are ready.';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get profileCompleteness => 'Profile completeness';

  @override
  String get completeProfileHint =>
      'A complete profile improves your recommendations.';

  @override
  String get topMatch => 'Top match';

  @override
  String get aboutMe => 'About me';

  @override
  String get email => 'Email';

  @override
  String get studyLevel => 'Study level';

  @override
  String get university => 'University';

  @override
  String get specialty => 'Specialty';

  @override
  String get bio => 'Bio';

  @override
  String get interests => 'Interests';

  @override
  String get noInterestsYet =>
      'No interests yet. Add some to personalize your matches.';

  @override
  String get topSkills => 'Top skills';

  @override
  String get noTopSkills => 'Complete labs to reveal your strongest skills.';

  @override
  String memberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get notSet => 'Not set';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String photoLoadError(String error) {
    return 'Could not load the photo: $error';
  }

  @override
  String get chooseFromGallery => 'Choose from gallery';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get universitySchool => 'University / School';

  @override
  String get specialtyHint => 'e.g. Software engineering';

  @override
  String get bioHint => 'Tell us about your goals';

  @override
  String get interestsHint => 'Used by the AI to compute your career matches.';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get language => 'Language';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get resetProgress => 'Reset my progress';

  @override
  String get resetProgressSubtitle => 'Delete all lab results and history';

  @override
  String get resetProgressTitle => 'Reset progress?';

  @override
  String get resetProgressMessage =>
      'All your lab results and recommendations will be deleted.';

  @override
  String get progressReset => 'Progress reset';

  @override
  String get googleSignInUnavailable =>
      'Google Sign-In is not available right now. Please use your email.';

  @override
  String get errorInvalidCredentials => 'Incorrect email or password.';

  @override
  String get errorWeakPassword => 'This password is too weak.';

  @override
  String get errorNetwork =>
      'No internet connection. Check your network and try again.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get errorProviderDisabled =>
      'This sign-in method is not enabled for the app.';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get passwordResetEnterEmail =>
      'Enter your email address above, then tap “Forgot password?” again.';

  @override
  String passwordResetSent(String email) {
    return 'A password reset link was sent to $email.';
  }

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get pushNotificationsSubtitle =>
      'Alerts when your results and recommendations are ready';

  @override
  String get premium => 'Premium';

  @override
  String get premiumTitle => 'CareerVerse Premium';

  @override
  String get premiumSubtitle =>
      'Unlock every Advanced lab and go further in your orientation.';

  @override
  String get premiumBenefitLabs => 'All Advanced labs (expert scenarios)';

  @override
  String get premiumBenefitSkills =>
      'Harder questions for a sharper skill analysis';

  @override
  String get premiumBenefitSync =>
      'Access on all your devices with your account';

  @override
  String premiumPrice(String price, int days) {
    return '$price / $days days';
  }

  @override
  String premiumBuy(String price) {
    return 'Subscribe for $price';
  }

  @override
  String premiumExtend(String price) {
    return 'Extend for $price';
  }

  @override
  String premiumActiveUntil(String date) {
    return 'Premium active until $date';
  }

  @override
  String premiumExpired(String date) {
    return 'Premium expired on $date';
  }

  @override
  String get premiumFree => 'Free plan';

  @override
  String get premiumTestMode => 'Stripe test mode: no real money is charged.';

  @override
  String get premiumTestCard =>
      'Test card: 4242 4242 4242 4242, any future date, any CVC.';

  @override
  String premiumSuccess(String date) {
    return 'Payment confirmed! Premium is active until $date.';
  }

  @override
  String get paymentCancelled => 'Payment cancelled.';

  @override
  String paymentFailed(String message) {
    return 'Payment failed: $message';
  }

  @override
  String get paymentNotConfigured =>
      'Payments are not available on this build (missing Stripe test keys or unsupported platform).';

  @override
  String get transactionHistory => 'Transaction history';

  @override
  String get noTransactions => 'No transactions yet.';

  @override
  String get premiumLabTitle => 'Premium lab';

  @override
  String premiumLabMessage(String title) {
    return '\"$title\" is an Advanced lab. Subscribe to Premium to unlock it.';
  }

  @override
  String get unlockPremium => 'Unlock with Premium';

  @override
  String get notifPremiumTitle => 'Welcome to Premium!';

  @override
  String notifPremiumBody(String date) {
    return 'Advanced labs are unlocked until $date.';
  }

  @override
  String get courseLabel => 'Course';

  @override
  String get labLabel => 'Lab';

  @override
  String lessonProgress(int current, int total) {
    return 'Lesson $current/$total';
  }

  @override
  String get keyPoints => 'Key points';

  @override
  String get exampleLabel => 'Example';

  @override
  String get takeaways => 'Key takeaways';

  @override
  String get summaryLabel => 'Summary';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get finishCourse => 'Finish';

  @override
  String get finishAndStartLab => 'Finish and start the lab';

  @override
  String readCourseNamed(String title) {
    return 'Read the course: $title';
  }

  @override
  String get courseCompleted => 'Course completed';

  @override
  String get reviewCourse => 'Review the course';

  @override
  String get readCourse => 'Read the course';

  @override
  String get courseRead => 'Course read';

  @override
  String get courseThenLab =>
      'Each step: a course with explanations, then a hands-on lab to practise.';

  @override
  String coursesDone(int done, int total) {
    return '$done/$total courses read';
  }
}
