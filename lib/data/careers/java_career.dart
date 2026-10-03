import 'package:flutter/material.dart';

import '../../models/career.dart';
import '../../models/career_pack.dart';
import '../../models/course.dart';

const javaPack = CareerPack(
  career: Career(
    id: 'java',
    title: 'Java Developer',
    summary:
        'Build robust Java applications, REST APIs and services that scale.',
    description: 'Java developers create reliable business applications, APIs and data services for web, mobile and enterprise products. They use object-oriented design, the JVM ecosystem and frameworks like Spring Boot to deliver maintainable software.',
    icon: Icons.coffee_outlined,
    color: Color(0xFFE76F00),
    tools: ['Java', 'Spring Boot', 'Maven', 'IntelliJ IDEA'],
    tags: ['Technology', 'Development', 'Problem solving'],
    salary: '38k – 62k € / year',
    outlook: 'Demand remains strong in finance, SaaS, consulting and large enterprise platforms.',
    education: 'Bac+2 to Bac+5 in software engineering or computer science',
    dailyTasks: [
      'Design Java classes and services',
      'Build and document REST endpoints',
      'Write tests and debug production issues',
      'Review code with the team',
    ],
    labs: [
      Lab(
        id: 'java-1',
        title: 'Java and object-oriented basics',
        scenario: 'You join a team rebuilding a small library management app in Java. Model the domain cleanly, choose the right collections and handle failures without hiding bugs.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'In Java, what is an object?',
            options: [
              'A blueprint that declares fields and methods',
              'A package imported from the JDK',
              'A runtime instance created from a class',
              'A comment used by the compiler',
            ],
            correct: {2},
            skill: 'OOP',
            explanation: 'A class is the blueprint; an object is a concrete instance with state and behavior at runtime.',
          ),
          LabQuestion(
            prompt: 'Which choices support encapsulation in a Java class? (select 2)',
            options: [
              'Keep fields private',
              'Expose every field as public',
              'Provide methods that validate state changes',
              'Put all code in one static method',
            ],
            correct: {0, 2},
            skill: 'Encapsulation',
            explanation: 'Encapsulation hides internal state and exposes controlled operations that protect invariants.',
          ),
          LabQuestion(
            prompt: 'Several payment providers share behavior but each provider has different implementation details. What should the service depend on?',
            options: [
              'One concrete provider class everywhere',
              'An interface implemented by each provider',
              'A Map with random keys',
              'A checked exception',
            ],
            correct: {1},
            skill: 'Interfaces',
            explanation: 'Depending on an interface lets the service use polymorphism while keeping provider implementations replaceable.',
          ),
          LabQuestion(
            prompt: 'A repository must find users quickly by id and report missing users clearly. Which design fits best?',
            options: [
              'Store users in a List and ignore missing ids',
              'Store users in a Map<String, User> and throw a specific exception when an id is absent',
              'Store one user per field in the class',
              'Catch every Exception and return null',
            ],
            correct: {1},
            skill: 'Collections',
            explanation: 'A Map gives direct lookup by key, and a specific exception makes the failure explicit instead of silently returning invalid data.',
          ),
        ],
      ),
      Lab(
        id: 'java-2',
        title: 'Build a REST API with Spring Boot',
        scenario: 'Your team needs a Spring Boot API for managing course registrations. Expose clear endpoints, validate input and persist data through a repository layer.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'Which annotation makes a class expose JSON REST endpoints in Spring Boot?',
            options: [
              '@Entity',
              '@Repository',
              '@RestController',
              '@AutowiredOnly',
            ],
            correct: {2},
            skill: 'Spring',
            explanation: '@RestController combines controller behavior with JSON response bodies for web endpoints.',
          ),
          LabQuestion(
            prompt:
                'Which code maps an HTTP GET request for /courses to a method?',
            options: [
              '@PostMapping("/courses")',
              '@GetMapping("/courses")',
              '@Table("courses")',
              '@Column("/courses")',
            ],
            correct: {1},
            skill: 'REST APIs',
            explanation: '@GetMapping declares that a controller method handles GET requests for the given path.',
          ),
          LabQuestion(
            prompt:
                'Which Spring practices keep the API maintainable? (select 2)',
            options: [
              'Inject services through constructors',
              'Create repositories by extending JpaRepository',
              'Instantiate dependencies with new inside every method',
              'Put SQL credentials in controller code',
            ],
            correct: {0, 1},
            skill: 'Dependency injection',
            explanation: 'Constructor injection makes dependencies explicit, and Spring Data repositories remove boilerplate persistence code.',
          ),
          LabQuestion(
            prompt: 'A client sends invalid JSON for creating a course. Which response is most appropriate?',
            options: [
              '201 Created',
              '400 Bad Request with validation errors',
              '204 No Content',
              '500 Internal Server Error',
            ],
            correct: {1},
            skill: 'Validation',
            explanation: 'Invalid client input should produce a 400 response, ideally with useful validation details.',
          ),
        ],
      ),
      Lab(
        id: 'java-3',
        title: 'Concurrency and JVM performance',
        scenario: 'A Java service processes many background jobs and has started showing slow responses under load. You must use threads safely, measure performance and avoid changes that only look faster.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'What is the safest way to run many short independent tasks in Java?',
            options: [
              'Create an unbounded new Thread for every request',
              'Use an ExecutorService with a bounded thread pool',
              'Call Thread.sleep before every task',
              'Make the main method synchronized',
            ],
            correct: {1},
            skill: 'Concurrency',
            explanation: 'ExecutorService reuses worker threads and a bounded pool protects the JVM from uncontrolled thread growth.',
          ),
          LabQuestion(
            prompt: 'Two threads increment the same counter and sometimes lose updates. What is the likely cause?',
            options: [
              'A race condition on shared mutable state',
              'Too many package declarations',
              'The garbage collector deleting source code',
              'A missing Maven dependency for int',
            ],
            correct: {0},
            skill: 'Synchronization',
            explanation: 'Concurrent read-modify-write operations need synchronization, locks or atomic types to avoid lost updates.',
          ),
          LabQuestion(
            prompt: 'Which actions help investigate a suspected memory leak? (select 2)',
            options: [
              'Capture a heap dump and inspect retained objects',
              'Profile allocation and garbage collection behavior',
              'Increase logging until the leak disappears',
              'Replace every loop with a stream automatically',
            ],
            correct: {0, 1},
            skill: 'Performance',
            explanation: 'Heap dumps and profilers reveal which objects remain referenced and how allocation pressure affects garbage collection.',
          ),
          LabQuestion(
            prompt: 'A stream pipeline is slower than a simple loop in a hot path. What should you do?',
            options: [
              'Keep the stream because streams are always faster',
              'Measure with a benchmark and choose the clearer fast-enough option',
              'Disable the garbage collector',
              'Use parallelStream for every collection',
            ],
            correct: {1},
            skill: 'Profiling',
            explanation: 'Streams improve expressiveness but are not automatically faster; profiling and benchmarks should guide hot-path decisions.',
          ),
        ],
      ),
    ],
  ),
  interests: ['Programming', 'Problem solving', 'Data', 'Teamwork'],
  contentFr: <String, String>{
    'Java Developer': 'Développeur Java',
    'Build robust Java applications, REST APIs and services that scale.': 'Construis des applications Java robustes, des API REST et des services capables de passer à l’échelle.',
    'Java developers create reliable business applications, APIs and data services for web, mobile and enterprise products. They use object-oriented design, the JVM ecosystem and frameworks like Spring Boot to deliver maintainable software.': 'Les développeurs Java créent des applications métier fiables, des API et des services de données pour des produits web, mobiles et d’entreprise. Ils utilisent la conception orientée objet, l’écosystème JVM et des frameworks comme Spring Boot pour livrer des logiciels maintenables.',
    '38k – 62k € / year': '38k – 62k € / an',
    'Demand remains strong in finance, SaaS, consulting and large enterprise platforms.': 'La demande reste forte dans la finance, le SaaS, le conseil et les grandes plateformes d’entreprise.',
    'Bac+2 to Bac+5 in software engineering or computer science':
        'Bac+2 à Bac+5 en génie logiciel ou informatique',
    'Design Java classes and services':
        'Concevoir des classes et des services Java',
    'Build and document REST endpoints':
        'Construire et documenter des endpoints REST',
    'Write tests and debug production issues':
        'Écrire des tests et déboguer les incidents de production',
    'Review code with the team': 'Relire le code avec l’équipe',
    'Technology': 'Technologie',
    'Development': 'Développement',
    'Problem solving': 'Résolution de problèmes',
    'Java and object-oriented basics': 'Java et bases de l’orienté objet',
    'You join a team rebuilding a small library management app in Java. Model the domain cleanly, choose the right collections and handle failures without hiding bugs.': 'Tu rejoins une équipe qui reconstruit une petite application de gestion de bibliothèque en Java. Modélise le domaine proprement, choisis les bonnes collections et gère les échecs sans cacher les bugs.',
    'Beginner': 'Débutant',
    'In Java, what is an object?': 'En Java, qu’est-ce qu’un objet ?',
    'A blueprint that declares fields and methods':
        'Un plan qui déclare des champs et des méthodes',
    'A package imported from the JDK': 'Un package importé depuis le JDK',
    'A runtime instance created from a class':
        'Une instance d’exécution créée à partir d’une classe',
    'A comment used by the compiler':
        'Un commentaire utilisé par le compilateur',
    'A class is the blueprint; an object is a concrete instance with state and behavior at runtime.': 'Une classe est le plan ; un objet est une instance concrète avec un état et un comportement à l’exécution.',
    'OOP': 'POO',
    'Which choices support encapsulation in a Java class? (select 2)': 'Quels choix favorisent l’encapsulation dans une classe Java ? (2 réponses)',
    'Keep fields private': 'Garder les champs privés',
    'Expose every field as public': 'Exposer tous les champs en public',
    'Provide methods that validate state changes':
        'Fournir des méthodes qui valident les changements d’état',
    'Put all code in one static method':
        'Mettre tout le code dans une seule méthode statique',
    'Encapsulation hides internal state and exposes controlled operations that protect invariants.': 'L’encapsulation cache l’état interne et expose des opérations contrôlées qui protègent les invariants.',
    'Encapsulation': 'Encapsulation',
    'Several payment providers share behavior but each provider has different implementation details. What should the service depend on?': 'Plusieurs fournisseurs de paiement partagent un comportement, mais chacun a des détails d’implémentation différents. De quoi le service doit-il dépendre ?',
    'One concrete provider class everywhere':
        'Une classe concrète de fournisseur partout',
    'An interface implemented by each provider':
        'Une interface implémentée par chaque fournisseur',
    'A Map with random keys': 'Une Map avec des clés aléatoires',
    'A checked exception': 'Une exception vérifiée',
    'Depending on an interface lets the service use polymorphism while keeping provider implementations replaceable.': 'Dépendre d’une interface permet au service d’utiliser le polymorphisme tout en gardant les implémentations de fournisseurs remplaçables.',
    'Interfaces': 'Interfaces',
    'A repository must find users quickly by id and report missing users clearly. Which design fits best?': 'Un repository doit retrouver rapidement les utilisateurs par id et signaler clairement les absences. Quelle conception convient le mieux ?',
    'Store users in a List and ignore missing ids':
        'Stocker les utilisateurs dans une List et ignorer les ids absents',
    'Store users in a Map<String, User> and throw a specific exception when an id is absent': 'Stocker les utilisateurs dans une Map<String, User> et lever une exception spécifique quand un id est absent',
    'Store one user per field in the class':
        'Stocker un utilisateur par champ dans la classe',
    'Catch every Exception and return null':
        'Attraper toutes les Exception et retourner null',
    'A Map gives direct lookup by key, and a specific exception makes the failure explicit instead of silently returning invalid data.': 'Une Map donne une recherche directe par clé, et une exception spécifique rend l’échec explicite au lieu de retourner silencieusement des données invalides.',
    'Collections': 'Collections',
    'Build a REST API with Spring Boot':
        'Construire une API REST avec Spring Boot',
    'Your team needs a Spring Boot API for managing course registrations. Expose clear endpoints, validate input and persist data through a repository layer.': 'Ton équipe a besoin d’une API Spring Boot pour gérer des inscriptions à des cours. Expose des endpoints clairs, valide les entrées et persiste les données via une couche repository.',
    'Intermediate': 'Intermédiaire',
    'Which annotation makes a class expose JSON REST endpoints in Spring Boot?': 'Quelle annotation permet à une classe d’exposer des endpoints REST JSON dans Spring Boot ?',
    '@Entity': '@Entity',
    '@Repository': '@Repository',
    '@RestController': '@RestController',
    '@AutowiredOnly': '@AutowiredOnly',
    '@RestController combines controller behavior with JSON response bodies for web endpoints.': '@RestController combine le comportement d’un contrôleur avec des corps de réponse JSON pour les endpoints web.',
    'Spring': 'Spring',
    'Which code maps an HTTP GET request for /courses to a method?':
        'Quel code associe une requête HTTP GET sur /courses à une méthode ?',
    '@PostMapping("/courses")': '@PostMapping("/courses")',
    '@GetMapping("/courses")': '@GetMapping("/courses")',
    '@Table("courses")': '@Table("courses")',
    '@Column("/courses")': '@Column("/courses")',
    '@GetMapping declares that a controller method handles GET requests for the given path.': '@GetMapping déclare qu’une méthode de contrôleur traite les requêtes GET pour le chemin donné.',
    'REST APIs': 'API REST',
    'Which Spring practices keep the API maintainable? (select 2)':
        'Quelles pratiques Spring gardent l’API maintenable ? (2 réponses)',
    'Inject services through constructors':
        'Injecter les services via les constructeurs',
    'Create repositories by extending JpaRepository':
        'Créer des repositories en étendant JpaRepository',
    'Instantiate dependencies with new inside every method':
        'Instancier les dépendances avec new dans chaque méthode',
    'Put SQL credentials in controller code':
        'Mettre les identifiants SQL dans le code du contrôleur',
    'Constructor injection makes dependencies explicit, and Spring Data repositories remove boilerplate persistence code.': 'L’injection par constructeur rend les dépendances explicites, et les repositories Spring Data suppriment le code de persistance répétitif.',
    'Dependency injection': 'Injection de dépendances',
    'A client sends invalid JSON for creating a course. Which response is most appropriate?': 'Un client envoie un JSON invalide pour créer un cours. Quelle réponse est la plus appropriée ?',
    '201 Created': '201 Created',
    '400 Bad Request with validation errors':
        '400 Bad Request avec des erreurs de validation',
    '204 No Content': '204 No Content',
    '500 Internal Server Error': '500 Internal Server Error',
    'Invalid client input should produce a 400 response, ideally with useful validation details.': 'Une entrée client invalide doit produire une réponse 400, idéalement avec des détails de validation utiles.',
    'Validation': 'Validation',
    'Concurrency and JVM performance': 'Concurrence et performance JVM',
    'A Java service processes many background jobs and has started showing slow responses under load. You must use threads safely, measure performance and avoid changes that only look faster.': 'Un service Java traite de nombreuses tâches en arrière-plan et commence à répondre lentement sous charge. Tu dois utiliser les threads en sécurité, mesurer la performance et éviter les changements qui semblent seulement plus rapides.',
    'Advanced': 'Avancé',
    'What is the safest way to run many short independent tasks in Java?': 'Quelle est la façon la plus sûre d’exécuter beaucoup de petites tâches indépendantes en Java ?',
    'Create an unbounded new Thread for every request':
        'Créer un nouveau Thread non borné pour chaque requête',
    'Use an ExecutorService with a bounded thread pool':
        'Utiliser un ExecutorService avec un pool de threads borné',
    'Call Thread.sleep before every task':
        'Appeler Thread.sleep avant chaque tâche',
    'Make the main method synchronized': 'Rendre la méthode main synchronized',
    'ExecutorService reuses worker threads and a bounded pool protects the JVM from uncontrolled thread growth.': 'ExecutorService réutilise des threads travailleurs et un pool borné protège la JVM contre une croissance incontrôlée des threads.',
    'Concurrency': 'Concurrence',
    'Two threads increment the same counter and sometimes lose updates. What is the likely cause?': 'Deux threads incrémentent le même compteur et perdent parfois des mises à jour. Quelle est la cause probable ?',
    'A race condition on shared mutable state':
        'Une condition de course sur un état mutable partagé',
    'Too many package declarations': 'Trop de déclarations package',
    'The garbage collector deleting source code':
        'Le garbage collector supprime le code source',
    'A missing Maven dependency for int':
        'Une dépendance Maven manquante pour int',
    'Concurrent read-modify-write operations need synchronization, locks or atomic types to avoid lost updates.': 'Les opérations concurrentes lecture-modification-écriture nécessitent de la synchronisation, des verrous ou des types atomiques pour éviter les mises à jour perdues.',
    'Synchronization': 'Synchronisation',
    'Which actions help investigate a suspected memory leak? (select 2)': 'Quelles actions aident à analyser une fuite mémoire suspectée ? (2 réponses)',
    'Capture a heap dump and inspect retained objects':
        'Capturer un heap dump et inspecter les objets retenus',
    'Profile allocation and garbage collection behavior':
        'Profiler les allocations et le comportement du garbage collector',
    'Increase logging until the leak disappears':
        'Augmenter les logs jusqu’à ce que la fuite disparaisse',
    'Replace every loop with a stream automatically':
        'Remplacer automatiquement chaque boucle par un stream',
    'Heap dumps and profilers reveal which objects remain referenced and how allocation pressure affects garbage collection.': 'Les heap dumps et les profilers montrent quels objets restent référencés et comment la pression d’allocation affecte le garbage collector.',
    'Performance': 'Performance',
    'A stream pipeline is slower than a simple loop in a hot path. What should you do?': 'Un pipeline de streams est plus lent qu’une boucle simple dans un chemin critique. Que dois-tu faire ?',
    'Keep the stream because streams are always faster':
        'Garder le stream parce que les streams sont toujours plus rapides',
    'Measure with a benchmark and choose the clearer fast-enough option':
        'Mesurer avec un benchmark et choisir l’option claire assez rapide',
    'Disable the garbage collector': 'Désactiver le garbage collector',
    'Use parallelStream for every collection':
        'Utiliser parallelStream pour chaque collection',
    'Streams improve expressiveness but are not automatically faster; profiling and benchmarks should guide hot-path decisions.': 'Les streams améliorent l’expressivité mais ne sont pas automatiquement plus rapides ; le profiling et les benchmarks doivent guider les décisions dans les chemins critiques.',
    'Profiling': 'Profiling',
  },
  contentAr: <String, String>{
    'Java Developer': 'مطوّر Java',
    'Build robust Java applications, REST APIs and services that scale.':
        'ابنِ تطبيقات Java قوية وواجهات REST API وخدمات قابلة للتوسع.',
    'Java developers create reliable business applications, APIs and data services for web, mobile and enterprise products. They use object-oriented design, the JVM ecosystem and frameworks like Spring Boot to deliver maintainable software.': 'ينشئ مطورو Java تطبيقات أعمال موثوقة وواجهات API وخدمات بيانات لمنتجات الويب والجوال والأنظمة المؤسسية. يستخدمون التصميم كائني التوجه ومنظومة JVM وأطر عمل مثل Spring Boot لتسليم برمجيات قابلة للصيانة.',
    '38k – 62k € / year': '38 ألف – 62 ألف € / سنة',
    'Demand remains strong in finance, SaaS, consulting and large enterprise platforms.': 'يبقى الطلب قوياً في التمويل وSaaS والاستشارات والمنصات المؤسسية الكبيرة.',
    'Bac+2 to Bac+5 in software engineering or computer science':
        'Bac+2 إلى Bac+5 في هندسة البرمجيات أو علوم الحاسوب',
    'Design Java classes and services': 'تصميم أصناف وخدمات Java',
    'Build and document REST endpoints': 'بناء وتوثيق نقاط نهاية REST',
    'Write tests and debug production issues':
        'كتابة الاختبارات وتصحيح مشكلات الإنتاج',
    'Review code with the team': 'مراجعة الشيفرة مع الفريق',
    'Technology': 'تكنولوجيا',
    'Development': 'تطوير',
    'Problem solving': 'حل المشكلات',
    'Java and object-oriented basics': 'Java وأساسيات البرمجة كائنية التوجه',
    'You join a team rebuilding a small library management app in Java. Model the domain cleanly, choose the right collections and handle failures without hiding bugs.': 'تنضم إلى فريق يعيد بناء تطبيق صغير لإدارة مكتبة باستخدام Java. نمذج المجال بوضوح، واختر المجموعات المناسبة، وتعامل مع الإخفاقات من دون إخفاء الأخطاء.',
    'Beginner': 'مبتدئ',
    'In Java, what is an object?': 'في Java، ما هو الكائن؟',
    'A blueprint that declares fields and methods': 'مخطط يعلن الحقول والدوال',
    'A package imported from the JDK': 'حزمة مستوردة من JDK',
    'A runtime instance created from a class': 'نسخة وقت تشغيل مُنشأة من صنف',
    'A comment used by the compiler': 'تعليق يستخدمه المترجم',
    'A class is the blueprint; an object is a concrete instance with state and behavior at runtime.': 'الصنف هو المخطط؛ أما الكائن فهو نسخة فعلية لها حالة وسلوك أثناء التشغيل.',
    'OOP': 'البرمجة كائنية التوجه',
    'Which choices support encapsulation in a Java class? (select 2)':
        'أي اختيارات تدعم التغليف في صنف Java؟ (اختر 2)',
    'Keep fields private': 'اجعل الحقول private',
    'Expose every field as public': 'اكشف كل حقل بوصفه public',
    'Provide methods that validate state changes':
        'وفّر دوال تتحقق من تغييرات الحالة',
    'Put all code in one static method': 'ضع كل الشيفرة في دالة static واحدة',
    'Encapsulation hides internal state and exposes controlled operations that protect invariants.': 'يخفي التغليف الحالة الداخلية ويعرض عمليات مضبوطة تحمي الثوابت المنطقية.',
    'Encapsulation': 'التغليف',
    'Several payment providers share behavior but each provider has different implementation details. What should the service depend on?': 'يشترك عدة مزودي دفع في السلوك، لكن لكل مزود تفاصيل تنفيذ مختلفة. على ماذا يجب أن تعتمد الخدمة؟',
    'One concrete provider class everywhere': 'صنف مزود ملموس واحد في كل مكان',
    'An interface implemented by each provider': 'واجهة ينفذها كل مزود',
    'A Map with random keys': 'Map بمفاتيح عشوائية',
    'A checked exception': 'استثناء checked',
    'Depending on an interface lets the service use polymorphism while keeping provider implementations replaceable.': 'الاعتماد على واجهة يسمح للخدمة باستخدام تعدد الأشكال مع إبقاء تنفيذات المزودين قابلة للاستبدال.',
    'Interfaces': 'الواجهات',
    'A repository must find users quickly by id and report missing users clearly. Which design fits best?': 'يجب أن يجد المستودع المستخدمين بسرعة حسب المعرّف وأن يبلّغ بوضوح عن المستخدمين المفقودين. أي تصميم هو الأنسب؟',
    'Store users in a List and ignore missing ids':
        'خزّن المستخدمين في List وتجاهل المعرّفات المفقودة',
    'Store users in a Map<String, User> and throw a specific exception when an id is absent': 'خزّن المستخدمين في Map<String, User> وارمِ استثناءً محدداً عند غياب المعرّف',
    'Store one user per field in the class':
        'خزّن مستخدماً واحداً في كل حقل داخل الصنف',
    'Catch every Exception and return null': 'التقط كل Exception وأعد null',
    'A Map gives direct lookup by key, and a specific exception makes the failure explicit instead of silently returning invalid data.': 'توفّر Map بحثاً مباشراً بالمفتاح، ويجعل الاستثناء المحدد الفشل صريحاً بدلاً من إرجاع بيانات غير صالحة بصمت.',
    'Collections': 'المجموعات',
    'Build a REST API with Spring Boot': 'بناء REST API باستخدام Spring Boot',
    'Your team needs a Spring Boot API for managing course registrations. Expose clear endpoints, validate input and persist data through a repository layer.': 'يحتاج فريقك إلى API باستخدام Spring Boot لإدارة التسجيلات في الدورات. اعرض نقاط نهاية واضحة، وتحقق من الإدخال، واحفظ البيانات عبر طبقة مستودع.',
    'Intermediate': 'متوسط',
    'Which annotation makes a class expose JSON REST endpoints in Spring Boot?': 'أي annotation تجعل الصنف يعرّض نقاط نهاية REST بصيغة JSON في Spring Boot؟',
    '@Entity': '@Entity',
    '@Repository': '@Repository',
    '@RestController': '@RestController',
    '@AutowiredOnly': '@AutowiredOnly',
    '@RestController combines controller behavior with JSON response bodies for web endpoints.': 'تجمع @RestController سلوك المتحكم مع أجسام استجابة JSON لنقاط نهاية الويب.',
    'Spring': 'Spring',
    'Which code maps an HTTP GET request for /courses to a method?':
        'أي شيفرة تربط طلب HTTP GET على /courses بدالة؟',
    '@PostMapping("/courses")': '@PostMapping("/courses")',
    '@GetMapping("/courses")': '@GetMapping("/courses")',
    '@Table("courses")': '@Table("courses")',
    '@Column("/courses")': '@Column("/courses")',
    '@GetMapping declares that a controller method handles GET requests for the given path.':
        'تعلن @GetMapping أن دالة في المتحكم تعالج طلبات GET للمسار المحدد.',
    'REST APIs': 'واجهات REST API',
    'Which Spring practices keep the API maintainable? (select 2)':
        'أي ممارسات Spring تجعل API قابلاً للصيانة؟ (اختر 2)',
    'Inject services through constructors': 'احقن الخدمات عبر constructors',
    'Create repositories by extending JpaRepository':
        'أنشئ المستودعات بتمديد JpaRepository',
    'Instantiate dependencies with new inside every method':
        'أنشئ التبعيات باستخدام new داخل كل دالة',
    'Put SQL credentials in controller code':
        'ضع بيانات اعتماد SQL داخل شيفرة المتحكم',
    'Constructor injection makes dependencies explicit, and Spring Data repositories remove boilerplate persistence code.': 'يجعل الحقن عبر constructor التبعيات صريحة، وتزيل مستودعات Spring Data شيفرة الاستمرارية المتكررة.',
    'Dependency injection': 'حقن التبعيات',
    'A client sends invalid JSON for creating a course. Which response is most appropriate?':
        'يرسل عميل JSON غير صالح لإنشاء دورة. أي استجابة هي الأنسب؟',
    '201 Created': '201 Created',
    '400 Bad Request with validation errors': '400 Bad Request مع أخطاء تحقق',
    '204 No Content': '204 No Content',
    '500 Internal Server Error': '500 Internal Server Error',
    'Invalid client input should produce a 400 response, ideally with useful validation details.': 'يجب أن ينتج الإدخال غير الصالح من العميل استجابة 400، ويفضل أن تتضمن تفاصيل تحقق مفيدة.',
    'Validation': 'التحقق',
    'Concurrency and JVM performance': 'التزامن وأداء JVM',
    'A Java service processes many background jobs and has started showing slow responses under load. You must use threads safely, measure performance and avoid changes that only look faster.': 'تعالج خدمة Java العديد من المهام الخلفية وبدأت تظهر استجابات بطيئة تحت الحمل. يجب أن تستخدم الخيوط بأمان، وتقيس الأداء، وتتجنب التغييرات التي تبدو أسرع فقط.',
    'Advanced': 'متقدم',
    'What is the safest way to run many short independent tasks in Java?': 'ما الطريقة الأكثر أماناً لتشغيل العديد من المهام القصيرة المستقلة في Java؟',
    'Create an unbounded new Thread for every request':
        'أنشئ Thread جديداً غير محدود لكل طلب',
    'Use an ExecutorService with a bounded thread pool':
        'استخدم ExecutorService مع تجمع خيوط محدود',
    'Call Thread.sleep before every task': 'استدعِ Thread.sleep قبل كل مهمة',
    'Make the main method synchronized': 'اجعل دالة main متزامنة synchronized',
    'ExecutorService reuses worker threads and a bounded pool protects the JVM from uncontrolled thread growth.': 'يعيد ExecutorService استخدام خيوط العمل، ويحمي التجمع المحدود JVM من نمو غير مضبوط في عدد الخيوط.',
    'Concurrency': 'التزامن',
    'Two threads increment the same counter and sometimes lose updates. What is the likely cause?': 'يقوم خيطان بزيادة العداد نفسه ويفقدان أحياناً بعض التحديثات. ما السبب المحتمل؟',
    'A race condition on shared mutable state':
        'حالة سباق على حالة مشتركة قابلة للتغيير',
    'Too many package declarations': 'عدد كبير جداً من تصريحات package',
    'The garbage collector deleting source code':
        'جامع القمامة يحذف الشيفرة المصدرية',
    'A missing Maven dependency for int': 'اعتمادية Maven مفقودة للنوع int',
    'Concurrent read-modify-write operations need synchronization, locks or atomic types to avoid lost updates.': 'تحتاج عمليات القراءة-التعديل-الكتابة المتزامنة إلى مزامنة أو أقفال أو أنواع ذرية لتجنب فقدان التحديثات.',
    'Synchronization': 'المزامنة',
    'Which actions help investigate a suspected memory leak? (select 2)':
        'أي إجراءات تساعد في التحقيق في تسرب ذاكرة مشتبه به؟ (اختر 2)',
    'Capture a heap dump and inspect retained objects':
        'التقط heap dump وافحص الكائنات المحتفظ بها',
    'Profile allocation and garbage collection behavior':
        'حلل سلوك التخصيص وجمع القمامة باستخدام profiler',
    'Increase logging until the leak disappears': 'زد التسجيل حتى يختفي التسرب',
    'Replace every loop with a stream automatically':
        'استبدل كل حلقة تلقائياً بـ stream',
    'Heap dumps and profilers reveal which objects remain referenced and how allocation pressure affects garbage collection.': 'تكشف heap dumps وأدوات profiling عن الكائنات التي تبقى مرجعة وكيف يؤثر ضغط التخصيص في جمع القمامة.',
    'Performance': 'الأداء',
    'A stream pipeline is slower than a simple loop in a hot path. What should you do?':
        'خط أنابيب stream أبطأ من حلقة بسيطة في مسار ساخن. ماذا يجب أن تفعل؟',
    'Keep the stream because streams are always faster':
        'أبقِ stream لأن streams دائماً أسرع',
    'Measure with a benchmark and choose the clearer fast-enough option':
        'قس الأداء بbenchmark واختر الخيار الأوضح والسريع بما يكفي',
    'Disable the garbage collector': 'عطّل جامع القمامة',
    'Use parallelStream for every collection':
        'استخدم parallelStream لكل collection',
    'Streams improve expressiveness but are not automatically faster; profiling and benchmarks should guide hot-path decisions.': 'تحسن streams التعبيرية لكنها ليست أسرع تلقائياً؛ يجب أن يوجه profiling والbenchmarks قرارات المسارات الساخنة.',
    'Profiling': 'تحليل الأداء',
  },
  coursesEn: <String, Course>{
    'java-1': Course(
      labId: 'java-1',
      intro: 'This course prepares you to model small Java applications with classes, objects, interfaces, collections and explicit error handling.',
      sections: [
        CourseSection(
          title: 'Classes, objects and encapsulation',
          body: 'A class describes fields and methods, while an object is a runtime instance of that class. Good Java code keeps fields private so callers cannot put an object into an invalid state. Public methods express the operations the object allows and can validate every change. Encapsulation makes refactoring safer because outside code depends on behavior, not internal storage.',
          points: [
            'Class = blueprint, object = runtime instance.',
            'Private fields protect state from uncontrolled writes.',
            'Methods should enforce the rules of the domain.',
          ],
        ),
        CourseSection(
          title: 'Inheritance, interfaces and polymorphism',
          body: 'Inheritance shares implementation from a parent class, but using it everywhere can create fragile hierarchies. Interfaces are often better for services because they describe what can be done without locking code to one implementation. A class can implement an interface and provide its own details. Code that depends on the interface can switch providers, mocks or implementations more easily.',
          points: [
            'Use inheritance for true is-a relationships.',
            'Use interfaces to depend on capabilities.',
            'Polymorphism lets one service call many implementations safely.',
          ],
        ),
        CourseSection(
          title: 'Collections and exceptions',
          body: 'A List keeps elements in order and can contain duplicates, which is useful for ordered results. A Map stores values by key and is ideal when you must find an item quickly by id. When data is missing or invalid, returning null often hides the real problem. Throwing or handling a specific exception makes the failure visible and easier to test.',
          points: [
            'List for ordered sequences, Map for key-based lookup.',
            'Prefer specific exceptions over catching everything.',
            'Do not silently ignore failures that callers must handle.',
          ],
        ),
      ],
      takeaways: [
        'Objects are instances, classes are blueprints.',
        'Interfaces keep code flexible and testable.',
        'Choose collections by access pattern and report errors explicitly.',
      ],
    ),
    'java-2': Course(
      labId: 'java-2',
      intro: 'This course teaches the Spring Boot building blocks needed for a clean CRUD-style REST API.',
      sections: [
        CourseSection(
          title: 'Controllers and request mappings',
          body: '@RestController marks a class whose methods handle web requests and return response bodies, usually JSON. Mapping annotations such as @GetMapping and @PostMapping connect HTTP methods and paths to Java methods. REST design should use the HTTP method to express the action, not a random verb in the URL. Clear paths and status codes help clients understand the API contract.',
          points: [
            '@RestController exposes JSON-friendly endpoints.',
            '@GetMapping handles HTTP GET for a path.',
            'Use HTTP methods and resource names consistently.',
          ],
        ),
        CourseSection(
          title: 'Dependency injection and repositories',
          body: 'Spring creates application components and wires them together through dependency injection. Constructor injection is preferred because dependencies are visible and can be required at creation time. Spring Data JPA repositories often extend JpaRepository to get common database operations without writing boilerplate SQL. Controllers should call services, and services should call repositories, so each layer has one job.',
          points: [
            'Constructor injection makes dependencies explicit.',
            'JpaRepository supplies common persistence methods.',
            'Keep controllers thin and business logic in services.',
          ],
        ),
        CourseSection(
          title: 'Validation and HTTP status codes',
          body: 'APIs must distinguish successful requests from client mistakes and server failures. Creating a resource normally returns 201 Created, while invalid input should return 400 Bad Request. Bean Validation annotations can check fields before business logic runs. Useful validation messages help clients fix their request instead of guessing what failed.',
          points: [
            '201 means a new resource was created.',
            '400 means the client sent invalid input.',
            'Validation belongs at the API boundary and in domain rules.',
          ],
        ),
      ],
      takeaways: [
        'Controllers map HTTP requests to Java methods.',
        'Dependency injection and repositories keep code maintainable.',
        'Validation and status codes are part of the API contract.',
      ],
    ),
    'java-3': Course(
      labId: 'java-3',
      intro: 'This course focuses on safe concurrency and practical JVM performance decisions for production services.',
      sections: [
        CourseSection(
          title: 'Threads and ExecutorService',
          body: 'A Java Thread is an operating-system-backed execution path, so creating unlimited threads can exhaust memory and scheduling time. ExecutorService manages a pool of reusable worker threads and a queue of tasks. Bounded pools protect the service because they limit how many tasks run at once. Always shut down executors when the application no longer needs them.',
          points: [
            'Do not create an unbounded thread per request.',
            'Use ExecutorService to reuse and limit workers.',
            'Bounded pools create back pressure under load.',
          ],
        ),
        CourseSection(
          title: 'Race conditions and synchronization',
          body: 'A race condition appears when multiple threads access shared mutable state and the result depends on timing. Incrementing a counter is not one atomic action; it reads, modifies and writes. synchronized blocks, locks and atomic classes coordinate access so updates are not lost. The simplest design is often to avoid shared mutable state or confine it to one thread.',
          points: [
            'Shared mutable state needs coordination.',
            'Use synchronized, locks or atomic classes for critical updates.',
            'Immutability and confinement reduce concurrency bugs.',
          ],
        ),
        CourseSection(
          title: 'Garbage collection, profiling and hot paths',
          body: 'The garbage collector frees objects that are no longer reachable, but it cannot free objects still referenced by caches, static fields or long-lived collections. A memory leak in Java usually means unwanted references are kept alive. Heap dumps and profilers show retained objects, allocation rates and garbage collection pauses. Streams can make code clearer, but in hot paths you should measure loops and streams instead of assuming one is faster.',
          points: [
            'Leaks are often unwanted references, not missing free calls.',
            'Use heap dumps and profilers before changing performance code.',
            'Streams are expressive; benchmarks decide hot-path choices.',
          ],
        ),
      ],
      takeaways: [
        'Use bounded executors for controlled concurrency.',
        'Protect shared state or avoid sharing it.',
        'Profile memory and CPU before optimizing JVM code.',
      ],
    ),
  },
  coursesFr: <String, Course>{
    'java-1': Course(
      labId: 'java-1',
      intro: 'Ce cours te prépare à modéliser de petites applications Java avec des classes, des objets, des interfaces, des collections et une gestion d’erreurs explicite.',
      sections: [
        CourseSection(
          title: 'Classes, objets et encapsulation',
          body: 'Une classe décrit des champs et des méthodes, tandis qu’un objet est une instance de cette classe à l’exécution. Un bon code Java garde les champs privés afin que le code appelant ne puisse pas placer l’objet dans un état invalide. Les méthodes publiques expriment les opérations autorisées et peuvent valider chaque changement. L’encapsulation rend le refactoring plus sûr, car le code extérieur dépend du comportement et non du stockage interne.',
          points: [
            'Classe = plan, objet = instance à l’exécution.',
            'Les champs privés protègent l’état contre les écritures incontrôlées.',
            'Les méthodes doivent faire respecter les règles du domaine.',
          ],
        ),
        CourseSection(
          title: 'Héritage, interfaces et polymorphisme',
          body: 'L’héritage partage l’implémentation depuis une classe parente, mais l’utiliser partout peut créer des hiérarchies fragiles. Les interfaces sont souvent meilleures pour les services, car elles décrivent ce qui peut être fait sans lier le code à une seule implémentation. Une classe peut implémenter une interface et fournir ses propres détails. Le code qui dépend de l’interface peut changer de fournisseur, de mock ou d’implémentation plus facilement.',
          points: [
            'Utilise l’héritage pour de vraies relations est-un.',
            'Utilise les interfaces pour dépendre de capacités.',
            'Le polymorphisme permet à un service d’appeler plusieurs implémentations en sécurité.',
          ],
        ),
        CourseSection(
          title: 'Collections et exceptions',
          body: 'Une List conserve les éléments dans l’ordre et peut contenir des doublons, ce qui convient aux résultats ordonnés. Une Map stocke les valeurs par clé et convient quand tu dois retrouver rapidement un élément par id. Quand une donnée manque ou est invalide, retourner null cache souvent le vrai problème. Lever ou gérer une exception spécifique rend l’échec visible et plus facile à tester.',
          points: [
            'List pour les séquences ordonnées, Map pour la recherche par clé.',
            'Préfère les exceptions spécifiques plutôt que tout attraper.',
            'N’ignore pas silencieusement les échecs que le code appelant doit gérer.',
          ],
        ),
      ],
      takeaways: [
        'Les objets sont des instances, les classes sont des plans.',
        'Les interfaces gardent le code flexible et testable.',
        'Choisis les collections selon le mode d’accès et signale les erreurs explicitement.',
      ],
    ),
    'java-2': Course(
      labId: 'java-2',
      intro: 'Ce cours enseigne les briques Spring Boot nécessaires pour une API REST de type CRUD propre.',
      sections: [
        CourseSection(
          title: 'Contrôleurs et mappings de requêtes',
          body: '@RestController marque une classe dont les méthodes traitent les requêtes web et retournent des corps de réponse, souvent en JSON. Les annotations de mapping comme @GetMapping et @PostMapping relient les méthodes HTTP et les chemins à des méthodes Java. La conception REST doit utiliser la méthode HTTP pour exprimer l’action, pas un verbe aléatoire dans l’URL. Des chemins et des codes de statut clairs aident les clients à comprendre le contrat de l’API.',
          points: [
            '@RestController expose des endpoints adaptés au JSON.',
            '@GetMapping traite HTTP GET pour un chemin.',
            'Utilise les méthodes HTTP et les noms de ressources de façon cohérente.',
          ],
        ),
        CourseSection(
          title: 'Injection de dépendances et repositories',
          body: 'Spring crée les composants de l’application et les relie grâce à l’injection de dépendances. L’injection par constructeur est préférée, car les dépendances sont visibles et peuvent être obligatoires dès la création. Les repositories Spring Data JPA étendent souvent JpaRepository pour obtenir les opérations de base de données courantes sans écrire de SQL répétitif. Les contrôleurs doivent appeler des services, et les services appeler des repositories, afin que chaque couche ait un seul rôle.',
          points: [
            'L’injection par constructeur rend les dépendances explicites.',
            'JpaRepository fournit les méthodes de persistance courantes.',
            'Garde les contrôleurs légers et la logique métier dans les services.',
          ],
        ),
        CourseSection(
          title: 'Validation et codes de statut HTTP',
          body: 'Les API doivent distinguer les requêtes réussies des erreurs client et des pannes serveur. Créer une ressource retourne généralement 201 Created, tandis qu’une entrée invalide doit retourner 400 Bad Request. Les annotations Bean Validation peuvent vérifier les champs avant l’exécution de la logique métier. Des messages de validation utiles aident les clients à corriger leur requête au lieu de deviner ce qui a échoué.',
          points: [
            '201 signifie qu’une nouvelle ressource a été créée.',
            '400 signifie que le client a envoyé une entrée invalide.',
            'La validation appartient à la frontière de l’API et aux règles du domaine.',
          ],
        ),
      ],
      takeaways: [
        'Les contrôleurs associent les requêtes HTTP à des méthodes Java.',
        'L’injection de dépendances et les repositories gardent le code maintenable.',
        'La validation et les codes de statut font partie du contrat de l’API.',
      ],
    ),
    'java-3': Course(
      labId: 'java-3',
      intro: 'Ce cours se concentre sur la concurrence sûre et les décisions pratiques de performance JVM pour les services en production.',
      sections: [
        CourseSection(
          title: 'Threads et ExecutorService',
          body: 'Un Thread Java est un chemin d’exécution soutenu par le système d’exploitation, donc créer des threads sans limite peut épuiser la mémoire et le temps d’ordonnancement. ExecutorService gère un pool de threads travailleurs réutilisables et une file de tâches. Les pools bornés protègent le service, car ils limitent le nombre de tâches exécutées en même temps. Arrête toujours les executors quand l’application n’en a plus besoin.',
          points: [
            'Ne crée pas un thread non borné par requête.',
            'Utilise ExecutorService pour réutiliser et limiter les workers.',
            'Les pools bornés créent une pression de retour sous charge.',
          ],
        ),
        CourseSection(
          title: 'Conditions de course et synchronisation',
          body: 'Une condition de course apparaît quand plusieurs threads accèdent à un état mutable partagé et que le résultat dépend du timing. Incrémenter un compteur n’est pas une seule action atomique : il faut lire, modifier et écrire. Les blocs synchronized, les verrous et les classes atomiques coordonnent l’accès pour éviter les mises à jour perdues. La conception la plus simple consiste souvent à éviter l’état mutable partagé ou à le confiner à un seul thread.',
          points: [
            'L’état mutable partagé nécessite une coordination.',
            'Utilise synchronized, des verrous ou des classes atomiques pour les mises à jour critiques.',
            'L’immutabilité et le confinement réduisent les bugs de concurrence.',
          ],
        ),
        CourseSection(
          title: 'Garbage collection, profiling et chemins critiques',
          body: 'Le garbage collector libère les objets qui ne sont plus accessibles, mais il ne peut pas libérer les objets encore référencés par des caches, des champs static ou des collections longue durée. Une fuite mémoire en Java signifie souvent que des références inutiles restent vivantes. Les heap dumps et les profilers montrent les objets retenus, les taux d’allocation et les pauses de garbage collection. Les streams peuvent rendre le code plus clair, mais dans les chemins critiques tu dois mesurer les boucles et les streams au lieu de supposer que l’un est plus rapide.',
          points: [
            'Les fuites sont souvent des références inutiles, pas des appels free manquants.',
            'Utilise des heap dumps et des profilers avant de changer le code de performance.',
            'Les streams sont expressifs ; les benchmarks décident dans les chemins critiques.',
          ],
        ),
      ],
      takeaways: [
        'Utilise des executors bornés pour contrôler la concurrence.',
        'Protège l’état partagé ou évite de le partager.',
        'Profile la mémoire et le CPU avant d’optimiser du code JVM.',
      ],
    ),
  },
  coursesAr: <String, Course>{
    'java-1': Course(
      labId: 'java-1',
      intro: 'يحضّرك هذا الدرس لنمذجة تطبيقات Java صغيرة باستخدام الأصناف والكائنات والواجهات والمجموعات ومعالجة أخطاء صريحة.',
      sections: [
        CourseSection(
          title: 'الأصناف والكائنات والتغليف',
          body: 'يصف الصنف الحقول والدوال، بينما يكون الكائن نسخة وقت تشغيل من ذلك الصنف. يحافظ كود Java الجيد على الحقول private حتى لا يضعها الكود المستدعي في حالة غير صالحة. تعبّر الدوال العامة عن العمليات المسموحة ويمكنها التحقق من كل تغيير. يجعل التغليف إعادة الهيكلة أكثر أماناً لأن الكود الخارجي يعتمد على السلوك لا على التخزين الداخلي.',
          points: [
            'الصنف هو مخطط، والكائن هو نسخة أثناء التشغيل.',
            'الحقول private تحمي الحالة من الكتابة غير المضبوطة.',
            'يجب أن تفرض الدوال قواعد المجال.',
          ],
        ),
        CourseSection(
          title: 'الوراثة والواجهات وتعدد الأشكال',
          body: 'تشارك الوراثة التنفيذ من صنف أب، لكن استخدامها في كل مكان قد ينشئ تسلسلات هشة. تكون الواجهات غالباً أفضل للخدمات لأنها تصف ما يمكن فعله من دون ربط الكود بتنفيذ واحد. يمكن لصنف أن ينفذ واجهة وأن يقدم تفاصيله الخاصة. الكود الذي يعتمد على الواجهة يستطيع تبديل المزودين أو النسخ الوهمية أو التنفيذات بسهولة أكبر.',
          points: [
            'استخدم الوراثة لعلاقات is-a الحقيقية.',
            'استخدم الواجهات للاعتماد على القدرات.',
            'يسمح تعدد الأشكال لخدمة واحدة باستدعاء عدة تنفيذات بأمان.',
          ],
        ),
        CourseSection(
          title: 'المجموعات والاستثناءات',
          body: 'تحافظ List على ترتيب العناصر ويمكن أن تحتوي على تكرارات، وهذا مفيد للنتائج المرتبة. تخزن Map القيم حسب المفتاح وتناسب البحث السريع عن عنصر بواسطة id. عندما تكون البيانات مفقودة أو غير صالحة، فإن إرجاع null يخفي المشكلة الحقيقية غالباً. رمي استثناء محدد أو التعامل معه يجعل الفشل واضحاً وأسهل في الاختبار.',
          points: [
            'List للتسلسلات المرتبة، وMap للبحث بالمفتاح.',
            'فضّل الاستثناءات المحددة بدلاً من التقاط كل شيء.',
            'لا تتجاهل بصمت إخفاقات يجب على المستدعي التعامل معها.',
          ],
        ),
      ],
      takeaways: [
        'الكائنات نسخ، والأصناف مخططات.',
        'تحافظ الواجهات على مرونة الكود وقابليته للاختبار.',
        'اختر المجموعات حسب نمط الوصول وبلّغ عن الأخطاء بوضوح.',
      ],
    ),
    'java-2': Course(
      labId: 'java-2',
      intro: 'يعلّمك هذا الدرس لبنات Spring Boot اللازمة لبناء REST API نظيفة بنمط CRUD.',
      sections: [
        CourseSection(
          title: 'المتحكمات وربط الطلبات',
          body: 'تعلّم @RestController صنفاً تعالج دواله طلبات الويب وتعيد أجسام استجابة، غالباً بصيغة JSON. تربط annotations مثل @GetMapping و@PostMapping طرق HTTP والمسارات بدوال Java. يجب أن يستخدم تصميم REST طريقة HTTP للتعبير عن الفعل، لا فعلاً عشوائياً داخل URL. تساعد المسارات وأكواد الحالة الواضحة العملاء على فهم عقد API.',
          points: [
            'تعرض @RestController نقاط نهاية مناسبة لـ JSON.',
            'تعالج @GetMapping طلب HTTP GET لمسار محدد.',
            'استخدم طرق HTTP وأسماء الموارد باتساق.',
          ],
        ),
        CourseSection(
          title: 'حقن التبعيات والمستودعات',
          body: 'ينشئ Spring مكونات التطبيق ويربطها معاً عبر حقن التبعيات. يفضّل الحقن عبر constructor لأن التبعيات تصبح مرئية ويمكن طلبها عند الإنشاء. غالباً ما تمدد مستودعات Spring Data JPA الواجهة JpaRepository للحصول على عمليات قاعدة البيانات الشائعة من دون كتابة SQL متكرر. يجب أن تستدعي المتحكمات الخدمات، وأن تستدعي الخدمات المستودعات، حتى تملك كل طبقة مسؤولية واحدة.',
          points: [
            'الحقن عبر constructor يجعل التبعيات صريحة.',
            'يوفر JpaRepository دوال الاستمرارية الشائعة.',
            'أبقِ المتحكمات خفيفة وضع منطق الأعمال في الخدمات.',
          ],
        ),
        CourseSection(
          title: 'التحقق وأكواد حالة HTTP',
          body: 'يجب أن تميّز واجهات API بين الطلبات الناجحة وأخطاء العميل وأعطال الخادم. عادةً ما يعيد إنشاء مورد 201 Created، بينما يجب أن يعيد الإدخال غير الصالح 400 Bad Request. يمكن لـ annotations الخاصة بـ Bean Validation فحص الحقول قبل تنفيذ منطق الأعمال. تساعد رسائل التحقق المفيدة العملاء على إصلاح طلباتهم بدلاً من تخمين سبب الفشل.',
          points: [
            'يعني 201 أن مورداً جديداً أُنشئ.',
            'يعني 400 أن العميل أرسل إدخالاً غير صالح.',
            'ينتمي التحقق إلى حدود API وإلى قواعد المجال.',
          ],
        ),
      ],
      takeaways: [
        'تربط المتحكمات طلبات HTTP بدوال Java.',
        'يحافظ حقن التبعيات والمستودعات على قابلية صيانة الكود.',
        'التحقق وأكواد الحالة جزء من عقد API.',
      ],
    ),
    'java-3': Course(
      labId: 'java-3',
      intro: 'يركز هذا الدرس على التزامن الآمن وقرارات أداء JVM العملية لخدمات الإنتاج.',
      sections: [
        CourseSection(
          title: 'الخيوط وExecutorService',
          body: 'يمثل Thread في Java مسار تنفيذ مدعوماً من نظام التشغيل، لذلك قد يؤدي إنشاء خيوط غير محدودة إلى استنزاف الذاكرة ووقت الجدولة. يدير ExecutorService تجمعاً من خيوط العمل القابلة لإعادة الاستخدام وقائمة انتظار للمهام. تحمي التجمعات المحدودة الخدمة لأنها تحدد عدد المهام التي تعمل في الوقت نفسه. أوقف executors دائماً عندما لا يعود التطبيق بحاجة إليها.',
          points: [
            'لا تنشئ خيطاً غير محدود لكل طلب.',
            'استخدم ExecutorService لإعادة استخدام العمال وتحديد عددهم.',
            'تنشئ التجمعات المحدودة ضغطاً عكسياً تحت الحمل.',
          ],
        ),
        CourseSection(
          title: 'حالات السباق والمزامنة',
          body: 'تظهر حالة السباق عندما تصل عدة خيوط إلى حالة مشتركة قابلة للتغيير ويعتمد الناتج على التوقيت. زيادة عداد ليست عملية ذرية واحدة؛ فهي تقرأ وتعدّل وتكتب. تنسق كتل synchronized والأقفال والأنواع الذرية الوصول حتى لا تضيع التحديثات. أبسط تصميم غالباً هو تجنب الحالة المشتركة القابلة للتغيير أو حصرها في خيط واحد.',
          points: [
            'تحتاج الحالة المشتركة القابلة للتغيير إلى تنسيق.',
            'استخدم synchronized أو الأقفال أو الأنواع الذرية للتحديثات الحرجة.',
            'تقلل اللامتغيرات والحصر من أخطاء التزامن.',
          ],
        ),
        CourseSection(
          title: 'جمع القمامة وprofiling والمسارات الساخنة',
          body: 'يحرر جامع القمامة الكائنات التي لم تعد قابلة للوصول، لكنه لا يستطيع تحرير الكائنات التي ما زالت مذكورة في caches أو حقول static أو مجموعات طويلة العمر. يعني تسرب الذاكرة في Java غالباً أن مراجع غير مرغوبة بقيت حية. تعرض heap dumps وأدوات profiling الكائنات المحتفظ بها ومعدلات التخصيص وتوقفات جمع القمامة. قد تجعل streams الكود أوضح، لكن في المسارات الساخنة يجب أن تقيس الحلقات وstreams بدلاً من افتراض أن أحدهما أسرع.',
          points: [
            'غالباً ما تكون التسربات مراجع غير مرغوبة، لا نداءات free مفقودة.',
            'استخدم heap dumps وأدوات profiling قبل تغيير كود الأداء.',
            'streams تعبيرية؛ والbenchmarks تحسم اختيارات المسارات الساخنة.',
          ],
        ),
      ],
      takeaways: [
        'استخدم executors محدودة للتحكم في التزامن.',
        'احمِ الحالة المشتركة أو تجنب مشاركتها.',
        'حلل الذاكرة وCPU قبل تحسين كود JVM.',
      ],
    ),
  },
  courseExamples: <String, List<String?>>{
    'java-1': [
      'class Book {\n'
          '  private String title;\n'
          '  Book(String title) { this.title = title; }\n'
          '  String title() { return title; }\n'
          '}',
      'interface PaymentProvider {\n'
          '  Receipt charge(Money amount);\n'
          '}\n'
          'class StripeProvider implements PaymentProvider {\n'
          '  public Receipt charge(Money amount) { return new Receipt(); }\n'
          '}',
      'Map<String, User> users = new HashMap<>();\n'
          'User user = users.get(id);\n'
          'if (user == null) {\n'
          '  throw new UserNotFoundException(id);\n'
          '}',
    ],
    'java-2': [
      '@RestController\n'
          'class CourseController {\n'
          '  @GetMapping("/courses")\n'
          '  List<CourseDto> all() { return service.all(); }\n'
          '}',
      'class CourseService {\n'
          '  CourseService(CourseRepository repo) {\n'
          '    this.repo = repo;\n'
          '  }\n'
          '}',
      'interface CourseRepository\n'
          '    extends JpaRepository<Course, Long> {}\n'
          '@ResponseStatus(HttpStatus.BAD_REQUEST)\n'
          'class InvalidCourseException extends RuntimeException {}',
    ],
    'java-3': [
      'ExecutorService pool = Executors.newFixedThreadPool(8);\n'
          'try {\n'
          '  pool.submit(() -> process(job));\n'
          '} finally {\n'
          '  pool.shutdown();\n'
          '}',
      'private final AtomicInteger count = new AtomicInteger();\n'
          'void recordSuccess() {\n'
          '  count.incrementAndGet();\n'
          '}',
      'jcmd <pid> GC.heap_dump app.hprof\n'
          'jfr start name=api settings=profile\n'
          'jfr dump name=api filename=api.jfr',
    ],
  },
);
