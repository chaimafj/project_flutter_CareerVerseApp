import 'package:flutter/material.dart';

import '../../models/career.dart';
import '../../models/career_pack.dart';
import '../../models/course.dart';

const aiPack = CareerPack(
  career: Career(
    id: 'ai',
    title: 'AI / ML Engineer',
    summary: 'Design, train and deploy intelligent models that turn data into predictions and assistants.',
    description: 'AI / ML engineers transform data into models that classify images, understand text or automate decisions. They prototype experiments, evaluate results carefully and deploy reliable models with monitoring.',
    icon: Icons.psychology_outlined,
    color: Color(0xFFD81B60),
    tools: ['Python', 'PyTorch', 'Hugging Face', 'MLflow'],
    tags: ['Technology', 'AI', 'Data'],
    salary: '45k – 75k € / year',
    outlook: 'Demand is strong as companies add AI features while needing engineers who can make them reliable.',
    education: 'Bac+5 in computer science, data science or applied mathematics',
    dailyTasks: [
      'Prepare datasets and evaluate model quality',
      'Train neural networks and tune hyperparameters',
      'Build LLM prototypes with safe prompts and retrieval',
      'Deploy models and monitor drift in production',
    ],
    labs: [
      Lab(
        id: 'ai-1',
        title: 'Neural network fundamentals',
        scenario: 'A medical imaging team wants a first neural network prototype to classify X-ray images. You must explain the main building blocks before training begins.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'What is the role of an activation function such as ReLU in a neural network?',
            options: [
              'Store the training dataset',
              'Add non-linearity so layers can learn complex patterns',
              'Encrypt the model weights',
              'Choose the final file format',
            ],
            correct: {1},
            skill: 'Deep learning',
            explanation: 'Activation functions make the network non-linear. Without them, stacked layers would behave like one linear model.',
          ),
          LabQuestion(
            prompt: 'Which choices usually help train a model more stably? (select 2)',
            options: [
              'Normalize input features',
              'Choose a learning rate that is not too large',
              'Remove all validation data',
              'Increase loss by reversing labels',
            ],
            correct: {0, 1},
            skill: 'Training',
            explanation: 'Normalized inputs and a sensible learning rate help gradient descent move smoothly toward lower loss.',
          ),
          LabQuestion(
            prompt: 'During training, what does gradient descent update?',
            options: [
              'Weights and biases',
              'The number of images in the hospital',
              'The ground-truth labels',
              'The Python interpreter version',
            ],
            correct: {0},
            skill: 'Training',
            explanation: 'Gradient descent uses the loss gradient to update trainable parameters such as weights and biases.',
          ),
          LabQuestion(
            prompt: 'Which architecture is especially suited for image classification?',
            options: [
              'A transformer configured only for server logs',
              'A convolutional neural network',
              'A linear regression on file names',
              'K-means clustering without labels',
            ],
            correct: {1},
            skill: 'Computer vision',
            explanation: 'Convolutional neural networks learn local visual patterns such as edges and textures, which is why they work well on images.',
          ),
        ],
      ),
      Lab(
        id: 'ai-2',
        title: 'Build an assistant with an LLM',
        scenario: 'A support team wants an assistant that answers questions from internal documentation. It must be useful, predictable and safe with company credentials.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'Why does an LLM context window matter when you send a long document?',
            options: [
              'It sets the GPU color used during training',
              'It replaces the need for tokens',
              'It limits how much text the model can consider at once',
              'It guarantees that every answer is true',
            ],
            correct: {2},
            skill: 'LLMs',
            explanation: 'The context window is measured in tokens and caps the text available to the model for one request.',
          ),
          LabQuestion(
            prompt:
                'Which prompt practices improve an LLM assistant? (select 2)',
            options: [
              'Ask for hidden system prompts',
              'Give the task, constraints and output format clearly',
              'Use vague instructions to let the model guess',
              'Provide relevant examples when the format matters',
            ],
            correct: {1, 3},
            skill: 'Prompt engineering',
            explanation: 'Clear instructions and relevant examples reduce ambiguity and make the response format more consistent.',
          ),
          LabQuestion(
            prompt:
                'What does a higher temperature usually do in an LLM request?',
            options: [
              'It shortens the context window',
              'It stores the API key on the client',
              'It disables tokenization',
              'It makes outputs more varied and less deterministic',
            ],
            correct: {3},
            skill: 'LLMs',
            explanation: 'Temperature controls sampling randomness. Higher values can be creative, but they may also reduce consistency.',
          ),
          LabQuestion(
            prompt: 'Which design reduces hallucinations when answering from company documents?',
            options: [
              'Fine-tune on unrelated public jokes',
              'Retrieve relevant chunks with embeddings and a vector database before answering',
              'Put the API key in the mobile app',
              'Ask the model to invent missing policy details',
            ],
            correct: {1},
            skill: 'RAG',
            explanation: 'Retrieval-augmented generation grounds the answer in retrieved sources. API keys should stay server-side, not in client apps.',
          ),
        ],
      ),
      Lab(
        id: 'ai-3',
        title: 'Serve and monitor models in production',
        scenario: 'Your fraud model worked in notebooks and now must serve real users. The team needs versioning, cost control, safe rollout and monitoring after release.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'What is the main purpose of a model registry?',
            options: [
              'Replace all evaluation metrics',
              'Store user passwords for the model',
              'Version models with metadata, stages and artifacts',
              'Generate synthetic GPUs for free',
            ],
            correct: {2},
            skill: 'MLOps',
            explanation: 'A registry tracks model versions, metrics, artifacts and promotion stages so teams know exactly what is deployed.',
          ),
          LabQuestion(
            prompt: 'Which serving choices match common production needs? (select 2)',
            options: [
              'Use a REST API for low-latency online predictions',
              'Retrain inside every user request',
              'Serve only from a notebook on a laptop',
              'Run batch scoring for large offline datasets',
            ],
            correct: {0, 3},
            skill: 'Serving',
            explanation: 'REST APIs are common for interactive predictions, while batch jobs process large datasets without real-time latency pressure.',
          ),
          LabQuestion(
            prompt: 'A model is accurate but too slow and expensive on GPU. What can help most?',
            options: [
              'Increase the number of unused features',
              'Apply quantization and benchmark the smaller model',
              'Delete latency metrics',
              'Disable monitoring after launch',
            ],
            correct: {1},
            skill: 'Optimization',
            explanation: 'Quantization can reduce memory, latency and cost by using lower-precision weights, but it must be benchmarked for quality.',
          ),
          LabQuestion(
            prompt: 'Which practices support safe rollout and responsible AI? (select 2)',
            options: [
              'Run an A/B test before full rollout',
              'Check unfair error rates across user groups',
              'Ignore feedback after deployment',
              'Hide the deployed model version',
            ],
            correct: {0, 1},
            skill: 'Responsible AI',
            explanation: 'A/B tests limit rollout risk, and fairness checks help detect harmful behavior across groups.',
          ),
        ],
      ),
    ],
  ),
  interests: ['AI', 'Data', 'Programming', 'Automation'],
  contentFr: <String, String>{
    'AI / ML Engineer': 'Ingénieur IA / ML',
    'Design, train and deploy intelligent models that turn data into predictions and assistants.': 'Concevoir, entraîner et déployer des modèles intelligents qui transforment les données en prédictions et assistants.',
    'AI / ML engineers transform data into models that classify images, understand text or automate decisions. They prototype experiments, evaluate results carefully and deploy reliable models with monitoring.': 'Les ingénieurs IA / ML transforment les données en modèles qui classent des images, comprennent du texte ou automatisent des décisions. Ils prototypent des expériences, évaluent les résultats avec rigueur et déploient des modèles fiables avec de la surveillance.',
    '45k – 75k € / year': '45k – 75k € / an',
    'Demand is strong as companies add AI features while needing engineers who can make them reliable.': 'La demande est forte car les entreprises ajoutent des fonctionnalités IA tout en ayant besoin d’ingénieurs capables de les rendre fiables.',
    'Bac+5 in computer science, data science or applied mathematics':
        'Bac+5 en informatique, data science ou mathématiques appliquées',
    'Prepare datasets and evaluate model quality':
        'Préparer les jeux de données et évaluer la qualité des modèles',
    'Train neural networks and tune hyperparameters':
        'Entraîner des réseaux de neurones et ajuster les hyperparamètres',
    'Build LLM prototypes with safe prompts and retrieval': 'Construire des prototypes LLM avec des prompts sûrs et de la recherche documentaire',
    'Deploy models and monitor drift in production':
        'Déployer des modèles et surveiller la dérive en production',
    'Technology': 'Technologie',
    'AI': 'IA',
    'Data': 'Données',
    'Neural network fundamentals': 'Bases des réseaux de neurones',
    'A medical imaging team wants a first neural network prototype to classify X-ray images. You must explain the main building blocks before training begins.': 'Une équipe d’imagerie médicale veut un premier prototype de réseau de neurones pour classer des radiographies. Tu dois expliquer les briques principales avant le début de l’entraînement.',
    'Beginner': 'Débutant',
    'What is the role of an activation function such as ReLU in a neural network?': 'Quel est le rôle d’une fonction d’activation comme ReLU dans un réseau de neurones ?',
    'Store the training dataset': 'Stocker le jeu de données d’entraînement',
    'Add non-linearity so layers can learn complex patterns': 'Ajouter de la non-linéarité pour que les couches apprennent des motifs complexes',
    'Encrypt the model weights': 'Chiffrer les poids du modèle',
    'Choose the final file format': 'Choisir le format de fichier final',
    'Activation functions make the network non-linear. Without them, stacked layers would behave like one linear model.': 'Les fonctions d’activation rendent le réseau non linéaire. Sans elles, des couches empilées se comporteraient comme un seul modèle linéaire.',
    'Deep learning': 'Deep learning',
    'Which choices usually help train a model more stably? (select 2)': 'Quels choix aident généralement à entraîner un modèle plus stablement ? (2 réponses)',
    'Normalize input features': 'Normaliser les caractéristiques d’entrée',
    'Choose a learning rate that is not too large':
        'Choisir un taux d’apprentissage qui n’est pas trop grand',
    'Remove all validation data': 'Supprimer toutes les données de validation',
    'Increase loss by reversing labels':
        'Augmenter la perte en inversant les étiquettes',
    'Normalized inputs and a sensible learning rate help gradient descent move smoothly toward lower loss.': 'Des entrées normalisées et un taux d’apprentissage raisonnable aident la descente de gradient à avancer régulièrement vers une perte plus faible.',
    'Training': 'Entraînement',
    'During training, what does gradient descent update?':
        'Pendant l’entraînement, que met à jour la descente de gradient ?',
    'Weights and biases': 'Les poids et les biais',
    'The number of images in the hospital': 'Le nombre d’images dans l’hôpital',
    'The ground-truth labels': 'Les étiquettes de vérité terrain',
    'The Python interpreter version': 'La version de l’interpréteur Python',
    'Gradient descent uses the loss gradient to update trainable parameters such as weights and biases.': 'La descente de gradient utilise le gradient de la perte pour mettre à jour les paramètres entraînables comme les poids et les biais.',
    'Which architecture is especially suited for image classification?': 'Quelle architecture est particulièrement adaptée à la classification d’images ?',
    'A transformer configured only for server logs':
        'Un transformer configuré uniquement pour des journaux serveur',
    'A convolutional neural network': 'Un réseau de neurones convolutionnel',
    'A linear regression on file names':
        'Une régression linéaire sur les noms de fichiers',
    'K-means clustering without labels':
        'Un clustering K-means sans étiquettes',
    'Convolutional neural networks learn local visual patterns such as edges and textures, which is why they work well on images.': 'Les réseaux de neurones convolutionnels apprennent des motifs visuels locaux comme les contours et les textures, ce qui explique leur efficacité sur les images.',
    'Computer vision': 'Vision par ordinateur',
    'Build an assistant with an LLM': 'Construire un assistant avec un LLM',
    'A support team wants an assistant that answers questions from internal documentation. It must be useful, predictable and safe with company credentials.': 'Une équipe support veut un assistant qui répond aux questions à partir de la documentation interne. Il doit être utile, prévisible et sûr avec les identifiants de l’entreprise.',
    'Intermediate': 'Intermédiaire',
    'Why does an LLM context window matter when you send a long document?': 'Pourquoi la fenêtre de contexte d’un LLM compte-t-elle quand tu envoies un long document ?',
    'It sets the GPU color used during training':
        'Elle fixe la couleur du GPU utilisée pendant l’entraînement',
    'It replaces the need for tokens': 'Elle remplace le besoin de tokens',
    'It limits how much text the model can consider at once': 'Elle limite la quantité de texte que le modèle peut considérer en une fois',
    'It guarantees that every answer is true':
        'Elle garantit que chaque réponse est vraie',
    'The context window is measured in tokens and caps the text available to the model for one request.': 'La fenêtre de contexte se mesure en tokens et limite le texte disponible pour le modèle dans une requête.',
    'LLMs': 'LLM',
    'Which prompt practices improve an LLM assistant? (select 2)': 'Quelles pratiques de prompt améliorent un assistant LLM ? (2 réponses)',
    'Ask for hidden system prompts': 'Demander les prompts système cachés',
    'Give the task, constraints and output format clearly':
        'Donner clairement la tâche, les contraintes et le format de sortie',
    'Use vague instructions to let the model guess':
        'Utiliser des instructions vagues pour laisser le modèle deviner',
    'Provide relevant examples when the format matters':
        'Fournir des exemples pertinents quand le format compte',
    'Clear instructions and relevant examples reduce ambiguity and make the response format more consistent.': 'Des instructions claires et des exemples pertinents réduisent l’ambiguïté et rendent le format de réponse plus régulier.',
    'Prompt engineering': 'Prompt engineering',
    'What does a higher temperature usually do in an LLM request?': 'Que fait généralement une température plus élevée dans une requête LLM ?',
    'It shortens the context window': 'Elle raccourcit la fenêtre de contexte',
    'It stores the API key on the client': 'Elle stocke la clé API côté client',
    'It disables tokenization': 'Elle désactive la tokenisation',
    'It makes outputs more varied and less deterministic':
        'Elle rend les sorties plus variées et moins déterministes',
    'Temperature controls sampling randomness. Higher values can be creative, but they may also reduce consistency.': 'La température contrôle l’aléatoire de l’échantillonnage. Des valeurs plus élevées peuvent être créatives, mais elles peuvent aussi réduire la cohérence.',
    'Which design reduces hallucinations when answering from company documents?': 'Quelle conception réduit les hallucinations lors de réponses à partir de documents d’entreprise ?',
    'Fine-tune on unrelated public jokes':
        'Faire un fine-tuning sur des blagues publiques sans rapport',
    'Retrieve relevant chunks with embeddings and a vector database before answering': 'Récupérer des passages pertinents avec des embeddings et une base vectorielle avant de répondre',
    'Put the API key in the mobile app':
        'Mettre la clé API dans l’application mobile',
    'Ask the model to invent missing policy details':
        'Demander au modèle d’inventer les détails de politique manquants',
    'Retrieval-augmented generation grounds the answer in retrieved sources. API keys should stay server-side, not in client apps.': 'La génération augmentée par recherche ancre la réponse dans des sources récupérées. Les clés API doivent rester côté serveur, pas dans les applications clientes.',
    'RAG': 'RAG',
    'Serve and monitor models in production':
        'Servir et surveiller des modèles en production',
    'Your fraud model worked in notebooks and now must serve real users. The team needs versioning, cost control, safe rollout and monitoring after release.': 'Ton modèle de détection de fraude fonctionnait dans des notebooks et doit maintenant servir de vrais utilisateurs. L’équipe a besoin de versioning, de contrôle des coûts, d’un déploiement sûr et de surveillance après la mise en ligne.',
    'Advanced': 'Avancé',
    'What is the main purpose of a model registry?':
        'Quel est l’objectif principal d’un registre de modèles ?',
    'Replace all evaluation metrics':
        'Remplacer toutes les métriques d’évaluation',
    'Store user passwords for the model':
        'Stocker les mots de passe des utilisateurs pour le modèle',
    'Version models with metadata, stages and artifacts':
        'Versionner les modèles avec métadonnées, étapes et artefacts',
    'Generate synthetic GPUs for free':
        'Générer gratuitement des GPU synthétiques',
    'A registry tracks model versions, metrics, artifacts and promotion stages so teams know exactly what is deployed.': 'Un registre suit les versions de modèles, les métriques, les artefacts et les étapes de promotion afin que les équipes sachent exactement ce qui est déployé.',
    'MLOps': 'MLOps',
    'Which serving choices match common production needs? (select 2)': 'Quels choix de service correspondent à des besoins courants de production ? (2 réponses)',
    'Use a REST API for low-latency online predictions':
        'Utiliser une API REST pour des prédictions en ligne à faible latence',
    'Retrain inside every user request':
        'Réentraîner dans chaque requête utilisateur',
    'Serve only from a notebook on a laptop':
        'Servir uniquement depuis un notebook sur un ordinateur portable',
    'Run batch scoring for large offline datasets':
        'Exécuter un scoring batch pour de grands jeux de données hors ligne',
    'REST APIs are common for interactive predictions, while batch jobs process large datasets without real-time latency pressure.': 'Les API REST sont courantes pour les prédictions interactives, tandis que les jobs batch traitent de grands jeux de données sans pression de latence temps réel.',
    'Serving': 'Service',
    'A model is accurate but too slow and expensive on GPU. What can help most?': 'Un modèle est précis mais trop lent et coûteux sur GPU. Qu’est-ce qui peut le plus aider ?',
    'Increase the number of unused features':
        'Augmenter le nombre de caractéristiques inutilisées',
    'Apply quantization and benchmark the smaller model':
        'Appliquer la quantification et mesurer le modèle plus petit',
    'Delete latency metrics': 'Supprimer les métriques de latence',
    'Disable monitoring after launch':
        'Désactiver la surveillance après le lancement',
    'Quantization can reduce memory, latency and cost by using lower-precision weights, but it must be benchmarked for quality.': 'La quantification peut réduire la mémoire, la latence et le coût en utilisant des poids de précision plus faible, mais elle doit être évaluée sur la qualité.',
    'Optimization': 'Optimisation',
    'Which practices support safe rollout and responsible AI? (select 2)': 'Quelles pratiques soutiennent un déploiement sûr et une IA responsable ? (2 réponses)',
    'Run an A/B test before full rollout':
        'Exécuter un test A/B avant le déploiement complet',
    'Check unfair error rates across user groups':
        'Vérifier les taux d’erreur injustes entre groupes d’utilisateurs',
    'Ignore feedback after deployment':
        'Ignorer les retours après le déploiement',
    'Hide the deployed model version': 'Cacher la version du modèle déployé',
    'A/B tests limit rollout risk, and fairness checks help detect harmful behavior across groups.': 'Les tests A/B limitent le risque de déploiement, et les contrôles d’équité aident à détecter les comportements nuisibles entre groupes.',
    'Responsible AI': 'IA responsable',
  },
  contentAr: <String, String>{
    'AI / ML Engineer': 'مهندس ذكاء اصطناعي / تعلم آلي',
    'Design, train and deploy intelligent models that turn data into predictions and assistants.':
        'يصمم ويدرّب وينشر نماذج ذكية تحول البيانات إلى تنبؤات ومساعدين.',
    'AI / ML engineers transform data into models that classify images, understand text or automate decisions. They prototype experiments, evaluate results carefully and deploy reliable models with monitoring.': 'يحوّل مهندسو الذكاء الاصطناعي والتعلم الآلي البيانات إلى نماذج تصنف الصور أو تفهم النصوص أو تؤتمت القرارات. يبنون تجارب أولية ويقيّمون النتائج بعناية وينشرون نماذج موثوقة مع المراقبة.',
    '45k – 75k € / year': '45 ألف – 75 ألف € / سنة',
    'Demand is strong as companies add AI features while needing engineers who can make them reliable.': 'الطلب قوي لأن الشركات تضيف ميزات ذكاء اصطناعي وتحتاج إلى مهندسين يجعلونها موثوقة.',
    'Bac+5 in computer science, data science or applied mathematics':
        'Bac+5 في علوم الحاسوب أو علم البيانات أو الرياضيات التطبيقية',
    'Prepare datasets and evaluate model quality':
        'تحضير مجموعات البيانات وتقييم جودة النماذج',
    'Train neural networks and tune hyperparameters':
        'تدريب الشبكات العصبية وضبط المعاملات الفائقة',
    'Build LLM prototypes with safe prompts and retrieval':
        'بناء نماذج أولية لـ LLM باستخدام مطالبات آمنة واسترجاع',
    'Deploy models and monitor drift in production':
        'نشر النماذج ومراقبة الانجراف في الإنتاج',
    'Technology': 'تكنولوجيا',
    'AI': 'ذكاء اصطناعي',
    'Data': 'بيانات',
    'Neural network fundamentals': 'أساسيات الشبكات العصبية',
    'A medical imaging team wants a first neural network prototype to classify X-ray images. You must explain the main building blocks before training begins.': 'يريد فريق تصوير طبي نموذجًا أوليًا لشبكة عصبية لتصنيف صور الأشعة السينية. يجب أن تشرح المكونات الأساسية قبل بدء التدريب.',
    'Beginner': 'مبتدئ',
    'What is the role of an activation function such as ReLU in a neural network?':
        'ما دور دالة تنشيط مثل ReLU في الشبكة العصبية؟',
    'Store the training dataset': 'تخزين مجموعة بيانات التدريب',
    'Add non-linearity so layers can learn complex patterns':
        'إضافة لاخطية كي تتعلم الطبقات أنماطًا معقدة',
    'Encrypt the model weights': 'تشفير أوزان النموذج',
    'Choose the final file format': 'اختيار صيغة الملف النهائية',
    'Activation functions make the network non-linear. Without them, stacked layers would behave like one linear model.': 'تجعل دوال التنشيط الشبكة غير خطية. وبدونها ستتصرف الطبقات المتراكبة كنموذج خطي واحد.',
    'Deep learning': 'تعلم عميق',
    'Which choices usually help train a model more stably? (select 2)': 'ما الخيارات التي تساعد عادةً على تدريب النموذج باستقرار أكبر؟ (اختر 2)',
    'Normalize input features': 'تطبيع خصائص الإدخال',
    'Choose a learning rate that is not too large':
        'اختيار معدل تعلم غير كبير جدًا',
    'Remove all validation data': 'إزالة كل بيانات التحقق',
    'Increase loss by reversing labels': 'زيادة الخسارة بعكس التسميات',
    'Normalized inputs and a sensible learning rate help gradient descent move smoothly toward lower loss.': 'تساعد المدخلات المطبّعة ومعدل التعلم المناسب انحدار التدرج على التحرك بسلاسة نحو خسارة أقل.',
    'Training': 'تدريب',
    'During training, what does gradient descent update?':
        'أثناء التدريب، ماذا يحدّث انحدار التدرج؟',
    'Weights and biases': 'الأوزان والانحيازات',
    'The number of images in the hospital': 'عدد الصور في المستشفى',
    'The ground-truth labels': 'تسميات الحقيقة المرجعية',
    'The Python interpreter version': 'إصدار مفسّر Python',
    'Gradient descent uses the loss gradient to update trainable parameters such as weights and biases.': 'يستخدم انحدار التدرج تدرج الخسارة لتحديث المعاملات القابلة للتدريب مثل الأوزان والانحيازات.',
    'Which architecture is especially suited for image classification?':
        'أي معمارية مناسبة خصوصًا لتصنيف الصور؟',
    'A transformer configured only for server logs':
        'Transformer مضبوط فقط لسجلات الخادم',
    'A convolutional neural network': 'شبكة عصبية التفافية',
    'A linear regression on file names': 'انحدار خطي على أسماء الملفات',
    'K-means clustering without labels': 'تجميع K-means دون تسميات',
    'Convolutional neural networks learn local visual patterns such as edges and textures, which is why they work well on images.': 'تتعلم الشبكات العصبية الالتفافية أنماطًا بصرية محلية مثل الحواف والأنسجة، لذلك تعمل جيدًا مع الصور.',
    'Computer vision': 'رؤية حاسوبية',
    'Build an assistant with an LLM': 'بناء مساعد باستخدام LLM',
    'A support team wants an assistant that answers questions from internal documentation. It must be useful, predictable and safe with company credentials.': 'يريد فريق الدعم مساعدًا يجيب عن الأسئلة من الوثائق الداخلية. يجب أن يكون مفيدًا وقابلًا للتوقع وآمنًا مع بيانات اعتماد الشركة.',
    'Intermediate': 'متوسط',
    'Why does an LLM context window matter when you send a long document?':
        'لماذا تهم نافذة سياق LLM عند إرسال مستند طويل؟',
    'It sets the GPU color used during training':
        'تحدد لون GPU المستخدم أثناء التدريب',
    'It replaces the need for tokens': 'تلغي الحاجة إلى الرموز',
    'It limits how much text the model can consider at once':
        'تحد من كمية النص التي يستطيع النموذج النظر فيها دفعة واحدة',
    'It guarantees that every answer is true': 'تضمن أن كل إجابة صحيحة',
    'The context window is measured in tokens and caps the text available to the model for one request.':
        'تُقاس نافذة السياق بالرموز وتحد من النص المتاح للنموذج في طلب واحد.',
    'LLMs': 'نماذج LLM',
    'Which prompt practices improve an LLM assistant? (select 2)':
        'ما ممارسات المطالبة التي تحسن مساعد LLM؟ (اختر 2)',
    'Ask for hidden system prompts': 'طلب مطالبات النظام المخفية',
    'Give the task, constraints and output format clearly':
        'توضيح المهمة والقيود وتنسيق المخرجات',
    'Use vague instructions to let the model guess':
        'استخدام تعليمات غامضة ليخمن النموذج',
    'Provide relevant examples when the format matters':
        'تقديم أمثلة ذات صلة عندما يكون التنسيق مهمًا',
    'Clear instructions and relevant examples reduce ambiguity and make the response format more consistent.': 'تقلل التعليمات الواضحة والأمثلة المناسبة الغموض وتجعل تنسيق الإجابة أكثر اتساقًا.',
    'Prompt engineering': 'هندسة المطالبات',
    'What does a higher temperature usually do in an LLM request?':
        'ماذا تفعل درجة الحرارة الأعلى عادةً في طلب LLM؟',
    'It shortens the context window': 'تقصّر نافذة السياق',
    'It stores the API key on the client': 'تخزن مفتاح API على العميل',
    'It disables tokenization': 'تعطّل التقسيم إلى رموز',
    'It makes outputs more varied and less deterministic':
        'تجعل المخرجات أكثر تنوعًا وأقل حتمية',
    'Temperature controls sampling randomness. Higher values can be creative, but they may also reduce consistency.': 'تتحكم درجة الحرارة في عشوائية أخذ العينات. يمكن للقيم الأعلى أن تكون إبداعية لكنها قد تقلل الاتساق أيضًا.',
    'Which design reduces hallucinations when answering from company documents?':
        'أي تصميم يقلل الهلوسة عند الإجابة من وثائق الشركة؟',
    'Fine-tune on unrelated public jokes':
        'إجراء Fine-tuning على نكات عامة غير مرتبطة',
    'Retrieve relevant chunks with embeddings and a vector database before answering': 'استرجاع مقاطع ذات صلة باستخدام embeddings وقاعدة بيانات متجهية قبل الإجابة',
    'Put the API key in the mobile app': 'وضع مفتاح API في تطبيق الهاتف',
    'Ask the model to invent missing policy details':
        'طلب اختراع تفاصيل السياسة الناقصة من النموذج',
    'Retrieval-augmented generation grounds the answer in retrieved sources. API keys should stay server-side, not in client apps.': 'يربط RAG الإجابة بالمصادر المسترجعة. يجب أن تبقى مفاتيح API على الخادم لا في تطبيقات العملاء.',
    'RAG': 'RAG',
    'Serve and monitor models in production':
        'خدمة النماذج ومراقبتها في الإنتاج',
    'Your fraud model worked in notebooks and now must serve real users. The team needs versioning, cost control, safe rollout and monitoring after release.': 'كان نموذج كشف الاحتيال يعمل في notebooks والآن يجب أن يخدم مستخدمين حقيقيين. يحتاج الفريق إلى إصدار النماذج وضبط التكلفة وطرح آمن ومراقبة بعد الإصدار.',
    'Advanced': 'متقدم',
    'What is the main purpose of a model registry?':
        'ما الغرض الرئيسي من سجل النماذج؟',
    'Replace all evaluation metrics': 'استبدال كل مقاييس التقييم',
    'Store user passwords for the model':
        'تخزين كلمات مرور المستخدمين من أجل النموذج',
    'Version models with metadata, stages and artifacts':
        'إصدار النماذج مع بيانات وصفية ومراحل وملفات أثرية',
    'Generate synthetic GPUs for free': 'توليد GPUs اصطناعية مجانًا',
    'A registry tracks model versions, metrics, artifacts and promotion stages so teams know exactly what is deployed.': 'يتتبع السجل إصدارات النماذج والمقاييس والملفات الأثرية ومراحل الترقية حتى تعرف الفرق بالضبط ما هو منشور.',
    'MLOps': 'MLOps',
    'Which serving choices match common production needs? (select 2)':
        'أي خيارات خدمة تناسب احتياجات الإنتاج الشائعة؟ (اختر 2)',
    'Use a REST API for low-latency online predictions':
        'استخدام API REST لتنبؤات فورية منخفضة الكمون',
    'Retrain inside every user request': 'إعادة التدريب داخل كل طلب مستخدم',
    'Serve only from a notebook on a laptop':
        'الخدمة فقط من notebook على حاسوب محمول',
    'Run batch scoring for large offline datasets':
        'تشغيل تقييم batch لمجموعات بيانات كبيرة غير متصلة',
    'REST APIs are common for interactive predictions, while batch jobs process large datasets without real-time latency pressure.': 'تُستخدم REST APIs كثيرًا للتنبؤات التفاعلية، بينما تعالج مهام batch مجموعات بيانات كبيرة دون ضغط كمون فوري.',
    'Serving': 'خدمة',
    'A model is accurate but too slow and expensive on GPU. What can help most?':
        'النموذج دقيق لكنه بطيء ومكلف جدًا على GPU. ما الذي قد يساعد أكثر؟',
    'Increase the number of unused features': 'زيادة عدد الخصائص غير المستخدمة',
    'Apply quantization and benchmark the smaller model':
        'تطبيق quantization وقياس أداء النموذج الأصغر',
    'Delete latency metrics': 'حذف مقاييس الكمون',
    'Disable monitoring after launch': 'تعطيل المراقبة بعد الإطلاق',
    'Quantization can reduce memory, latency and cost by using lower-precision weights, but it must be benchmarked for quality.': 'يمكن أن تقلل quantization الذاكرة والكمون والتكلفة باستخدام أوزان بدقة أقل، لكن يجب قياس أثرها على الجودة.',
    'Optimization': 'تحسين',
    'Which practices support safe rollout and responsible AI? (select 2)':
        'ما الممارسات التي تدعم طرحًا آمنًا وذكاءً اصطناعيًا مسؤولًا؟ (اختر 2)',
    'Run an A/B test before full rollout': 'تشغيل اختبار A/B قبل الطرح الكامل',
    'Check unfair error rates across user groups':
        'فحص معدلات خطأ غير عادلة بين مجموعات المستخدمين',
    'Ignore feedback after deployment': 'تجاهل الملاحظات بعد النشر',
    'Hide the deployed model version': 'إخفاء إصدار النموذج المنشور',
    'A/B tests limit rollout risk, and fairness checks help detect harmful behavior across groups.': 'تحد اختبارات A/B من مخاطر الطرح، وتساعد فحوص العدالة على كشف السلوك الضار بين المجموعات.',
    'Responsible AI': 'ذكاء اصطناعي مسؤول',
  },
  coursesEn: <String, Course>{
    'ai-1': Course(
      labId: 'ai-1',
      intro: 'Neural networks learn patterns by adjusting numeric parameters from examples. This course gives you the vocabulary needed to reason about layers, loss, optimization and image models before you start the lab.',
      sections: [
        CourseSection(
          title: 'Neurons, layers and activations',
          body: 'A neuron computes a weighted sum of its inputs and adds a bias. Layers group many neurons so the network can transform data step by step. If every layer stayed linear, the whole network would still be equivalent to one linear model. Activation functions such as ReLU add non-linearity, so deeper layers can learn richer patterns.',
          points: [
            'Weights and biases are the trainable parameters.',
            'Layers compose simple transformations into complex ones.',
            'Activations such as ReLU make the model non-linear.',
          ],
        ),
        CourseSection(
          title: 'Loss, batches and gradient descent',
          body: 'The loss measures how wrong the prediction is compared with the label. Training uses batches, which are small groups of examples processed before an update. One epoch means the model has seen the training dataset once. Gradient descent follows the loss gradient to update weights, and the learning rate controls the size of each step.',
          points: [
            'Lower loss usually means better fit on the training objective.',
            'Batches make training faster and less noisy than one example at a time.',
            'A learning rate that is too high can make training unstable.',
          ],
        ),
        CourseSection(
          title: 'Why CNNs work well on images',
          body: 'Images contain local patterns such as edges, corners and textures. Convolutional neural networks scan small filters over the image to detect these patterns wherever they appear. Deeper layers combine simple features into shapes and objects. This structure is more efficient for images than treating every pixel as an unrelated column.',
          points: [
            'Convolutions reuse filters across the image.',
            'CNNs learn local visual features before global concepts.',
            'Image models still need validation data to check generalization.',
          ],
        ),
      ],
      takeaways: [
        'Neural networks learn trainable weights through layered transformations.',
        'Loss, batches, epochs and learning rate describe the training loop.',
        'CNNs are a strong default architecture for image classification.',
      ],
    ),
    'ai-2': Course(
      labId: 'ai-2',
      intro: 'Large language models are powerful, but a useful assistant needs more than sending a question to an API. You must manage tokens, write clear prompts, ground answers in documents and protect credentials.',
      sections: [
        CourseSection(
          title: 'Tokens, context and temperature',
          body: 'LLMs read and write tokens, which are pieces of words rather than always full words. The context window is the maximum number of tokens the model can consider in one request. If a document is too long, you must summarize it or retrieve only the relevant parts. Temperature controls sampling randomness: low values are more deterministic, while higher values are more varied.',
          points: [
            'The context window limits what the model can use at once.',
            'Long documents need chunking, retrieval or summarization.',
            'Temperature changes variety, not factual knowledge.',
          ],
        ),
        CourseSection(
          title: 'Prompt engineering for assistants',
          body: 'A prompt should state the task, constraints and expected output format. Examples are useful when the answer must follow a precise style or schema. Vague instructions force the model to guess what matters. Good prompts also tell the assistant when to say it does not know instead of inventing details.',
          points: [
            'Clear task and constraints reduce ambiguity.',
            'Examples improve formatting consistency.',
            'Ask the model to admit missing information.',
          ],
        ),
        CourseSection(
          title: 'RAG and server-side API keys',
          body: 'Retrieval-augmented generation, or RAG, connects an LLM to trusted documents. The system splits documents into chunks, turns them into embeddings and stores them in a vector database. At question time, it retrieves relevant chunks and sends them with the prompt, which reduces hallucinations. API keys must stay on a backend server because mobile or web clients can be inspected.',
          points: [
            'Embeddings make semantic document search possible.',
            'Retrieved sources ground the generated answer.',
            'Keep LLM API keys server-side and never in the app.',
          ],
        ),
      ],
      takeaways: [
        'Tokens and context windows limit each LLM request.',
        'Prompt clarity and examples improve assistant behavior.',
        'RAG grounds answers, and API keys belong on the server.',
      ],
    ),
    'ai-3': Course(
      labId: 'ai-3',
      intro: 'Production ML is about repeatability, service quality and risk control. A model that works in a notebook still needs versioning, serving, cost management, monitoring and responsible rollout.',
      sections: [
        CourseSection(
          title: 'Model registry and serving patterns',
          body: 'A model registry stores model versions with metrics, artifacts and deployment stages. It lets the team promote a specific version to staging or production without guessing which file was used. Online serving exposes predictions through a REST API when users need quick answers. Batch serving scores large datasets on a schedule when immediate latency is not required.',
          points: [
            'Registries make model versions traceable.',
            'REST APIs fit low-latency online predictions.',
            'Batch scoring fits large offline workloads.',
          ],
        ),
        CourseSection(
          title: 'Latency, GPU cost and quantization',
          body: 'Inference cost depends on model size, hardware and traffic volume. GPUs are fast for large models, but they can be expensive and underused. Quantization stores weights with lower precision, which can reduce memory use and latency. Always benchmark the optimized model because smaller models can lose accuracy.',
          points: [
            'Latency is a product metric, not only an engineering metric.',
            'GPU cost must be watched like any other production cost.',
            'Quantization trades precision for speed and efficiency.',
          ],
        ),
        CourseSection(
          title: 'Monitoring, experiments and responsible AI',
          body: 'After deployment, data can change and make the model less accurate; this is called drift. Monitoring compares production inputs, predictions and outcomes with what was seen during validation. A/B tests roll out a new model to a limited audience before full release. Responsible AI also checks fairness, failure modes and user feedback across groups.',
          points: [
            'Drift monitoring detects when production data changes.',
            'A/B tests reduce rollout risk with evidence.',
            'Fairness checks help prevent harmful model behavior.',
          ],
        ),
      ],
      takeaways: [
        'MLOps tracks which model version is deployed and why.',
        'Serving design balances latency, batch needs and cost.',
        'Monitoring, A/B tests and fairness checks make releases safer.',
      ],
    ),
  },
  coursesFr: <String, Course>{
    'ai-1': Course(
      labId: 'ai-1',
      intro: 'Les réseaux de neurones apprennent des motifs en ajustant des paramètres numériques à partir d’exemples. Ce cours te donne le vocabulaire nécessaire pour raisonner sur les couches, la perte, l’optimisation et les modèles d’image avant de commencer le lab.',
      sections: [
        CourseSection(
          title: 'Neurones, couches et activations',
          body: 'Un neurone calcule une somme pondérée de ses entrées et ajoute un biais. Les couches regroupent plusieurs neurones pour transformer les données étape par étape. Si chaque couche restait linéaire, tout le réseau serait encore équivalent à un seul modèle linéaire. Les fonctions d’activation comme ReLU ajoutent de la non-linéarité, ce qui permet aux couches profondes d’apprendre des motifs plus riches.',
          points: [
            'Les poids et les biais sont les paramètres entraînables.',
            'Les couches composent des transformations simples en transformations complexes.',
            'Les activations comme ReLU rendent le modèle non linéaire.',
          ],
        ),
        CourseSection(
          title: 'Perte, batches et descente de gradient',
          body: 'La perte mesure l’écart entre la prédiction et l’étiquette. L’entraînement utilise des batches, c’est-à-dire de petits groupes d’exemples traités avant une mise à jour. Une epoch signifie que le modèle a vu une fois le jeu de données d’entraînement. La descente de gradient suit le gradient de la perte pour mettre à jour les poids, et le taux d’apprentissage contrôle la taille de chaque pas.',
          points: [
            'Une perte plus faible indique généralement un meilleur ajustement sur l’objectif d’entraînement.',
            'Les batches rendent l’entraînement plus rapide et moins bruité qu’un exemple à la fois.',
            'Un taux d’apprentissage trop élevé peut rendre l’entraînement instable.',
          ],
        ),
        CourseSection(
          title: 'Pourquoi les CNN fonctionnent bien sur les images',
          body: 'Les images contiennent des motifs locaux comme des contours, des coins et des textures. Les réseaux de neurones convolutionnels font glisser de petits filtres sur l’image pour détecter ces motifs où qu’ils apparaissent. Les couches plus profondes combinent des caractéristiques simples en formes et objets. Cette structure est plus efficace pour les images que traiter chaque pixel comme une colonne indépendante.',
          points: [
            'Les convolutions réutilisent les filtres sur toute l’image.',
            'Les CNN apprennent des caractéristiques visuelles locales avant les concepts globaux.',
            'Les modèles d’image ont quand même besoin de données de validation pour vérifier la généralisation.',
          ],
        ),
      ],
      takeaways: [
        'Les réseaux de neurones apprennent des poids entraînables par transformations en couches.',
        'La perte, les batches, les epochs et le taux d’apprentissage décrivent la boucle d’entraînement.',
        'Les CNN sont une architecture de départ solide pour la classification d’images.',
      ],
    ),
    'ai-2': Course(
      labId: 'ai-2',
      intro: 'Les grands modèles de langage sont puissants, mais un assistant utile demande plus qu’envoyer une question à une API. Tu dois gérer les tokens, écrire des prompts clairs, ancrer les réponses dans des documents et protéger les identifiants.',
      sections: [
        CourseSection(
          title: 'Tokens, contexte et température',
          body: 'Les LLM lisent et écrivent des tokens, qui sont des morceaux de mots plutôt que toujours des mots entiers. La fenêtre de contexte est le nombre maximal de tokens que le modèle peut considérer dans une requête. Si un document est trop long, tu dois le résumer ou récupérer seulement les parties pertinentes. La température contrôle l’aléatoire de l’échantillonnage : les valeurs basses sont plus déterministes, tandis que les valeurs hautes sont plus variées.',
          points: [
            'La fenêtre de contexte limite ce que le modèle peut utiliser en une fois.',
            'Les longs documents exigent du découpage, de la recherche ou du résumé.',
            'La température change la variété, pas la connaissance factuelle.',
          ],
        ),
        CourseSection(
          title: 'Prompt engineering pour assistants',
          body: 'Un prompt doit indiquer la tâche, les contraintes et le format de sortie attendu. Les exemples sont utiles quand la réponse doit suivre un style ou un schéma précis. Des instructions vagues obligent le modèle à deviner ce qui compte. De bons prompts disent aussi à l’assistant quand répondre qu’il ne sait pas au lieu d’inventer des détails.',
          points: [
            'Une tâche et des contraintes claires réduisent l’ambiguïté.',
            'Les exemples améliorent la cohérence du format.',
            'Demande au modèle d’admettre les informations manquantes.',
          ],
        ),
        CourseSection(
          title: 'RAG et clés API côté serveur',
          body: 'La génération augmentée par recherche, ou RAG, relie un LLM à des documents fiables. Le système découpe les documents en passages, les transforme en embeddings et les stocke dans une base vectorielle. Au moment de la question, il récupère les passages pertinents et les envoie avec le prompt, ce qui réduit les hallucinations. Les clés API doivent rester sur un serveur backend, car les clients mobiles ou web peuvent être inspectés.',
          points: [
            'Les embeddings rendent possible la recherche sémantique dans les documents.',
            'Les sources récupérées ancrent la réponse générée.',
            'Garde les clés API LLM côté serveur, jamais dans l’app.',
          ],
        ),
      ],
      takeaways: [
        'Les tokens et la fenêtre de contexte limitent chaque requête LLM.',
        'La clarté du prompt et les exemples améliorent le comportement de l’assistant.',
        'Le RAG ancre les réponses, et les clés API appartiennent au serveur.',
      ],
    ),
    'ai-3': Course(
      labId: 'ai-3',
      intro: 'Le ML en production concerne la répétabilité, la qualité de service et la maîtrise des risques. Un modèle qui fonctionne dans un notebook a encore besoin de versioning, de service, de gestion des coûts, de surveillance et d’un déploiement responsable.',
      sections: [
        CourseSection(
          title: 'Registre de modèles et modes de service',
          body: 'Un registre de modèles stocke les versions avec métriques, artefacts et étapes de déploiement. Il permet à l’équipe de promouvoir une version précise vers la préproduction ou la production sans deviner quel fichier a été utilisé. Le service en ligne expose les prédictions via une API REST quand les utilisateurs ont besoin de réponses rapides. Le service batch score de grands jeux de données selon un planning quand la latence immédiate n’est pas nécessaire.',
          points: [
            'Les registres rendent les versions de modèles traçables.',
            'Les API REST conviennent aux prédictions en ligne à faible latence.',
            'Le scoring batch convient aux gros traitements hors ligne.',
          ],
        ),
        CourseSection(
          title: 'Latence, coût GPU et quantification',
          body: 'Le coût d’inférence dépend de la taille du modèle, du matériel et du volume de trafic. Les GPU sont rapides pour les grands modèles, mais ils peuvent être coûteux et sous-utilisés. La quantification stocke les poids avec une précision plus faible, ce qui peut réduire l’usage mémoire et la latence. Mesure toujours le modèle optimisé, car les modèles plus petits peuvent perdre en précision.',
          points: [
            'La latence est une métrique produit, pas seulement une métrique d’ingénierie.',
            'Le coût GPU doit être surveillé comme tout autre coût de production.',
            'La quantification échange de la précision contre vitesse et efficacité.',
          ],
        ),
        CourseSection(
          title: 'Surveillance, expériences et IA responsable',
          body: 'Après le déploiement, les données peuvent changer et rendre le modèle moins précis : c’est la dérive. La surveillance compare les entrées, prédictions et résultats de production avec ce qui a été vu pendant la validation. Les tests A/B déploient un nouveau modèle à une audience limitée avant la sortie complète. L’IA responsable vérifie aussi l’équité, les modes d’échec et les retours utilisateur entre groupes.',
          points: [
            'La surveillance de dérive détecte quand les données de production changent.',
            'Les tests A/B réduisent le risque de déploiement avec des preuves.',
            'Les contrôles d’équité aident à prévenir les comportements nuisibles du modèle.',
          ],
        ),
      ],
      takeaways: [
        'Le MLOps suit quelle version de modèle est déployée et pourquoi.',
        'La conception du service équilibre latence, batch et coût.',
        'Surveillance, tests A/B et contrôles d’équité rendent les sorties plus sûres.',
      ],
    ),
  },
  coursesAr: <String, Course>{
    'ai-1': Course(
      labId: 'ai-1',
      intro: 'تتعلم الشبكات العصبية الأنماط عبر تعديل معاملات رقمية من الأمثلة. يمنحك هذا الدرس المفردات اللازمة للتفكير في الطبقات والخسارة والتحسين ونماذج الصور قبل بدء المختبر.',
      sections: [
        CourseSection(
          title: 'العصبونات والطبقات ودوال التنشيط',
          body: 'يحسب العصبون مجموعًا موزونًا لمدخلاته ويضيف انحيازًا. تجمع الطبقات عصبونات كثيرة كي تحول البيانات خطوة بعد خطوة. إذا بقيت كل طبقة خطية فستبقى الشبكة كلها مكافئة لنموذج خطي واحد. تضيف دوال التنشيط مثل ReLU لاخطية، لذلك تستطيع الطبقات العميقة تعلم أنماط أغنى.',
          points: [
            'الأوزان والانحيازات هي المعاملات القابلة للتدريب.',
            'تركّب الطبقات تحويلات بسيطة لتكوين تحويلات معقدة.',
            'تجعل دوال التنشيط مثل ReLU النموذج غير خطي.',
          ],
        ),
        CourseSection(
          title: 'الخسارة والدفعات وانحدار التدرج',
          body: 'تقيس الخسارة مدى خطأ التنبؤ مقارنة بالتسمية. يستخدم التدريب دفعات، وهي مجموعات صغيرة من الأمثلة تعالج قبل كل تحديث. تعني epoch واحدة أن النموذج شاهد مجموعة التدريب مرة واحدة. يتبع انحدار التدرج تدرج الخسارة لتحديث الأوزان، ويتحكم معدل التعلم في حجم كل خطوة.',
          points: [
            'الخسارة الأقل تعني غالبًا ملاءمة أفضل لهدف التدريب.',
            'تجعل الدفعات التدريب أسرع وأقل ضجيجًا من مثال واحد في كل مرة.',
            'قد يجعل معدل التعلم الكبير جدًا التدريب غير مستقر.',
          ],
        ),
        CourseSection(
          title: 'لماذا تعمل CNN جيدًا مع الصور',
          body: 'تحتوي الصور على أنماط محلية مثل الحواف والزوايا والأنسجة. تمرر الشبكات العصبية الالتفافية مرشحات صغيرة فوق الصورة لاكتشاف هذه الأنماط أينما ظهرت. تجمع الطبقات الأعمق الخصائص البسيطة في أشكال وكائنات. هذه البنية أكفأ للصور من معاملة كل بكسل كعمود مستقل.',
          points: [
            'تعيد الالتفافات استخدام المرشحات عبر الصورة.',
            'تتعلم CNN خصائص بصرية محلية قبل المفاهيم العامة.',
            'ما زالت نماذج الصور تحتاج إلى بيانات تحقق لاختبار التعميم.',
          ],
        ),
      ],
      takeaways: [
        'تتعلم الشبكات العصبية أوزانًا قابلة للتدريب عبر تحويلات طبقية.',
        'تصف الخسارة والدفعات وepochs ومعدل التعلم حلقة التدريب.',
        'تعد CNN معمارية بداية قوية لتصنيف الصور.',
      ],
    ),
    'ai-2': Course(
      labId: 'ai-2',
      intro: 'نماذج اللغة الكبيرة قوية، لكن المساعد المفيد يحتاج إلى أكثر من إرسال سؤال إلى API. يجب إدارة الرموز وكتابة مطالبات واضحة وربط الإجابات بالوثائق وحماية بيانات الاعتماد.',
      sections: [
        CourseSection(
          title: 'الرموز والسياق ودرجة الحرارة',
          body: 'تقرأ LLMs وتكتب رموزًا، وهي أجزاء من الكلمات وليست دائمًا كلمات كاملة. نافذة السياق هي أكبر عدد من الرموز يستطيع النموذج النظر فيه في طلب واحد. إذا كان المستند طويلًا جدًا فيجب تلخيصه أو استرجاع الأجزاء المهمة فقط. تتحكم درجة الحرارة في عشوائية أخذ العينات: القيم المنخفضة أكثر حتمية، والقيم الأعلى أكثر تنوعًا.',
          points: [
            'تحد نافذة السياق مما يمكن للنموذج استخدامه دفعة واحدة.',
            'تحتاج المستندات الطويلة إلى تقسيم أو استرجاع أو تلخيص.',
            'تغير درجة الحرارة التنوع ولا تغير المعرفة الواقعية.',
          ],
        ),
        CourseSection(
          title: 'هندسة المطالبات للمساعدين',
          body: 'يجب أن تذكر المطالبة المهمة والقيود وتنسيق المخرجات المتوقع. تكون الأمثلة مفيدة عندما يجب أن تتبع الإجابة أسلوبًا أو مخططًا دقيقًا. التعليمات الغامضة تجبر النموذج على تخمين ما هو مهم. كما تخبر المطالبات الجيدة المساعد متى يقول إنه لا يعرف بدل اختراع تفاصيل.',
          points: [
            'المهمة والقيود الواضحة تقلل الغموض.',
            'تحسن الأمثلة اتساق التنسيق.',
            'اطلب من النموذج الاعتراف بالمعلومات الناقصة.',
          ],
        ),
        CourseSection(
          title: 'RAG ومفاتيح API على الخادم',
          body: 'يربط RAG نموذج LLM بوثائق موثوقة. يقسم النظام الوثائق إلى مقاطع ويحوّلها إلى embeddings ويخزنها في قاعدة بيانات متجهية. عند السؤال، يسترجع المقاطع ذات الصلة ويرسلها مع المطالبة، مما يقلل الهلوسة. يجب أن تبقى مفاتيح API على خادم خلفي لأن عملاء الويب أو الهاتف يمكن فحصهم.',
          points: [
            'تجعل embeddings البحث الدلالي في الوثائق ممكنًا.',
            'تربط المصادر المسترجعة الإجابة المولدة بالواقع.',
            'أبق مفاتيح LLM API على الخادم ولا تضعها في التطبيق.',
          ],
        ),
      ],
      takeaways: [
        'تحد الرموز ونافذة السياق كل طلب LLM.',
        'تحسن وضوح المطالبة والأمثلة سلوك المساعد.',
        'يثبت RAG الإجابات، ومفاتيح API مكانها الخادم.',
      ],
    ),
    'ai-3': Course(
      labId: 'ai-3',
      intro: 'يدور ML في الإنتاج حول قابلية التكرار وجودة الخدمة والتحكم في المخاطر. النموذج الذي يعمل في notebook ما زال يحتاج إلى إصدار وخدمة وإدارة تكلفة ومراقبة وطرح مسؤول.',
      sections: [
        CourseSection(
          title: 'سجل النماذج وأنماط الخدمة',
          body: 'يخزن سجل النماذج الإصدارات مع المقاييس والملفات الأثرية ومراحل النشر. يسمح للفريق بترقية إصدار محدد إلى الاختبار أو الإنتاج دون تخمين الملف المستخدم. تعرض الخدمة الفورية التنبؤات عبر API REST عندما يحتاج المستخدمون إلى إجابات سريعة. تعالج خدمة batch مجموعات بيانات كبيرة وفق جدول عندما لا تكون الكمون الفوري مطلوبًا.',
          points: [
            'تجعل السجلات إصدارات النماذج قابلة للتتبع.',
            'تناسب REST APIs التنبؤات الفورية منخفضة الكمون.',
            'يناسب scoring batch أعباء العمل الكبيرة غير المتصلة.',
          ],
        ),
        CourseSection(
          title: 'الكمون وتكلفة GPU والتكميم',
          body: 'تعتمد تكلفة الاستدلال على حجم النموذج والعتاد وحجم المرور. تعد GPUs سريعة للنماذج الكبيرة لكنها قد تكون مكلفة وغير مستغلة بالكامل. يخزن التكميم الأوزان بدقة أقل، مما قد يقلل استخدام الذاكرة والكمون. اختبر النموذج المحسن دائمًا لأن النماذج الأصغر قد تفقد الدقة.',
          points: [
            'الكمون مقياس منتج وليس مقياسًا هندسيًا فقط.',
            'يجب مراقبة تكلفة GPU مثل أي تكلفة إنتاج أخرى.',
            'يبادل التكميم بعض الدقة مقابل السرعة والكفاءة.',
          ],
        ),
        CourseSection(
          title: 'المراقبة والتجارب والذكاء الاصطناعي المسؤول',
          body: 'بعد النشر، قد تتغير البيانات وتجعل النموذج أقل دقة؛ يسمى ذلك انجرافًا. تقارن المراقبة مدخلات الإنتاج وتنبؤاته ونتائجه بما شوهد أثناء التحقق. تطرح اختبارات A/B نموذجًا جديدًا على جمهور محدود قبل الإصدار الكامل. يفحص الذكاء الاصطناعي المسؤول أيضًا العدالة وأنماط الفشل وملاحظات المستخدمين عبر المجموعات.',
          points: [
            'تكشف مراقبة الانجراف متى تتغير بيانات الإنتاج.',
            'تقلل اختبارات A/B مخاطر الطرح بالأدلة.',
            'تساعد فحوص العدالة على منع سلوك النموذج الضار.',
          ],
        ),
      ],
      takeaways: [
        'يتتبع MLOps أي إصدار نموذج منشور ولماذا.',
        'يوازن تصميم الخدمة بين الكمون وbatch والتكلفة.',
        'تجعل المراقبة واختبارات A/B وفحوص العدالة الإصدارات أكثر أمانًا.',
      ],
    ),
  },
  courseExamples: <String, List<String?>>{
    'ai-1': [
      'import torch.nn as nn\n'
          'model = nn.Sequential(\n'
          '    nn.Linear(30, 16), nn.ReLU(),\n'
          '    nn.Linear(16, 2)\n'
          ')',
      'for epoch in range(10):\n'
          '    for xb, yb in loader:\n'
          '        loss = criterion(model(xb), yb)\n'
          '        loss.backward()\n'
          '        optimizer.step()\n'
          '        optimizer.zero_grad()',
      'import torchvision.models as models\n'
          'model = models.resnet18(weights=None)\n'
          'model.fc = nn.Linear(model.fc.in_features, 2)',
    ],
    'ai-2': [
      'prompt = f"""\n'
          'Answer only from this context:\n'
          '{context}\n'
          'Question: {question}\n'
          'If missing, say you do not know.\n'
          '"""',
      'from sentence_transformers import SentenceTransformer\n'
          'model = SentenceTransformer("all-MiniLM-L6-v2")\n'
          'vectors = model.encode(chunks)\n'
          'index.add(vectors)',
      'curl -X POST https://api.example.com/assistant \\\n'
          '  -H "Authorization: Bearer \$SERVER_TOKEN" \\\n'
          '  -d \'{"question":"How do I reset MFA?"}\'',
    ],
    'ai-3': [
      'import mlflow\n'
          'mlflow.log_metric("f1", 0.91)\n'
          'mlflow.sklearn.log_model(model, "model")\n'
          'mlflow.register_model("runs:/RUN_ID/model", "fraud-model")',
      'from fastapi import FastAPI\n'
          'app = FastAPI()\n'
          '@app.post("/predict")\n'
          'def predict(row: dict):\n'
          '    return {"score": float(model.predict_proba([row])[0][1])}',
      'drift = abs(prod_mean - train_mean)\n'
          'if drift > threshold:\n'
          '    alert("feature drift detected")\n'
          'run_ab_test(model_a, model_b)',
    ],
  },
);
