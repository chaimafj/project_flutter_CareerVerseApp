import '../models/course.dart';

// French version of the courses (same structure as `coursesEn`).
const coursesFr = <String, Course>{
  // ------------------------------------------------------------- Cloud
  'cloud-1': Course(
    labId: 'cloud-1',
    intro:
        "Avant de déployer un vrai site web sur AWS, il faut connaître les "
        "briques de base : du calcul qui suit le trafic, un stockage pour les "
        "fichiers, une base de données qui survit aux pannes et un CDN qui "
        "rapproche le contenu des utilisateurs.",
    sections: [
      CourseSection(
        title: "Calcul élastique : EC2, Auto Scaling et répartition de charge",
        body:
            "Une instance EC2 est un serveur virtuel. Un seul serveur est un "
            "point de défaillance unique et ne peut pas absorber les pics de "
            "trafic. Un groupe Auto Scaling maintient une flotte d’instances "
            "identiques et en ajoute ou en retire selon une métrique comme "
            "l’utilisation CPU. Un Application Load Balancer (ALB) reçoit "
            "chaque requête et la répartit entre les instances saines du "
            "groupe.",
        points: [
          "Auto Scaling = le bon nombre de serveurs à tout moment.",
          "Le load balancer n’envoie le trafic qu’aux instances saines.",
          "Répartissez les instances sur plusieurs zones de disponibilité (AZ).",
        ],
      ),
      CourseSection(
        title: "Stocker les fichiers et les données",
        body:
            "Les fichiers statiques (images, CSS, vidéos) vont dans Amazon S3, "
            "un stockage objet très durable et peu coûteux. Les données "
            "structurées vont dans une base managée comme Amazon RDS. Avec "
            "l’option Multi-AZ, RDS garde une copie synchrone dans une autre "
            "zone de disponibilité et bascule automatiquement si la principale "
            "tombe en panne.",
        points: [
          "S3 pour les objets et fichiers statiques, jamais le disque du serveur web.",
          "RDS Multi-AZ = bascule automatique vers une base de secours.",
          "Les sauvegardes protègent des erreurs, le Multi-AZ des pannes.",
        ],
      ),
      CourseSection(
        title: "Passer à l’échelle mondiale avec un CDN",
        body:
            "Amazon CloudFront est un réseau de diffusion de contenu (CDN) : "
            "il met votre contenu en cache dans des centaines de points de "
            "présence dans le monde. Un utilisateur à Tunis ou à Paris est "
            "servi par le point le plus proche, ce qui réduit la latence et "
            "soulage vos serveurs.",
        points: [
          "CloudFront met le contenu en cache près des utilisateurs.",
          "Il peut servir les fichiers S3 comme votre load balancer.",
          "Moins de latence pour les utilisateurs, moins de charge pour vos serveurs.",
        ],
      ),
    ],
    takeaways: [
      "ALB + groupe Auto Scaling sur plusieurs AZ pour la couche web.",
      "S3 pour les fichiers statiques, RDS Multi-AZ pour la base de données.",
      "CloudFront devant le tout pour réduire la latence.",
    ],
  ),
  'cloud-2': Course(
    labId: 'cloud-2',
    intro:
        "IAM (Identity and Access Management) décide qui peut faire quoi sur "
        "un compte AWS. La plupart des incidents de sécurité cloud viennent de "
        "clés divulguées ou de permissions trop larges : IAM est donc la "
        "première compétence d’un ingénieur cloud.",
    sections: [
      CourseSection(
        title: "Utilisateurs, groupes, rôles et politiques",
        body:
            "Une politique est un document JSON qui autorise ou refuse des "
            "actions sur des ressources. Les utilisateurs représentent des "
            "personnes, les groupes partagent des politiques entre "
            "utilisateurs, et les rôles sont des identités que les services ou "
            "applications endossent pour obtenir des identifiants temporaires. "
            "Une instance EC2 avec un rôle n’a jamais besoin de clés stockées.",
        points: [
          "Personnes → utilisateurs dans des groupes, applications → rôles.",
          "Les rôles fournissent automatiquement des identifiants temporaires.",
          "Ne mettez jamais de clés d’accès dans le code source.",
        ],
      ),
      CourseSection(
        title: "Le principe du moindre privilège",
        body:
            "Chaque identité ne doit recevoir que les permissions dont elle a "
            "besoin, sur les ressources dont elle a besoin, et rien de plus. Si "
            "une clé fuit, les dégâts restent limités. Commencez par une "
            "politique restreinte et élargissez-la seulement quand un vrai "
            "besoin apparaît.",
        points: [
          "Autorisez des actions précises sur des ressources précises.",
          "Évitez les actions et ressources \"*\" en production.",
          "Révisez et supprimez régulièrement les permissions inutilisées.",
        ],
      ),
      CourseSection(
        title: "Protéger le compte et auditer",
        body:
            "Le compte root peut tout faire, y compris fermer le compte : "
            "protégez-le avec le MFA et ne l’utilisez pas au quotidien. AWS "
            "CloudTrail enregistre chaque appel d’API (qui, quoi, quand, "
            "d’où), ce qui est essentiel pour les audits et les enquêtes.",
        points: [
          "Activez le MFA sur root et sur chaque utilisateur humain.",
          "N’utilisez root que pour de rares tâches de gestion du compte.",
          "CloudTrail = historique de chaque appel d’API.",
        ],
      ),
    ],
    takeaways: [
      "Les applications utilisent des rôles IAM, pas des clés stockées.",
      "Le moindre privilège limite l’impact d’une fuite.",
      "MFA sur root, et CloudTrail pour tout auditer.",
    ],
  ),
  'cloud-3': Course(
    labId: 'cloud-3',
    intro:
        "Une bonne architecture cloud est fiable et abordable. Les ingénieurs "
        "cloud choisissent le bon modèle de tarification pour chaque charge "
        "de travail et surveillent les coûts en continu, comme n’importe "
        "quelle autre métrique.",
    sections: [
      CourseSection(
        title: "Les modèles de tarification du calcul",
        body:
            "Les instances On-Demand sont flexibles mais les plus chères. Les "
            "instances Spot utilisent la capacité inutilisée d’AWS avec jusqu’à "
            "90 % de réduction, mais peuvent être interrompues avec un préavis "
            "de 2 minutes : parfait pour des traitements batch capables de "
            "redémarrer. Les Savings Plans et Reserved Instances offrent de "
            "fortes réductions contre un engagement de 1 ou 3 ans, idéal pour "
            "une production qui tourne 24 h/24.",
        points: [
          "Traitements batch interruptibles → instances Spot.",
          "Charges stables 24 h/24 → Savings Plans ou Reserved Instances.",
          "Besoins courts ou imprévisibles → On-Demand.",
        ],
      ),
      CourseSection(
        title: "Classes de stockage et règles de cycle de vie",
        body:
            "S3 propose plusieurs classes de stockage. S3 Standard pour les "
            "données lues souvent, S3 Standard-IA pour les accès peu fréquents, "
            "et S3 Glacier pour les archives rarement lues mais à conserver "
            "des années. Les règles de cycle de vie déplacent automatiquement "
            "les objets entre les classes à mesure qu’ils vieillissent.",
        points: [
          "Plus la donnée est froide, moins la classe de stockage coûte.",
          "Glacier est conçu pour l’archivage à long terme.",
          "Les règles de cycle de vie automatisent les transitions.",
        ],
      ),
      CourseSection(
        title: "Surveiller les coûts",
        body:
            "AWS Budgets envoie des alertes quand les dépenses dépassent un "
            "seuil. Cost Explorer montre où va l’argent, et Cost Anomaly "
            "Detection utilise l’apprentissage automatique pour repérer les "
            "dépenses inhabituelles. Étiqueter les ressources par projet ou "
            "par équipe rend ces rapports utiles.",
        points: [
          "Définissez un budget avec alertes sur chaque compte.",
          "Consultez Cost Explorer et Anomaly Detection chaque semaine.",
          "Étiquetez les ressources pour savoir qui dépense quoi.",
        ],
      ),
    ],
    takeaways: [
      "Spot pour les traitements interruptibles, Savings Plans pour la production 24 h/24.",
      "Les règles de cycle de vie S3 déplacent les vieilles données vers Glacier.",
      "Budgets et Cost Anomaly Detection détectent tôt les surprises.",
    ],
  ),

  // ------------------------------------------------------------ DevOps
  'devops-1': Course(
    labId: 'devops-1',
    intro:
        "L’intégration continue (CI) vérifie automatiquement chaque "
        "modification : le code est compilé et testé dès qu’il est poussé. "
        "Les bugs sont trouvés en quelques minutes au lieu de plusieurs "
        "semaines, et l’équipe peut livrer souvent et en toute sécurité.",
    sections: [
      CourseSection(
        title: "Ce que fait un pipeline CI",
        body:
            "Un pipeline est une liste d’étapes automatisées déclenchées à "
            "chaque push et à chaque pull request : installer les dépendances, "
            "lancer le linter, exécuter les tests unitaires, puis construire "
            "un artefact. Si une étape échoue, la modification est bloquée "
            "avant d’atteindre la branche principale.",
        points: [
          "Exécuté à chaque push et à chaque pull request.",
          "Étapes typiques : lint, tests, build.",
          "Un pipeline rouge bloque la fusion.",
        ],
      ),
      CourseSection(
        title: "Empaqueter avec Docker",
        body:
            "Un Dockerfile décrit comment construire une image de conteneur : "
            "l’image de base, les fichiers à copier, les commandes à exécuter "
            "et la commande qui démarre l’application. L’image s’exécute de la "
            "même façon sur un portable, en CI et en production.",
        points: [
          "Dockerfile = la recette de l’image.",
          "Une seule image, identique dans tous les environnements.",
          "Utilisez des images de base officielles et légères.",
        ],
      ),
      CourseSection(
        title: "Les secrets dans les pipelines",
        body:
            "Les pipelines ont souvent besoin de jetons (registre, cloud, clés "
            "d’API). Ils ne doivent jamais être écrits dans le dépôt. "
            "Stockez-les dans le coffre à secrets de l’outil CI (par exemple "
            "les secrets GitHub Actions) et injectez-les comme variables "
            "d’environnement à l’exécution.",
        points: [
          "Ne commitez jamais un secret, même dans un dépôt privé.",
          "Utilisez le coffre à secrets de la CI et des variables d’environnement.",
          "Renouvelez immédiatement un secret qui a fuité.",
        ],
      ),
    ],
    takeaways: [
      "La CI lance lint, tests et build à chaque push et pull request.",
      "Un Dockerfile rend le build reproductible partout.",
      "Les jetons vivent dans le coffre à secrets de la CI, jamais dans Git.",
    ],
  ),
  'devops-2': Course(
    labId: 'devops-2',
    intro:
        "Kubernetes exécute des conteneurs sur un cluster de machines. Vous "
        "décrivez l’état souhaité dans des fichiers YAML, et Kubernetes "
        "travaille en continu pour que la réalité y corresponde : il "
        "redémarre les conteneurs plantés, répartit la charge et déploie les "
        "nouvelles versions.",
    sections: [
      CourseSection(
        title: "Pods et Deployments",
        body:
            "Un Pod est la plus petite unité : un ou plusieurs conteneurs qui "
            "partagent une adresse réseau. On crée rarement des Pods "
            "directement : un Deployment déclare le nombre de réplicas voulu "
            "et l’image à exécuter, et recrée automatiquement les Pods qui "
            "meurent.",
        points: [
          "Pod = conteneur(s) en cours d’exécution.",
          "Deployment = nombre de réplicas souhaité + image.",
          "Kubernetes répare le cluster pour respecter l’état souhaité.",
        ],
      ),
      CourseSection(
        title: "Services et sondes de santé",
        body:
            "Les Pods sont remplacés en permanence et leurs adresses IP "
            "changent. Un Service leur donne un nom et une adresse stables et "
            "répartit la charge entre eux. Une readiness probe indique à "
            "Kubernetes quand un Pod peut recevoir du trafic, et une liveness "
            "probe quand il doit être redémarré.",
        points: [
          "Service = adresse stable devant les Pods.",
          "Readiness probe = prêt à recevoir du trafic ?",
          "Liveness probe = toujours vivant, ou à redémarrer ?",
        ],
      ),
      CourseSection(
        title: "La configuration",
        body:
            "La configuration ne doit pas être figée dans l’image. Une "
            "ConfigMap stocke les paramètres non sensibles (URL, feature "
            "flags), et un Secret stocke les valeurs sensibles comme les mots "
            "de passe. Les deux sont injectés dans les Pods en variables "
            "d’environnement ou en fichiers.",
        points: [
          "ConfigMap pour les paramètres normaux.",
          "Secret pour les mots de passe et les jetons.",
          "La même image tourne dans tous les environnements.",
        ],
      ),
    ],
    takeaways: [
      "Un Deployment maintient le nombre de réplicas demandé.",
      "Un Service donne aux Pods une adresse interne stable.",
      "Les sondes contrôlent le trafic ; ConfigMaps et Secrets portent la configuration.",
    ],
  ),
  'devops-3': Course(
    labId: 'devops-3',
    intro:
        "Les utilisateurs ne doivent jamais remarquer un déploiement. Les "
        "équipes modernes livrent plusieurs fois par jour sans interruption "
        "en choisissant une stratégie de déploiement progressive et en "
        "surveillant de près les métriques.",
    sections: [
      CourseSection(
        title: "Les stratégies de déploiement",
        body:
            "Un rolling update remplace les instances quelques-unes à la fois. "
            "Un déploiement canary envoie d’abord la nouvelle version à une "
            "petite part des utilisateurs (par exemple 5 %), puis augmente si "
            "tout va bien. Un déploiement blue/green fait tourner deux "
            "environnements complets et bascule tout le trafic d’un coup de "
            "l’ancien (blue) vers le nouveau (green), ce qui rend le retour "
            "arrière instantané.",
        points: [
          "Rolling update : remplacer les instances progressivement.",
          "Canary : une petite part des utilisateurs teste la nouvelle version.",
          "Blue/green : deux environnements, bascule et retour arrière instantanés.",
        ],
      ),
      CourseSection(
        title: "Le retour arrière automatique",
        body:
            "Un déploiement n’est sûr que si l’on détecte vite les problèmes. "
            "Définissez des signaux de santé avant de déployer : le taux "
            "d’erreurs (HTTP 5xx) et la latence sont les plus importants. "
            "Quand ils dépassent un seuil après une mise en production, le "
            "pipeline revient automatiquement à la version précédente.",
        points: [
          "Surveillez le taux d’erreurs et la latence.",
          "Fixez les seuils avant le déploiement.",
          "Revenez en arrière d’abord, enquêtez ensuite.",
        ],
      ),
      CourseSection(
        title: "Superviser avec Prometheus et Grafana",
        body:
            "Prometheus collecte à intervalles réguliers les métriques des "
            "applications et des serveurs et évalue des règles d’alerte. "
            "Grafana transforme ces métriques en tableaux de bord. Ensemble, "
            "ils montrent en temps réel la santé de chaque version.",
        points: [
          "Prometheus collecte et stocke les métriques.",
          "Les règles d’alerte déclenchent notifications ou retours arrière.",
          "Grafana visualise les métriques.",
        ],
      ),
    ],
    takeaways: [
      "Canary = une petite part d’abord ; blue/green = bascule instantanée.",
      "Le taux d’erreurs et la latence déclenchent le retour arrière automatique.",
      "Prometheus collecte les métriques, Grafana les affiche.",
    ],
  ),

  // ----------------------------------------------------------- Backend
  'backend-1': Course(
    labId: 'backend-1',
    intro:
        "Une API REST expose des ressources (livres, utilisateurs, commandes) "
        "via des URL et des méthodes HTTP standard. Une API bien conçue est "
        "prévisible : les autres développeurs devinent son fonctionnement "
        "sans lire le code.",
    sections: [
      CourseSection(
        title: "Ressources et méthodes HTTP",
        body:
            "Chaque ressource a une URL, en général un nom au pluriel : /books "
            "et /books/42. La méthode HTTP donne l’action : GET lit, POST crée, "
            "PUT remplace, PATCH modifie partiellement et DELETE supprime. Les "
            "verbes n’apparaissent jamais dans l’URL.",
        points: [
          "URL = la ressource, méthode = l’action.",
          "POST /books crée un livre.",
          "GET /books/42 lit le livre 42.",
        ],
      ),
      CourseSection(
        title: "Les codes de statut",
        body:
            "Le code de statut indique au client ce qui s’est passé. 2xx "
            "signifie succès (200 OK, 201 Created, 204 No Content), 4xx une "
            "erreur du client (400 Bad Request, 401 Unauthorized, 404 Not "
            "Found) et 5xx une erreur du serveur.",
        points: [
          "201 Created après un POST réussi.",
          "404 Not Found quand la ressource n’existe pas.",
          "Ne répondez jamais 200 avec une erreur dans le corps.",
        ],
      ),
      CourseSection(
        title: "L’idempotence",
        body:
            "Une méthode est idempotente quand l’appeler plusieurs fois a le "
            "même effet que l’appeler une seule fois. GET, PUT et DELETE sont "
            "idempotentes : les clients peuvent les relancer sans risque après "
            "une erreur réseau. POST ne l’est pas : deux appels créent deux "
            "ressources.",
        points: [
          "GET, PUT, DELETE : relance sans risque.",
          "POST : chaque appel crée quelque chose de nouveau.",
          "Les relances sont fréquentes sur les réseaux mobiles.",
        ],
      ),
    ],
    takeaways: [
      "Des noms dans les URL, les actions dans les méthodes HTTP.",
      "201 après une création, 404 quand la ressource est introuvable.",
      "PUT et DELETE sont idempotentes, POST ne l’est pas.",
    ],
  ),
  'backend-2': Course(
    labId: 'backend-2',
    intro:
        "La plupart des backends stockent leurs données dans une base "
        "relationnelle (PostgreSQL, MySQL). Un bon schéma garde les données "
        "cohérentes, et de bonnes requêtes gardent l’application rapide et "
        "sécurisée.",
    sections: [
      CourseSection(
        title: "Tables et relations",
        body:
            "Chaque table stocke un type d’entité, et les clés étrangères "
            "relient les tables entre elles. Un utilisateur peut emprunter "
            "plusieurs livres et un livre peut être emprunté par plusieurs "
            "utilisateurs : cette relation plusieurs-à-plusieurs nécessite une "
            "table de jointure (par exemple loans) contenant les deux clés "
            "étrangères.",
        points: [
          "Une table par entité, une ligne par élément.",
          "Les clés étrangères relient les tables.",
          "Plusieurs-à-plusieurs → table de jointure.",
        ],
      ),
      CourseSection(
        title: "Index et transactions",
        body:
            "Sans index, la base lit chaque ligne pour trouver une valeur. Un "
            "index sur une colonne recherchée (comme isbn) rend la recherche "
            "presque instantanée. Une transaction regroupe plusieurs "
            "instructions qui doivent toutes réussir ou toutes être annulées "
            "(ACID) : le stock et l’emprunt restent cohérents même si quelque "
            "chose échoue au milieu.",
        points: [
          "Indexez les colonnes sur lesquelles vous recherchez.",
          "Transaction = tout ou rien.",
          "COMMIT valide, ROLLBACK annule.",
        ],
      ),
      CourseSection(
        title: "Prévenir l’injection SQL",
        body:
            "Construire du SQL en concaténant les saisies de l’utilisateur "
            "permet à un attaquant de modifier la requête (par exemple "
            "' OR 1=1 --). Les requêtes paramétrées (ou un ORM) envoient les "
            "valeurs séparément du SQL : elles ne sont jamais exécutées comme "
            "du code.",
        points: [
          "Ne concaténez jamais une saisie utilisateur dans du SQL.",
          "Utilisez des requêtes paramétrées ou un ORM.",
          "Validez aussi les entrées côté serveur.",
        ],
      ),
    ],
    takeaways: [
      "Les relations plusieurs-à-plusieurs utilisent une table de jointure.",
      "Les index accélèrent les recherches ; les transactions gardent les données cohérentes.",
      "Les requêtes paramétrées empêchent l’injection SQL.",
    ],
  ),
  'backend-3': Course(
    labId: 'backend-3',
    intro:
        "Un backend en production doit protéger les comptes des utilisateurs "
        "et rester rapide quand le trafic augmente. Ce cours couvre le "
        "stockage des mots de passe, l’authentification par jeton, le cache "
        "et les tâches en arrière-plan.",
    sections: [
      CourseSection(
        title: "Stocker les mots de passe",
        body:
            "Les mots de passe ne sont jamais stockés en clair, ni avec un "
            "hachage rapide comme MD5 ou SHA-1. Utilisez un algorithme de "
            "hachage lent et salé, conçu pour les mots de passe : bcrypt ou "
            "Argon2. Même si la base fuit, l’attaquant ne peut pas retrouver "
            "facilement les mots de passe.",
        points: [
          "bcrypt ou Argon2, avec un sel unique.",
          "Ne chiffrez pas et ne stockez jamais les mots de passe en clair.",
          "Comparez les hachages, jamais les mots de passe eux-mêmes.",
        ],
      ),
      CourseSection(
        title: "Authentification sans état avec JWT",
        body:
            "Après la connexion, le serveur renvoie un jeton signé (JWT) "
            "contenant l’identifiant de l’utilisateur et une date "
            "d’expiration. Le client l’envoie dans l’en-tête Authorization de "
            "chaque requête. Le serveur vérifie la signature sans stocker de "
            "session : n’importe quelle instance peut traiter n’importe quelle "
            "requête.",
        points: [
          "Authorization: Bearer <jeton> à chaque requête.",
          "La signature prouve que le jeton n’a pas été modifié.",
          "Des jetons de courte durée, envoyés uniquement en HTTPS.",
        ],
      ),
      CourseSection(
        title: "Cache et tâches en arrière-plan",
        body:
            "Des données lues des milliers de fois ne doivent pas solliciter "
            "la base à chaque fois : un cache comme Redis les garde en "
            "mémoire, et un CDN peut mettre en cache les pages publiques. Les "
            "tâches lentes comme l’envoi d’e-mails passent par une file de "
            "messages ; un worker les traite en arrière-plan pour que la "
            "requête réponde immédiatement.",
        points: [
          "Cache Redis pour les données chaudes, CDN pour le contenu public.",
          "File de messages + worker pour les tâches lentes.",
          "Répondre d’abord à l’utilisateur, traiter ensuite.",
        ],
      ),
    ],
    takeaways: [
      "Hachez les mots de passe avec bcrypt ou Argon2.",
      "Un JWT dans l’en-tête Authorization pour une API sans état.",
      "Mettez en cache les données chaudes, déportez le travail lent dans une file.",
    ],
  ),

  // ---------------------------------------------------------- Security
  'cyber-1': Course(
    labId: 'cyber-1',
    intro:
        "Le phishing est le moyen le plus courant pour entrer dans une "
        "entreprise : un faux e-mail pousse quelqu’un à cliquer sur un lien "
        "ou à donner un mot de passe. Le reconnaître et réagir vite sont des "
        "compétences clés d’un analyste sécurité.",
    sections: [
      CourseSection(
        title: "Reconnaître le phishing",
        body:
            "Les e-mails de phishing créent de l’urgence (« votre compte sera "
            "fermé aujourd’hui »), imitent une marque ou un collègue connu, et "
            "utilisent un domaine d’expéditeur ou un lien presque correct "
            "(micros0ft-support.com). Ils demandent souvent des identifiants "
            "ou un paiement.",
        points: [
          "L’urgence et la pression sont des signaux d’alerte.",
          "Vérifiez le vrai domaine de l’expéditeur, pas le nom affiché.",
          "Pièce jointe inattendue ou demande de connexion = suspect.",
        ],
      ),
      CourseSection(
        title: "Vérifier un lien sans risque",
        body:
            "Survolez un lien (ou faites un appui long sur mobile) pour voir "
            "la vraie adresse avant de cliquer. Comparez le domaine avec soin. "
            "En cas de doute, allez sur le site en tapant vous-même son "
            "adresse, ou analysez le lien dans un bac à sable comme "
            "VirusTotal.",
        points: [
          "Survolez pour lire la vraie URL.",
          "Regardez le domaine juste avant le premier « / ».",
          "N’ouvrez jamais un lien suspect pour le « tester ».",
        ],
      ),
      CourseSection(
        title: "Réagir et prévenir",
        body:
            "Si quelqu’un a saisi un mot de passe sur une page de phishing, "
            "changez-le immédiatement, fermez les sessions actives et prévenez "
            "l’équipe sécurité. L’authentification multifacteur (MFA) bloque "
            "la plupart des attaques par mot de passe volé, car l’attaquant a "
            "aussi besoin du second facteur.",
        points: [
          "Réinitialisez d’abord le mot de passe et révoquez les sessions.",
          "Signalez l’e-mail pour protéger les autres.",
          "Le MFA stoppe la plupart des attaques par mot de passe volé.",
        ],
      ),
    ],
    takeaways: [
      "Urgence + domaine ressemblant = phishing probable.",
      "Survolez les liens, ne les testez jamais en cliquant.",
      "Réinitialisez le mot de passe tout de suite ; le MFA est la meilleure prévention.",
    ],
  ),
  'cyber-2': Course(
    labId: 'cyber-2',
    intro:
        "Sécuriser un réseau, c’est savoir ce qui est exposé, bloquer tout ce "
        "qui n’est pas nécessaire et donner un accès distant sûr. Les "
        "attaquants cherchent le point le plus faible : les défenses doivent "
        "être en couches.",
    sections: [
      CourseSection(
        title: "Cartographier la surface d’attaque",
        body:
            "Nmap analyse un serveur ou un réseau et liste les ports ouverts et "
            "les services derrière (SSH sur 22, HTTP sur 80…). Chaque port "
            "ouvert est un point d’entrée potentiel : fermez ce qui n’est pas "
            "nécessaire et n’analysez que les systèmes que vous êtes autorisé "
            "à tester.",
        points: [
          "Nmap liste les ports ouverts et les services.",
          "Moins de ports ouverts = surface d’attaque réduite.",
          "N’analysez qu’avec une autorisation.",
        ],
      ),
      CourseSection(
        title: "Pare-feu : tout refuser par défaut",
        body:
            "Un pare-feu filtre le trafic avec des règles. L’approche sûre est "
            "« refuser par défaut » : bloquer tout le trafic entrant, puis "
            "n’autoriser que les ports et sources nécessaires. La segmentation "
            "du réseau (zones séparées pour les serveurs, les utilisateurs et "
            "les invités) limite les déplacements d’un attaquant.",
        points: [
          "Politique entrante par défaut : refuser.",
          "N’autorisez que ce qui est explicitement nécessaire.",
          "Segmentez le réseau en zones.",
        ],
      ),
      CourseSection(
        title: "Accès distant et hygiène",
        body:
            "N’exposez jamais directement sur Internet des services internes "
            "comme RDP. Les employés à distance se connectent via un VPN (ou "
            "une solution d’accès Zero Trust) avec MFA. Appliquer vite les "
            "correctifs de sécurité et supprimer les services inutilisés "
            "élimine la plupart des vulnérabilités connues.",
        points: [
          "VPN ou Zero Trust avec MFA pour l’accès distant.",
          "Appliquez régulièrement les correctifs.",
          "Désactivez les services inutilisés.",
        ],
      ),
    ],
    takeaways: [
      "Nmap montre ce qui est exposé.",
      "Pare-feu : refuser par défaut, autoriser le minimum.",
      "VPN + MFA pour le télétravail, correctifs pour l’hygiène.",
    ],
  ),
  'cyber-3': Course(
    labId: 'cyber-3',
    intro:
        "Un ransomware chiffre les fichiers et exige un paiement. Une bonne "
        "réponse suit un processus clair pour limiter les dégâts, préserver "
        "les preuves et permettre à l’entreprise de se rétablir sans payer.",
    sections: [
      CourseSection(
        title: "Le cycle de réponse aux incidents",
        body:
            "Le cycle du NIST compte quatre phases : préparation ; détection et "
            "analyse ; confinement, éradication et rétablissement ; et "
            "activités post-incident (retour d’expérience). Quand un "
            "ransomware est détecté, la première étape est le confinement : "
            "isoler du réseau les machines infectées pour stopper la "
            "propagation, sans les éteindre.",
        points: [
          "Isoler d’abord pour stopper la propagation.",
          "Ne pas éteindre : la mémoire contient des preuves.",
          "Suivre le plan de réponse aux incidents.",
        ],
      ),
      CourseSection(
        title: "Enquêter",
        body:
            "Les analystes reconstituent la chronologie de l’attaque : comment "
            "l’attaquant est entré, quels comptes ont été utilisés et quelles "
            "machines ont été touchées. Les journaux système et de sécurité, "
            "les alertes EDR et le trafic réseau sont les principales sources "
            "de preuves.",
        points: [
          "Collectez les journaux avant qu’ils ne soient écrasés.",
          "L’EDR et les traces réseau révèlent le chemin de l’attaquant.",
          "Trouvez le point d’entrée pour le fermer.",
        ],
      ),
      CourseSection(
        title: "Se rétablir et apprendre",
        body:
            "Des sauvegardes hors ligne ou immuables, testées régulièrement, "
            "permettent de se rétablir sans payer la rançon. La règle 3-2-1 "
            "aide : 3 copies, sur 2 supports différents, dont 1 hors site. "
            "Après le rétablissement, un retour d’expérience identifie ce "
            "qu’il faut améliorer pour que cela ne se reproduise pas.",
        points: [
          "Sauvegardes 3-2-1, dont au moins une copie hors ligne.",
          "Testez régulièrement les restaurations.",
          "Le retour d’expérience clôt le cycle.",
        ],
      ),
    ],
    takeaways: [
      "Confiner d’abord : isoler les machines infectées.",
      "Journaux, EDR et traces réseau guident l’enquête.",
      "Les sauvegardes hors ligne permettent de se rétablir ; puis on tire les leçons.",
    ],
  ),
};
