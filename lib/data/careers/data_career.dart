import 'package:flutter/material.dart';

import '../../models/career.dart';
import '../../models/career_pack.dart';
import '../../models/course.dart';

const dataPack = CareerPack(
  career: Career(
    id: 'data',
    title: 'Data Scientist',
    summary: 'Turn messy data into reliable predictions and decisions.',
    description:
        'Data scientists collect, clean and explore datasets before building '
        'statistical or machine learning models. They explain results to teams, '
        'measure model quality and watch for bias or drift after deployment.',
    icon: Icons.insights,
    color: Color(0xFF00897B),
    tools: ['Python', 'pandas', 'scikit-learn', 'Jupyter'],
    tags: ['Technology', 'Data', 'Problem solving'],
    salary: '40k – 65k € / year',
    outlook: 'Demand is strong in product, finance, health and industry as companies turn data into decisions.',
    education: 'Bac+3 to Bac+5 in data science, statistics or computer science',
    dailyTasks: [
      'Clean and document raw datasets',
      'Explore trends with statistics and charts',
      'Train and compare prediction models',
      'Explain insights and risks to stakeholders',
    ],
    labs: [
      Lab(
        id: 'data-1',
        title: 'Explore and clean a dataset',
        scenario:
            'A product team gives you a pandas DataFrame with customer activity. '
            'Before any model, you must detect missing values, outliers and useful descriptive patterns.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'Which actions are sensible first checks for missing data? (select 2)',
            options: [
              'Run df.isna().sum() to count missing values',
              'Delete every numeric column immediately',
              'Decide whether to impute or drop rows based on business meaning',
              'Train a model before looking at the data',
            ],
            correct: {0, 2},
            skill: 'Data cleaning',
            explanation: 'Counting missing values shows the scale of the issue, then domain meaning guides whether imputation or deletion is safe.',
          ),
          LabQuestion(
            prompt: 'Which method is commonly used to flag numeric outliers?',
            options: [
              'Alphabetical sorting',
              'The interquartile range rule',
              'Changing all values to strings',
              'Dropping the target column',
            ],
            correct: {1},
            skill: 'Statistics',
            explanation: 'The IQR rule flags values far below Q1 or above Q3 and is useful for skewed numeric data.',
          ),
          LabQuestion(
            prompt: 'You want to study the relationship between age and monthly spending. Best chart?',
            options: [
              'Pie chart',
              'Single-value KPI card',
              'Scatter plot',
              'File tree',
            ],
            correct: {2},
            skill: 'Visualization',
            explanation: 'A scatter plot shows how two numeric variables vary together and can reveal clusters or outliers.',
          ),
          LabQuestion(
            prompt: 'What does df.describe() mainly provide?',
            options: [
              'Production monitoring alerts',
              'SQL indexes',
              'Model deployment scripts',
              'Descriptive statistics such as mean, quartiles and standard deviation',
            ],
            correct: {3},
            skill: 'Statistics',
            explanation: 'df.describe() summarizes numeric distributions, which helps you spot ranges, spread and unusual values.',
          ),
        ],
      ),
      Lab(
        id: 'data-2',
        title: 'Train and evaluate a prediction model',
        scenario:
            'You prepare a supervised learning experiment in scikit-learn. '
            'The team needs the right problem type, a fair train/test split and metrics that match the business question.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'Predicting whether a customer will churn next month is what type of task?',
            options: [
              'Regression',
              'Classification',
              'Clustering only',
              'Data visualization only',
            ],
            correct: {1},
            skill: 'Machine learning',
            explanation: 'Churn is a category such as yes or no, so it is a classification problem.',
          ),
          LabQuestion(
            prompt: 'Why split data into train and test sets?',
            options: [
              'To make the dataset smaller for no reason',
              'To remove all categorical variables',
              'To estimate performance on data the model has not learned from',
              'To guarantee perfect accuracy',
            ],
            correct: {2},
            skill: 'Evaluation',
            explanation: 'A held-out test set approximates future unseen data and gives a more honest performance estimate.',
          ),
          LabQuestion(
            prompt: 'Which metrics are especially useful for a classification model when false positives and false negatives matter? (select 2)',
            options: [
              'Precision',
              'RMSE',
              'Recall',
              'Number of columns in the CSV',
            ],
            correct: {0, 2},
            skill: 'Evaluation',
            explanation: 'Precision measures how many positive predictions are correct, while recall measures how many real positives are found.',
          ),
          LabQuestion(
            prompt: 'Which symptom suggests overfitting?',
            options: [
              'Similar train and test scores',
              'Low train score and low test score',
              'No model was trained',
              'Very high train score but much lower test score',
            ],
            correct: {3},
            skill: 'Machine learning',
            explanation: 'Overfitting means the model learned training noise and generalizes poorly to the test set.',
          ),
        ],
      ),
      Lab(
        id: 'data-3',
        title: 'Imbalanced data, bias and deployment',
        scenario:
            'Your model is ready for a pilot, but only a small share of examples are positive. '
            'You must evaluate imbalance, avoid leakage, check fairness and monitor the model once it runs in production.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'For an imbalanced classification problem, which metrics are often more informative than accuracy? (select 2)',
            options: [
              'Mean absolute error',
              'F1-score',
              'ROC-AUC',
              'Dataset file size',
            ],
            correct: {1, 2},
            skill: 'Evaluation',
            explanation: 'F1 balances precision and recall, and ROC-AUC evaluates ranking ability across thresholds.',
          ),
          LabQuestion(
            prompt: 'Which workflow creates data leakage?',
            options: [
              'Fit a scaler on the full dataset before the train/test split',
              'Fit preprocessing only on the training set',
              'Use cross-validation inside the training data',
              'Keep the test set untouched until final evaluation',
            ],
            correct: {0},
            skill: 'Data cleaning',
            explanation: 'Preprocessing learned from the full dataset lets information from the test set influence training.',
          ),
          LabQuestion(
            prompt: 'How can you start checking fairness across user groups?',
            options: [
              'Hide every metric from the product team',
              'Use only the global average score',
              'Remove documentation',
              'Compare error rates and recall by group',
            ],
            correct: {3},
            skill: 'Ethics',
            explanation: 'Group-level metrics can reveal whether the model performs worse for a protected or important segment.',
          ),
          LabQuestion(
            prompt: 'After deployment, what should model monitoring include?',
            options: [
              'Ignore inputs once the model is online',
              'Retrain every minute without review',
              'Track prediction quality and feature drift over time',
              'Delete historical predictions immediately',
            ],
            correct: {2},
            skill: 'MLOps',
            explanation: 'Monitoring detects drift in input distributions and performance changes before users are harmed.',
          ),
        ],
      ),
    ],
  ),
  interests: ['Data', 'AI', 'Problem solving', 'Programming'],
  contentFr: <String, String>{
    'Data Scientist': 'Data Scientist',
    'Turn messy data into reliable predictions and decisions.':
        'Transformer des données brutes en prédictions et décisions fiables.',
    'Data scientists collect, clean and explore datasets before building statistical or machine learning models. They explain results to teams, measure model quality and watch for bias or drift after deployment.': 'Les Data Scientists collectent, nettoient et explorent des jeux de données avant de construire des modèles statistiques ou de machine learning. Ils expliquent les résultats aux équipes, mesurent la qualité des modèles et surveillent les biais ou la dérive après déploiement.',
    '40k – 65k € / year': '40k – 65k € / an',
    'Demand is strong in product, finance, health and industry as companies turn data into decisions.': 'La demande est forte dans le produit, la finance, la santé et l’industrie, car les entreprises transforment les données en décisions.',
    'Bac+3 to Bac+5 in data science, statistics or computer science':
        'Bac+3 à Bac+5 en data science, statistiques ou informatique',
    'Clean and document raw datasets':
        'Nettoyer et documenter des jeux de données bruts',
    'Explore trends with statistics and charts':
        'Explorer les tendances avec des statistiques et des graphiques',
    'Train and compare prediction models':
        'Entraîner et comparer des modèles prédictifs',
    'Explain insights and risks to stakeholders':
        'Expliquer les insights et les risques aux parties prenantes',
    'Technology': 'Technologie',
    'Data': 'Données',
    'Problem solving': 'Résolution de problèmes',
    'Explore and clean a dataset': 'Explorer et nettoyer un jeu de données',
    'A product team gives you a pandas DataFrame with customer activity. Before any model, you must detect missing values, outliers and useful descriptive patterns.': 'Une équipe produit te donne un DataFrame pandas avec l’activité client. Avant tout modèle, tu dois détecter les valeurs manquantes, les valeurs aberrantes et les tendances descriptives utiles.',
    'Beginner': 'Débutant',
    'Which actions are sensible first checks for missing data? (select 2)': 'Quelles actions sont de bons premiers contrôles pour les données manquantes ? (2 réponses)',
    'Run df.isna().sum() to count missing values':
        'Exécuter df.isna().sum() pour compter les valeurs manquantes',
    'Delete every numeric column immediately':
        'Supprimer immédiatement toutes les colonnes numériques',
    'Decide whether to impute or drop rows based on business meaning':
        'Choisir d’imputer ou de supprimer des lignes selon le sens métier',
    'Train a model before looking at the data':
        'Entraîner un modèle avant de regarder les données',
    'Counting missing values shows the scale of the issue, then domain meaning guides whether imputation or deletion is safe.': 'Compter les valeurs manquantes montre l’ampleur du problème, puis le sens métier indique si l’imputation ou la suppression est sûre.',
    'Data cleaning': 'Nettoyage des données',
    'Which method is commonly used to flag numeric outliers?': 'Quelle méthode est couramment utilisée pour repérer les valeurs aberrantes numériques ?',
    'Alphabetical sorting': 'Tri alphabétique',
    'The interquartile range rule': 'La règle de l’écart interquartile',
    'Changing all values to strings':
        'Transformer toutes les valeurs en chaînes de caractères',
    'Dropping the target column': 'Supprimer la colonne cible',
    'The IQR rule flags values far below Q1 or above Q3 and is useful for skewed numeric data.': 'La règle IQR signale les valeurs très sous Q1 ou au-dessus de Q3 et reste utile pour des données numériques asymétriques.',
    'Statistics': 'Statistiques',
    'You want to study the relationship between age and monthly spending. Best chart?': 'Tu veux étudier la relation entre l’âge et les dépenses mensuelles. Quel graphique choisir ?',
    'Pie chart': 'Diagramme circulaire',
    'Single-value KPI card': 'Carte KPI à valeur unique',
    'Scatter plot': 'Nuage de points',
    'File tree': 'Arborescence de fichiers',
    'A scatter plot shows how two numeric variables vary together and can reveal clusters or outliers.': 'Un nuage de points montre comment deux variables numériques varient ensemble et peut révéler des groupes ou des valeurs aberrantes.',
    'Visualization': 'Visualisation',
    'What does df.describe() mainly provide?':
        'Que fournit principalement df.describe() ?',
    'Production monitoring alerts': 'Alertes de monitoring en production',
    'SQL indexes': 'Index SQL',
    'Model deployment scripts': 'Scripts de déploiement de modèle',
    'Descriptive statistics such as mean, quartiles and standard deviation': 'Des statistiques descriptives comme la moyenne, les quartiles et l’écart type',
    'df.describe() summarizes numeric distributions, which helps you spot ranges, spread and unusual values.': 'df.describe() résume les distributions numériques, ce qui t’aide à repérer les plages, la dispersion et les valeurs inhabituelles.',
    'Train and evaluate a prediction model':
        'Entraîner et évaluer un modèle prédictif',
    'You prepare a supervised learning experiment in scikit-learn. The team needs the right problem type, a fair train/test split and metrics that match the business question.': 'Tu prépares une expérience d’apprentissage supervisé dans scikit-learn. L’équipe a besoin du bon type de problème, d’un découpage train/test honnête et de métriques adaptées à la question métier.',
    'Intermediate': 'Intermédiaire',
    'Predicting whether a customer will churn next month is what type of task?': 'Prédire si un client va se désabonner le mois prochain correspond à quel type de tâche ?',
    'Regression': 'Régression',
    'Classification': 'Classification',
    'Clustering only': 'Uniquement clustering',
    'Data visualization only': 'Uniquement visualisation de données',
    'Churn is a category such as yes or no, so it is a classification problem.': 'Le churn est une catégorie comme oui ou non : c’est donc un problème de classification.',
    'Machine learning': 'Machine learning',
    'Why split data into train and test sets?':
        'Pourquoi séparer les données en ensembles d’entraînement et de test ?',
    'To make the dataset smaller for no reason':
        'Pour réduire le jeu de données sans raison',
    'To remove all categorical variables':
        'Pour supprimer toutes les variables catégorielles',
    'To estimate performance on data the model has not learned from': 'Pour estimer la performance sur des données que le modèle n’a pas apprises',
    'To guarantee perfect accuracy': 'Pour garantir une exactitude parfaite',
    'A held-out test set approximates future unseen data and gives a more honest performance estimate.': 'Un jeu de test mis de côté approxime de futures données inconnues et donne une estimation plus honnête de la performance.',
    'Evaluation': 'Évaluation',
    'Which metrics are especially useful for a classification model when false positives and false negatives matter? (select 2)': 'Quelles métriques sont particulièrement utiles pour un modèle de classification quand les faux positifs et faux négatifs comptent ? (2 réponses)',
    'Precision': 'Précision',
    'RMSE': 'RMSE',
    'Recall': 'Rappel',
    'Number of columns in the CSV': 'Nombre de colonnes dans le CSV',
    'Precision measures how many positive predictions are correct, while recall measures how many real positives are found.': 'La précision mesure combien de prédictions positives sont correctes, tandis que le rappel mesure combien de vrais positifs sont retrouvés.',
    'Which symptom suggests overfitting?':
        'Quel symptôme suggère du surapprentissage ?',
    'Similar train and test scores':
        'Scores d’entraînement et de test similaires',
    'Low train score and low test score':
        'Score d’entraînement faible et score de test faible',
    'No model was trained': 'Aucun modèle n’a été entraîné',
    'Very high train score but much lower test score':
        'Score d’entraînement très élevé mais score de test bien plus faible',
    'Overfitting means the model learned training noise and generalizes poorly to the test set.': 'Le surapprentissage signifie que le modèle a appris le bruit de l’entraînement et généralise mal au jeu de test.',
    'Imbalanced data, bias and deployment':
        'Données déséquilibrées, biais et déploiement',
    'Your model is ready for a pilot, but only a small share of examples are positive. You must evaluate imbalance, avoid leakage, check fairness and monitor the model once it runs in production.': 'Ton modèle est prêt pour un pilote, mais seule une petite part des exemples est positive. Tu dois évaluer le déséquilibre, éviter les fuites, vérifier l’équité et surveiller le modèle une fois en production.',
    'Advanced': 'Avancé',
    'For an imbalanced classification problem, which metrics are often more informative than accuracy? (select 2)': 'Pour un problème de classification déséquilibré, quelles métriques sont souvent plus informatives que l’accuracy ? (2 réponses)',
    'Mean absolute error': 'Erreur absolue moyenne',
    'F1-score': 'Score F1',
    'ROC-AUC': 'ROC-AUC',
    'Dataset file size': 'Taille du fichier de données',
    'F1 balances precision and recall, and ROC-AUC evaluates ranking ability across thresholds.': 'Le F1 équilibre précision et rappel, et ROC-AUC évalue la capacité de classement sur plusieurs seuils.',
    'Which workflow creates data leakage?':
        'Quel workflow crée une fuite de données ?',
    'Fit a scaler on the full dataset before the train/test split': 'Ajuster un scaler sur tout le jeu de données avant le découpage train/test',
    'Fit preprocessing only on the training set':
        'Ajuster le prétraitement uniquement sur l’ensemble d’entraînement',
    'Use cross-validation inside the training data':
        'Utiliser la validation croisée dans les données d’entraînement',
    'Keep the test set untouched until final evaluation':
        'Garder le jeu de test intact jusqu’à l’évaluation finale',
    'Preprocessing learned from the full dataset lets information from the test set influence training.': 'Un prétraitement appris sur tout le jeu de données laisse des informations du test influencer l’entraînement.',
    'How can you start checking fairness across user groups?':
        'Comment commencer à vérifier l’équité entre groupes d’utilisateurs ?',
    'Hide every metric from the product team':
        'Cacher toutes les métriques à l’équipe produit',
    'Use only the global average score':
        'Utiliser seulement le score moyen global',
    'Remove documentation': 'Supprimer la documentation',
    'Compare error rates and recall by group':
        'Comparer les taux d’erreur et le rappel par groupe',
    'Group-level metrics can reveal whether the model performs worse for a protected or important segment.': 'Les métriques par groupe peuvent révéler si le modèle fonctionne moins bien pour un segment protégé ou important.',
    'Ethics': 'Éthique',
    'After deployment, what should model monitoring include?':
        'Après le déploiement, que doit inclure le monitoring du modèle ?',
    'Ignore inputs once the model is online':
        'Ignorer les entrées une fois le modèle en ligne',
    'Retrain every minute without review':
        'Réentraîner chaque minute sans revue',
    'Track prediction quality and feature drift over time': 'Suivre la qualité des prédictions et la dérive des variables dans le temps',
    'Delete historical predictions immediately':
        'Supprimer immédiatement les prédictions historiques',
    'Monitoring detects drift in input distributions and performance changes before users are harmed.': 'Le monitoring détecte la dérive des distributions d’entrée et les changements de performance avant d’impacter les utilisateurs.',
    'MLOps': 'MLOps',
  },
  contentAr: <String, String>{
    'Data Scientist': 'عالم بيانات',
    'Turn messy data into reliable predictions and decisions.':
        'حوّل البيانات غير المرتبة إلى تنبؤات وقرارات موثوقة.',
    'Data scientists collect, clean and explore datasets before building statistical or machine learning models. They explain results to teams, measure model quality and watch for bias or drift after deployment.': 'يجمع علماء البيانات مجموعات البيانات وينظفونها ويستكشفونها قبل بناء نماذج إحصائية أو نماذج machine learning. يشرحون النتائج للفرق، ويقيسون جودة النماذج، ويراقبون التحيز أو الانحراف بعد النشر.',
    '40k – 65k € / year': '40k – 65k € / سنة',
    'Demand is strong in product, finance, health and industry as companies turn data into decisions.': 'الطلب قوي في المنتج والمالية والصحة والصناعة لأن الشركات تحول البيانات إلى قرارات.',
    'Bac+3 to Bac+5 in data science, statistics or computer science':
        'Bac+3 إلى Bac+5 في علم البيانات أو الإحصاء أو علوم الحاسوب',
    'Clean and document raw datasets': 'تنظيف وتوثيق مجموعات البيانات الخام',
    'Explore trends with statistics and charts':
        'استكشاف الاتجاهات بالإحصاءات والرسوم البيانية',
    'Train and compare prediction models': 'تدريب نماذج التنبؤ ومقارنتها',
    'Explain insights and risks to stakeholders':
        'شرح الرؤى والمخاطر لأصحاب المصلحة',
    'Technology': 'تكنولوجيا',
    'Data': 'بيانات',
    'Problem solving': 'حل المشكلات',
    'Explore and clean a dataset': 'استكشاف مجموعة بيانات وتنظيفها',
    'A product team gives you a pandas DataFrame with customer activity. Before any model, you must detect missing values, outliers and useful descriptive patterns.': 'يعطيك فريق المنتج pandas DataFrame يحتوي على نشاط العملاء. قبل أي نموذج، يجب أن تكتشف القيم المفقودة والقيم الشاذة والأنماط الوصفية المفيدة.',
    'Beginner': 'مبتدئ',
    'Which actions are sensible first checks for missing data? (select 2)':
        'ما الإجراءات المناسبة كفحوصات أولى للبيانات المفقودة؟ (اختر 2)',
    'Run df.isna().sum() to count missing values':
        'تشغيل df.isna().sum() لعد القيم المفقودة',
    'Delete every numeric column immediately': 'حذف كل عمود رقمي فورًا',
    'Decide whether to impute or drop rows based on business meaning':
        'تقرير التعويض أو حذف الصفوف بناءً على المعنى التجاري',
    'Train a model before looking at the data':
        'تدريب نموذج قبل النظر إلى البيانات',
    'Counting missing values shows the scale of the issue, then domain meaning guides whether imputation or deletion is safe.': 'عد القيم المفقودة يوضح حجم المشكلة، ثم يوجه معنى المجال قرار التعويض أو الحذف بأمان.',
    'Data cleaning': 'تنظيف البيانات',
    'Which method is commonly used to flag numeric outliers?':
        'ما الطريقة الشائعة لتحديد القيم الشاذة الرقمية؟',
    'Alphabetical sorting': 'الفرز الأبجدي',
    'The interquartile range rule': 'قاعدة المدى الربيعي',
    'Changing all values to strings': 'تحويل كل القيم إلى نصوص',
    'Dropping the target column': 'حذف عمود الهدف',
    'The IQR rule flags values far below Q1 or above Q3 and is useful for skewed numeric data.': 'تحدد قاعدة IQR القيم البعيدة تحت Q1 أو فوق Q3، وهي مفيدة للبيانات الرقمية المنحرفة.',
    'Statistics': 'إحصاء',
    'You want to study the relationship between age and monthly spending. Best chart?':
        'تريد دراسة العلاقة بين العمر والإنفاق الشهري. ما أفضل رسم؟',
    'Pie chart': 'مخطط دائري',
    'Single-value KPI card': 'بطاقة KPI بقيمة واحدة',
    'Scatter plot': 'مخطط مبعثر',
    'File tree': 'شجرة ملفات',
    'A scatter plot shows how two numeric variables vary together and can reveal clusters or outliers.': 'يوضح المخطط المبعثر كيف يتغير متغيران رقميان معًا وقد يكشف تجمعات أو قيمًا شاذة.',
    'Visualization': 'تصوير البيانات',
    'What does df.describe() mainly provide?':
        'ماذا يوفر df.describe() بشكل أساسي؟',
    'Production monitoring alerts': 'تنبيهات مراقبة الإنتاج',
    'SQL indexes': 'فهارس SQL',
    'Model deployment scripts': 'سكربتات نشر النموذج',
    'Descriptive statistics such as mean, quartiles and standard deviation':
        'إحصاءات وصفية مثل المتوسط والربيعات والانحراف المعياري',
    'df.describe() summarizes numeric distributions, which helps you spot ranges, spread and unusual values.': 'يلخص df.describe() التوزيعات الرقمية، مما يساعدك على ملاحظة النطاقات والتشتت والقيم غير المعتادة.',
    'Train and evaluate a prediction model': 'تدريب نموذج تنبؤ وتقييمه',
    'You prepare a supervised learning experiment in scikit-learn. The team needs the right problem type, a fair train/test split and metrics that match the business question.': 'تجهز تجربة تعلم موجه في scikit-learn. يحتاج الفريق إلى نوع المشكلة الصحيح، وتقسيم train/test عادل، ومقاييس تناسب السؤال التجاري.',
    'Intermediate': 'متوسط',
    'Predicting whether a customer will churn next month is what type of task?':
        'التنبؤ بما إذا كان العميل سيغادر الشهر المقبل هو أي نوع من المهام؟',
    'Regression': 'انحدار',
    'Classification': 'تصنيف',
    'Clustering only': 'تجميع فقط',
    'Data visualization only': 'تصوير بيانات فقط',
    'Churn is a category such as yes or no, so it is a classification problem.':
        'المغادرة فئة مثل نعم أو لا، لذلك فهي مشكلة تصنيف.',
    'Machine learning': 'Machine learning',
    'Why split data into train and test sets?':
        'لماذا نقسم البيانات إلى مجموعتي train وtest؟',
    'To make the dataset smaller for no reason':
        'لتصغير مجموعة البيانات بلا سبب',
    'To remove all categorical variables': 'لإزالة كل المتغيرات الفئوية',
    'To estimate performance on data the model has not learned from':
        'لتقدير الأداء على بيانات لم يتعلم منها النموذج',
    'To guarantee perfect accuracy': 'لضمان دقة مثالية',
    'A held-out test set approximates future unseen data and gives a more honest performance estimate.': 'تمثل مجموعة اختبار محجوزة بيانات مستقبلية غير مرئية وتعطي تقدير أداء أكثر صدقًا.',
    'Evaluation': 'تقييم',
    'Which metrics are especially useful for a classification model when false positives and false negatives matter? (select 2)': 'ما المقاييس المفيدة خصوصًا لنموذج تصنيف عندما تهم الإيجابيات الكاذبة والسلبيات الكاذبة؟ (اختر 2)',
    'Precision': 'الدقة الإيجابية',
    'RMSE': 'RMSE',
    'Recall': 'الاسترجاع',
    'Number of columns in the CSV': 'عدد الأعمدة في ملف CSV',
    'Precision measures how many positive predictions are correct, while recall measures how many real positives are found.': 'تقيس Precision عدد التنبؤات الإيجابية الصحيحة، بينما يقيس Recall عدد الإيجابيات الحقيقية التي تم العثور عليها.',
    'Which symptom suggests overfitting?': 'أي عرض يشير إلى فرط التخصيص؟',
    'Similar train and test scores': 'درجات train وtest متشابهة',
    'Low train score and low test score': 'درجة train منخفضة ودرجة test منخفضة',
    'No model was trained': 'لم يتم تدريب أي نموذج',
    'Very high train score but much lower test score':
        'درجة train عالية جدًا لكن درجة test أقل بكثير',
    'Overfitting means the model learned training noise and generalizes poorly to the test set.': 'فرط التخصيص يعني أن النموذج تعلم ضجيج التدريب ويعمم بشكل ضعيف على مجموعة الاختبار.',
    'Imbalanced data, bias and deployment': 'بيانات غير متوازنة وتحيز ونشر',
    'Your model is ready for a pilot, but only a small share of examples are positive. You must evaluate imbalance, avoid leakage, check fairness and monitor the model once it runs in production.': 'نموذجك جاهز لتجربة أولية، لكن نسبة صغيرة فقط من الأمثلة إيجابية. يجب تقييم عدم التوازن، وتجنب تسرب البيانات، وفحص العدالة، ومراقبة النموذج عند تشغيله في الإنتاج.',
    'Advanced': 'متقدم',
    'For an imbalanced classification problem, which metrics are often more informative than accuracy? (select 2)': 'في مشكلة تصنيف غير متوازنة، ما المقاييس التي تكون غالبًا أكثر إفادة من accuracy؟ (اختر 2)',
    'Mean absolute error': 'متوسط الخطأ المطلق',
    'F1-score': 'درجة F1',
    'ROC-AUC': 'ROC-AUC',
    'Dataset file size': 'حجم ملف مجموعة البيانات',
    'F1 balances precision and recall, and ROC-AUC evaluates ranking ability across thresholds.': 'توازن F1 بين Precision وRecall، وتقيم ROC-AUC قدرة الترتيب عبر عتبات متعددة.',
    'Which workflow creates data leakage?': 'أي سير عمل يسبب تسرب البيانات؟',
    'Fit a scaler on the full dataset before the train/test split':
        'ملاءمة scaler على مجموعة البيانات كاملة قبل تقسيم train/test',
    'Fit preprocessing only on the training set':
        'ملاءمة المعالجة المسبقة على مجموعة التدريب فقط',
    'Use cross-validation inside the training data':
        'استخدام cross-validation داخل بيانات التدريب',
    'Keep the test set untouched until final evaluation':
        'إبقاء مجموعة الاختبار دون لمس حتى التقييم النهائي',
    'Preprocessing learned from the full dataset lets information from the test set influence training.': 'المعالجة المسبقة المتعلمة من كامل البيانات تسمح لمعلومات من مجموعة الاختبار بالتأثير على التدريب.',
    'How can you start checking fairness across user groups?':
        'كيف تبدأ فحص العدالة بين مجموعات المستخدمين؟',
    'Hide every metric from the product team':
        'إخفاء كل المقاييس عن فريق المنتج',
    'Use only the global average score': 'استخدام المتوسط العام فقط',
    'Remove documentation': 'إزالة التوثيق',
    'Compare error rates and recall by group':
        'مقارنة معدلات الخطأ والاسترجاع حسب المجموعة',
    'Group-level metrics can reveal whether the model performs worse for a protected or important segment.': 'يمكن لمقاييس مستوى المجموعة أن تكشف ما إذا كان أداء النموذج أسوأ لشريحة محمية أو مهمة.',
    'Ethics': 'أخلاقيات',
    'After deployment, what should model monitoring include?':
        'بعد النشر، ماذا يجب أن تتضمن مراقبة النموذج؟',
    'Ignore inputs once the model is online':
        'تجاهل المدخلات بمجرد أن يصبح النموذج متصلًا',
    'Retrain every minute without review': 'إعادة التدريب كل دقيقة دون مراجعة',
    'Track prediction quality and feature drift over time':
        'تتبع جودة التنبؤ وانحراف الخصائص بمرور الوقت',
    'Delete historical predictions immediately': 'حذف التنبؤات التاريخية فورًا',
    'Monitoring detects drift in input distributions and performance changes before users are harmed.': 'تكشف المراقبة انحراف توزيعات المدخلات وتغيرات الأداء قبل أن يتضرر المستخدمون.',
    'MLOps': 'MLOps',
  },
  coursesEn: <String, Course>{
    'data-1': Course(
      labId: 'data-1',
      intro: 'Exploratory data analysis is the safety check before modeling. You learn what each column means, how much data is missing and whether values look plausible.',
      sections: [
        CourseSection(
          title: 'Inspect the DataFrame',
          body: 'Start by looking at the shape, column names and data types of the pandas DataFrame. Use head() to see realistic rows, info() to find nullable columns and isna().sum() to count missing values. Missing data is not always an error: a missing cancellation date may mean the customer is still active. Choose imputation, deletion or a separate category only after understanding the business meaning.',
          points: [
            'Use shape, head(), info() and isna().sum() before changing data.',
            'Treat missing values according to meaning, not automatically.',
            'Document cleaning choices so results can be reproduced.',
          ],
        ),
        CourseSection(
          title: 'Summaries and outliers',
          body: 'Descriptive statistics summarize distributions with mean, median, quartiles and standard deviation. df.describe() gives a quick numeric overview, but you still need to interpret it. Outliers can be real VIP customers, entry errors or rare events. The interquartile range rule is a robust first method: values far below Q1 or above Q3 deserve inspection.',
          points: [
            'Mean and standard deviation describe center and spread.',
            'Quartiles and IQR are useful when data is skewed.',
            'Do not delete outliers before checking what they represent.',
          ],
        ),
        CourseSection(
          title: 'Choose the right visualisation',
          body: 'Charts turn distributions and relationships into patterns humans can see. A histogram shows the shape of one numeric variable, such as age or order value. A scatter plot compares two numeric variables and can reveal correlation, clusters or outliers. A bar chart compares counts or averages across categories, such as plan type or region.',
          points: [
            'Histogram: one numeric distribution.',
            'Scatter plot: relationship between two numeric variables.',
            'Bar chart: compare categories clearly.',
          ],
        ),
      ],
      takeaways: [
        'Explore before cleaning so you do not destroy useful signal.',
        'Use descriptive statistics and IQR to understand numeric columns.',
        'Match the chart type to the question and variable types.',
      ],
    ),
    'data-2': Course(
      labId: 'data-2',
      intro: 'Supervised learning uses examples with known answers to predict future answers. A good experiment defines the task, keeps evaluation honest and chooses metrics that match risk.',
      sections: [
        CourseSection(
          title: 'Regression or classification',
          body: 'The target variable decides the supervised learning family. If the target is a number, such as monthly revenue or delivery time, the task is regression. If the target is a class, such as churn yes/no or fraud/not fraud, the task is classification. scikit-learn offers estimators for both families, but the interpretation and metrics are different.',
          points: [
            'Numeric target means regression.',
            'Categorical target means classification.',
            'Choose the model family before choosing metrics.',
          ],
        ),
        CourseSection(
          title: 'Train/test split and overfitting',
          body: 'A model can memorize training examples instead of learning a reusable pattern. A train/test split keeps part of the data unseen until evaluation, giving a more honest estimate of future performance. Overfitting appears when training performance is excellent but test performance is much worse. Cross-validation can make the training estimate more stable when data is limited.',
          points: [
            'Never evaluate only on the data used for fitting.',
            'A large train-test gap is a warning sign of overfitting.',
            'Cross-validation repeats validation across several folds.',
          ],
        ),
        CourseSection(
          title: 'Pick useful metrics',
          body: 'Accuracy is simple for balanced classification, but it can hide costly errors. Precision answers: among predicted positives, how many were correct. Recall answers: among real positives, how many did we find. RMSE is for regression and penalizes large numeric prediction errors more strongly.',
          points: [
            'Precision controls false positives.',
            'Recall controls false negatives.',
            'RMSE evaluates numeric prediction error for regression.',
          ],
        ),
      ],
      takeaways: [
        'The target type determines regression or classification.',
        'A held-out test set protects against overly optimistic results.',
        'Metrics must match the business cost of mistakes.',
      ],
    ),
    'data-3': Course(
      labId: 'data-3',
      intro: 'Advanced data science is not only model accuracy. Real systems face rare events, biased data, leakage risks and changing production conditions.',
      sections: [
        CourseSection(
          title: 'Imbalance and robust validation',
          body: 'In imbalanced classification, a model can look accurate while ignoring the rare class. F1-score combines precision and recall, which makes it useful when both missed positives and false alarms matter. ROC-AUC evaluates whether the model ranks positives above negatives across thresholds. Cross-validation helps check whether the result is stable across different slices of the training data.',
          points: [
            'Accuracy can be misleading when one class dominates.',
            'F1 and ROC-AUC reveal more about rare-class behavior.',
            'Cross-validation estimates stability across folds.',
          ],
        ),
        CourseSection(
          title: 'Leakage and fairness',
          body: 'Data leakage happens when training uses information that would not be available at prediction time. Fitting preprocessing on the full dataset before splitting is a common leakage pattern because the test set influences the scaler. Fairness checks ask whether errors are concentrated on specific user groups. Comparing recall, false positive rates and false negative rates by group is a practical starting point.',
          points: [
            'Fit preprocessing only on the training data.',
            'Keep the final test set untouched until the end.',
            'Measure errors by group, not only globally.',
          ],
        ),
        CourseSection(
          title: 'Deployment monitoring and drift',
          body: 'A deployed model lives in an environment that changes. Feature drift means input distributions move away from training data, for example a new customer segment or seasonal behavior. Concept drift means the relationship between inputs and the target changes. Monitoring tracks data quality, feature distributions, prediction volumes and real-world performance when labels arrive.',
          points: [
            'Monitor inputs, predictions and delayed ground truth.',
            'Drift can reduce quality even if the code did not change.',
            'Alerts and review gates are part of responsible MLOps.',
          ],
        ),
      ],
      takeaways: [
        'Imbalanced data needs metrics beyond plain accuracy.',
        'Leakage and bias checks protect trust before launch.',
        'Production monitoring detects drift and performance decay.',
      ],
    ),
  },
  coursesFr: <String, Course>{
    'data-1': Course(
      labId: 'data-1',
      intro: 'L’analyse exploratoire est le contrôle de sécurité avant la modélisation. Tu apprends ce que signifie chaque colonne, combien de données manquent et si les valeurs semblent plausibles.',
      sections: [
        CourseSection(
          title: 'Inspecter le DataFrame',
          body: 'Commence par regarder la forme, les noms de colonnes et les types du DataFrame pandas. Utilise head() pour voir des lignes réalistes, info() pour trouver les colonnes nullables et isna().sum() pour compter les valeurs manquantes. Une donnée manquante n’est pas toujours une erreur : une date de résiliation vide peut signifier que le client est encore actif. Choisis l’imputation, la suppression ou une catégorie séparée seulement après avoir compris le sens métier.',
          points: [
            'Utilise shape, head(), info() et isna().sum() avant de modifier les données.',
            'Traite les valeurs manquantes selon leur sens, pas automatiquement.',
            'Documente les choix de nettoyage pour reproduire les résultats.',
          ],
        ),
        CourseSection(
          title: 'Résumés et valeurs aberrantes',
          body: 'Les statistiques descriptives résument les distributions avec la moyenne, la médiane, les quartiles et l’écart type. df.describe() donne un aperçu numérique rapide, mais tu dois encore l’interpréter. Les valeurs aberrantes peuvent être de vrais clients VIP, des erreurs de saisie ou des événements rares. La règle de l’écart interquartile est une première méthode robuste : les valeurs très sous Q1 ou au-dessus de Q3 méritent une inspection.',
          points: [
            'La moyenne et l’écart type décrivent le centre et la dispersion.',
            'Les quartiles et l’IQR sont utiles quand les données sont asymétriques.',
            'Ne supprime pas les valeurs aberrantes avant de vérifier ce qu’elles représentent.',
          ],
        ),
        CourseSection(
          title: 'Choisir la bonne visualisation',
          body: 'Les graphiques transforment les distributions et les relations en motifs visibles. Un histogramme montre la forme d’une variable numérique, comme l’âge ou le montant de commande. Un nuage de points compare deux variables numériques et peut révéler une corrélation, des groupes ou des valeurs aberrantes. Un diagramme en barres compare des comptes ou des moyennes entre catégories, comme le type d’offre ou la région.',
          points: [
            'Histogramme : une distribution numérique.',
            'Nuage de points : relation entre deux variables numériques.',
            'Diagramme en barres : comparer clairement des catégories.',
          ],
        ),
      ],
      takeaways: [
        'Explore avant de nettoyer pour ne pas détruire un signal utile.',
        'Utilise statistiques descriptives et IQR pour comprendre les colonnes numériques.',
        'Associe le type de graphique à la question et aux types de variables.',
      ],
    ),
    'data-2': Course(
      labId: 'data-2',
      intro: 'L’apprentissage supervisé utilise des exemples avec réponses connues pour prédire de futures réponses. Une bonne expérience définit la tâche, garde une évaluation honnête et choisit des métriques adaptées au risque.',
      sections: [
        CourseSection(
          title: 'Régression ou classification',
          body: 'La variable cible décide de la famille d’apprentissage supervisé. Si la cible est un nombre, comme le revenu mensuel ou le délai de livraison, la tâche est une régression. Si la cible est une classe, comme churn oui/non ou fraude/non fraude, la tâche est une classification. scikit-learn propose des estimateurs pour les deux familles, mais l’interprétation et les métriques diffèrent.',
          points: [
            'Une cible numérique signifie régression.',
            'Une cible catégorielle signifie classification.',
            'Choisis la famille de modèle avant de choisir les métriques.',
          ],
        ),
        CourseSection(
          title: 'Découpage train/test et surapprentissage',
          body: 'Un modèle peut mémoriser les exemples d’entraînement au lieu d’apprendre un motif réutilisable. Un découpage train/test garde une partie des données inconnue jusqu’à l’évaluation, ce qui donne une estimation plus honnête de la performance future. Le surapprentissage apparaît quand la performance d’entraînement est excellente mais que la performance de test est bien plus faible. La validation croisée peut stabiliser l’estimation d’entraînement quand les données sont limitées.',
          points: [
            'N’évalue jamais seulement sur les données utilisées pour l’ajustement.',
            'Un grand écart train-test signale un risque de surapprentissage.',
            'La validation croisée répète la validation sur plusieurs folds.',
          ],
        ),
        CourseSection(
          title: 'Choisir des métriques utiles',
          body: 'L’accuracy est simple pour une classification équilibrée, mais elle peut cacher des erreurs coûteuses. La précision répond : parmi les positifs prédits, combien étaient corrects. Le rappel répond : parmi les vrais positifs, combien avons-nous retrouvés. RMSE sert à la régression et pénalise plus fortement les grandes erreurs numériques de prédiction.',
          points: [
            'La précision contrôle les faux positifs.',
            'Le rappel contrôle les faux négatifs.',
            'RMSE évalue l’erreur de prédiction numérique en régression.',
          ],
        ),
      ],
      takeaways: [
        'Le type de cible détermine régression ou classification.',
        'Un jeu de test mis de côté protège des résultats trop optimistes.',
        'Les métriques doivent correspondre au coût métier des erreurs.',
      ],
    ),
    'data-3': Course(
      labId: 'data-3',
      intro: 'La data science avancée ne se limite pas à l’accuracy du modèle. Les vrais systèmes rencontrent événements rares, données biaisées, risques de fuite et conditions de production changeantes.',
      sections: [
        CourseSection(
          title: 'Déséquilibre et validation robuste',
          body: 'En classification déséquilibrée, un modèle peut sembler exact tout en ignorant la classe rare. Le score F1 combine précision et rappel, ce qui le rend utile quand les positifs manqués et les fausses alertes comptent. ROC-AUC évalue si le modèle classe les positifs au-dessus des négatifs à travers plusieurs seuils. La validation croisée aide à vérifier si le résultat reste stable sur différentes tranches des données d’entraînement.',
          points: [
            'L’accuracy peut tromper quand une classe domine.',
            'F1 et ROC-AUC révèlent mieux le comportement de la classe rare.',
            'La validation croisée estime la stabilité entre folds.',
          ],
        ),
        CourseSection(
          title: 'Fuite et équité',
          body: 'La fuite de données arrive quand l’entraînement utilise une information indisponible au moment de la prédiction. Ajuster le prétraitement sur tout le jeu de données avant le découpage est un cas courant, car le test influence le scaler. Les contrôles d’équité demandent si les erreurs se concentrent sur certains groupes d’utilisateurs. Comparer rappel, taux de faux positifs et taux de faux négatifs par groupe est un bon point de départ.',
          points: [
            'Ajuste le prétraitement seulement sur les données d’entraînement.',
            'Garde le jeu de test final intact jusqu’à la fin.',
            'Mesure les erreurs par groupe, pas seulement globalement.',
          ],
        ),
        CourseSection(
          title: 'Monitoring de déploiement et dérive',
          body: 'Un modèle déployé vit dans un environnement qui change. La dérive des variables signifie que les distributions d’entrée s’éloignent des données d’entraînement, par exemple avec un nouveau segment client ou un comportement saisonnier. La dérive de concept signifie que la relation entre entrées et cible change. Le monitoring suit la qualité des données, les distributions de variables, les volumes de prédiction et la performance réelle quand les labels arrivent.',
          points: [
            'Surveille entrées, prédictions et vérité terrain retardée.',
            'La dérive peut réduire la qualité même si le code ne change pas.',
            'Alertes et revues font partie d’un MLOps responsable.',
          ],
        ),
      ],
      takeaways: [
        'Les données déséquilibrées exigent plus que l’accuracy simple.',
        'Les contrôles de fuite et de biais protègent la confiance avant lancement.',
        'Le monitoring de production détecte dérive et baisse de performance.',
      ],
    ),
  },
  coursesAr: <String, Course>{
    'data-1': Course(
      labId: 'data-1',
      intro: 'تحليل البيانات الاستكشافي هو فحص الأمان قبل بناء النماذج. تتعلم معنى كل عمود، وكمية البيانات المفقودة، وهل تبدو القيم منطقية.',
      sections: [
        CourseSection(
          title: 'فحص DataFrame',
          body: 'ابدأ بالنظر إلى الشكل وأسماء الأعمدة وأنواع البيانات في pandas DataFrame. استخدم head() لرؤية صفوف واقعية، وinfo() لاكتشاف الأعمدة التي تقبل القيم الفارغة، وisna().sum() لعد القيم المفقودة. البيانات المفقودة ليست دائمًا خطأ: تاريخ إلغاء مفقود قد يعني أن العميل ما زال نشطًا. اختر التعويض أو الحذف أو فئة مستقلة فقط بعد فهم المعنى التجاري.',
          points: [
            'استخدم shape وhead() وinfo() وisna().sum() قبل تغيير البيانات.',
            'عالج القيم المفقودة حسب معناها وليس تلقائيًا.',
            'وثق قرارات التنظيف كي يمكن إعادة إنتاج النتائج.',
          ],
        ),
        CourseSection(
          title: 'الملخصات والقيم الشاذة',
          body: 'تلخص الإحصاءات الوصفية التوزيعات باستخدام المتوسط والوسيط والربيعات والانحراف المعياري. يعطي df.describe() نظرة رقمية سريعة، لكنك ما زلت بحاجة إلى تفسيرها. قد تكون القيم الشاذة عملاء مهمين حقيقيين أو أخطاء إدخال أو أحداثًا نادرة. قاعدة المدى الربيعي طريقة أولى قوية: القيم البعيدة جدًا تحت Q1 أو فوق Q3 تستحق الفحص.',
          points: [
            'المتوسط والانحراف المعياري يصفان المركز والتشتت.',
            'الربيعات وIQR مفيدة عندما تكون البيانات منحرفة.',
            'لا تحذف القيم الشاذة قبل التحقق مما تمثله.',
          ],
        ),
        CourseSection(
          title: 'اختيار التصور المناسب',
          body: 'تحول الرسوم البيانية التوزيعات والعلاقات إلى أنماط يمكن للبشر رؤيتها. يوضح histogram شكل متغير رقمي واحد مثل العمر أو قيمة الطلب. يقارن scatter plot بين متغيرين رقميين ويمكن أن يكشف ارتباطًا أو تجمعات أو قيمًا شاذة. يقارن bar chart الأعداد أو المتوسطات بين الفئات مثل نوع الخطة أو المنطقة.',
          points: [
            'Histogram: توزيع رقمي واحد.',
            'Scatter plot: علاقة بين متغيرين رقميين.',
            'Bar chart: مقارنة الفئات بوضوح.',
          ],
        ),
      ],
      takeaways: [
        'استكشف قبل التنظيف حتى لا تدمر إشارة مفيدة.',
        'استخدم الإحصاءات الوصفية وIQR لفهم الأعمدة الرقمية.',
        'طابق نوع الرسم مع السؤال وأنواع المتغيرات.',
      ],
    ),
    'data-2': Course(
      labId: 'data-2',
      intro: 'يستخدم التعلم الموجه أمثلة ذات إجابات معروفة للتنبؤ بإجابات مستقبلية. التجربة الجيدة تحدد المهمة، وتحافظ على تقييم عادل، وتختار مقاييس تناسب المخاطر.',
      sections: [
        CourseSection(
          title: 'انحدار أم تصنيف',
          body: 'يحدد المتغير الهدف عائلة التعلم الموجه. إذا كان الهدف رقمًا مثل الإيراد الشهري أو زمن التسليم، فالمهمة هي regression. إذا كان الهدف فئة مثل churn نعم/لا أو fraud/not fraud، فالمهمة هي classification. يوفر scikit-learn مقدرات للعائلتين، لكن التفسير والمقاييس تختلف.',
          points: [
            'الهدف الرقمي يعني regression.',
            'الهدف الفئوي يعني classification.',
            'اختر عائلة النموذج قبل اختيار المقاييس.',
          ],
        ),
        CourseSection(
          title: 'تقسيم train/test وفرط التخصيص',
          body: 'يمكن للنموذج أن يحفظ أمثلة التدريب بدل تعلم نمط قابل لإعادة الاستخدام. يحفظ تقسيم train/test جزءًا من البيانات غير مرئي حتى التقييم، مما يعطي تقديرًا أصدق للأداء المستقبلي. يظهر overfitting عندما يكون أداء التدريب ممتازًا لكن أداء الاختبار أضعف بكثير. يمكن أن تجعل cross-validation تقدير التدريب أكثر استقرارًا عندما تكون البيانات محدودة.',
          points: [
            'لا تقيم أبدًا على البيانات المستخدمة في fitting فقط.',
            'فجوة كبيرة بين train وtest تحذر من overfitting.',
            'تكرر cross-validation التحقق عبر عدة folds.',
          ],
        ),
        CourseSection(
          title: 'اختيار مقاييس مفيدة',
          body: 'Accuracy بسيطة للتصنيف المتوازن، لكنها قد تخفي أخطاء مكلفة. تجيب Precision: من بين الإيجابيات المتنبأ بها، كم كان صحيحًا. يجيب Recall: من بين الإيجابيات الحقيقية، كم وجدنا. RMSE مخصص للانحدار ويعاقب أخطاء التنبؤ الرقمية الكبيرة بقوة أكبر.',
          points: [
            'Precision تتحكم في الإيجابيات الكاذبة.',
            'Recall يتحكم في السلبيات الكاذبة.',
            'RMSE يقيم خطأ التنبؤ الرقمي في regression.',
          ],
        ),
      ],
      takeaways: [
        'نوع الهدف يحدد regression أو classification.',
        'مجموعة اختبار محجوزة تحمي من النتائج المتفائلة جدًا.',
        'يجب أن تطابق المقاييس تكلفة الأخطاء التجارية.',
      ],
    ),
    'data-3': Course(
      labId: 'data-3',
      intro: 'علم البيانات المتقدم لا يقتصر على accuracy النموذج. الأنظمة الحقيقية تواجه أحداثًا نادرة وبيانات منحازة ومخاطر تسرب وظروف إنتاج متغيرة.',
      sections: [
        CourseSection(
          title: 'عدم التوازن والتحقق القوي',
          body: 'في التصنيف غير المتوازن، قد يبدو النموذج دقيقًا وهو يتجاهل الفئة النادرة. تجمع F1-score بين precision وrecall، لذلك تفيد عندما تهم الإيجابيات المفقودة والإنذارات الكاذبة. تقيم ROC-AUC ما إذا كان النموذج يرتب الإيجابيات فوق السلبيات عبر عتبات مختلفة. تساعد cross-validation في التحقق من ثبات النتيجة عبر شرائح مختلفة من بيانات التدريب.',
          points: [
            'قد تكون accuracy مضللة عندما تهيمن فئة واحدة.',
            'تكشف F1 وROC-AUC أكثر عن سلوك الفئة النادرة.',
            'تقدر cross-validation الثبات عبر folds.',
          ],
        ),
        CourseSection(
          title: 'التسرب والعدالة',
          body: 'يحدث تسرب البيانات عندما يستخدم التدريب معلومات لن تكون متاحة وقت التنبؤ. ملاءمة المعالجة المسبقة على كامل مجموعة البيانات قبل التقسيم نمط شائع من التسرب لأن مجموعة الاختبار تؤثر في scaler. تسأل فحوصات العدالة هل تتركز الأخطاء على مجموعات مستخدمين محددة. مقارنة recall ومعدلات الإيجابيات الكاذبة والسلبيات الكاذبة حسب المجموعة بداية عملية.',
          points: [
            'لائم المعالجة المسبقة على بيانات التدريب فقط.',
            'اترك مجموعة الاختبار النهائية دون لمس حتى النهاية.',
            'قس الأخطاء حسب المجموعة وليس عالميًا فقط.',
          ],
        ),
        CourseSection(
          title: 'مراقبة النشر والانحراف',
          body: 'يعيش النموذج المنشور في بيئة تتغير. يعني feature drift أن توزيعات المدخلات تبتعد عن بيانات التدريب، مثل شريحة عملاء جديدة أو سلوك موسمي. يعني concept drift أن العلاقة بين المدخلات والهدف تغيرت. تراقب المنظومة جودة البيانات وتوزيعات الخصائص وأحجام التنبؤ والأداء الواقعي عندما تصل التسميات.',
          points: [
            'راقب المدخلات والتنبؤات والحقيقة المتأخرة.',
            'قد يقلل الانحراف الجودة حتى لو لم يتغير الكود.',
            'التنبيهات وبوابات المراجعة جزء من MLOps مسؤول.',
          ],
        ),
      ],
      takeaways: [
        'البيانات غير المتوازنة تحتاج مقاييس تتجاوز accuracy.',
        'فحوصات التسرب والتحيز تحمي الثقة قبل الإطلاق.',
        'مراقبة الإنتاج تكشف الانحراف وتراجع الأداء.',
      ],
    ),
  },
  courseExamples: <String, List<String?>>{
    'data-1': [
      "import pandas as pd\n"
          "df = pd.read_csv('customers.csv')\n"
          "print(df.shape)\n"
          "print(df.info())\n"
          "print(df.isna().sum())",
      "q1 = df['spend'].quantile(0.25)\n"
          "q3 = df['spend'].quantile(0.75)\n"
          "iqr = q3 - q1\n"
          "outliers = df[(df['spend'] < q1 - 1.5 * iqr) | (df['spend'] > q3 + 1.5 * iqr)]\n"
          "print(outliers[['customer_id', 'spend']].head())",
      "import matplotlib.pyplot as plt\n"
          "df.plot.scatter(x='age', y='monthly_spend')\n"
          "plt.title('Age vs monthly spend')\n"
          "plt.show()",
    ],
    'data-2': [
      "from sklearn.model_selection import train_test_split\n"
          "X = df[['visits', 'tickets', 'monthly_spend']]\n"
          "y = df['churned']\n"
          "X_train, X_test, y_train, y_test = train_test_split(\n"
          "    X, y, test_size=0.2, random_state=42, stratify=y)",
      "from sklearn.ensemble import RandomForestClassifier\n"
          "model = RandomForestClassifier(random_state=42)\n"
          "model.fit(X_train, y_train)\n"
          "print(model.score(X_train, y_train))\n"
          "print(model.score(X_test, y_test))",
      "from sklearn.metrics import precision_score, recall_score, mean_squared_error\n"
          "pred = model.predict(X_test)\n"
          "print(precision_score(y_test, pred))\n"
          "print(recall_score(y_test, pred))\n"
          "print(mean_squared_error(y_test, pred, squared=False))",
    ],
    'data-3': [
      "from sklearn.metrics import f1_score, roc_auc_score\n"
          "proba = model.predict_proba(X_test)[:, 1]\n"
          "pred = proba >= 0.4\n"
          "print(f1_score(y_test, pred))\n"
          "print(roc_auc_score(y_test, proba))",
      "from sklearn.pipeline import Pipeline\n"
          "from sklearn.preprocessing import StandardScaler\n"
          "pipe = Pipeline([\n"
          "    ('scale', StandardScaler()),\n"
          "    ('model', LogisticRegression(max_iter=1000)),\n"
          "])\n"
          "pipe.fit(X_train, y_train)",
      "current = live_features['age'].mean()\n"
          "training = X_train['age'].mean()\n"
          "drift = abs(current - training)\n"
          "if drift > 5:\n"
          "    alert('age distribution drift')",
    ],
  },
);
