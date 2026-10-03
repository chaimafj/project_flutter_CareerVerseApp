// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'CareerVerse';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get loginSubtitle => 'Connectez-vous pour continuer votre parcours';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordInfo =>
      'Les comptes sont stockés sur cet appareil. Créez un nouveau compte si vous avez oublié votre mot de passe.';

  @override
  String get logIn => 'Se connecter';

  @override
  String get or => 'ou';

  @override
  String get googleSignInInfo =>
      'La connexion Google est disponible dans l\'application Android et iOS.';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get noAccount => 'Vous n\'avez pas de compte ?';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get validationRequired => 'Ce champ est obligatoire';

  @override
  String get validationNameLength =>
      'Le nom doit contenir au moins 2 caractères';

  @override
  String get validationEmail => 'Entrez une adresse e-mail valide';

  @override
  String get validationPasswordLength =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get errorEmailTaken => 'Un compte existe déjà avec cet e-mail.';

  @override
  String get errorNoAccount => 'Aucun compte trouvé pour cet e-mail.';

  @override
  String get errorWrongPassword => 'Mot de passe incorrect.';

  @override
  String get notifWelcomeTitle => 'Bienvenue sur CareerVerse 🎉';

  @override
  String get notifWelcomeBody =>
      'Complétez votre profil et lancez votre premier Career Lab pour obtenir des recommandations personnalisées.';

  @override
  String get notifResultTitle => 'Vos recommandations sont prêtes !';

  @override
  String notifResultBody(String lab, int score, String career, int topScore) {
    return '$lab : $score %. Meilleur métier : $career ($topScore %).';
  }

  @override
  String get notifNewBest => 'Nouveau record personnel !';

  @override
  String reasonScored(int score, int done, int total) {
    return 'Vous avez obtenu $score % sur $done/$total labs.';
  }

  @override
  String reasonStrongest(String skill) {
    return 'Compétence la plus forte : $skill.';
  }

  @override
  String get reasonNotTested =>
      'Pas encore testé : essayez un lab pour confirmer ce métier.';

  @override
  String reasonInterests(String interests) {
    return 'Correspond à vos centres d\'intérêt : $interests.';
  }

  @override
  String get timeJustNow => 'à l\'instant';

  @override
  String timeMinutesAgo(int count) {
    return 'il y a $count min';
  }

  @override
  String timeHoursAgo(int count) {
    return 'il y a $count h';
  }

  @override
  String timeDaysAgo(int count) {
    return 'il y a $count j';
  }

  @override
  String get acceptTermsError =>
      'Veuillez accepter les conditions pour continuer.';

  @override
  String get createYourAccount => 'Créez votre compte';

  @override
  String get registerSubtitle =>
      'Découvrez les métiers grâce à de vraies simulations';

  @override
  String get fullName => 'Nom complet';

  @override
  String get passwordHint => 'Au moins 6 caractères';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get acceptTerms =>
      'J\'accepte les conditions d\'utilisation et la politique de confidentialité';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get haveAccount => 'Vous avez déjà un compte ?';

  @override
  String get welcomeTagline =>
      'Explorer  ·  Apprendre  ·  Construire\nVotre avenir';

  @override
  String get cybersecurity => 'Cybersécurité';

  @override
  String get getStarted => 'Commencer';

  @override
  String get home => 'Accueil';

  @override
  String get labs => 'Labs';

  @override
  String get explore => 'Explorer';

  @override
  String get progress => 'Progrès';

  @override
  String get profile => 'Profil';

  @override
  String helloName(String name) {
    return 'Bonjour, $name 👋';
  }

  @override
  String get homeSubtitle => 'Explorez votre parcours professionnel';

  @override
  String get homeSearchHint => 'Rechercher des métiers, labs ou compétences...';

  @override
  String get yourAiProfile => 'Votre profil IA';

  @override
  String labsPracticed(int done, int total, int minutes) {
    return '$done/$total labs · $minutes min de pratique';
  }

  @override
  String get viewProgress => 'Voir les progrès  →';

  @override
  String get avg => 'moy.';

  @override
  String get startFirstLab => 'Lancez votre premier lab';

  @override
  String get upNext => 'À suivre';

  @override
  String get quickAccess => 'Accès rapide';

  @override
  String get aiMatch => 'Match IA';

  @override
  String get path => 'Parcours';

  @override
  String get recommendedCareers => 'Métiers recommandés';

  @override
  String get seeAll => 'Tout voir';

  @override
  String get recentActivity => 'Activité récente';

  @override
  String get noActivity =>
      'Aucun lab terminé pour l\'instant. Vos scores et recommandations apparaîtront ici.';

  @override
  String get basedOnLabs => 'Basé sur vos labs';

  @override
  String get basedOnInterests => 'Basé sur vos intérêts';

  @override
  String get careerLabs => 'Career Labs';

  @override
  String get exploreCareers => 'Explorer les métiers';

  @override
  String get aiRecommendations => 'Recommandations IA';

  @override
  String get learningPath => 'Parcours d\'apprentissage';

  @override
  String get myProgress => 'Mes progrès';

  @override
  String get notifications => 'Notifications';

  @override
  String get settings => 'Paramètres';

  @override
  String get about => 'À propos';

  @override
  String get aboutText =>
      'Découvrez les métiers grâce à des simulations pratiques.';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get exploreCareersTitle => 'Explorer les métiers';

  @override
  String get exploreSearchHint => 'Rechercher métiers, outils ou labs...';

  @override
  String get all => 'Tous';

  @override
  String get categoryInfrastructure => 'Infrastructure';

  @override
  String get categoryDevelopment => 'Développement';

  @override
  String get categorySecurity => 'Sécurité';

  @override
  String get categoryMobileWeb => 'Mobile & Web';

  @override
  String get categoryDataAi => 'Data & IA';

  @override
  String get noCareerFound => 'Aucun métier trouvé';

  @override
  String get noCareerFoundMessage =>
      'Essayez un autre mot-clé, par ex. « AWS » ou « Docker ».';

  @override
  String labsProgress(int done, int total) {
    return '$done/$total labs';
  }

  @override
  String get toDo => 'À faire';

  @override
  String get completed => 'Terminés';

  @override
  String labsCount(int count) {
    return '$count labs';
  }

  @override
  String completedCount(int done, int total) {
    return '$done/$total terminés';
  }

  @override
  String get noLabHere => 'Aucun lab ici';

  @override
  String get noLabHereMessage => 'Modifiez les filtres pour voir plus de labs.';

  @override
  String get start => 'Démarrer';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String labsCompletedOf(int done, int total) {
    return '$done/$total labs terminés';
  }

  @override
  String get match => 'compatibilité';

  @override
  String get salaryFrance => 'Salaire (France)';

  @override
  String get education => 'Formation';

  @override
  String get aboutTheJob => 'À propos du métier';

  @override
  String get typicalDay => 'Une journée type';

  @override
  String get toolsYouWillUse => 'Outils que vous utiliserez';

  @override
  String get replayFirstLab => 'Rejouer le premier lab';

  @override
  String startLabNamed(String title) {
    return 'Démarrer le lab : $title';
  }

  @override
  String continueLabNamed(String title) {
    return 'Continuer : $title';
  }

  @override
  String tasksCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tâches',
      one: '1 tâche',
    );
    return '$_temp0';
  }

  @override
  String attemptsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tentatives',
      one: '1 tentative',
    );
    return '$_temp0';
  }

  @override
  String get leaveLabTitle => 'Quitter le lab ?';

  @override
  String get leaveLabMessage => 'Votre progression dans ce lab sera perdue.';

  @override
  String get stay => 'Rester';

  @override
  String get leave => 'Quitter';

  @override
  String questionOf(int index, int total) {
    return 'Question $index sur $total';
  }

  @override
  String correctCount(int count) {
    return '$count correctes';
  }

  @override
  String selectAnswers(int count) {
    return 'Sélectionnez $count réponses';
  }

  @override
  String get checkAnswer => 'Vérifier la réponse';

  @override
  String get finishLab => 'Terminer le lab';

  @override
  String get nextQuestion => 'Question suivante';

  @override
  String get scenario => 'Scénario';

  @override
  String get correct => 'Correct !';

  @override
  String get notQuite => 'Pas tout à fait';

  @override
  String get resultNotFound => 'Résultat introuvable';

  @override
  String get resultNotFoundMessage => 'Ce résultat n\'est plus disponible.';

  @override
  String get labResults => 'Résultats du lab';

  @override
  String get labCompleted => 'Lab terminé !';

  @override
  String get keepPracticing => 'Continuez à vous entraîner !';

  @override
  String get overall => 'global';

  @override
  String get correctAnswers => 'Bonnes réponses';

  @override
  String timeTarget(String time) {
    return 'Temps (objectif $time)';
  }

  @override
  String get accuracyWeight => 'Précision (80 %)';

  @override
  String get speedWeight => 'Rapidité (20 %)';

  @override
  String newPersonalBest(int gain, int previous) {
    return 'Nouveau record ! +$gain pts par rapport à $previous %.';
  }

  @override
  String stillBest(int best) {
    return 'Votre meilleur score sur ce lab reste $best %.';
  }

  @override
  String get skillsBreakdown => 'Détail des compétences';

  @override
  String matchNow(String career, int score, int done, int total) {
    return 'Compatibilité $career : $score %. $done/$total labs terminés dans ce métier.';
  }

  @override
  String nextLabNamed(String title) {
    return 'Lab suivant : $title';
  }

  @override
  String tryCareerLab(String career, String lab) {
    return 'Essayer $career : $lab';
  }

  @override
  String get viewRecommendations => 'Voir les recommandations';

  @override
  String get retry => 'Réessayer';

  @override
  String get matches => 'Métiers';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get bestMatch => 'Meilleure compatibilité';

  @override
  String get matchesInterestsOnly =>
      'Ces résultats sont basés uniquement sur vos centres d\'intérêt. Terminez des labs pour obtenir des recommandations basées sur vos performances réelles.';

  @override
  String matchesAnalysis(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Analyse de $count métiers testés',
      one: 'Analyse d\'1 métier testé',
    );
    return '$_temp0 : compatibilité = 75 % performance aux labs + 25 % intérêts.';
  }

  @override
  String get allMatches => 'Tous les métiers';

  @override
  String get recommendationHistory => 'Historique des recommandations';

  @override
  String get noRecommendationYet => 'Aucune recommandation pour le moment';

  @override
  String get noRecommendationYetMessage =>
      'Une nouvelle recommandation est générée après chaque lab terminé.';

  @override
  String get learningPathTitle => 'Parcours d\'apprentissage';

  @override
  String becomeCareer(String career) {
    return 'Devenir $career';
  }

  @override
  String pathSteps(int done, int total, int minutes) {
    return '$done sur $total étapes · ~$minutes min au total';
  }

  @override
  String get later => 'Plus tard';

  @override
  String get startThePath => 'Commencer le parcours';

  @override
  String pathCompleted(String career, int average) {
    return 'Parcours terminé ! Votre moyenne en $career est de $average %. Rejouez les labs pour l\'améliorer.';
  }

  @override
  String get myProgressTitle => 'Mes progrès';

  @override
  String get labsDone => 'Labs faits';

  @override
  String get avgScore => 'Score moyen';

  @override
  String get minutes => 'Minutes';

  @override
  String get careerProgress => 'Progression par métier';

  @override
  String get skills => 'Compétences';

  @override
  String get noSkillsYet => 'Terminez un lab pour mesurer vos compétences.';

  @override
  String get history => 'Historique';

  @override
  String get noAttemptsYet => 'Aucune tentative';

  @override
  String get noAttemptsYetMessage => 'Vos labs terminés apparaîtront ici.';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String get clearAll => 'Tout effacer';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get noNotificationsMessage =>
      'Vous serez notifié lorsque vos résultats et recommandations seront prêts.';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get profileCompleteness => 'Profil complété';

  @override
  String get completeProfileHint =>
      'Un profil complet améliore vos recommandations.';

  @override
  String get topMatch => 'Top métier';

  @override
  String get aboutMe => 'À propos de moi';

  @override
  String get email => 'E-mail';

  @override
  String get studyLevel => 'Niveau d\'études';

  @override
  String get university => 'Université';

  @override
  String get specialty => 'Spécialité';

  @override
  String get bio => 'Bio';

  @override
  String get interests => 'Centres d\'intérêt';

  @override
  String get noInterestsYet =>
      'Aucun centre d\'intérêt. Ajoutez-en pour personnaliser vos résultats.';

  @override
  String get topSkills => 'Meilleures compétences';

  @override
  String get noTopSkills => 'Terminez des labs pour révéler vos points forts.';

  @override
  String memberSince(String date) {
    return 'Membre depuis le $date';
  }

  @override
  String get notSet => 'Non renseigné';

  @override
  String get editProfileTitle => 'Modifier le profil';

  @override
  String photoLoadError(String error) {
    return 'Impossible de charger la photo : $error';
  }

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get universitySchool => 'Université / École';

  @override
  String get specialtyHint => 'ex. Génie logiciel';

  @override
  String get bioHint => 'Parlez-nous de vos objectifs';

  @override
  String get interestsHint =>
      'Utilisés par l\'IA pour calculer vos métiers compatibles.';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get theme => 'Thème';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get language => 'Langue';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get resetProgress => 'Réinitialiser ma progression';

  @override
  String get resetProgressSubtitle =>
      'Supprimer tous les résultats et l\'historique';

  @override
  String get resetProgressTitle => 'Réinitialiser la progression ?';

  @override
  String get resetProgressMessage =>
      'Tous vos résultats de labs et recommandations seront supprimés.';

  @override
  String get progressReset => 'Progression réinitialisée';

  @override
  String get googleSignInUnavailable =>
      'La connexion Google n\'est pas disponible pour le moment. Utilisez votre e-mail.';

  @override
  String get errorInvalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get errorWeakPassword => 'Ce mot de passe est trop faible.';

  @override
  String get errorNetwork =>
      'Pas de connexion Internet. Vérifiez votre réseau et réessayez.';

  @override
  String get errorTooManyRequests => 'Trop de tentatives. Réessayez plus tard.';

  @override
  String get errorProviderDisabled =>
      'Cette méthode de connexion n\'est pas activée pour l\'application.';

  @override
  String get errorUnknown => 'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get passwordResetEnterEmail =>
      'Saisissez votre adresse e-mail ci-dessus, puis appuyez à nouveau sur « Mot de passe oublié ? ».';

  @override
  String passwordResetSent(String email) {
    return 'Un lien de réinitialisation a été envoyé à $email.';
  }

  @override
  String get pushNotifications => 'Notifications push';

  @override
  String get pushNotificationsSubtitle =>
      'Alertes lorsque vos résultats et recommandations sont prêts';

  @override
  String get premium => 'Premium';

  @override
  String get premiumTitle => 'CareerVerse Premium';

  @override
  String get premiumSubtitle =>
      'Débloquez tous les labs avancés et allez plus loin dans votre orientation.';

  @override
  String get premiumBenefitLabs => 'Tous les labs avancés (scénarios experts)';

  @override
  String get premiumBenefitSkills =>
      'Des questions plus difficiles pour une analyse plus fine de vos compétences';

  @override
  String get premiumBenefitSync =>
      'Accès sur tous vos appareils avec votre compte';

  @override
  String premiumPrice(String price, int days) {
    return '$price / $days jours';
  }

  @override
  String premiumBuy(String price) {
    return 'S\'abonner pour $price';
  }

  @override
  String premiumExtend(String price) {
    return 'Prolonger pour $price';
  }

  @override
  String premiumActiveUntil(String date) {
    return 'Premium actif jusqu\'au $date';
  }

  @override
  String premiumExpired(String date) {
    return 'Premium expiré le $date';
  }

  @override
  String get premiumFree => 'Offre gratuite';

  @override
  String get premiumTestMode =>
      'Stripe en mode test : aucun argent réel n\'est débité.';

  @override
  String get premiumTestCard =>
      'Carte de test : 4242 4242 4242 4242, une date future, n\'importe quel CVC.';

  @override
  String premiumSuccess(String date) {
    return 'Paiement confirmé ! Premium est actif jusqu\'au $date.';
  }

  @override
  String get paymentCancelled => 'Paiement annulé.';

  @override
  String paymentFailed(String message) {
    return 'Échec du paiement : $message';
  }

  @override
  String get paymentNotConfigured =>
      'Le paiement n\'est pas disponible dans cette version (clés de test Stripe manquantes ou plateforme non prise en charge).';

  @override
  String get transactionHistory => 'Historique des transactions';

  @override
  String get noTransactions => 'Aucune transaction pour le moment.';

  @override
  String get premiumLabTitle => 'Lab Premium';

  @override
  String premiumLabMessage(String title) {
    return '« $title » est un lab avancé. Abonnez-vous à Premium pour le débloquer.';
  }

  @override
  String get unlockPremium => 'Débloquer avec Premium';

  @override
  String get notifPremiumTitle => 'Bienvenue dans Premium !';

  @override
  String notifPremiumBody(String date) {
    return 'Les labs avancés sont débloqués jusqu\'au $date.';
  }

  @override
  String get courseLabel => 'Cours';

  @override
  String get labLabel => 'Lab';

  @override
  String lessonProgress(int current, int total) {
    return 'Leçon $current/$total';
  }

  @override
  String get keyPoints => 'Points clés';

  @override
  String get exampleLabel => 'Exemple';

  @override
  String get takeaways => 'À retenir';

  @override
  String get summaryLabel => 'Résumé';

  @override
  String get previous => 'Précédent';

  @override
  String get next => 'Suivant';

  @override
  String get finishCourse => 'Terminer';

  @override
  String get finishAndStartLab => 'Terminer et lancer le lab';

  @override
  String readCourseNamed(String title) {
    return 'Lire le cours : $title';
  }

  @override
  String get courseCompleted => 'Cours terminé';

  @override
  String get reviewCourse => 'Revoir le cours';

  @override
  String get readCourse => 'Lire le cours';

  @override
  String get courseRead => 'Cours lu';

  @override
  String get courseThenLab =>
      'Chaque étape : un cours avec des explications, puis un lab pratique pour s’entraîner.';

  @override
  String coursesDone(int done, int total) {
    return '$done/$total cours lus';
  }
}
