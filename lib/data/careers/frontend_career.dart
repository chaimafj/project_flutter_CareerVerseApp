import 'package:flutter/material.dart';

import '../../models/career.dart';
import '../../models/career_pack.dart';
import '../../models/course.dart';

const frontendPack = CareerPack(
  career: Career(
    id: 'frontend',
    title: 'Frontend Web Developer',
    summary: 'Build accessible, responsive and interactive web interfaces.',
    description:
        'Frontend web developers transform product ideas and designs into pages '
        'that users can see, understand and use on any device. They combine '
        'HTML, CSS, JavaScript and frameworks such as React while caring about '
        'accessibility, performance and security.',
    icon: Icons.web,
    color: Color(0xFFF4511E),
    tools: ['HTML/CSS', 'JavaScript', 'React', 'Figma'],
    tags: ['Technology', 'Web', 'Design'],
    salary: '35k – 55k € / year',
    outlook:
        'Strong demand as every product needs fast, inclusive web experiences.',
    education: 'Bac+2 to Bac+5 in web development or software engineering',
    dailyTasks: [
      'Turn UI mockups into responsive pages',
      'Build reusable React components',
      'Test accessibility and browser compatibility',
      'Collaborate with designers, backend developers and product teams',
    ],
    labs: [
      Lab(
        id: 'frontend-1',
        title: 'Build an accessible, responsive page',
        scenario:
            'You are creating a landing page for a training platform. The page '
            'must be readable on mobile, structured for assistive technologies '
            'and clear enough for users with different needs.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'Which element should wrap the primary navigation links of the page?',
            options: ['<nav>', '<div>', '<span>', '<footer>'],
            correct: {0},
            skill: 'HTML',
            explanation:
                'The <nav> element gives semantic meaning to the main navigation. '
                'Screen readers can expose it as a navigation landmark.',
          ),
          LabQuestion(
            prompt: 'Which CSS tool is best for a two-dimensional card layout with rows and columns?',
            options: ['CSS Grid', 'line-height', 'z-index', 'text-transform'],
            correct: {0},
            skill: 'CSS',
            explanation:
                'CSS Grid is designed for layouts that need rows and columns. '
                'Flexbox is better for one-dimensional alignment.',
          ),
          LabQuestion(
            prompt: 'Which practices improve accessibility on a sign-up form? (select 2)',
            options: [
              'Associate each input with a visible <label>',
              'Keep strong color contrast between text and background',
              'Use placeholder text as the only label',
              'Remove focus outlines from all fields',
            ],
            correct: {0, 1},
            skill: 'Accessibility',
            explanation:
                'Labels describe form controls, and sufficient contrast keeps '
                'text readable. Placeholder-only labels and hidden focus states '
                'make forms harder to use.',
          ),
          LabQuestion(
            prompt: 'In a mobile-first stylesheet, where should wide-screen changes usually go?',
            options: [
              'Inside min-width media queries',
              'Only in inline styles',
              'Inside alt attributes',
              'In the package.json file',
            ],
            correct: {0},
            skill: 'CSS',
            explanation:
                'Mobile-first CSS starts with the small-screen layout, then uses '
                'min-width media queries to enhance the design for larger screens.',
          ),
        ],
      ),
      Lab(
        id: 'frontend-2',
        title: 'Interactive UI with JavaScript and React',
        scenario:
            'A dashboard must load project data, let users filter the list and '
            'update the interface without a full page reload. You need to mix '
            'plain JavaScript concepts with React component state.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt:
                'Which JavaScript API listens for a button click in the DOM?',
            options: [
              'addEventListener',
              'JSON.stringify',
              'querySelectorAll only',
              'localStorage.clear',
            ],
            correct: {0},
            skill: 'JavaScript',
            explanation:
                'addEventListener registers a function that runs when an event '
                'such as click, input or submit happens on an element.',
          ),
          LabQuestion(
            prompt: 'What is the clearest way to call an API and wait for JSON data?',
            options: [
              'fetch with async/await',
              'setInterval without stopping it',
              'document.write',
              'CSS media queries',
            ],
            correct: {0},
            skill: 'JavaScript',
            explanation:
                'fetch sends the HTTP request, and async/await makes the '
                'asynchronous flow easier to read while you parse the JSON.',
          ),
          LabQuestion(
            prompt: 'In React, which values should be stored in state?',
            options: [
              'Data that changes because of user interaction',
              'The component name',
              'Static text that never changes',
              'The import path of React',
            ],
            correct: {0},
            skill: 'React',
            explanation:
                'State is for values that can change over time and should cause '
                'the component to render again when they change.',
          ),
          LabQuestion(
            prompt: 'Which React practices keep a dynamic list predictable? (select 2)',
            options: [
              'Pass stable data into child components with props',
              'Give each rendered list item a stable key',
              'Mutate the state array directly with push',
              'Use the array index as the key for reorderable items',
            ],
            correct: {0, 1},
            skill: 'React',
            explanation:
                'Props pass data down clearly, and stable keys help React match '
                'items between renders. Direct mutation and unstable keys create '
                'subtle UI bugs.',
          ),
        ],
      ),
      Lab(
        id: 'frontend-3',
        title: 'Web performance and security',
        scenario:
            'Your single-page application is now public and receives real '
            'traffic. Users complain about slow loading, while the team wants '
            'to reduce common browser-side security risks.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'Which Core Web Vital measures how quickly the largest visible content loads?',
            options: ['CLS', 'LCP', 'INP', 'TTFB only'],
            correct: {1},
            skill: 'Performance',
            explanation:
                'Largest Contentful Paint (LCP) measures when the main visible '
                'content, such as a hero image or heading, has loaded.',
          ),
          LabQuestion(
            prompt: 'Which techniques can reduce the initial JavaScript and image cost? (select 2)',
            options: [
              'Lazy-load below-the-fold images',
              'Split code by route or feature',
              'Bundle every admin screen into the home page',
              'Disable browser caching',
            ],
            correct: {0, 1},
            skill: 'Performance',
            explanation:
                'Lazy loading delays non-critical images, and code splitting '
                'sends less JavaScript at first load.',
          ),
          LabQuestion(
            prompt: 'How should user-generated HTML be handled before inserting it into the page?',
            options: [
              'Sanitize it with a trusted library',
              'Insert it directly with innerHTML',
              'Store it in a cookie first',
              'Rename the variable to safeHtml',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'Untrusted HTML can contain scripts or dangerous attributes. '
                'Sanitizing removes unsafe content before rendering.',
          ),
          LabQuestion(
            prompt: 'Where is the safest place for long-lived refresh tokens in a browser app?',
            options: [
              'A secure, HttpOnly, SameSite cookie',
              'localStorage',
              'A global JavaScript variable',
              'The URL query string',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'HttpOnly cookies are not readable by JavaScript, which limits '
                'token theft during XSS. Secure and SameSite flags reduce other '
                'browser-side risks.',
          ),
        ],
      ),
    ],
  ),
  interests: ['Web', 'Design', 'Programming', 'Teamwork'],
  contentFr: <String, String>{
    'Frontend Web Developer': 'Développeur web frontend',
    'Build accessible, responsive and interactive web interfaces.': 'Construire des interfaces web accessibles, responsives et interactives.',
    'Frontend web developers transform product ideas and designs into pages that users can see, understand and use on any device. They combine HTML, CSS, JavaScript and frameworks such as React while caring about accessibility, performance and security.': 'Les développeurs web frontend transforment les idées produit et les maquettes en pages que les utilisateurs peuvent voir, comprendre et utiliser sur n’importe quel appareil. Ils combinent HTML, CSS, JavaScript et des frameworks comme React tout en veillant à l’accessibilité, aux performances et à la sécurité.',
    '35k – 55k € / year': '35k – 55k € / an',
    'Strong demand as every product needs fast, inclusive web experiences.': 'Demande forte, car chaque produit a besoin d’expériences web rapides et inclusives.',
    'Bac+2 to Bac+5 in web development or software engineering':
        'Bac+2 à Bac+5 en développement web ou génie logiciel',
    'Turn UI mockups into responsive pages':
        'Transformer des maquettes UI en pages responsives',
    'Build reusable React components':
        'Construire des composants React réutilisables',
    'Test accessibility and browser compatibility':
        'Tester l’accessibilité et la compatibilité navigateur',
    'Collaborate with designers, backend developers and product teams': 'Collaborer avec les designers, les développeurs backend et les équipes produit',
    'Technology': 'Technologie',
    'Web': 'Web',
    'Design': 'Design',
    'Build an accessible, responsive page':
        'Construire une page accessible et responsive',
    'You are creating a landing page for a training platform. The page must be readable on mobile, structured for assistive technologies and clear enough for users with different needs.': 'Tu crées une page d’accueil pour une plateforme de formation. La page doit être lisible sur mobile, structurée pour les technologies d’assistance et assez claire pour des utilisateurs aux besoins différents.',
    'Beginner': 'Débutant',
    'Which element should wrap the primary navigation links of the page?': 'Quel élément doit contenir les liens de navigation principaux de la page ?',
    '<nav>': '<nav>',
    '<div>': '<div>',
    '<span>': '<span>',
    '<footer>': '<footer>',
    'The <nav> element gives semantic meaning to the main navigation. Screen readers can expose it as a navigation landmark.': 'L’élément <nav> donne un sens sémantique à la navigation principale. Les lecteurs d’écran peuvent l’exposer comme repère de navigation.',
    'HTML': 'HTML',
    'Which CSS tool is best for a two-dimensional card layout with rows and columns?': 'Quel outil CSS convient le mieux à une grille de cartes en deux dimensions avec lignes et colonnes ?',
    'CSS Grid': 'CSS Grid',
    'line-height': 'line-height',
    'z-index': 'z-index',
    'text-transform': 'text-transform',
    'CSS Grid is designed for layouts that need rows and columns. Flexbox is better for one-dimensional alignment.': 'CSS Grid est conçu pour les mises en page qui nécessitent des lignes et des colonnes. Flexbox convient mieux à l’alignement sur une seule dimension.',
    'CSS': 'CSS',
    'Which practices improve accessibility on a sign-up form? (select 2)': 'Quelles pratiques améliorent l’accessibilité d’un formulaire d’inscription ? (2 réponses)',
    'Associate each input with a visible <label>':
        'Associer chaque champ à un <label> visible',
    'Keep strong color contrast between text and background':
        'Garder un contraste élevé entre le texte et l’arrière-plan',
    'Use placeholder text as the only label':
        'Utiliser le placeholder comme seule étiquette',
    'Remove focus outlines from all fields':
        'Supprimer les contours de focus de tous les champs',
    'Labels describe form controls, and sufficient contrast keeps text readable. Placeholder-only labels and hidden focus states make forms harder to use.': 'Les labels décrivent les contrôles de formulaire, et un contraste suffisant garde le texte lisible. Les placeholders seuls et les états de focus masqués rendent les formulaires plus difficiles à utiliser.',
    'Accessibility': 'Accessibilité',
    'In a mobile-first stylesheet, where should wide-screen changes usually go?': 'Dans une feuille de style mobile-first, où faut-il généralement placer les changements pour grand écran ?',
    'Inside min-width media queries': 'Dans des media queries avec min-width',
    'Only in inline styles': 'Uniquement dans les styles inline',
    'Inside alt attributes': 'Dans les attributs alt',
    'In the package.json file': 'Dans le fichier package.json',
    'Mobile-first CSS starts with the small-screen layout, then uses min-width media queries to enhance the design for larger screens.': 'Le CSS mobile-first commence par la mise en page petit écran, puis utilise des media queries min-width pour améliorer le design sur les écrans plus grands.',
    'Interactive UI with JavaScript and React':
        'Interface interactive avec JavaScript et React',
    'A dashboard must load project data, let users filter the list and update the interface without a full page reload. You need to mix plain JavaScript concepts with React component state.': 'Un tableau de bord doit charger les données des projets, laisser les utilisateurs filtrer la liste et mettre à jour l’interface sans rechargement complet. Tu dois combiner les concepts JavaScript de base avec l’état des composants React.',
    'Intermediate': 'Intermédiaire',
    'Which JavaScript API listens for a button click in the DOM?':
        'Quelle API JavaScript écoute le clic sur un bouton dans le DOM ?',
    'addEventListener': 'addEventListener',
    'JSON.stringify': 'JSON.stringify',
    'querySelectorAll only': 'querySelectorAll seulement',
    'localStorage.clear': 'localStorage.clear',
    'addEventListener registers a function that runs when an event such as click, input or submit happens on an element.': 'addEventListener enregistre une fonction qui s’exécute lorsqu’un événement comme click, input ou submit se produit sur un élément.',
    'JavaScript': 'JavaScript',
    'What is the clearest way to call an API and wait for JSON data?': 'Quelle est la façon la plus claire d’appeler une API et d’attendre des données JSON ?',
    'fetch with async/await': 'fetch avec async/await',
    'setInterval without stopping it': 'setInterval sans l’arrêter',
    'document.write': 'document.write',
    'CSS media queries': 'media queries CSS',
    'fetch sends the HTTP request, and async/await makes the asynchronous flow easier to read while you parse the JSON.': 'fetch envoie la requête HTTP, et async/await rend le flux asynchrone plus facile à lire pendant que tu analyses le JSON.',
    'In React, which values should be stored in state?':
        'Dans React, quelles valeurs faut-il stocker dans le state ?',
    'Data that changes because of user interaction':
        'Les données qui changent à cause d’une interaction utilisateur',
    'The component name': 'Le nom du composant',
    'Static text that never changes': 'Du texte statique qui ne change jamais',
    'The import path of React': 'Le chemin d’import de React',
    'State is for values that can change over time and should cause the component to render again when they change.': 'Le state sert aux valeurs qui peuvent changer dans le temps et doivent provoquer un nouveau rendu du composant lorsqu’elles changent.',
    'React': 'React',
    'Which React practices keep a dynamic list predictable? (select 2)': 'Quelles pratiques React gardent une liste dynamique prévisible ? (2 réponses)',
    'Pass stable data into child components with props':
        'Passer des données stables aux composants enfants avec des props',
    'Give each rendered list item a stable key':
        'Donner une clé stable à chaque élément rendu de la liste',
    'Mutate the state array directly with push':
        'Modifier directement le tableau de state avec push',
    'Use the array index as the key for reorderable items':
        'Utiliser l’index du tableau comme clé pour des éléments réordonnables',
    'Props pass data down clearly, and stable keys help React match items between renders. Direct mutation and unstable keys create subtle UI bugs.': 'Les props transmettent clairement les données vers le bas, et les clés stables aident React à faire correspondre les éléments entre les rendus. La mutation directe et les clés instables créent des bugs UI subtils.',
    'Web performance and security': 'Performance web et sécurité',
    'Your single-page application is now public and receives real traffic. Users complain about slow loading, while the team wants to reduce common browser-side security risks.': 'Ton application single-page est maintenant publique et reçoit du vrai trafic. Les utilisateurs se plaignent de lenteurs, tandis que l’équipe veut réduire les risques de sécurité courants côté navigateur.',
    'Advanced': 'Avancé',
    'Which Core Web Vital measures how quickly the largest visible content loads?': 'Quel Core Web Vital mesure la vitesse de chargement du plus grand contenu visible ?',
    'CLS': 'CLS',
    'LCP': 'LCP',
    'INP': 'INP',
    'TTFB only': 'TTFB seulement',
    'Largest Contentful Paint (LCP) measures when the main visible content, such as a hero image or heading, has loaded.': 'Largest Contentful Paint (LCP) mesure le moment où le contenu visible principal, comme une image hero ou un titre, est chargé.',
    'Performance': 'Performance',
    'Which techniques can reduce the initial JavaScript and image cost? (select 2)': 'Quelles techniques peuvent réduire le coût initial du JavaScript et des images ? (2 réponses)',
    'Lazy-load below-the-fold images':
        'Charger paresseusement les images sous la ligne de flottaison',
    'Split code by route or feature':
        'Découper le code par route ou par fonctionnalité',
    'Bundle every admin screen into the home page':
        'Regrouper tous les écrans d’administration dans la page d’accueil',
    'Disable browser caching': 'Désactiver le cache du navigateur',
    'Lazy loading delays non-critical images, and code splitting sends less JavaScript at first load.': 'Le lazy loading retarde les images non critiques, et le code splitting envoie moins de JavaScript au premier chargement.',
    'How should user-generated HTML be handled before inserting it into the page?': 'Comment faut-il traiter le HTML généré par les utilisateurs avant de l’insérer dans la page ?',
    'Sanitize it with a trusted library':
        'Le nettoyer avec une bibliothèque fiable',
    'Insert it directly with innerHTML': 'L’insérer directement avec innerHTML',
    'Store it in a cookie first': 'Le stocker d’abord dans un cookie',
    'Rename the variable to safeHtml': 'Renommer la variable en safeHtml',
    'Untrusted HTML can contain scripts or dangerous attributes. Sanitizing removes unsafe content before rendering.': 'Du HTML non fiable peut contenir des scripts ou des attributs dangereux. Le nettoyage retire le contenu risqué avant le rendu.',
    'Security': 'Sécurité',
    'Where is the safest place for long-lived refresh tokens in a browser app?': 'Quel est l’endroit le plus sûr pour des refresh tokens longue durée dans une application navigateur ?',
    'A secure, HttpOnly, SameSite cookie':
        'Un cookie sécurisé, HttpOnly et SameSite',
    'localStorage': 'localStorage',
    'A global JavaScript variable': 'Une variable JavaScript globale',
    'The URL query string': 'La chaîne de requête de l’URL',
    'HttpOnly cookies are not readable by JavaScript, which limits token theft during XSS. Secure and SameSite flags reduce other browser-side risks.': 'Les cookies HttpOnly ne sont pas lisibles par JavaScript, ce qui limite le vol de tokens lors d’une XSS. Les attributs Secure et SameSite réduisent d’autres risques côté navigateur.',
  },
  contentAr: <String, String>{
    'Frontend Web Developer': 'مطوّر واجهات ويب أمامية',
    'Build accessible, responsive and interactive web interfaces.':
        'بناء واجهات ويب تفاعلية ومتجاوبة وقابلة للوصول.',
    'Frontend web developers transform product ideas and designs into pages that users can see, understand and use on any device. They combine HTML, CSS, JavaScript and frameworks such as React while caring about accessibility, performance and security.': 'يحوّل مطوّرو الواجهات الأمامية أفكار المنتج والتصاميم إلى صفحات يستطيع المستخدمون رؤيتها وفهمها واستخدامها على أي جهاز. يجمعون بين HTML وCSS وJavaScript وأطر مثل React مع الاهتمام بإمكانية الوصول والأداء والأمان.',
    '35k – 55k € / year': '35k – 55k € / سنة',
    'Strong demand as every product needs fast, inclusive web experiences.':
        'طلب قوي لأن كل منتج يحتاج إلى تجارب ويب سريعة وشاملة.',
    'Bac+2 to Bac+5 in web development or software engineering':
        'من Bac+2 إلى Bac+5 في تطوير الويب أو هندسة البرمجيات',
    'Turn UI mockups into responsive pages':
        'تحويل نماذج واجهة المستخدم إلى صفحات متجاوبة',
    'Build reusable React components':
        'بناء مكوّنات React قابلة لإعادة الاستخدام',
    'Test accessibility and browser compatibility':
        'اختبار إمكانية الوصول وتوافق المتصفحات',
    'Collaborate with designers, backend developers and product teams':
        'التعاون مع المصممين ومطوّري الخلفية وفرق المنتج',
    'Technology': 'تكنولوجيا',
    'Web': 'ويب',
    'Design': 'تصميم',
    'Build an accessible, responsive page': 'بناء صفحة متجاوبة وقابلة للوصول',
    'You are creating a landing page for a training platform. The page must be readable on mobile, structured for assistive technologies and clear enough for users with different needs.': 'أنت تنشئ صفحة هبوط لمنصة تدريب. يجب أن تكون الصفحة مقروءة على الهاتف، ومنظّمة للتقنيات المساعدة، وواضحة بما يكفي لمستخدمين ذوي احتياجات مختلفة.',
    'Beginner': 'مبتدئ',
    'Which element should wrap the primary navigation links of the page?':
        'أي عنصر يجب أن يغلّف روابط التنقل الرئيسية في الصفحة؟',
    '<nav>': '<nav>',
    '<div>': '<div>',
    '<span>': '<span>',
    '<footer>': '<footer>',
    'The <nav> element gives semantic meaning to the main navigation. Screen readers can expose it as a navigation landmark.': 'يعطي عنصر <nav> معنى دلالياً للتنقل الرئيسي. يمكن لقارئات الشاشة عرضه كمعلم للتنقل.',
    'HTML': 'HTML',
    'Which CSS tool is best for a two-dimensional card layout with rows and columns?':
        'أي أداة CSS هي الأنسب لتخطيط بطاقات ثنائي الأبعاد بصفوف وأعمدة؟',
    'CSS Grid': 'CSS Grid',
    'line-height': 'line-height',
    'z-index': 'z-index',
    'text-transform': 'text-transform',
    'CSS Grid is designed for layouts that need rows and columns. Flexbox is better for one-dimensional alignment.': 'صُمّم CSS Grid للتخطيطات التي تحتاج إلى صفوف وأعمدة. أما Flexbox فهو أفضل للمحاذاة أحادية البعد.',
    'CSS': 'CSS',
    'Which practices improve accessibility on a sign-up form? (select 2)':
        'ما الممارسات التي تحسّن إمكانية الوصول في نموذج التسجيل؟ (اختر 2)',
    'Associate each input with a visible <label>':
        'ربط كل حقل إدخال بعنصر <label> مرئي',
    'Keep strong color contrast between text and background':
        'الحفاظ على تباين قوي بين النص والخلفية',
    'Use placeholder text as the only label':
        'استخدام نص placeholder كالتسمية الوحيدة',
    'Remove focus outlines from all fields': 'إزالة حدود التركيز من كل الحقول',
    'Labels describe form controls, and sufficient contrast keeps text readable. Placeholder-only labels and hidden focus states make forms harder to use.': 'تصف التسميات عناصر النموذج، ويحافظ التباين الكافي على قابلية قراءة النص. التسميات المعتمدة فقط على placeholder وحالات التركيز المخفية تجعل النماذج أصعب استخداماً.',
    'Accessibility': 'إمكانية الوصول',
    'In a mobile-first stylesheet, where should wide-screen changes usually go?':
        'في ملف أنماط mobile-first، أين توضع عادةً تغييرات الشاشات الواسعة؟',
    'Inside min-width media queries': 'داخل استعلامات وسائط min-width',
    'Only in inline styles': 'فقط داخل الأنماط المضمنة',
    'Inside alt attributes': 'داخل سمات alt',
    'In the package.json file': 'في ملف package.json',
    'Mobile-first CSS starts with the small-screen layout, then uses min-width media queries to enhance the design for larger screens.': 'يبدأ CSS بأسلوب mobile-first بتخطيط الشاشة الصغيرة، ثم يستخدم استعلامات min-width لتحسين التصميم على الشاشات الأكبر.',
    'Interactive UI with JavaScript and React':
        'واجهة تفاعلية باستخدام JavaScript وReact',
    'A dashboard must load project data, let users filter the list and update the interface without a full page reload. You need to mix plain JavaScript concepts with React component state.': 'يجب أن تحمّل لوحة المعلومات بيانات المشاريع، وتسمح للمستخدمين بتصفية القائمة، وتحدّث الواجهة دون إعادة تحميل كاملة. تحتاج إلى مزج مفاهيم JavaScript الأساسية مع حالة مكوّنات React.',
    'Intermediate': 'متوسط',
    'Which JavaScript API listens for a button click in the DOM?':
        'أي واجهة JavaScript تستمع إلى نقرة زر في DOM؟',
    'addEventListener': 'addEventListener',
    'JSON.stringify': 'JSON.stringify',
    'querySelectorAll only': 'querySelectorAll فقط',
    'localStorage.clear': 'localStorage.clear',
    'addEventListener registers a function that runs when an event such as click, input or submit happens on an element.': 'تسجّل addEventListener دالة تعمل عند حدوث حدث مثل click أو input أو submit على عنصر.',
    'JavaScript': 'JavaScript',
    'What is the clearest way to call an API and wait for JSON data?':
        'ما أوضح طريقة لاستدعاء API وانتظار بيانات JSON؟',
    'fetch with async/await': 'fetch مع async/await',
    'setInterval without stopping it': 'setInterval دون إيقافه',
    'document.write': 'document.write',
    'CSS media queries': 'استعلامات وسائط CSS',
    'fetch sends the HTTP request, and async/await makes the asynchronous flow easier to read while you parse the JSON.': 'يرسل fetch طلب HTTP، وتجعل async/await التدفق غير المتزامن أسهل قراءة أثناء تحليل JSON.',
    'In React, which values should be stored in state?':
        'في React، أي قيم يجب تخزينها في الحالة؟',
    'Data that changes because of user interaction':
        'البيانات التي تتغير بسبب تفاعل المستخدم',
    'The component name': 'اسم المكوّن',
    'Static text that never changes': 'نص ثابت لا يتغير أبداً',
    'The import path of React': 'مسار استيراد React',
    'State is for values that can change over time and should cause the component to render again when they change.': 'الحالة مخصصة للقيم التي يمكن أن تتغير مع الوقت ويجب أن تجعل المكوّن يُعاد عرضه عند تغيرها.',
    'React': 'React',
    'Which React practices keep a dynamic list predictable? (select 2)':
        'أي ممارسات React تجعل القائمة الديناميكية قابلة للتنبؤ؟ (اختر 2)',
    'Pass stable data into child components with props':
        'تمرير بيانات مستقرة إلى المكوّنات الفرعية عبر props',
    'Give each rendered list item a stable key':
        'إعطاء كل عنصر معروض في القائمة مفتاحاً مستقراً',
    'Mutate the state array directly with push':
        'تعديل مصفوفة الحالة مباشرة باستخدام push',
    'Use the array index as the key for reorderable items':
        'استخدام فهرس المصفوفة كمفتاح لعناصر يمكن إعادة ترتيبها',
    'Props pass data down clearly, and stable keys help React match items between renders. Direct mutation and unstable keys create subtle UI bugs.': 'تمرر props البيانات بوضوح إلى الأسفل، وتساعد المفاتيح المستقرة React على مطابقة العناصر بين عمليات العرض. التعديل المباشر والمفاتيح غير المستقرة يسببان أخطاء واجهة دقيقة.',
    'Web performance and security': 'أداء الويب والأمان',
    'Your single-page application is now public and receives real traffic. Users complain about slow loading, while the team wants to reduce common browser-side security risks.': 'أصبح تطبيق الصفحة الواحدة الخاص بك عاماً ويتلقى حركة فعلية. يشتكي المستخدمون من بطء التحميل، بينما يريد الفريق تقليل مخاطر الأمان الشائعة في المتصفح.',
    'Advanced': 'متقدم',
    'Which Core Web Vital measures how quickly the largest visible content loads?':
        'أي Core Web Vital يقيس سرعة تحميل أكبر محتوى مرئي؟',
    'CLS': 'CLS',
    'LCP': 'LCP',
    'INP': 'INP',
    'TTFB only': 'TTFB فقط',
    'Largest Contentful Paint (LCP) measures when the main visible content, such as a hero image or heading, has loaded.': 'يقيس Largest Contentful Paint (LCP) وقت تحميل المحتوى المرئي الرئيسي، مثل صورة hero أو عنوان.',
    'Performance': 'الأداء',
    'Which techniques can reduce the initial JavaScript and image cost? (select 2)': 'ما التقنيات التي يمكن أن تقلل تكلفة JavaScript والصور في التحميل الأول؟ (اختر 2)',
    'Lazy-load below-the-fold images':
        'تحميل الصور الموجودة أسفل الجزء المرئي بشكل كسول',
    'Split code by route or feature': 'تقسيم الكود حسب المسار أو الميزة',
    'Bundle every admin screen into the home page':
        'تجميع كل شاشات الإدارة داخل الصفحة الرئيسية',
    'Disable browser caching': 'تعطيل تخزين المتصفح المؤقت',
    'Lazy loading delays non-critical images, and code splitting sends less JavaScript at first load.': 'يؤخر التحميل الكسول الصور غير الحرجة، ويرسل تقسيم الكود JavaScript أقل عند التحميل الأول.',
    'How should user-generated HTML be handled before inserting it into the page?':
        'كيف يجب التعامل مع HTML الذي ينشئه المستخدمون قبل إدخاله في الصفحة؟',
    'Sanitize it with a trusted library': 'تنظيفه بمكتبة موثوقة',
    'Insert it directly with innerHTML': 'إدخاله مباشرة باستخدام innerHTML',
    'Store it in a cookie first': 'تخزينه أولاً في cookie',
    'Rename the variable to safeHtml': 'إعادة تسمية المتغير إلى safeHtml',
    'Untrusted HTML can contain scripts or dangerous attributes. Sanitizing removes unsafe content before rendering.': 'قد يحتوي HTML غير الموثوق على سكربتات أو سمات خطيرة. يزيل التنظيف المحتوى غير الآمن قبل العرض.',
    'Security': 'الأمان',
    'Where is the safest place for long-lived refresh tokens in a browser app?':
        'أين المكان الأكثر أماناً لرموز refresh طويلة العمر في تطبيق متصفح؟',
    'A secure, HttpOnly, SameSite cookie': 'Cookie آمن مع HttpOnly وSameSite',
    'localStorage': 'localStorage',
    'A global JavaScript variable': 'متغير JavaScript عام',
    'The URL query string': 'سلسلة الاستعلام في URL',
    'HttpOnly cookies are not readable by JavaScript, which limits token theft during XSS. Secure and SameSite flags reduce other browser-side risks.': 'لا يمكن قراءة cookies من نوع HttpOnly بواسطة JavaScript، ما يحد من سرقة الرموز أثناء XSS. تقلل أعلام Secure وSameSite مخاطر أخرى من جهة المتصفح.',
  },
  coursesEn: <String, Course>{
    'frontend-1': Course(
      labId: 'frontend-1',
      intro:
          'A good first page is not only pretty: it has meaningful HTML, a '
          'layout that adapts to the screen and accessibility details that make '
          'it usable with keyboards, screen readers and low vision.',
      sections: [
        CourseSection(
          title: 'Semantic HTML for page structure',
          body:
              'Semantic HTML uses elements that describe their role instead of '
              'generic boxes everywhere. A header introduces the page, nav wraps '
              'important navigation links, main contains the unique content and '
              'footer closes the page. This structure helps browsers, search '
              'engines and assistive technologies understand the document. For '
              'forms, a visible label connected to each input is more reliable '
              'than placeholder text alone.',
          points: [
            'Use <nav> for primary navigation links.',
            'Keep one clear <main> area for the page content.',
            'Connect labels to inputs so form controls have names.',
          ],
        ),
        CourseSection(
          title: 'Responsive layout with Grid, Flexbox and media queries',
          body:
              'Responsive pages start from the smallest useful layout, then add '
              'space and columns as the viewport grows. Flexbox is ideal for '
              'one-dimensional alignment such as a row of buttons or a toolbar. '
              'CSS Grid is better when cards must align in both rows and '
              'columns. In a mobile-first approach, the base CSS targets phones '
              'and min-width media queries add tablet or desktop changes.',
          points: [
            'Start with the mobile layout before desktop refinements.',
            'Choose Grid for two-dimensional rows and columns.',
            'Use min-width media queries for larger screens.',
          ],
        ),
        CourseSection(
          title: 'Accessibility basics that users notice',
          body:
              'Accessibility is part of frontend quality. Images that convey '
              'meaning need useful alt text, while decorative images can have '
              'empty alt text. Text must keep enough contrast against its '
              'background, otherwise many users cannot read it comfortably. '
              'Keyboard users also need visible focus indicators so they always '
              'know which link, button or field is active.',
          points: [
            'Write alt text for meaningful images.',
            'Keep strong contrast for text and important UI.',
            'Never remove focus outlines without a clear replacement.',
          ],
        ),
      ],
      takeaways: [
        'Semantic elements make the page understandable beyond the visual design.',
        'Grid, Flexbox and min-width queries solve different layout problems.',
        'Labels, contrast, alt text and focus states are essential accessibility work.',
      ],
    ),
    'frontend-2': Course(
      labId: 'frontend-2',
      intro:
          'Interactive interfaces react to events, request data from APIs and '
          'render only the parts that changed. React organizes this work into '
          'components that receive props, keep state and run effects when needed.',
      sections: [
        CourseSection(
          title: 'DOM events and asynchronous data',
          body:
              'In plain JavaScript, interactivity often begins by selecting an '
              'element and registering an event listener. addEventListener runs '
              'your callback when a click, input or submit event happens. When '
              'the interface needs server data, fetch starts an HTTP request. '
              'Using async and await keeps the code readable while you wait for '
              'the response and parse JSON.',
          points: [
            'Use addEventListener for DOM events.',
            'Use fetch to request API data.',
            'Use async/await to write asynchronous flows clearly.',
          ],
        ),
        CourseSection(
          title: 'Components, props and state in React',
          body:
              'A React component is a function that returns UI for a piece of '
              'the screen. Props are inputs passed from a parent component and '
              'should be treated as read-only. State belongs to the component '
              'and stores values that change through interaction, such as a '
              'filter, a selected tab or loaded data. Updating state tells React '
              'to render the component again with the new value.',
          points: [
            'Props pass data from parent to child.',
            'State stores values that change over time.',
            'Never mutate state arrays directly.',
          ],
        ),
        CourseSection(
          title: 'Effects and stable lists',
          body:
              'useEffect runs side effects after React renders, for example '
              'loading data when a component appears or when a filter changes. '
              'The dependency array controls when the effect runs again, so it '
              'should contain the values used by the effect. When rendering an '
              'array, each item needs a stable key that identifies the same item '
              'between renders. Stable keys prevent React from mixing up rows '
              'when items are inserted, removed or reordered.',
          points: [
            'Use useEffect for data loading and other side effects.',
            'List effect dependencies deliberately.',
            'Use stable item ids as React keys.',
          ],
        ),
      ],
      takeaways: [
        'Events and fetch power browser interactivity outside React.',
        'Props are inputs; state is for changing values that trigger rerenders.',
        'useEffect and stable keys keep data loading and lists predictable.',
      ],
    ),
    'frontend-3': Course(
      labId: 'frontend-3',
      intro:
          'Production frontend work includes speed and safety. A useful app '
          'must load quickly, stay stable during interaction and avoid exposing '
          'users to common browser attacks.',
      sections: [
        CourseSection(
          title: 'Core Web Vitals and loading strategy',
          body:
              'Core Web Vitals are user-centered performance measurements. LCP '
              'tracks when the largest visible content finishes loading, CLS '
              'tracks unexpected layout shifts and INP tracks responsiveness to '
              'interactions. Large JavaScript bundles and heavy images often '
              'hurt these metrics. Lazy loading below-the-fold images and code '
              'splitting by route or feature reduce the initial work needed to '
              'show the first useful screen.',
          points: [
            'LCP measures the main visible content loading.',
            'CLS measures unexpected visual movement.',
            'INP measures interaction responsiveness.',
          ],
        ),
        CourseSection(
          title: 'Caching, CDNs and HTTPS',
          body:
              'Caching avoids downloading or recomputing the same assets again '
              'and again. Static files with content hashes can be cached for a '
              'long time because a new filename is produced when the file '
              'changes. A CDN serves those files from locations near users, '
              'reducing latency and pressure on the origin server. HTTPS is the '
              'baseline for modern web apps because it protects traffic in '
              'transit and unlocks secure browser features.',
          points: [
            'Cache fingerprinted static assets aggressively.',
            'Use a CDN to move files closer to users.',
            'Serve production apps over HTTPS.',
          ],
        ),
        CourseSection(
          title: 'Browser security: XSS, CORS and tokens',
          body:
              'Cross-site scripting happens when untrusted content is executed '
              'as code in the page. Avoid inserting raw user HTML; if HTML must '
              'be rendered, sanitize it with a trusted library first. CORS is a '
              'browser policy that controls which origins may read API '
              'responses, not a substitute for authentication. Long-lived '
              'refresh tokens are safer in Secure, HttpOnly, SameSite cookies '
              'than in JavaScript-readable storage.',
          points: [
            'Sanitize user-generated HTML before rendering it.',
            'Configure CORS for trusted origins only.',
            'Prefer HttpOnly cookies for long-lived refresh tokens.',
          ],
        ),
      ],
      takeaways: [
        'LCP, CLS and INP describe loading, visual stability and responsiveness.',
        'Lazy loading, code splitting, caching and CDNs reduce perceived load time.',
        'Sanitization, careful CORS and HttpOnly cookies reduce browser-side risk.',
      ],
    ),
  },
  coursesFr: <String, Course>{
    'frontend-1': Course(
      labId: 'frontend-1',
      intro:
          'Une bonne première page n’est pas seulement jolie : elle possède un '
          'HTML porteur de sens, une mise en page qui s’adapte à l’écran et des '
          'détails d’accessibilité qui la rendent utilisable au clavier, avec '
          'un lecteur d’écran ou en basse vision.',
      sections: [
        CourseSection(
          title: 'HTML sémantique pour structurer la page',
          body:
              'Le HTML sémantique utilise des éléments qui décrivent leur rôle '
              'au lieu de mettre des boîtes génériques partout. Un header '
              'introduit la page, nav regroupe les liens de navigation '
              'importants, main contient le contenu unique et footer clôt la '
              'page. Cette structure aide les navigateurs, les moteurs de '
              'recherche et les technologies d’assistance à comprendre le '
              'document. Pour les formulaires, un label visible relié à chaque '
              'champ est plus fiable qu’un placeholder seul.',
          points: [
            'Utilise <nav> pour les liens de navigation principaux.',
            'Garde une zone <main> claire pour le contenu de la page.',
            'Relie les labels aux champs pour nommer les contrôles.',
          ],
        ),
        CourseSection(
          title: 'Mise en page responsive avec Grid, Flexbox et media queries',
          body:
              'Les pages responsives partent de la plus petite mise en page '
              'utile, puis ajoutent de l’espace et des colonnes quand la vue '
              's’agrandit. Flexbox est idéal pour l’alignement sur une '
              'dimension, comme une rangée de boutons ou une barre d’outils. '
              'CSS Grid convient mieux quand des cartes doivent s’aligner en '
              'lignes et en colonnes. Dans une approche mobile-first, le CSS de '
              'base vise les téléphones et les media queries min-width ajoutent '
              'les changements tablette ou desktop.',
          points: [
            'Commence par la mise en page mobile avant les raffinements desktop.',
            'Choisis Grid pour les lignes et colonnes en deux dimensions.',
            'Utilise des media queries min-width pour les grands écrans.',
          ],
        ),
        CourseSection(
          title: 'Bases d’accessibilité visibles par les utilisateurs',
          body:
              'L’accessibilité fait partie de la qualité frontend. Les images '
              'qui portent du sens ont besoin d’un texte alt utile, tandis que '
              'les images décoratives peuvent avoir un alt vide. Le texte doit '
              'garder assez de contraste avec son arrière-plan, sinon beaucoup '
              'd’utilisateurs ne peuvent pas le lire confortablement. Les '
              'utilisateurs au clavier ont aussi besoin d’indicateurs de focus '
              'visibles pour savoir quel lien, bouton ou champ est actif.',
          points: [
            'Écris un texte alt pour les images significatives.',
            'Garde un contraste fort pour le texte et l’UI importante.',
            'Ne supprime jamais le focus sans remplacement clair.',
          ],
        ),
      ],
      takeaways: [
        'Les éléments sémantiques rendent la page compréhensible au-delà du visuel.',
        'Grid, Flexbox et les requêtes min-width résolvent des problèmes différents.',
        'Labels, contraste, texte alt et focus sont des bases d’accessibilité.',
      ],
    ),
    'frontend-2': Course(
      labId: 'frontend-2',
      intro:
          'Les interfaces interactives réagissent aux événements, demandent des '
          'données aux API et ne réaffichent que les parties qui changent. React '
          'organise ce travail en composants qui reçoivent des props, gardent un '
          'state et lancent des effets quand c’est nécessaire.',
      sections: [
        CourseSection(
          title: 'Événements DOM et données asynchrones',
          body:
              'En JavaScript simple, l’interactivité commence souvent par la '
              'sélection d’un élément et l’enregistrement d’un écouteur '
              'd’événement. addEventListener exécute ton callback quand un '
              'événement click, input ou submit arrive. Quand l’interface a '
              'besoin de données serveur, fetch lance une requête HTTP. Avec '
              'async et await, le code reste lisible pendant que tu attends la '
              'réponse et analyses le JSON.',
          points: [
            'Utilise addEventListener pour les événements DOM.',
            'Utilise fetch pour demander des données à une API.',
            'Utilise async/await pour clarifier le flux asynchrone.',
          ],
        ),
        CourseSection(
          title: 'Composants, props et state dans React',
          body:
              'Un composant React est une fonction qui retourne l’UI d’une '
              'partie de l’écran. Les props sont des entrées passées par un '
              'composant parent et doivent être traitées comme immuables. Le '
              'state appartient au composant et stocke les valeurs qui changent '
              'avec l’interaction, comme un filtre, un onglet sélectionné ou des '
              'données chargées. Mettre à jour le state demande à React de '
              'rendre à nouveau le composant avec la nouvelle valeur.',
          points: [
            'Les props passent les données du parent vers l’enfant.',
            'Le state stocke les valeurs qui changent dans le temps.',
            'Ne mute jamais directement les tableaux du state.',
          ],
        ),
        CourseSection(
          title: 'Effets et listes stables',
          body:
              'useEffect exécute des effets après le rendu React, par exemple '
              'charger des données quand un composant apparaît ou quand un '
              'filtre change. Le tableau de dépendances contrôle quand l’effet '
              'se relance, donc il doit contenir les valeurs utilisées par '
              'l’effet. Quand tu affiches un tableau, chaque élément a besoin '
              'd’une clé stable qui identifie le même élément entre les rendus. '
              'Les clés stables évitent à React de mélanger les lignes quand '
              'des éléments sont insérés, supprimés ou réordonnés.',
          points: [
            'Utilise useEffect pour le chargement de données et les effets.',
            'Liste volontairement les dépendances de l’effet.',
            'Utilise des ids stables comme clés React.',
          ],
        ),
      ],
      takeaways: [
        'Les événements et fetch alimentent l’interactivité hors React.',
        'Les props sont des entrées ; le state change et relance le rendu.',
        'useEffect et les clés stables rendent chargements et listes prévisibles.',
      ],
    ),
    'frontend-3': Course(
      labId: 'frontend-3',
      intro:
          'Le frontend en production inclut la vitesse et la sécurité. Une '
          'application utile doit charger vite, rester stable pendant '
          'l’interaction et éviter d’exposer les utilisateurs aux attaques '
          'courantes du navigateur.',
      sections: [
        CourseSection(
          title: 'Core Web Vitals et stratégie de chargement',
          body:
              'Les Core Web Vitals sont des mesures de performance centrées sur '
              'l’utilisateur. LCP suit le moment où le plus grand contenu visible '
              'finit de charger, CLS suit les décalages de mise en page '
              'inattendus et INP suit la réactivité aux interactions. Les gros '
              'bundles JavaScript et les images lourdes dégradent souvent ces '
              'métriques. Le lazy loading des images sous la ligne de flottaison '
              'et le code splitting par route ou fonctionnalité réduisent le '
              'travail initial nécessaire pour afficher le premier écran utile.',
          points: [
            'LCP mesure le chargement du contenu visible principal.',
            'CLS mesure les mouvements visuels inattendus.',
            'INP mesure la réactivité aux interactions.',
          ],
        ),
        CourseSection(
          title: 'Cache, CDN et HTTPS',
          body:
              'Le cache évite de télécharger ou recalculer les mêmes ressources '
              'encore et encore. Les fichiers statiques avec hash de contenu '
              'peuvent être cachés longtemps, car un nouveau nom de fichier est '
              'produit quand le fichier change. Un CDN sert ces fichiers depuis '
              'des emplacements proches des utilisateurs, ce qui réduit la '
              'latence et la pression sur le serveur d’origine. HTTPS est la '
              'base des applications web modernes, car il protège le trafic en '
              'transit et active des fonctionnalités navigateur sécurisées.',
          points: [
            'Mets fortement en cache les fichiers statiques versionnés.',
            'Utilise un CDN pour rapprocher les fichiers des utilisateurs.',
            'Sers les applications de production en HTTPS.',
          ],
        ),
        CourseSection(
          title: 'Sécurité navigateur : XSS, CORS et tokens',
          body:
              'Le cross-site scripting arrive quand du contenu non fiable '
              's’exécute comme du code dans la page. Évite d’insérer du HTML '
              'utilisateur brut ; si du HTML doit être rendu, nettoie-le avec '
              'une bibliothèque fiable. CORS est une politique navigateur qui '
              'contrôle quelles origines peuvent lire les réponses API, pas un '
              'remplacement de l’authentification. Les refresh tokens longue '
              'durée sont plus sûrs dans des cookies Secure, HttpOnly et '
              'SameSite que dans un stockage lisible par JavaScript.',
          points: [
            'Nettoie le HTML utilisateur avant de le rendre.',
            'Configure CORS uniquement pour les origines de confiance.',
            'Préfère les cookies HttpOnly pour les refresh tokens longue durée.',
          ],
        ),
      ],
      takeaways: [
        'LCP, CLS et INP décrivent chargement, stabilité visuelle et réactivité.',
        'Lazy loading, code splitting, cache et CDN réduisent le temps perçu.',
        'Sanitization, CORS prudent et cookies HttpOnly réduisent les risques.',
      ],
    ),
  },
  coursesAr: <String, Course>{
    'frontend-1': Course(
      labId: 'frontend-1',
      intro:
          'الصفحة الأولى الجيدة ليست جميلة فقط: فهي تستخدم HTML ذا معنى، '
          'وتخطيطاً يتكيّف مع الشاشة، وتفاصيل وصول تجعلها قابلة للاستخدام '
          'باللوحة المفاتيح وقارئات الشاشة ولضعاف البصر.',
      sections: [
        CourseSection(
          title: 'HTML الدلالي لبنية الصفحة',
          body:
              'يستخدم HTML الدلالي عناصر تصف دورها بدلاً من الاعتماد على '
              'صناديق عامة في كل مكان. يقدّم header الصفحة، ويغلّف nav روابط '
              'التنقل المهمة، ويحتوي main على المحتوى الفريد، ويغلق footer '
              'الصفحة. تساعد هذه البنية المتصفحات ومحركات البحث والتقنيات '
              'المساعدة على فهم المستند. في النماذج، يكون label مرئي مرتبط '
              'بكل حقل أكثر موثوقية من placeholder وحده.',
          points: [
            'استخدم <nav> لروابط التنقل الرئيسية.',
            'حافظ على منطقة <main> واضحة لمحتوى الصفحة.',
            'اربط labels بالحقول حتى تحصل عناصر النموذج على أسماء.',
          ],
        ),
        CourseSection(
          title: 'تخطيط متجاوب باستخدام Grid وFlexbox واستعلامات الوسائط',
          body:
              'تبدأ الصفحات المتجاوبة من أصغر تخطيط مفيد، ثم تضيف المساحات '
              'والأعمدة مع كبر مساحة العرض. Flexbox مناسب للمحاذاة أحادية '
              'البعد مثل صف أزرار أو شريط أدوات. CSS Grid أفضل عندما يجب أن '
              'تنتظم البطاقات في صفوف وأعمدة. في أسلوب mobile-first يستهدف CSS '
              'الأساسي الهواتف، ثم تضيف استعلامات min-width تغييرات الأجهزة '
              'اللوحية وسطح المكتب.',
          points: [
            'ابدأ بتخطيط الهاتف قبل تحسينات سطح المكتب.',
            'اختر Grid للصفوف والأعمدة ثنائية البعد.',
            'استخدم استعلامات min-width للشاشات الأكبر.',
          ],
        ),
        CourseSection(
          title: 'أساسيات الوصول التي يلاحظها المستخدمون',
          body:
              'إمكانية الوصول جزء من جودة الواجهة الأمامية. الصور التي تحمل '
              'معنى تحتاج إلى نص alt مفيد، أما الصور الزخرفية فيمكن أن يكون '
              'alt الخاص بها فارغاً. يجب أن يحافظ النص على تباين كافٍ مع '
              'الخلفية، وإلا فلن يستطيع كثير من المستخدمين قراءته بسهولة. '
              'يحتاج مستخدمو لوحة المفاتيح أيضاً إلى مؤشرات تركيز مرئية '
              'لمعرفة الرابط أو الزر أو الحقل النشط.',
          points: [
            'اكتب نص alt للصور ذات المعنى.',
            'حافظ على تباين قوي للنص وواجهة المستخدم المهمة.',
            'لا تزل حدود التركيز دون بديل واضح.',
          ],
        ),
      ],
      takeaways: [
        'العناصر الدلالية تجعل الصفحة مفهومة خارج التصميم المرئي.',
        'تحل Grid وFlexbox واستعلامات min-width مشكلات تخطيط مختلفة.',
        'labels والتباين ونص alt وحالات التركيز أساسيات لإمكانية الوصول.',
      ],
    ),
    'frontend-2': Course(
      labId: 'frontend-2',
      intro:
          'تتفاعل الواجهات التفاعلية مع الأحداث، وتطلب البيانات من APIs، '
          'وتعرض فقط الأجزاء التي تغيرت. ينظم React هذا العمل في مكوّنات '
          'تستقبل props، وتحفظ state، وتشغّل effects عند الحاجة.',
      sections: [
        CourseSection(
          title: 'أحداث DOM والبيانات غير المتزامنة',
          body:
              'في JavaScript العادي، يبدأ التفاعل غالباً باختيار عنصر وتسجيل '
              'مستمع حدث. تنفّذ addEventListener الدالة عند حدوث click أو input '
              'أو submit. عندما تحتاج الواجهة إلى بيانات من الخادم، يبدأ fetch '
              'طلب HTTP. استخدام async وawait يجعل الكود أسهل قراءة أثناء '
              'انتظار الاستجابة وتحليل JSON.',
          points: [
            'استخدم addEventListener لأحداث DOM.',
            'استخدم fetch لطلب بيانات API.',
            'استخدم async/await لكتابة تدفقات غير متزامنة بوضوح.',
          ],
        ),
        CourseSection(
          title: 'المكوّنات وprops وstate في React',
          body:
              'مكوّن React هو دالة تعيد واجهة لجزء من الشاشة. props هي مدخلات '
              'يمررها المكوّن الأب ويجب التعامل معها كقيم للقراءة فقط. state '
              'تخص المكوّن وتخزّن قيماً تتغير بالتفاعل، مثل مرشح أو تبويب '
              'محدد أو بيانات محمّلة. تحديث state يخبر React أن يعرض المكوّن '
              'مرة أخرى بالقيمة الجديدة.',
          points: [
            'تمرر props البيانات من الأب إلى الابن.',
            'تخزن state القيم التي تتغير مع الوقت.',
            'لا تعدّل مصفوفات state مباشرة.',
          ],
        ),
        CourseSection(
          title: 'التأثيرات والقوائم المستقرة',
          body:
              'تشغّل useEffect تأثيرات جانبية بعد أن يعرض React الواجهة، مثل '
              'تحميل البيانات عند ظهور مكوّن أو تغير مرشح. تتحكم مصفوفة '
              'الاعتماديات في وقت تشغيل التأثير مرة أخرى، لذلك يجب أن تحتوي '
              'على القيم التي يستخدمها التأثير. عند عرض مصفوفة، يحتاج كل عنصر '
              'إلى key مستقر يحدد العنصر نفسه بين عمليات العرض. تمنع المفاتيح '
              'المستقرة React من خلط الصفوف عند إدراج عناصر أو حذفها أو إعادة '
              'ترتيبها.',
          points: [
            'استخدم useEffect لتحميل البيانات والتأثيرات الأخرى.',
            'اكتب اعتماديات التأثير بعناية.',
            'استخدم ids مستقرة كمفاتيح React.',
          ],
        ),
      ],
      takeaways: [
        'الأحداث وfetch تشغل التفاعل داخل المتصفح خارج React.',
        'props مدخلات، وstate للقيم المتغيرة التي تعيد العرض.',
        'useEffect والمفاتيح المستقرة تجعل التحميل والقوائم قابلة للتنبؤ.',
      ],
    ),
    'frontend-3': Course(
      labId: 'frontend-3',
      intro:
          'يشمل عمل الواجهة الأمامية في الإنتاج السرعة والسلامة. يجب أن يحمّل '
          'التطبيق المفيد بسرعة، وأن يبقى مستقراً أثناء التفاعل، وأن يتجنب '
          'تعريض المستخدمين لهجمات المتصفح الشائعة.',
      sections: [
        CourseSection(
          title: 'Core Web Vitals واستراتيجية التحميل',
          body:
              'Core Web Vitals هي قياسات أداء متمحورة حول المستخدم. يتتبع LCP '
              'وقت انتهاء تحميل أكبر محتوى مرئي، ويتتبع CLS تغييرات التخطيط '
              'غير المتوقعة، ويتتبع INP الاستجابة للتفاعلات. غالباً ما تضر '
              'حزم JavaScript الكبيرة والصور الثقيلة بهذه المقاييس. يقلل '
              'التحميل الكسول للصور أسفل الجزء المرئي وتقسيم الكود حسب المسار '
              'أو الميزة العمل الأولي المطلوب لإظهار أول شاشة مفيدة.',
          points: [
            'يقيس LCP تحميل المحتوى المرئي الرئيسي.',
            'يقيس CLS الحركة المرئية غير المتوقعة.',
            'يقيس INP الاستجابة للتفاعلات.',
          ],
        ),
        CourseSection(
          title: 'التخزين المؤقت وCDN وHTTPS',
          body:
              'يتجنب التخزين المؤقت تنزيل الأصول نفسها أو إعادة حسابها مراراً. '
              'يمكن تخزين الملفات الثابتة ذات بصمة المحتوى لفترة طويلة لأن '
              'اسماً جديداً يُنتج عندما يتغير الملف. يقدّم CDN هذه الملفات من '
              'مواقع قريبة من المستخدمين، مما يقلل زمن الوصول والضغط على '
              'الخادم الأصلي. HTTPS أساس تطبيقات الويب الحديثة لأنه يحمي '
              'المرور أثناء النقل ويفتح ميزات متصفح آمنة.',
          points: [
            'خزّن الأصول الثابتة ذات البصمة بقوة.',
            'استخدم CDN لتقريب الملفات من المستخدمين.',
            'قدّم تطبيقات الإنتاج عبر HTTPS.',
          ],
        ),
        CourseSection(
          title: 'أمان المتصفح: XSS وCORS والرموز',
          body:
              'يحدث cross-site scripting عندما يُنفّذ محتوى غير موثوق ككود في '
              'الصفحة. تجنب إدخال HTML خام من المستخدم؛ وإذا كان لا بد من عرض '
              'HTML فقم بتنظيفه أولاً بمكتبة موثوقة. CORS سياسة متصفح تتحكم '
              'في الأصول التي يمكنها قراءة ردود API، وليست بديلاً عن المصادقة. '
              'تكون refresh tokens طويلة العمر أكثر أماناً في cookies مع '
              'Secure وHttpOnly وSameSite من تخزين يمكن لـJavaScript قراءته.',
          points: [
            'نظّف HTML الذي ينشئه المستخدم قبل عرضه.',
            'اضبط CORS للأصول الموثوقة فقط.',
            'فضّل cookies من نوع HttpOnly لرموز refresh طويلة العمر.',
          ],
        ),
      ],
      takeaways: [
        'تصف LCP وCLS وINP التحميل والثبات البصري والاستجابة.',
        'يقلل lazy loading وتقسيم الكود والتخزين المؤقت وCDN زمن التحميل المدرك.',
        'يقلل التنظيف وCORS الحذر وHttpOnly cookies مخاطر المتصفح.',
      ],
    ),
  },
  courseExamples: <String, List<String?>>{
    'frontend-1': [
      '<header>\n'
          '  <nav aria-label="Main navigation">\n'
          '    <a href="#courses">Courses</a>\n'
          '    <a href="#signup">Sign up</a>\n'
          '  </nav>\n'
          '</header>',
      '.cards {\n'
          '  display: grid;\n'
          '  gap: 1rem;\n'
          '}\n'
          '@media (min-width: 48rem) {\n'
          '  .cards { grid-template-columns: repeat(3, 1fr); }\n'
          '}',
      '<label for="email">Email</label>\n'
          '<input id="email" name="email" type="email" />\n'
          '<img src="mentor.jpg" alt="Mentor reviewing a student project" />',
    ],
    'frontend-2': [
      "button.addEventListener('click', async () => {\n"
          "  const response = await fetch('/api/projects');\n"
          '  const projects = await response.json();\n'
          '  renderProjects(projects);\n'
          '});',
      'function ProjectCard({ project }) {\n'
          '  const [favorite, setFavorite] = useState(false);\n'
          '  return <button onClick={() => setFavorite(!favorite)}>\n'
          '    {project.name}\n'
          '  </button>;\n'
          '}',
      'useEffect(() => {\n'
          '  fetch(`/api/projects?filter=\${filter}`)\n'
          '    .then((res) => res.json())\n'
          '    .then(setProjects);\n'
          '}, [filter]);\n'
          'return projects.map((p) => <ProjectCard key={p.id} project={p} />);',
    ],
    'frontend-3': [
      '<img src="team.jpg" loading="lazy" alt="Team workshop" />\n'
          "const Admin = lazy(() => import('./AdminDashboard'));\n"
          '<Suspense fallback={<Spinner />}>\n'
          '  <Admin />\n'
          '</Suspense>',
      'Cache-Control: public, max-age=31536000, immutable\n'
          'app.8f3a1c2.js  → CDN edge in Paris\n'
          'https://careerverse.example',
      "const clean = DOMPurify.sanitize(userHtml);\n"
          "content.innerHTML = clean;\n"
          'Set-Cookie: refresh=token; Secure; HttpOnly; SameSite=Lax',
    ],
  },
);
