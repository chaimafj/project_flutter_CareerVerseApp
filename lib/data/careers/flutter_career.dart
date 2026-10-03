import 'package:flutter/material.dart';

import '../../models/career.dart';
import '../../models/career_pack.dart';
import '../../models/course.dart';

const flutterPack = CareerPack(
  career: Career(
    id: 'flutter',
    title: 'Flutter Mobile Developer',
    summary:
        'Create beautiful cross-platform mobile apps with Flutter and Dart.',
    description:
        'Flutter mobile developers build Android and iOS apps from one codebase. '
        'They design responsive interfaces, connect apps to APIs, manage state '
        'and prepare releases for app stores.',
    icon: Icons.phone_android,
    color: Color(0xFF02569B),
    tools: ['Flutter', 'Dart', 'Firebase', 'Android Studio'],
    tags: ['Technology', 'Mobile', 'Development'],
    salary: '38k – 60k € / year',
    outlook: 'Demand is strong as teams want fast mobile delivery on both Android and iOS.',
    education: 'Bac+2 to Bac+5 in software development or mobile engineering',
    dailyTasks: [
      'Build responsive screens with Flutter widgets',
      'Connect mobile apps to REST APIs',
      'Manage app state and navigation',
      'Test, profile and publish releases',
    ],
    labs: [
      Lab(
        id: 'flutter-1',
        title: 'Build your first Flutter screen',
        scenario:
            'A startup asks you to build the first screen of a habit-tracking app. '
            'You must choose the right widgets, organize the layout and display a '
            'dynamic list while iterating quickly with hot reload.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'Which widget is best for a screen that only displays fixed text and icons?',
            options: [
              'StatelessWidget',
              'StatefulWidget',
              'FutureBuilder',
              'ChangeNotifier',
            ],
            correct: {0},
            skill: 'Widgets',
            explanation: 'A StatelessWidget is ideal when the widget has no mutable UI state. Use StatefulWidget only when the screen needs to change internally.',
          ),
          LabQuestion(
            prompt: 'Which widgets help arrange children horizontally and share remaining space? (select 2)',
            options: ['Column', 'Expanded', 'Row', 'ListView.builder'],
            correct: {1, 2},
            skill: 'Layout',
            explanation: 'Row lays children out horizontally, and Expanded lets one child take available space. Column is vertical, while ListView.builder is for scrolling lists.',
          ),
          LabQuestion(
            prompt: 'You changed a Text color and want to see it without losing state. What should you use?',
            options: [
              'Full reinstall',
              'Hot reload',
              'Delete the build folder',
              'Change the package name',
            ],
            correct: {1},
            skill: 'Hot reload',
            explanation: 'Hot reload injects updated code into the running app and keeps most state. It is perfect for UI iteration.',
          ),
          LabQuestion(
            prompt: 'Which widget efficiently builds a long scrolling list from data?',
            options: ['Stack', 'Container', 'ListView.builder', 'SizedBox'],
            correct: {2},
            skill: 'Lists',
            explanation: 'ListView.builder lazily creates only the visible rows and reuses the builder for large collections.',
          ),
        ],
      ),
      Lab(
        id: 'flutter-2',
        title: 'Manage state and call a REST API',
        scenario:
            'Your app now loads habits from a backend endpoint and lets users mark '
            'one as done. You must pick a state strategy, fetch JSON data and show '
            'clear loading and error states.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'When is setState enough for Flutter state management?',
            options: [
              'For local state owned by one widget',
              'For global app state shared everywhere',
              'For decoding JSON automatically',
              'For publishing to app stores',
            ],
            correct: {0},
            skill: 'State management',
            explanation: 'setState is simple and appropriate for state local to one StatefulWidget. Shared or complex state usually needs a dedicated model.',
          ),
          LabQuestion(
            prompt: 'Which Provider pattern exposes shared state and notifies listening widgets?',
            options: [
              'A StatelessWidget with final fields only',
              'ChangeNotifier with notifyListeners()',
              'A const Column',
              'An AndroidManifest entry',
            ],
            correct: {1},
            skill: 'State management',
            explanation: 'ChangeNotifier stores mutable state and calls notifyListeners() so Provider can rebuild dependents.',
          ),
          LabQuestion(
            prompt: 'What should FutureBuilder render while an HTTP request is still waiting?',
            options: [
              'A success screen with fake data',
              'A loading indicator',
              'A release APK',
              'An empty MaterialApp',
            ],
            correct: {1},
            skill: 'Async UI',
            explanation: 'FutureBuilder receives connection states, so waiting should usually show a progress indicator before data exists.',
          ),
          LabQuestion(
            prompt: 'After http.get returns JSON text, which steps turn it into typed Dart objects? (select 2)',
            options: [
              'Decode the response body with jsonDecode',
              'Map decoded values into model constructors',
              'Call hot reload on the server',
              'Put raw JSON directly in a TextField',
            ],
            correct: {0, 1},
            skill: 'Networking',
            explanation: 'The HTTP response is text, so decode it first and then build typed model objects. Keeping raw JSON in widgets makes the UI fragile.',
          ),
        ],
      ),
      Lab(
        id: 'flutter-3',
        title: 'Test and ship a production app',
        scenario:
            'The product is ready for beta users, but it must be reliable and fast. '
            'You add automated tests, reduce unnecessary rebuilds and prepare '
            'signed release artifacts for stores and CI.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'Which test checks that tapping a button changes visible UI text?',
            options: [
              'Unit test',
              'Widget test',
              'Golden file name only',
              'Manual store review',
            ],
            correct: {1},
            skill: 'Testing',
            explanation: 'A widget test pumps widgets, interacts with them and verifies what appears on screen. Unit tests are better for pure Dart logic.',
          ),
          LabQuestion(
            prompt:
                'Which practices reduce unnecessary rebuild work? (select 2)',
            options: [
              'Use const constructors when inputs never change',
              'Split large widgets so only small parts rebuild',
              'Call setState around the whole app every second',
              'Decode JSON inside every build method',
            ],
            correct: {0, 1},
            skill: 'Performance',
            explanation: 'const widgets can be reused, and smaller widget boundaries limit rebuild impact. Expensive work in build methods hurts frame performance.',
          ),
          LabQuestion(
            prompt: 'Which command creates an Android App Bundle for Play Store upload?',
            options: [
              'flutter test',
              'flutter build apk --debug',
              'flutter build appbundle --release',
              'dart format',
            ],
            correct: {2},
            skill: 'Deployment',
            explanation: 'Google Play expects an AAB for many releases, produced by flutter build appbundle --release after signing is configured.',
          ),
          LabQuestion(
            prompt: 'What should a CI pipeline do before uploading a mobile release?',
            options: [
              'Run analyze and automated tests',
              'Disable all tests to save time',
              'Commit generated secrets',
              'Rename every widget',
            ],
            correct: {0},
            skill: 'CI',
            explanation: 'CI should catch static analysis and test failures before building or uploading artifacts. Secrets must stay in secure CI storage.',
          ),
        ],
      ),
    ],
  ),
  interests: ['Mobile', 'Programming', 'Design', 'Problem solving'],
  contentFr: <String, String>{
    'Flutter Mobile Developer': 'Développeur mobile Flutter',
    'Create beautiful cross-platform mobile apps with Flutter and Dart.': 'Crée de belles applications mobiles multiplateformes avec Flutter et Dart.',
    'Flutter mobile developers build Android and iOS apps from one codebase. They design responsive interfaces, connect apps to APIs, manage state and prepare releases for app stores.': 'Les développeurs mobiles Flutter créent des applications Android et iOS à partir d’une seule base de code. Ils conçoivent des interfaces responsives, connectent les apps à des API, gèrent l’état et préparent les versions pour les stores.',
    '38k – 60k € / year': '38k – 60k € / an',
    'Demand is strong as teams want fast mobile delivery on both Android and iOS.': 'La demande est forte, car les équipes veulent livrer vite sur Android comme sur iOS.',
    'Bac+2 to Bac+5 in software development or mobile engineering':
        'Bac+2 à Bac+5 en développement logiciel ou ingénierie mobile',
    'Build responsive screens with Flutter widgets':
        'Construire des écrans responsives avec les widgets Flutter',
    'Connect mobile apps to REST APIs':
        'Connecter des applications mobiles à des API REST',
    'Manage app state and navigation':
        'Gérer l’état de l’application et la navigation',
    'Test, profile and publish releases':
        'Tester, profiler et publier les versions',
    'Technology': 'Technologie',
    'Mobile': 'Mobile',
    'Development': 'Développement',
    'Build your first Flutter screen': 'Construire ton premier écran Flutter',
    'A startup asks you to build the first screen of a habit-tracking app. You must choose the right widgets, organize the layout and display a dynamic list while iterating quickly with hot reload.': 'Une startup te demande de construire le premier écran d’une app de suivi d’habitudes. Tu dois choisir les bons widgets, organiser la mise en page et afficher une liste dynamique tout en itérant vite avec le hot reload.',
    'Beginner': 'Débutant',
    'Which widget is best for a screen that only displays fixed text and icons?': 'Quel widget convient le mieux à un écran qui affiche seulement du texte et des icônes fixes ?',
    'StatelessWidget': 'StatelessWidget',
    'StatefulWidget': 'StatefulWidget',
    'FutureBuilder': 'FutureBuilder',
    'ChangeNotifier': 'ChangeNotifier',
    'A StatelessWidget is ideal when the widget has no mutable UI state. Use StatefulWidget only when the screen needs to change internally.': 'Un StatelessWidget est idéal quand le widget n’a pas d’état d’interface mutable. Utilise StatefulWidget seulement quand l’écran doit changer en interne.',
    'Widgets': 'Widgets',
    'Which widgets help arrange children horizontally and share remaining space? (select 2)': 'Quels widgets aident à organiser les enfants horizontalement et à partager l’espace restant ? (2 réponses)',
    'Column': 'Column',
    'Expanded': 'Expanded',
    'Row': 'Row',
    'ListView.builder': 'ListView.builder',
    'Row lays children out horizontally, and Expanded lets one child take available space. Column is vertical, while ListView.builder is for scrolling lists.': 'Row dispose les enfants horizontalement, et Expanded permet à un enfant de prendre l’espace disponible. Column est vertical, tandis que ListView.builder sert aux listes défilantes.',
    'Layout': 'Mise en page',
    'You changed a Text color and want to see it without losing state. What should you use?': 'Tu as changé la couleur d’un Text et tu veux la voir sans perdre l’état. Que dois-tu utiliser ?',
    'Full reinstall': 'Réinstallation complète',
    'Hot reload': 'Hot reload',
    'Delete the build folder': 'Supprimer le dossier de build',
    'Change the package name': 'Changer le nom du package',
    'Hot reload injects updated code into the running app and keeps most state. It is perfect for UI iteration.': 'Le hot reload injecte le code mis à jour dans l’app en cours d’exécution et conserve la plupart de l’état. C’est parfait pour itérer sur l’interface.',
    'Which widget efficiently builds a long scrolling list from data?': 'Quel widget construit efficacement une longue liste défilante à partir de données ?',
    'Stack': 'Stack',
    'Container': 'Container',
    'SizedBox': 'SizedBox',
    'ListView.builder lazily creates only the visible rows and reuses the builder for large collections.': 'ListView.builder crée paresseusement seulement les lignes visibles et réutilise le builder pour les grandes collections.',
    'Lists': 'Listes',
    'Manage state and call a REST API': 'Gérer l’état et appeler une API REST',
    'Your app now loads habits from a backend endpoint and lets users mark one as done. You must pick a state strategy, fetch JSON data and show clear loading and error states.': 'Ton app charge maintenant des habitudes depuis un endpoint backend et permet aux utilisateurs d’en marquer une comme terminée. Tu dois choisir une stratégie d’état, récupérer des données JSON et afficher des états de chargement et d’erreur clairs.',
    'Intermediate': 'Intermédiaire',
    'When is setState enough for Flutter state management?':
        'Quand setState suffit-il pour gérer l’état Flutter ?',
    'For local state owned by one widget':
        'Pour un état local appartenant à un seul widget',
    'For global app state shared everywhere':
        'Pour un état global partagé partout dans l’app',
    'For decoding JSON automatically': 'Pour décoder JSON automatiquement',
    'For publishing to app stores': 'Pour publier sur les stores',
    'setState is simple and appropriate for state local to one StatefulWidget. Shared or complex state usually needs a dedicated model.': 'setState est simple et adapté à un état local à un StatefulWidget. Un état partagé ou complexe a généralement besoin d’un modèle dédié.',
    'State management': 'Gestion d’état',
    'Which Provider pattern exposes shared state and notifies listening widgets?': 'Quel pattern Provider expose un état partagé et notifie les widgets à l’écoute ?',
    'A StatelessWidget with final fields only':
        'Un StatelessWidget avec seulement des champs final',
    'ChangeNotifier with notifyListeners()':
        'ChangeNotifier avec notifyListeners()',
    'A const Column': 'Une Column const',
    'An AndroidManifest entry': 'Une entrée AndroidManifest',
    'ChangeNotifier stores mutable state and calls notifyListeners() so Provider can rebuild dependents.': 'ChangeNotifier stocke l’état mutable et appelle notifyListeners() pour que Provider reconstruise les dépendants.',
    'What should FutureBuilder render while an HTTP request is still waiting?': 'Que doit afficher FutureBuilder pendant qu’une requête HTTP est encore en attente ?',
    'A success screen with fake data':
        'Un écran de succès avec de fausses données',
    'A loading indicator': 'Un indicateur de chargement',
    'A release APK': 'Un APK de release',
    'An empty MaterialApp': 'Une MaterialApp vide',
    'FutureBuilder receives connection states, so waiting should usually show a progress indicator before data exists.': 'FutureBuilder reçoit des états de connexion ; l’attente doit donc généralement afficher un indicateur de progression avant que les données existent.',
    'Async UI': 'UI asynchrone',
    'After http.get returns JSON text, which steps turn it into typed Dart objects? (select 2)': 'Après le retour de texte JSON par http.get, quelles étapes le transforment en objets Dart typés ? (2 réponses)',
    'Decode the response body with jsonDecode':
        'Décoder le corps de réponse avec jsonDecode',
    'Map decoded values into model constructors':
        'Mapper les valeurs décodées vers des constructeurs de modèles',
    'Call hot reload on the server': 'Appeler le hot reload sur le serveur',
    'Put raw JSON directly in a TextField':
        'Mettre le JSON brut directement dans un TextField',
    'The HTTP response is text, so decode it first and then build typed model objects. Keeping raw JSON in widgets makes the UI fragile.': 'La réponse HTTP est du texte : décode-la d’abord, puis construis des objets de modèle typés. Garder du JSON brut dans les widgets rend l’interface fragile.',
    'Networking': 'Réseau',
    'Test and ship a production app':
        'Tester et livrer une application de production',
    'The product is ready for beta users, but it must be reliable and fast. You add automated tests, reduce unnecessary rebuilds and prepare signed release artifacts for stores and CI.': 'Le produit est prêt pour les bêta-testeurs, mais il doit être fiable et rapide. Tu ajoutes des tests automatisés, réduis les reconstructions inutiles et prépares des artefacts de release signés pour les stores et la CI.',
    'Advanced': 'Avancé',
    'Which test checks that tapping a button changes visible UI text?': 'Quel test vérifie qu’un appui sur un bouton change le texte visible de l’interface ?',
    'Unit test': 'Test unitaire',
    'Widget test': 'Test de widget',
    'Golden file name only': 'Nom de fichier golden seulement',
    'Manual store review': 'Revue manuelle du store',
    'A widget test pumps widgets, interacts with them and verifies what appears on screen. Unit tests are better for pure Dart logic.': 'Un test de widget lance des widgets, interagit avec eux et vérifie ce qui apparaît à l’écran. Les tests unitaires conviennent mieux à la logique Dart pure.',
    'Testing': 'Tests',
    'Which practices reduce unnecessary rebuild work? (select 2)': 'Quelles pratiques réduisent les reconstructions inutiles ? (2 réponses)',
    'Use const constructors when inputs never change':
        'Utiliser des constructeurs const quand les entrées ne changent jamais',
    'Split large widgets so only small parts rebuild': 'Découper les gros widgets pour que seules de petites parties se reconstruisent',
    'Call setState around the whole app every second':
        'Appeler setState autour de toute l’app chaque seconde',
    'Decode JSON inside every build method':
        'Décoder JSON dans chaque méthode build',
    'const widgets can be reused, and smaller widget boundaries limit rebuild impact. Expensive work in build methods hurts frame performance.': 'Les widgets const peuvent être réutilisés, et des frontières de widgets plus petites limitent l’impact des reconstructions. Le travail coûteux dans les méthodes build nuit aux performances d’affichage.',
    'Performance': 'Performance',
    'Which command creates an Android App Bundle for Play Store upload?': 'Quelle commande crée un Android App Bundle pour l’envoi sur le Play Store ?',
    'flutter test': 'flutter test',
    'flutter build apk --debug': 'flutter build apk --debug',
    'flutter build appbundle --release': 'flutter build appbundle --release',
    'dart format': 'dart format',
    'Google Play expects an AAB for many releases, produced by flutter build appbundle --release after signing is configured.': 'Google Play attend un AAB pour de nombreuses versions, produit par flutter build appbundle --release après la configuration de la signature.',
    'Deployment': 'Déploiement',
    'What should a CI pipeline do before uploading a mobile release?': 'Que doit faire un pipeline CI avant de téléverser une release mobile ?',
    'Run analyze and automated tests':
        'Exécuter l’analyse et les tests automatisés',
    'Disable all tests to save time':
        'Désactiver tous les tests pour gagner du temps',
    'Commit generated secrets': 'Commiter des secrets générés',
    'Rename every widget': 'Renommer chaque widget',
    'CI should catch static analysis and test failures before building or uploading artifacts. Secrets must stay in secure CI storage.': 'La CI doit détecter les échecs d’analyse statique et de tests avant de construire ou téléverser des artefacts. Les secrets doivent rester dans le stockage sécurisé de la CI.',
    'CI': 'CI',
  },
  contentAr: <String, String>{
    'Flutter Mobile Developer': 'مطوّر تطبيقات جوّال Flutter',
    'Create beautiful cross-platform mobile apps with Flutter and Dart.':
        'أنشئ تطبيقات جوّال جميلة متعددة المنصات باستخدام Flutter وDart.',
    'Flutter mobile developers build Android and iOS apps from one codebase. They design responsive interfaces, connect apps to APIs, manage state and prepare releases for app stores.': 'يبني مطوّرو Flutter تطبيقات Android وiOS من قاعدة شفرة واحدة. يصممون واجهات متجاوبة، ويربطون التطبيقات بواجهات API، ويديرون الحالة، ويجهزون الإصدارات لمتاجر التطبيقات.',
    '38k – 60k € / year': '38 ألف – 60 ألف € / السنة',
    'Demand is strong as teams want fast mobile delivery on both Android and iOS.':
        'الطلب قوي لأن الفرق تريد تسليم التطبيقات بسرعة على Android وiOS معًا.',
    'Bac+2 to Bac+5 in software development or mobile engineering':
        'من Bac+2 إلى Bac+5 في تطوير البرمجيات أو هندسة الجوّال',
    'Build responsive screens with Flutter widgets':
        'بناء شاشات متجاوبة باستخدام ودجات Flutter',
    'Connect mobile apps to REST APIs': 'ربط تطبيقات الجوّال بواجهات REST API',
    'Manage app state and navigation': 'إدارة حالة التطبيق والتنقل',
    'Test, profile and publish releases':
        'اختبار الإصدارات وتحليل الأداء ونشرها',
    'Technology': 'تكنولوجيا',
    'Mobile': 'جوّال',
    'Development': 'تطوير',
    'Build your first Flutter screen': 'ابنِ أول شاشة Flutter لك',
    'A startup asks you to build the first screen of a habit-tracking app. You must choose the right widgets, organize the layout and display a dynamic list while iterating quickly with hot reload.': 'تطلب منك شركة ناشئة بناء أول شاشة لتطبيق تتبع العادات. يجب أن تختار الودجات المناسبة، وتنظم التخطيط، وتعرض قائمة ديناميكية مع التكرار السريع باستخدام hot reload.',
    'Beginner': 'مبتدئ',
    'Which widget is best for a screen that only displays fixed text and icons?':
        'أي ودجت هو الأنسب لشاشة تعرض نصوصًا وأيقونات ثابتة فقط؟',
    'StatelessWidget': 'StatelessWidget',
    'StatefulWidget': 'StatefulWidget',
    'FutureBuilder': 'FutureBuilder',
    'ChangeNotifier': 'ChangeNotifier',
    'A StatelessWidget is ideal when the widget has no mutable UI state. Use StatefulWidget only when the screen needs to change internally.': 'يكون StatelessWidget مناسبًا عندما لا يملك الودجت حالة واجهة قابلة للتغيير. استخدم StatefulWidget فقط عندما تحتاج الشاشة إلى التغير داخليًا.',
    'Widgets': 'الودجات',
    'Which widgets help arrange children horizontally and share remaining space? (select 2)': 'أي ودجات تساعد على ترتيب العناصر أفقيًا ومشاركة المساحة المتبقية؟ (اختر 2)',
    'Column': 'Column',
    'Expanded': 'Expanded',
    'Row': 'Row',
    'ListView.builder': 'ListView.builder',
    'Row lays children out horizontally, and Expanded lets one child take available space. Column is vertical, while ListView.builder is for scrolling lists.': 'يرتب Row العناصر أفقيًا، ويسمح Expanded لعنصر واحد بأخذ المساحة المتاحة. أما Column فهو عمودي، وListView.builder مخصص للقوائم القابلة للتمرير.',
    'Layout': 'التخطيط',
    'You changed a Text color and want to see it without losing state. What should you use?':
        'غيّرت لون Text وتريد رؤيته دون فقدان الحالة. ماذا تستخدم؟',
    'Full reinstall': 'إعادة تثبيت كاملة',
    'Hot reload': 'Hot reload',
    'Delete the build folder': 'حذف مجلد البناء',
    'Change the package name': 'تغيير اسم الحزمة',
    'Hot reload injects updated code into the running app and keeps most state. It is perfect for UI iteration.': 'يدخل hot reload الشفرة المحدّثة في التطبيق العامل ويحافظ على معظم الحالة. وهو مثالي لتكرار تطوير الواجهة.',
    'Which widget efficiently builds a long scrolling list from data?':
        'أي ودجت يبني بكفاءة قائمة طويلة قابلة للتمرير من البيانات؟',
    'Stack': 'Stack',
    'Container': 'Container',
    'SizedBox': 'SizedBox',
    'ListView.builder lazily creates only the visible rows and reuses the builder for large collections.': 'ينشئ ListView.builder الصفوف المرئية فقط عند الحاجة ويعيد استخدام builder للمجموعات الكبيرة.',
    'Lists': 'القوائم',
    'Manage state and call a REST API': 'إدارة الحالة واستدعاء REST API',
    'Your app now loads habits from a backend endpoint and lets users mark one as done. You must pick a state strategy, fetch JSON data and show clear loading and error states.': 'أصبح تطبيقك يحمّل العادات من نقطة نهاية خلفية ويسمح للمستخدمين بوضع علامة إنجاز على واحدة منها. يجب أن تختار استراتيجية للحالة، وتجلب بيانات JSON، وتعرض حالات تحميل وخطأ واضحة.',
    'Intermediate': 'متوسط',
    'When is setState enough for Flutter state management?':
        'متى تكفي setState لإدارة الحالة في Flutter؟',
    'For local state owned by one widget': 'للحالة المحلية المملوكة لودجت واحد',
    'For global app state shared everywhere':
        'لحالة التطبيق العامة المشتركة في كل مكان',
    'For decoding JSON automatically': 'لفك ترميز JSON تلقائيًا',
    'For publishing to app stores': 'للنشر على متاجر التطبيقات',
    'setState is simple and appropriate for state local to one StatefulWidget. Shared or complex state usually needs a dedicated model.': 'setState بسيطة ومناسبة للحالة المحلية داخل StatefulWidget واحد. أما الحالة المشتركة أو المعقدة فتحتاج غالبًا إلى نموذج مخصص.',
    'State management': 'إدارة الحالة',
    'Which Provider pattern exposes shared state and notifies listening widgets?':
        'أي نمط من Provider يعرض الحالة المشتركة ويبلغ الودجات المستمعة؟',
    'A StatelessWidget with final fields only':
        'StatelessWidget يحتوي حقول final فقط',
    'ChangeNotifier with notifyListeners()':
        'ChangeNotifier مع notifyListeners()',
    'A const Column': 'Column ثابتة const',
    'An AndroidManifest entry': 'مدخل في AndroidManifest',
    'ChangeNotifier stores mutable state and calls notifyListeners() so Provider can rebuild dependents.': 'يخزن ChangeNotifier الحالة القابلة للتغيير ويستدعي notifyListeners() كي يعيد Provider بناء العناصر المعتمدة عليها.',
    'What should FutureBuilder render while an HTTP request is still waiting?':
        'ماذا يجب أن يعرض FutureBuilder أثناء انتظار طلب HTTP؟',
    'A success screen with fake data': 'شاشة نجاح ببيانات وهمية',
    'A loading indicator': 'مؤشر تحميل',
    'A release APK': 'ملف APK للإصدار',
    'An empty MaterialApp': 'MaterialApp فارغ',
    'FutureBuilder receives connection states, so waiting should usually show a progress indicator before data exists.': 'يتلقى FutureBuilder حالات الاتصال، لذلك يجب أن تعرض حالة الانتظار عادة مؤشر تقدم قبل توفر البيانات.',
    'Async UI': 'واجهة غير متزامنة',
    'After http.get returns JSON text, which steps turn it into typed Dart objects? (select 2)': 'بعد أن يرجع http.get نص JSON، ما الخطوتان اللتان تحولانه إلى كائنات Dart typed؟ (اختر 2)',
    'Decode the response body with jsonDecode':
        'فك ترميز جسم الاستجابة باستخدام jsonDecode',
    'Map decoded values into model constructors':
        'تحويل القيم المفكوكة إلى منشئات نماذج',
    'Call hot reload on the server': 'استدعاء hot reload على الخادم',
    'Put raw JSON directly in a TextField':
        'وضع JSON الخام مباشرة داخل TextField',
    'The HTTP response is text, so decode it first and then build typed model objects. Keeping raw JSON in widgets makes the UI fragile.': 'استجابة HTTP هي نص، لذلك فك ترميزها أولًا ثم ابنِ كائنات نموذجية typed. إبقاء JSON الخام داخل الودجات يجعل الواجهة هشة.',
    'Networking': 'الشبكات',
    'Test and ship a production app': 'اختبار تطبيق إنتاجي وشحنه',
    'The product is ready for beta users, but it must be reliable and fast. You add automated tests, reduce unnecessary rebuilds and prepare signed release artifacts for stores and CI.': 'أصبح المنتج جاهزًا لمستخدمي النسخة التجريبية، لكنه يجب أن يكون موثوقًا وسريعًا. تضيف اختبارات آلية، وتقلل عمليات إعادة البناء غير الضرورية، وتجهز ملفات إصدار موقعة للمتاجر وCI.',
    'Advanced': 'متقدم',
    'Which test checks that tapping a button changes visible UI text?':
        'أي اختبار يتحقق من أن النقر على زر يغير النص المرئي في الواجهة؟',
    'Unit test': 'اختبار وحدة',
    'Widget test': 'اختبار ودجت',
    'Golden file name only': 'اسم ملف golden فقط',
    'Manual store review': 'مراجعة يدوية للمتجر',
    'A widget test pumps widgets, interacts with them and verifies what appears on screen. Unit tests are better for pure Dart logic.': 'اختبار الودجت يشغل الودجات، ويتفاعل معها، ويتحقق مما يظهر على الشاشة. اختبارات الوحدة أفضل لمنطق Dart الصافي.',
    'Testing': 'الاختبار',
    'Which practices reduce unnecessary rebuild work? (select 2)':
        'أي ممارسات تقلل عمل إعادة البناء غير الضروري؟ (اختر 2)',
    'Use const constructors when inputs never change':
        'استخدام منشئات const عندما لا تتغير المدخلات',
    'Split large widgets so only small parts rebuild':
        'تقسيم الودجات الكبيرة بحيث يعاد بناء أجزاء صغيرة فقط',
    'Call setState around the whole app every second':
        'استدعاء setState حول التطبيق كله كل ثانية',
    'Decode JSON inside every build method': 'فك ترميز JSON داخل كل دالة build',
    'const widgets can be reused, and smaller widget boundaries limit rebuild impact. Expensive work in build methods hurts frame performance.': 'يمكن إعادة استخدام ودجات const، كما تحد حدود الودجات الأصغر من تأثير إعادة البناء. العمل المكلف داخل دوال build يضر أداء الإطارات.',
    'Performance': 'الأداء',
    'Which command creates an Android App Bundle for Play Store upload?':
        'أي أمر ينشئ Android App Bundle لرفعه إلى Play Store؟',
    'flutter test': 'flutter test',
    'flutter build apk --debug': 'flutter build apk --debug',
    'flutter build appbundle --release': 'flutter build appbundle --release',
    'dart format': 'dart format',
    'Google Play expects an AAB for many releases, produced by flutter build appbundle --release after signing is configured.': 'يتوقع Google Play ملف AAB في كثير من الإصدارات، وينتجه الأمر flutter build appbundle --release بعد إعداد التوقيع.',
    'Deployment': 'النشر',
    'What should a CI pipeline do before uploading a mobile release?':
        'ماذا يجب أن يفعل خط CI قبل رفع إصدار جوّال؟',
    'Run analyze and automated tests': 'تشغيل التحليل والاختبارات الآلية',
    'Disable all tests to save time': 'تعطيل كل الاختبارات لتوفير الوقت',
    'Commit generated secrets': 'تثبيت الأسرار المولدة في المستودع',
    'Rename every widget': 'إعادة تسمية كل ودجت',
    'CI should catch static analysis and test failures before building or uploading artifacts. Secrets must stay in secure CI storage.': 'يجب أن يكتشف CI أخطاء التحليل الثابت والاختبارات قبل البناء أو رفع الملفات. يجب أن تبقى الأسرار في تخزين CI الآمن.',
    'CI': 'CI',
  },
  coursesEn: <String, Course>{
    'flutter-1': Course(
      labId: 'flutter-1',
      intro: 'This course prepares you to build a first Flutter screen confidently. You will learn how widgets describe UI, how layout widgets share space, how hot reload accelerates feedback and why builder lists matter for real data.',
      sections: [
        CourseSection(
          title: 'Choosing StatelessWidget or StatefulWidget',
          body: 'Flutter interfaces are trees of widgets. A StatelessWidget receives input and describes the same UI until its parent gives it new values. A StatefulWidget owns a State object that can change over time, usually by calling setState. Use the simplest widget that matches the behavior because simple widgets are easier to read and test. Fixed labels, icons and decorative rows are usually stateless, while counters, forms and toggles often need state.',
          points: [
            'Widgets describe what the UI should look like.',
            'StatelessWidget has no mutable state of its own.',
            'StatefulWidget is for UI that changes internally.',
          ],
        ),
        CourseSection(
          title: 'Building rows, columns and flexible space',
          body: 'Row and Column are the everyday layout tools for Flutter screens. Row places children from left to right, while Column places them from top to bottom. Expanded is used inside a Row, Column or Flex to let a child take the remaining available space. Without Expanded, long text or large children can overflow because they keep their natural size. Combining Column for page sections and Row for each line gives a clear screen structure.',
          points: [
            'Row is horizontal and Column is vertical.',
            'Expanded shares remaining space inside a flex layout.',
            'Small layout widgets combine into complex screens.',
          ],
        ),
        CourseSection(
          title: 'Iterating with hot reload and dynamic lists',
          body: 'Hot reload updates the running app with code changes and usually keeps the current state. It is designed for fast UI iteration, such as changing colors, text or widget nesting. When a screen shows many items, ListView.builder is better than manually creating every row. The builder creates rows lazily as they become visible, which saves memory and keeps scrolling smooth. Use it whenever the list comes from data or can grow.',
          points: [
            'Hot reload keeps most state during UI changes.',
            'ListView.builder lazily builds visible rows.',
            'Builder lists scale better than hard-coded children.',
          ],
        ),
      ],
      takeaways: [
        'Pick StatelessWidget unless the widget owns changing state.',
        'Use Row, Column and Expanded to control layout.',
        'Use hot reload and ListView.builder for fast, scalable UI work.',
      ],
    ),
    'flutter-2': Course(
      labId: 'flutter-2',
      intro: 'Modern Flutter apps rarely stay static. This course teaches when local setState is enough, when Provider with ChangeNotifier helps, how async and FutureBuilder coordinate network work and how to turn HTTP JSON into reliable UI states.',
      sections: [
        CourseSection(
          title: 'Local state versus shared state',
          body: 'setState belongs to a StatefulWidget and tells Flutter that this widget subtree needs rebuilding. It is excellent for local details like a selected tab, a checkbox or a temporary form value. When the same data must be read or changed by many screens, passing callbacks through every layer becomes noisy. A ChangeNotifier model with Provider centralizes the state and calls notifyListeners when values change. Listening widgets then rebuild from the shared model.',
          points: [
            'Use setState for state owned by one widget.',
            'Use ChangeNotifier for shared mutable state.',
            'notifyListeners tells Provider dependents to rebuild.',
          ],
        ),
        CourseSection(
          title: 'Fetching data with async, await and FutureBuilder',
          body: 'Network calls take time, so Dart represents their result as a Future. The async and await keywords let code read in order while still staying non-blocking. FutureBuilder listens to a Future and rebuilds when its connection state changes. During waiting, the UI should show progress instead of fake success. When the future completes with an error, the screen should explain the problem and allow recovery.',
          points: [
            'A Future represents a value available later.',
            'FutureBuilder reacts to waiting, data and error states.',
            'Loading and error UI are part of the feature.',
          ],
        ),
        CourseSection(
          title: 'Calling REST APIs and decoding JSON',
          body: 'The http package returns a response with a status code and a body string. JSON in the body is still text until jsonDecode converts it into maps and lists. Typed Dart model constructors then validate names and convert values into objects the UI can use. Keep networking and decoding outside build methods so the screen does not repeat expensive work on every rebuild. Always handle non-success status codes as errors.',
          points: [
            'http.get retrieves text and a status code.',
            'jsonDecode converts JSON text into Dart structures.',
            'Model constructors make API data safer for widgets.',
          ],
        ),
      ],
      takeaways: [
        'Local state can use setState; shared state needs a model.',
        'FutureBuilder should show loading, data and error branches.',
        'Decode JSON, then map it into typed Dart objects.',
      ],
    ),
    'flutter-3': Course(
      labId: 'flutter-3',
      intro: 'Shipping Flutter professionally means more than making the screen look right. This course covers the tests that prevent regressions, performance habits that keep frames smooth and the release and CI steps that prepare store-ready artifacts.',
      sections: [
        CourseSection(
          title: 'Unit tests and widget tests',
          body: 'A unit test checks pure Dart logic without rendering a screen. It is fast and perfect for functions, validators and model behavior. A widget test pumps a widget tree, interacts with widgets and verifies visible output. Use widget tests when a tap, text field or state change must be reflected in the UI. Together, these tests catch both logic errors and broken user flows before release.',
          points: [
            'Unit tests target pure Dart logic.',
            'Widget tests interact with rendered widgets.',
            'Automated tests protect changes from regressions.',
          ],
        ),
        CourseSection(
          title: 'Reducing rebuild cost',
          body: 'Flutter can rebuild widgets often, so build methods should stay cheap. A const widget with unchanged inputs can be reused instead of recreated. Splitting a large screen into focused widgets lets Flutter rebuild only the parts affected by changing state. Avoid decoding JSON, sorting huge lists or starting network calls inside build because build may run many times. Profiling helps find frames where expensive work causes jank.',
          points: [
            'Use const constructors for stable widgets.',
            'Split widgets to limit rebuild scope.',
            'Keep expensive work out of build methods.',
          ],
        ),
        CourseSection(
          title: 'Release builds, stores and CI',
          body: 'Debug builds are for development and include tooling that should not ship to users. Android releases commonly produce an APK for direct testing and an AAB for Google Play distribution. Store releases require signing, versioning, icons, permissions and privacy information. A CI pipeline should run analyze and tests before building release artifacts. Secrets such as signing keys or upload tokens belong in secure CI variables, not in source code.',
          points: [
            'Use release builds for store artifacts.',
            'Play Store commonly receives an AAB.',
            'CI should analyze, test and build with protected secrets.',
          ],
        ),
      ],
      takeaways: [
        'Use unit tests for logic and widget tests for UI behavior.',
        'const widgets and small widget boundaries improve performance.',
        'Release builds and CI make store delivery repeatable.',
      ],
    ),
  },
  coursesFr: <String, Course>{
    'flutter-1': Course(
      labId: 'flutter-1',
      intro: 'Ce cours te prépare à construire un premier écran Flutter avec confiance. Tu vas apprendre comment les widgets décrivent l’interface, comment les widgets de mise en page partagent l’espace, comment le hot reload accélère les retours et pourquoi les listes builder sont importantes avec de vraies données.',
      sections: [
        CourseSection(
          title: 'Choisir StatelessWidget ou StatefulWidget',
          body: 'Les interfaces Flutter sont des arbres de widgets. Un StatelessWidget reçoit des entrées et décrit la même interface jusqu’à ce que son parent lui donne de nouvelles valeurs. Un StatefulWidget possède un objet State qui peut changer avec le temps, généralement en appelant setState. Utilise le widget le plus simple qui correspond au comportement, car un widget simple est plus facile à lire et à tester. Les libellés fixes, icônes et lignes décoratives sont souvent stateless, tandis que les compteurs, formulaires et interrupteurs ont souvent besoin d’état.',
          points: [
            'Les widgets décrivent à quoi doit ressembler l’interface.',
            'StatelessWidget n’a pas d’état mutable propre.',
            'StatefulWidget sert à une interface qui change en interne.',
          ],
        ),
        CourseSection(
          title: 'Construire des rows, columns et espaces flexibles',
          body: 'Row et Column sont les outils de mise en page quotidiens des écrans Flutter. Row place les enfants de gauche à droite, tandis que Column les place de haut en bas. Expanded s’utilise dans un Row, un Column ou un Flex pour laisser un enfant prendre l’espace disponible restant. Sans Expanded, un texte long ou un grand enfant peut déborder parce qu’il garde sa taille naturelle. Combiner Column pour les sections de page et Row pour chaque ligne donne une structure claire.',
          points: [
            'Row est horizontal et Column est vertical.',
            'Expanded partage l’espace restant dans une mise en page flex.',
            'De petits widgets de layout composent des écrans complexes.',
          ],
        ),
        CourseSection(
          title: 'Itérer avec hot reload et listes dynamiques',
          body: 'Le hot reload met à jour l’application en cours d’exécution avec les changements de code et conserve généralement l’état courant. Il est conçu pour itérer vite sur l’interface, par exemple changer les couleurs, les textes ou l’imbrication des widgets. Quand un écran affiche beaucoup d’éléments, ListView.builder est meilleur que créer manuellement chaque ligne. Le builder crée les lignes paresseusement lorsqu’elles deviennent visibles, ce qui économise la mémoire et garde un défilement fluide. Utilise-le dès que la liste vient de données ou peut grandir.',
          points: [
            'Le hot reload garde la plupart de l’état pendant les changements UI.',
            'ListView.builder construit paresseusement les lignes visibles.',
            'Les listes builder passent mieux à l’échelle que des enfants codés en dur.',
          ],
        ),
      ],
      takeaways: [
        'Choisis StatelessWidget sauf si le widget possède un état changeant.',
        'Utilise Row, Column et Expanded pour contrôler la mise en page.',
        'Utilise hot reload et ListView.builder pour un travail UI rapide et évolutif.',
      ],
    ),
    'flutter-2': Course(
      labId: 'flutter-2',
      intro: 'Les applications Flutter modernes restent rarement statiques. Ce cours t’apprend quand l’état local avec setState suffit, quand Provider avec ChangeNotifier aide, comment async et FutureBuilder coordonnent le réseau et comment transformer du JSON HTTP en états d’interface fiables.',
      sections: [
        CourseSection(
          title: 'État local contre état partagé',
          body: 'setState appartient à un StatefulWidget et indique à Flutter que ce sous-arbre doit se reconstruire. Il est excellent pour des détails locaux comme un onglet sélectionné, une case à cocher ou une valeur temporaire de formulaire. Quand les mêmes données doivent être lues ou modifiées par plusieurs écrans, passer des callbacks partout devient bruyant. Un modèle ChangeNotifier avec Provider centralise l’état et appelle notifyListeners quand les valeurs changent. Les widgets à l’écoute se reconstruisent alors depuis le modèle partagé.',
          points: [
            'Utilise setState pour l’état possédé par un seul widget.',
            'Utilise ChangeNotifier pour un état mutable partagé.',
            'notifyListeners demande aux dépendants Provider de se reconstruire.',
          ],
        ),
        CourseSection(
          title: 'Récupérer des données avec async, await et FutureBuilder',
          body: 'Les appels réseau prennent du temps, donc Dart représente leur résultat par un Future. Les mots-clés async et await permettent de lire le code dans l’ordre tout en restant non bloquant. FutureBuilder écoute un Future et se reconstruit quand son état de connexion change. Pendant l’attente, l’interface doit montrer une progression au lieu d’un faux succès. Si le future se termine en erreur, l’écran doit expliquer le problème et permettre de réessayer.',
          points: [
            'Un Future représente une valeur disponible plus tard.',
            'FutureBuilder réagit aux états attente, données et erreur.',
            'Les UI de chargement et d’erreur font partie de la fonctionnalité.',
          ],
        ),
        CourseSection(
          title: 'Appeler des API REST et décoder JSON',
          body: 'Le package http renvoie une réponse avec un code de statut et un corps texte. Le JSON dans le corps reste du texte tant que jsonDecode ne le convertit pas en maps et listes. Des constructeurs de modèles Dart typés valident ensuite les noms et convertissent les valeurs en objets utilisables par l’interface. Garde le réseau et le décodage hors des méthodes build pour éviter de répéter un travail coûteux à chaque reconstruction. Traite toujours les codes non réussis comme des erreurs.',
          points: [
            'http.get récupère du texte et un code de statut.',
            'jsonDecode convertit le texte JSON en structures Dart.',
            'Les constructeurs de modèles rendent les données API plus sûres pour les widgets.',
          ],
        ),
      ],
      takeaways: [
        'L’état local peut utiliser setState ; l’état partagé a besoin d’un modèle.',
        'FutureBuilder doit montrer chargement, données et erreur.',
        'Décode JSON, puis mappe-le vers des objets Dart typés.',
      ],
    ),
    'flutter-3': Course(
      labId: 'flutter-3',
      intro: 'Livrer Flutter professionnellement demande plus que réussir l’apparence de l’écran. Ce cours couvre les tests qui évitent les régressions, les habitudes de performance qui gardent les frames fluides et les étapes de release et CI qui préparent des artefacts prêts pour les stores.',
      sections: [
        CourseSection(
          title: 'Tests unitaires et tests de widgets',
          body: 'Un test unitaire vérifie une logique Dart pure sans rendre d’écran. Il est rapide et parfait pour les fonctions, validateurs et comportements de modèles. Un test de widget lance un arbre de widgets, interagit avec eux et vérifie la sortie visible. Utilise les tests de widgets quand un appui, un champ texte ou un changement d’état doit se refléter dans l’interface. Ensemble, ces tests détectent les erreurs de logique et les parcours utilisateur cassés avant la release.',
          points: [
            'Les tests unitaires ciblent la logique Dart pure.',
            'Les tests de widgets interagissent avec des widgets rendus.',
            'Les tests automatisés protègent les changements contre les régressions.',
          ],
        ),
        CourseSection(
          title: 'Réduire le coût des reconstructions',
          body: 'Flutter peut reconstruire les widgets souvent, donc les méthodes build doivent rester légères. Un widget const avec des entrées inchangées peut être réutilisé au lieu d’être recréé. Découper un grand écran en widgets ciblés permet à Flutter de reconstruire seulement les parties affectées par l’état qui change. Évite de décoder JSON, de trier de grosses listes ou de lancer des appels réseau dans build, car build peut s’exécuter souvent. Le profilage aide à trouver les frames où un travail coûteux crée des saccades.',
          points: [
            'Utilise des constructeurs const pour les widgets stables.',
            'Découpe les widgets pour limiter la portée des reconstructions.',
            'Garde le travail coûteux hors des méthodes build.',
          ],
        ),
        CourseSection(
          title: 'Builds de release, stores et CI',
          body: 'Les builds debug servent au développement et incluent des outils qui ne doivent pas partir chez les utilisateurs. Les releases Android produisent souvent un APK pour les tests directs et un AAB pour la distribution Google Play. Les sorties store exigent signature, versioning, icônes, permissions et informations de confidentialité. Un pipeline CI doit exécuter l’analyse et les tests avant de construire les artefacts de release. Les secrets comme les clés de signature ou jetons d’upload restent dans des variables CI sécurisées, pas dans le code source.',
          points: [
            'Utilise des builds release pour les artefacts store.',
            'Le Play Store reçoit souvent un AAB.',
            'La CI doit analyser, tester et construire avec des secrets protégés.',
          ],
        ),
      ],
      takeaways: [
        'Utilise les tests unitaires pour la logique et les tests de widgets pour l’UI.',
        'Les widgets const et de petites frontières de widgets améliorent la performance.',
        'Les builds release et la CI rendent la livraison store répétable.',
      ],
    ),
  },
  coursesAr: <String, Course>{
    'flutter-1': Course(
      labId: 'flutter-1',
      intro: 'يجهزك هذا الدرس لبناء أول شاشة Flutter بثقة. ستتعلم كيف تصف الودجات الواجهة، وكيف توزع ودجات التخطيط المساحة، وكيف يسرّع hot reload دورة الملاحظات، ولماذا تهم قوائم builder عند التعامل مع بيانات حقيقية.',
      sections: [
        CourseSection(
          title: 'اختيار StatelessWidget أو StatefulWidget',
          body: 'واجهات Flutter هي أشجار من الودجات. يستقبل StatelessWidget مدخلات ويصف الواجهة نفسها إلى أن يعطيه الأب قيماً جديدة. يمتلك StatefulWidget كائن State يمكن أن يتغير مع الوقت، عادة عبر استدعاء setState. استخدم أبسط ودجت يطابق السلوك لأن الودجات البسيطة أسهل في القراءة والاختبار. النصوص الثابتة والأيقونات والصفوف الزخرفية تكون غالباً stateless، بينما تحتاج العدادات والنماذج والمفاتيح إلى حالة.',
          points: [
            'تصف الودجات الشكل الذي يجب أن تظهر به الواجهة.',
            'StatelessWidget لا يملك حالة قابلة للتغيير خاصة به.',
            'StatefulWidget مخصص لواجهة تتغير داخلياً.',
          ],
        ),
        CourseSection(
          title: 'بناء الصفوف والأعمدة والمساحة المرنة',
          body: 'Row وColumn هما أداتا التخطيط اليوميتان لشاشات Flutter. يضع Row العناصر من اليسار إلى اليمين، بينما يضعها Column من الأعلى إلى الأسفل. يستخدم Expanded داخل Row أو Column أو Flex لكي يأخذ عنصر المساحة المتبقية المتاحة. بدون Expanded قد يفيض النص الطويل أو العنصر الكبير لأنه يحتفظ بحجمه الطبيعي. جمع Column لأقسام الصفحة وRow لكل سطر يعطي بنية شاشة واضحة.',
          points: [
            'Row أفقي وColumn عمودي.',
            'Expanded يشارك المساحة المتبقية داخل تخطيط flex.',
            'تتحد ودجات التخطيط الصغيرة لبناء شاشات معقدة.',
          ],
        ),
        CourseSection(
          title: 'التكرار باستخدام hot reload والقوائم الديناميكية',
          body: 'يحدّث hot reload التطبيق العامل بتغييرات الشفرة ويحافظ عادة على الحالة الحالية. صمم للتكرار السريع على الواجهة، مثل تغيير الألوان أو النصوص أو تداخل الودجات. عندما تعرض الشاشة عناصر كثيرة، يكون ListView.builder أفضل من إنشاء كل صف يدوياً. ينشئ builder الصفوف عند الحاجة عندما تصبح مرئية، وهذا يوفر الذاكرة ويحافظ على سلاسة التمرير. استخدمه كلما جاءت القائمة من بيانات أو كان يمكن أن تكبر.',
          points: [
            'يحافظ hot reload على معظم الحالة أثناء تغييرات الواجهة.',
            'يبني ListView.builder الصفوف المرئية عند الحاجة.',
            'قوائم builder تتوسع أفضل من عناصر مكتوبة يدوياً.',
          ],
        ),
      ],
      takeaways: [
        'اختر StatelessWidget إلا إذا كان الودجت يملك حالة متغيرة.',
        'استخدم Row وColumn وExpanded للتحكم في التخطيط.',
        'استخدم hot reload وListView.builder لعمل واجهة سريع وقابل للتوسع.',
      ],
    ),
    'flutter-2': Course(
      labId: 'flutter-2',
      intro: 'نادراً ما تبقى تطبيقات Flutter الحديثة ثابتة. يعلمك هذا الدرس متى تكفي setState المحلية، ومتى يساعد Provider مع ChangeNotifier، وكيف ينسق async وFutureBuilder عمل الشبكة، وكيف تحول JSON القادم عبر HTTP إلى حالات واجهة موثوقة.',
      sections: [
        CourseSection(
          title: 'الحالة المحلية مقابل الحالة المشتركة',
          body: 'تنتمي setState إلى StatefulWidget وتخبر Flutter أن هذا الفرع من الشجرة يحتاج إلى إعادة بناء. هي ممتازة للتفاصيل المحلية مثل تبويب محدد أو خانة اختيار أو قيمة نموذج مؤقتة. عندما يجب أن تقرأ عدة شاشات البيانات نفسها أو تغيرها، يصبح تمرير callbacks عبر كل الطبقات مزعجاً. نموذج ChangeNotifier مع Provider يركز الحالة ويستدعي notifyListeners عندما تتغير القيم. بعدها تعيد الودجات المستمعة البناء من النموذج المشترك.',
          points: [
            'استخدم setState للحالة التي يملكها ودجت واحد.',
            'استخدم ChangeNotifier للحالة المشتركة القابلة للتغيير.',
            'notifyListeners يخبر عناصر Provider المعتمدة أن تعيد البناء.',
          ],
        ),
        CourseSection(
          title: 'جلب البيانات باستخدام async وawait وFutureBuilder',
          body: 'تستغرق استدعاءات الشبكة وقتاً، لذلك يمثل Dart نتيجتها كـ Future. تسمح الكلمتان async وawait بقراءة الشفرة بالترتيب مع بقائها غير حاجبة. يستمع FutureBuilder إلى Future ويعيد البناء عندما تتغير حالة الاتصال. أثناء الانتظار يجب أن تعرض الواجهة تقدم التحميل بدلاً من نجاح وهمي. إذا انتهى future بخطأ، يجب أن تشرح الشاشة المشكلة وتسمح بالتعافي.',
          points: [
            'يمثل Future قيمة ستتوفر لاحقاً.',
            'يتفاعل FutureBuilder مع حالات الانتظار والبيانات والخطأ.',
            'واجهات التحميل والخطأ جزء من الميزة.',
          ],
        ),
        CourseSection(
          title: 'استدعاء REST APIs وفك ترميز JSON',
          body: 'يرجع package http استجابة لها رمز حالة وجسم نصي. يبقى JSON في الجسم نصاً إلى أن يحوله jsonDecode إلى خرائط وقوائم. بعدها تتحقق منشئات نماذج Dart typed من الأسماء وتحول القيم إلى كائنات يمكن للواجهة استخدامها. أبقِ الشبكة وفك الترميز خارج دوال build حتى لا تكرر الشاشة عملاً مكلفاً عند كل إعادة بناء. تعامل دائماً مع رموز الحالة غير الناجحة كأخطاء.',
          points: [
            'يجلب http.get نصاً ورمز حالة.',
            'يحول jsonDecode نص JSON إلى هياكل Dart.',
            'تجعل منشئات النماذج بيانات API أكثر أماناً للودجات.',
          ],
        ),
      ],
      takeaways: [
        'يمكن للحالة المحلية استخدام setState، أما المشتركة فتحتاج نموذجاً.',
        'يجب أن يعرض FutureBuilder فروع التحميل والبيانات والخطأ.',
        'فك ترميز JSON ثم حوّله إلى كائنات Dart typed.',
      ],
    ),
    'flutter-3': Course(
      labId: 'flutter-3',
      intro: 'شحن Flutter باحتراف يعني أكثر من جعل الشاشة تبدو صحيحة. يغطي هذا الدرس الاختبارات التي تمنع الانحدارات، وعادات الأداء التي تبقي الإطارات سلسة، وخطوات الإصدار وCI التي تجهز ملفات مناسبة للمتاجر.',
      sections: [
        CourseSection(
          title: 'اختبارات الوحدة واختبارات الودجات',
          body: 'يفحص اختبار الوحدة منطق Dart الصافي دون رسم شاشة. هو سريع ومثالي للدوال والمدققات وسلوك النماذج. يضخ اختبار الودجت شجرة ودجات، ويتفاعل مع الودجات، ويتحقق من الناتج المرئي. استخدم اختبارات الودجات عندما يجب أن يظهر أثر نقرة أو حقل نص أو تغير حالة في الواجهة. معاً تلتقط هذه الاختبارات أخطاء المنطق وتدفقات المستخدم المكسورة قبل الإصدار.',
          points: [
            'تستهدف اختبارات الوحدة منطق Dart الصافي.',
            'تتفاعل اختبارات الودجات مع ودجات مرسومة.',
            'تحمي الاختبارات الآلية التغييرات من الانحدارات.',
          ],
        ),
        CourseSection(
          title: 'تقليل تكلفة إعادة البناء',
          body: 'يمكن أن يعيد Flutter بناء الودجات كثيراً، لذلك يجب أن تبقى دوال build خفيفة. يمكن إعادة استخدام ودجت const بمدخلات لا تتغير بدلاً من إنشائه من جديد. تقسيم شاشة كبيرة إلى ودجات مركزة يسمح لـ Flutter بإعادة بناء الأجزاء المتأثرة فقط بالحالة المتغيرة. تجنب فك ترميز JSON أو فرز قوائم ضخمة أو بدء استدعاءات شبكة داخل build لأن build قد يعمل مرات كثيرة. يساعد التحليل بالأدوات على إيجاد الإطارات التي يسبب فيها العمل المكلف تقطعاً.',
          points: [
            'استخدم منشئات const للودجات الثابتة.',
            'قسّم الودجات لتحديد نطاق إعادة البناء.',
            'أبقِ العمل المكلف خارج دوال build.',
          ],
        ),
        CourseSection(
          title: 'بناءات الإصدار والمتاجر وCI',
          body: 'بناءات debug مخصصة للتطوير وتتضمن أدوات لا يجب شحنها للمستخدمين. تنتج إصدارات Android عادة APK للاختبار المباشر وAAB للتوزيع عبر Google Play. تتطلب إصدارات المتاجر التوقيع وإدارة الإصدارات والأيقونات والأذونات ومعلومات الخصوصية. يجب أن يشغل خط CI التحليل والاختبارات قبل بناء ملفات الإصدار. الأسرار مثل مفاتيح التوقيع أو رموز الرفع مكانها متغيرات CI آمنة، وليس الشفرة المصدرية.',
          points: [
            'استخدم بناءات release لملفات المتاجر.',
            'يستقبل Play Store غالباً ملف AAB.',
            'يجب أن يحلل CI ويختبر ويبني باستخدام أسرار محمية.',
          ],
        ),
      ],
      takeaways: [
        'استخدم اختبارات الوحدة للمنطق واختبارات الودجات لسلوك الواجهة.',
        'تحسن ودجات const وحدود الودجات الصغيرة الأداء.',
        'تجعل بناءات release وCI تسليم المتاجر قابلاً للتكرار.',
      ],
    ),
  },
  courseExamples: <String, List<String?>>{
    'flutter-1': [
      "class WelcomeTitle extends StatelessWidget {\n"
          "  const WelcomeTitle({super.key});\n"
          "  @override\n"
          "  Widget build(BuildContext context) {\n"
          "    return const Text('Track habits');\n"
          "  }\n"
          "}",
      "Row(\n"
          "  children: const [\n"
          "    Icon(Icons.check_circle),\n"
          "    SizedBox(width: 12),\n"
          "    Expanded(child: Text('Drink water')),\n"
          "  ],\n"
          ")",
      "ListView.builder(\n"
          "  itemCount: habits.length,\n"
          "  itemBuilder: (context, index) {\n"
          "    return ListTile(title: Text(habits[index]));\n"
          "  },\n"
          ")",
    ],
    'flutter-2': [
      "class HabitsModel extends ChangeNotifier {\n"
          "  final habits = <String>[];\n"
          "  void add(String habit) {\n"
          "    habits.add(habit);\n"
          "    notifyListeners();\n"
          "  }\n"
          "}",
      "FutureBuilder<List<Habit>>(\n"
          "  future: fetchHabits(),\n"
          "  builder: (context, snapshot) {\n"
          "    if (snapshot.hasError) return const Text('Error');\n"
          "    if (!snapshot.hasData) return const CircularProgressIndicator();\n"
          "    return HabitList(snapshot.data!);\n"
          "  },\n"
          ")",
      "final response = await http.get(Uri.parse(apiUrl));\n"
          "if (response.statusCode != 200) throw Exception('Failed');\n"
          "final items = jsonDecode(response.body) as List<dynamic>;\n"
          "return items\n"
          "    .map((json) => Habit.fromJson(json as Map<String, dynamic>))\n"
          "    .toList();",
    ],
    'flutter-3': [
      "testWidgets('marks habit done', (tester) async {\n"
          "  await tester.pumpWidget(const HabitApp());\n"
          "  await tester.tap(find.text('Done'));\n"
          "  await tester.pump();\n"
          "  expect(find.text('Completed'), findsOneWidget);\n"
          "});",
      "class HabitRow extends StatelessWidget {\n"
          "  const HabitRow({super.key, required this.title});\n"
          "  final String title;\n"
          "  @override\n"
          "  Widget build(BuildContext context) => Text(title);\n"
          "}",
      "flutter analyze\n"
          "flutter test\n"
          "flutter build appbundle --release",
    ],
  },
);
