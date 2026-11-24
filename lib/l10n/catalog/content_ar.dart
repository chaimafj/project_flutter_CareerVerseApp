// Arabic translations of the career catalog content (keys are the English source strings).
const contentAr = <String, String>{
  "Cloud Engineer": "مهندس سحابة",
  "Design, deploy and operate scalable infrastructure on AWS.":
      "تصميم بنية تحتية قابلة للتوسع على AWS ونشرها وتشغيلها.",
  "Cloud engineers design and run the infrastructure that hosts modern applications. They pick the right managed services, secure access with IAM, automate deployments with Infrastructure as Code and keep costs and availability under control.": "يصمم مهندسو السحابة البنية التحتية التي تستضيف التطبيقات الحديثة ويشغّلونها. يختارون الخدمات المُدارة المناسبة، ويؤمّنون الوصول باستخدام IAM، ويؤتمتون عمليات النشر باستخدام Infrastructure as Code، ويحافظون على التكاليف والتوافر تحت السيطرة.",
  "40k – 65k € / year": "40k – 65k € / سنويًا",
  "Very high demand: cloud adoption keeps growing every year.":
      "طلب مرتفع جدًا: اعتماد السحابة يواصل النمو كل عام.",
  "Bac+3 to Bac+5 in computer science or networks":
      "باك+3 إلى باك+5 في علوم الحاسوب أو الشبكات",
  "Design highly available architectures": "تصميم معماريات عالية التوافر",
  "Write Terraform / CloudFormation templates":
      "كتابة قوالب Terraform / CloudFormation",
  "Monitor cost and performance": "مراقبة التكلفة والأداء",
  "Manage IAM permissions and security": "إدارة أذونات IAM والأمان",
  "Technology": "التكنولوجيا",
  "Infrastructure": "البنية التحتية",
  "Problem solving": "حل المشكلات",
  "Deploy a scalable web app": "نشر تطبيق ويب قابل للتوسع",
  "A startup wants to host its e-commerce website on AWS. Traffic is unpredictable and the site must survive the loss of a data center. Choose the right services.": "تريد شركة ناشئة استضافة موقعها للتجارة الإلكترونية على AWS. حركة المرور غير متوقعة ويجب أن يصمد الموقع عند فقدان مركز بيانات. اختر الخدمات المناسبة.",
  "Beginner": "مبتدئ",
  "Which services should host the web tier so that it scales automatically with traffic? (select 2)": "أي الخدمات يجب أن تستضيف طبقة الويب بحيث تتوسع تلقائيًا مع حركة المرور؟ (اختر إجابتين)",
  "EC2 instances in an Auto Scaling group":
      "مثيلات EC2 ضمن مجموعة Auto Scaling",
  "Application Load Balancer": "Application Load Balancer",
  "A single large EC2 instance": "مثيل EC2 واحد كبير",
  "Amazon S3 Glacier": "Amazon S3 Glacier",
  "An Application Load Balancer spreads requests across EC2 instances managed by an Auto Scaling group, which adds or removes instances depending on the load.": "يوزّع Application Load Balancer الطلبات على مثيلات EC2 التي تديرها مجموعة Auto Scaling، والتي تضيف أو تزيل مثيلات حسب الحمل.",
  "Architecture": "المعمارية",
  "Where should product images and static files be stored?":
      "أين يجب تخزين صور المنتجات والملفات الثابتة؟",
  "Amazon S3": "Amazon S3",
  "Amazon RDS": "Amazon RDS",
  "EC2 instance store": "مخزن مثيل EC2",
  "IAM": "IAM",
  "S3 is durable, cheap object storage made for static assets, and can be served through CloudFront.": "S3 تخزين كائنات متين ورخيص مُصمم للأصول الثابتة، ويمكن تقديمه عبر CloudFront.",
  "Storage": "التخزين",
  "How do you make the database survive the failure of an Availability Zone?":
      "كيف تجعل قاعدة البيانات تصمد أمام فشل منطقة توافر؟",
  "Enable RDS Multi-AZ deployment": "تفعيل نشر RDS Multi-AZ",
  "Take a manual snapshot once a month": "أخذ لقطة يدوية مرة في الشهر",
  "Use a bigger instance type": "استخدام نوع مثيل أكبر",
  "Store the database on the web server": "تخزين قاعدة البيانات على خادم الويب",
  "Multi-AZ keeps a synchronous standby in another AZ and fails over automatically.": "يحافظ Multi-AZ على نسخة احتياطية متزامنة في AZ أخرى وينتقل إليها تلقائيًا عند الفشل.",
  "Reliability": "الموثوقية",
  "Which service gives a global CDN in front of the website to reduce latency?":
      "أي خدمة توفر CDN عالميًا أمام الموقع لتقليل زمن الاستجابة؟",
  "Amazon CloudFront": "Amazon CloudFront",
  "AWS Lambda": "AWS Lambda",
  "Amazon SQS": "Amazon SQS",
  "AWS IAM": "AWS IAM",
  "CloudFront caches content in edge locations close to users.":
      "يخزّن CloudFront المحتوى مؤقتًا في مواقع طرفية قريبة من المستخدمين.",
  "Secure access with IAM": "تأمين الوصول باستخدام IAM",
  "The team is growing. You must give developers and applications access to AWS without exposing the account.": "الفريق ينمو. يجب أن تمنح المطورين والتطبيقات وصولًا إلى AWS دون تعريض الحساب للخطر.",
  "Intermediate": "متوسط",
  "An EC2 application must read an S3 bucket. Best option?":
      "يجب أن يقرأ تطبيق EC2 حاوية S3. ما الخيار الأفضل؟",
  "Attach an IAM role to the instance": "إرفاق دور IAM بالمثيل",
  "Store access keys in the source code":
      "تخزين مفاتيح الوصول في الشيفرة المصدرية",
  "Use the root account keys": "استخدام مفاتيح حساب root",
  "Make the bucket public": "جعل الحاوية عامة",
  "IAM roles provide temporary credentials automatically: no secret is stored on the server.": "توفر أدوار IAM بيانات اعتماد مؤقتة تلقائيًا: لا يُخزَّن أي سر على الخادم.",
  "Security": "الأمان",
  "Which principle should guide IAM policies?":
      "أي مبدأ يجب أن يوجّه سياسات IAM؟",
  "Least privilege": "أقل صلاحية ممكنة",
  "Full access for everyone": "وصول كامل للجميع",
  "One shared user for the team": "مستخدم مشترك واحد للفريق",
  "Disable logging": "تعطيل التسجيل",
  "Grant only the permissions needed for the task, nothing more.":
      "امنح فقط الأذونات اللازمة للمهمة، لا أكثر.",
  "How do you protect the root account? (select 2)":
      "كيف تحمي حساب root؟ (اختر إجابتين)",
  "Enable MFA": "تفعيل MFA",
  "Do not use it for daily tasks": "عدم استخدامه للمهام اليومية",
  "Share its password with admins": "مشاركة كلمة مروره مع المديرين",
  "Create access keys for it": "إنشاء مفاتيح وصول له",
  "Root must have MFA and be kept for the rare tasks that require it. Daily work uses IAM users or SSO.": "يجب تفعيل MFA لحساب root وحصر استخدامه في المهام النادرة التي تتطلبه. العمل اليومي يستخدم مستخدمي IAM أو SSO.",
  "Which service records every API call for auditing?":
      "أي خدمة تسجّل كل استدعاء API للتدقيق؟",
  "AWS CloudTrail": "AWS CloudTrail",
  "Amazon EBS": "Amazon EBS",
  "Route 53": "Route 53",
  "Amazon SNS": "Amazon SNS",
  "CloudTrail logs who did what and when on the account.":
      "يسجل CloudTrail من فعل ماذا ومتى على الحساب.",
  "Monitoring": "المراقبة",
  "Optimize cost & reliability": "تحسين التكلفة والموثوقية",
  "The monthly AWS bill doubled. Reduce costs without lowering the availability of production.":
      "تضاعفت فاتورة AWS الشهرية. خفّض التكاليف دون تقليل توافر بيئة الإنتاج.",
  "Advanced": "متقدم",
  "A batch job can be interrupted and restarted. Cheapest compute option?":
      "مهمة دفعية يمكن إيقافها وإعادة تشغيلها. ما خيار الحوسبة الأرخص؟",
  "EC2 Spot Instances": "EC2 Spot Instances",
  "On-Demand instances": "مثيلات On-Demand",
  "Dedicated hosts": "مضيفون مخصصون",
  "Bigger instances": "مثيلات أكبر",
  "Spot instances are up to 90% cheaper and fit interruptible workloads.":
      "مثيلات Spot أرخص حتى 90% وتناسب أحمال العمل القابلة للمقاطعة.",
  "Cost optimization": "تحسين التكلفة",
  "Production runs 24/7 for the next 3 years. What saves money?":
      "الإنتاج يعمل 24/7 للسنوات الثلاث القادمة. ما الذي يوفر المال؟",
  "Savings Plans / Reserved Instances": "Savings Plans / Reserved Instances",
  "Spot Instances only": "Spot Instances فقط",
  "Stopping the servers at night": "إيقاف الخوادم ليلًا",
  "Moving to a single AZ": "الانتقال إلى AZ واحدة",
  "A 1 or 3 year commitment gives large discounts on steady usage.":
      "التزام لمدة سنة أو 3 سنوات يمنح خصومات كبيرة على الاستخدام المستقر.",
  "Old logs are rarely read but must be kept 5 years. Solution?":
      "السجلات القديمة نادرًا ما تُقرأ لكن يجب الاحتفاظ بها 5 سنوات. ما الحل؟",
  "S3 lifecycle rule to Glacier": "قاعدة دورة حياة S3 للنقل إلى Glacier",
  "Keep them on EBS volumes": "إبقاؤها على وحدات EBS",
  "Delete them": "حذفها",
  "Store them in RDS": "تخزينها في RDS",
  "Lifecycle rules move cold data to Glacier automatically at a fraction of the price.": "تنقل قواعد دورة الحياة البيانات الباردة إلى Glacier تلقائيًا بجزء صغير من التكلفة.",
  "Which tools help you detect cost anomalies? (select 2)":
      "أي أدوات تساعدك على اكتشاف شذوذ التكلفة؟ (اختر إجابتين)",
  "AWS Budgets alerts": "تنبيهات AWS Budgets",
  "Cost Explorer": "Cost Explorer",
  "Amazon Polly": "Amazon Polly",
  "AWS Snowball": "AWS Snowball",
  "Cost Explorer analyzes spending; Budgets sends alerts when a threshold is exceeded.":
      "يحلل Cost Explorer الإنفاق؛ وترسل Budgets تنبيهات عند تجاوز عتبة محددة.",
  "DevOps Engineer": "مهندس DevOps",
  "Automate builds, tests and deployments from code to production.":
      "أتمتة البناء والاختبارات والنشر من الشيفرة إلى الإنتاج.",
  "DevOps engineers bridge development and operations. They build CI/CD pipelines, containerize applications, orchestrate them with Kubernetes and make releases fast, safe and repeatable.": "يربط مهندسو DevOps بين التطوير والعمليات. يبنون خطوط CI/CD، ويضعون التطبيقات في حاويات، وينسقونها باستخدام Kubernetes، ويجعلون الإصدارات سريعة وآمنة وقابلة للتكرار.",
  "42k – 65k € / year": "42k – 65k € / سنويًا",
  "High demand in startups, scale-ups and large companies.":
      "طلب مرتفع في الشركات الناشئة والمتوسعة والكبيرة.",
  "Bac+3 to Bac+5 in software engineering or systems":
      "باك+3 إلى باك+5 في هندسة البرمجيات أو الأنظمة",
  "Maintain CI/CD pipelines": "صيانة خطوط CI/CD",
  "Build and secure container images": "بناء صور الحاويات وتأمينها",
  "Operate Kubernetes clusters": "تشغيل عناقيد Kubernetes",
  "Set up monitoring and alerting": "إعداد المراقبة والتنبيهات",
  "Automation": "الأتمتة",
  "Collaboration": "التعاون",
  "Build a CI pipeline": "بناء خط CI",
  "Developers push code several times a day and bugs reach production. Design a continuous integration pipeline.": "يدفع المطورون الشيفرة عدة مرات يوميًا وتصل الأخطاء إلى الإنتاج. صمّم خط تكامل مستمر.",
  "When should the CI pipeline run?": "متى يجب أن يعمل خط CI؟",
  "On every push and pull request": "عند كل push وكل pull request",
  "Once a month": "مرة في الشهر",
  "Only before vacations": "فقط قبل العطل",
  "Never, tests are done manually": "أبدًا، الاختبارات تُجرى يدويًا",
  "Running on every change detects regressions as early as possible.":
      "تشغيله عند كل تغيير يكتشف الانحدارات في أبكر وقت ممكن.",
  "CI/CD": "CI/CD",
  "Which steps belong in a CI pipeline? (select 2)":
      "أي خطوات تنتمي إلى خط CI؟ (اختر إجابتين)",
  "Run automated tests": "تشغيل الاختبارات الآلية",
  "Lint / static analysis": "Lint / تحليل ثابت",
  "Delete the production database": "حذف قاعدة بيانات الإنتاج",
  "Email the code to the manager": "إرسال الشيفرة بالبريد إلى المدير",
  "Lint and tests are the core quality gates of CI.":
      "الـ Lint والاختبارات هما بوابتا الجودة الأساسيتان في CI.",
  "What file describes how to build a container image?":
      "أي ملف يصف كيفية بناء صورة حاوية؟",
  "Dockerfile": "Dockerfile",
  "package.lock": "package.lock",
  "README.md": "README.md",
  ".gitignore": ".gitignore",
  "A Dockerfile lists the instructions used by docker build.":
      "يسرد Dockerfile التعليمات التي يستخدمها docker build.",
  "Containers": "الحاويات",
  "Where should API tokens used by the pipeline be stored?":
      "أين يجب تخزين رموز API التي يستخدمها خط العمل؟",
  "In the CI secret store": "في مخزن أسرار CI",
  "In the repository in clear text": "في المستودع كنص واضح",
  "In the commit message": "في رسالة commit",
  "In the Docker image": "في صورة Docker",
  "Secrets must be injected at runtime from an encrypted store.":
      "يجب حقن الأسرار وقت التشغيل من مخزن مشفر.",
  "Run containers on Kubernetes": "تشغيل الحاويات على Kubernetes",
  "Your API must run on Kubernetes with 3 replicas and be reachable by other services.": "يجب أن تعمل API الخاصة بك على Kubernetes بثلاث نسخ وأن تكون قابلة للوصول من خدمات أخرى.",
  "Which object keeps 3 replicas of the API running?":
      "أي كائن يحافظ على تشغيل 3 نسخ من API؟",
  "Deployment": "Deployment",
  "ConfigMap": "ConfigMap",
  "Namespace": "Namespace",
  "Secret": "Secret",
  "A Deployment manages a ReplicaSet that maintains the desired number of pods.":
      "يدير Deployment كائن ReplicaSet يحافظ على العدد المطلوب من pods.",
  "Kubernetes": "Kubernetes",
  "Which object gives the pods a stable internal address?":
      "أي كائن يعطي الـ pods عنوانًا داخليًا ثابتًا؟",
  "Service": "Service",
  "Pod": "Pod",
  "Volume": "Volume",
  "Job": "Job",
  "A Service exposes a stable DNS name and load-balances to pods.":
      "يوفر Service اسم DNS ثابتًا ويوزع الحمل على pods.",
  "How does Kubernetes know when a pod is ready to receive traffic?":
      "كيف يعرف Kubernetes أن pod جاهز لاستقبال حركة المرور؟",
  "Readiness probe": "Readiness probe",
  "Pod name": "اسم Pod",
  "Image tag": "وسم Image",
  "Node label": "تسمية Node",
  "The readiness probe removes the pod from the Service until it answers correctly.":
      "يزيل Readiness probe الـ pod من Service إلى أن يستجيب بشكل صحيح.",
  "Where do you store non-sensitive configuration? ":
      "أين تخزن الإعدادات غير الحساسة؟ ",
  "Ingress": "Ingress",
  "ConfigMaps hold plain configuration; Secrets are for sensitive data.":
      "تحتفظ ConfigMaps بالإعدادات العادية؛ أما Secrets فللبيانات الحساسة.",
  "Zero-downtime deployments": "نشر دون توقف",
  "A new version must be released during business hours without interrupting users, and must be easy to roll back.": "يجب إصدار نسخة جديدة خلال ساعات العمل دون تعطيل المستخدمين، ويجب أن تكون سهلة الرجوع.",
  "Which strategy sends the new version to a small share of users first?":
      "أي استراتيجية ترسل النسخة الجديدة أولًا إلى نسبة صغيرة من المستخدمين؟",
  "Canary release": "إصدار Canary",
  "Big bang": "Big bang",
  "Recreate": "Recreate",
  "Manual copy": "نسخ يدوي",
  "Canary releases expose a small percentage of traffic and grow it progressively.":
      "تعرض إصدارات Canary نسبة صغيرة من حركة المرور ثم تزيدها تدريجيًا.",
  "Blue/green deployment means…": "يعني نشر blue/green…",
  "Two identical environments, traffic is switched at once":
      "بيئتان متطابقتان، ويتم تحويل حركة المرور دفعة واحدة",
  "Deploying only on Mondays": "النشر فقط أيام الاثنين",
  "Using two Git branches": "استخدام فرعين في Git",
  "Coloring the logs": "تلوين السجلات",
  "Rollback is instant: just switch traffic back to blue.":
      "الرجوع فوري: فقط حوّل حركة المرور مرة أخرى إلى blue.",
  "Which signals should trigger an automatic rollback? (select 2)":
      "أي إشارات يجب أن تُطلق رجوعًا تلقائيًا؟ (اختر إجابتين)",
  "Error rate increase": "ارتفاع معدل الأخطاء",
  "Latency spike": "قفزة في زمن الاستجابة",
  "New commit on main": "commit جديد على main",
  "Developer goes home": "المطور يذهب إلى المنزل",
  "Error rate and latency are key SLO indicators of a bad release.":
      "معدل الأخطاء وزمن الاستجابة مؤشرات SLO أساسية لإصدار سيئ.",
  "Which tool collects metrics for those alerts?":
      "أي أداة تجمع المقاييس لهذه التنبيهات؟",
  "Prometheus": "Prometheus",
  "Photoshop": "Photoshop",
  "Excel": "Excel",
  "Jira": "Jira",
  "Prometheus scrapes metrics and evaluates alerting rules.":
      "يجمع Prometheus المقاييس ويقيّم قواعد التنبيه.",
  "Backend Developer": "مطوّر Backend",
  "Build APIs, business logic and databases behind applications.":
      "بناء APIs ومنطق الأعمال وقواعد البيانات خلف التطبيقات.",
  "Backend developers write the server-side code of applications: REST APIs, data models, authentication and performance. They work with databases, caches and message queues.": "يكتب مطورو Backend الشيفرة من جهة الخادم للتطبيقات: REST APIs، نماذج البيانات، المصادقة والأداء. يعملون مع قواعد البيانات وذاكرات التخزين المؤقت وطوابير الرسائل.",
  "35k – 60k € / year": "35k – 60k € / سنويًا",
  "Stable and strong demand in every sector.": "طلب مستقر وقوي في كل القطاعات.",
  "Bac+2 to Bac+5 in software development":
      "باك+2 إلى باك+5 في تطوير البرمجيات",
  "Design and implement REST APIs": "تصميم وتنفيذ REST APIs",
  "Model data in SQL databases": "نمذجة البيانات في قواعد بيانات SQL",
  "Write unit and integration tests": "كتابة اختبارات وحدات وتكامل",
  "Review teammates’ code": "مراجعة شيفرة زملاء الفريق",
  "Logic": "المنطق",
  "Data": "البيانات",
  "Design a REST API": "تصميم REST API",
  "You build the API of a library app: books can be listed, created, updated and deleted.":
      "أنت تبني API لتطبيق مكتبة: يمكن عرض الكتب وإنشاؤها وتحديثها وحذفها.",
  "Which HTTP method creates a new book?": "أي طريقة HTTP تنشئ كتابًا جديدًا؟",
  "POST /books": "POST /books",
  "GET /books": "GET /books",
  "DELETE /books": "DELETE /books",
  "HEAD /books": "HEAD /books",
  "POST on a collection creates a new resource.":
      "استخدام POST على مجموعة ينشئ موردًا جديدًا.",
  "API design": "تصميم API",
  "Which status code is returned after a successful creation?":
      "أي رمز حالة يُعاد بعد إنشاء ناجح؟",
  "201 Created": "201 Created",
  "404 Not Found": "404 Not Found",
  "500 Server Error": "500 Server Error",
  "302 Found": "302 Found",
  "201 indicates that a resource has been created.":
      "يشير 201 إلى أنه تم إنشاء مورد.",
  "The requested book id does not exist. Status code?":
      "معرّف الكتاب المطلوب غير موجود. ما رمز الحالة؟",
  "200 OK": "200 OK",
  "418": "418",
  "404 means the resource could not be found.":
      "يعني 404 أن المورد لم يُعثر عليه.",
  "Which methods are idempotent? (select 2)":
      "أي الطرق idempotent؟ (اختر إجابتين)",
  "PUT": "PUT",
  "DELETE": "DELETE",
  "POST": "POST",
  "PATCH (always)": "PATCH (دائمًا)",
  "Calling PUT or DELETE several times produces the same final state.":
      "استدعاء PUT أو DELETE عدة مرات ينتج الحالة النهائية نفسها.",
  "Model a relational database": "نمذجة قاعدة بيانات علائقية",
  "Each user can borrow many books, and each book can be borrowed by many users over time.": "يمكن لكل مستخدم استعارة العديد من الكتب، ويمكن لكل كتاب أن يُستعار من عدة مستخدمين مع مرور الوقت.",
  "How do you model the users ↔ books relation?":
      "كيف تمثل علاقة المستخدمين ↔ الكتب؟",
  "A join table \"loans\" with two foreign keys":
      "جدول ربط \"loans\" بمفتاحين أجنبيين",
  "A comma-separated list in the users table":
      "قائمة مفصولة بفواصل في جدول users",
  "Duplicate the book in each user row": "تكرار الكتاب في كل صف مستخدم",
  "One table per user": "جدول واحد لكل مستخدم",
  "Many-to-many relations use an association table.":
      "تستخدم العلاقات متعدد إلى متعدد جدول ارتباط.",
  "Databases": "قواعد البيانات",
  "Searching books by ISBN is slow. What helps most?":
      "البحث عن الكتب باستخدام ISBN بطيء. ما الذي يساعد أكثر؟",
  "Create an index on isbn": "إنشاء فهرس على isbn",
  "Add more columns": "إضافة أعمدة أكثر",
  "Use SELECT *": "استخدام SELECT *",
  "Restart the server daily": "إعادة تشغيل الخادم يوميًا",
  "An index avoids a full table scan.": "يتجنب الفهرس فحص الجدول كاملًا.",
  "Performance": "الأداء",
  "A loan must decrease stock and insert a row, or do nothing. Which feature?": "يجب أن تُنقص عملية استعارة المخزون وتُدرج صفًا، أو لا تفعل شيئًا. أي ميزة؟",
  "A transaction": "معاملة",
  "A view": "عرض",
  "A comment": "تعليق",
  "A trigger on SELECT": "مشغّل عند SELECT",
  "Transactions are atomic: all statements succeed or none.":
      "المعاملات ذرية: إما تنجح كل العبارات أو لا ينجح أي منها.",
  "How do you prevent SQL injection?": "كيف تمنع SQL injection؟",
  "Parameterized queries": "استعلامات مُعلّمة",
  "String concatenation": "دمج السلاسل النصية",
  "Hiding the error messages": "إخفاء رسائل الخطأ",
  "Using uppercase SQL": "استخدام SQL بأحرف كبيرة",
  "Parameters are sent separately from the SQL text, so input is never executed.":
      "تُرسل المعلمات منفصلة عن نص SQL، لذلك لا يُنفّذ الإدخال أبدًا.",
  "Authentication & performance": "المصادقة والأداء",
  "The API becomes popular: secure user accounts and handle 10× more traffic.": "أصبحت API شائعة: أمّن حسابات المستخدمين وتعامل مع حركة مرور أكثر بـ 10×.",
  "How should passwords be stored?": "كيف يجب تخزين كلمات المرور؟",
  "Hashed with bcrypt / Argon2 and a salt":
      "تجزئتها باستخدام bcrypt / Argon2 مع salt",
  "In clear text": "كنص واضح",
  "Encrypted with a key stored in the code": "تشفيرها بمفتاح مخزن في الشيفرة",
  "Base64 encoded": "مرمّزة بـ Base64",
  "Slow salted hashes make leaked passwords very hard to crack.":
      "التجزئات البطيئة مع salt تجعل كلمات المرور المسرّبة صعبة الكسر جدًا.",
  "A stateless API authenticates requests with…":
      "تُصادق API عديمة الحالة الطلبات باستخدام…",
  "Signed JWT tokens": "رموز JWT موقعة",
  "Server RAM sessions only": "جلسات RAM على الخادم فقط",
  "The IP address": "عنوان IP",
  "Cookies without signature": "كوكيز دون توقيع",
  "A signed token can be verified by any instance without shared state.":
      "يمكن لأي مثيل التحقق من الرمز الموقّع دون حالة مشتركة.",
  "Popular book pages are read thousands of times. Solution? (select 2)":
      "صفحات الكتب الشائعة تُقرأ آلاف المرات. ما الحل؟ (اختر إجابتين)",
  "Cache responses in Redis": "تخزين الاستجابات مؤقتًا في Redis",
  "Use HTTP caching headers": "استخدام ترويسات التخزين المؤقت HTTP",
  "Query the database twice": "استعلام قاعدة البيانات مرتين",
  "Disable pagination": "تعطيل التقسيم إلى صفحات",
  "Server-side and HTTP caches avoid recomputing identical responses.": "تتجنب التخزينات المؤقتة من جهة الخادم وHTTP إعادة حساب الاستجابات المتطابقة.",
  "Sending emails slows down requests. What do you do?":
      "إرسال الرسائل الإلكترونية يبطئ الطلبات. ماذا تفعل؟",
  "Push the task to a message queue and process it asynchronously":
      "دفع المهمة إلى طابور رسائل ومعالجتها بشكل غير متزامن",
  "Send emails in a loop inside the request":
      "إرسال الرسائل في حلقة داخل الطلب",
  "Remove emails": "إزالة الرسائل الإلكترونية",
  "Increase the timeout": "زيادة مهلة الانتظار",
  "Queues decouple slow work from the request/response cycle.":
      "تفصل الطوابير العمل البطيء عن دورة الطلب/الاستجابة.",
  "Cybersecurity Analyst": "محلل أمن سيبراني",
  "Protect systems, detect attacks and respond to incidents.":
      "حماية الأنظمة، واكتشاف الهجمات، والاستجابة للحوادث.",
  "Cybersecurity analysts monitor networks and systems, investigate alerts, and respond to incidents. They raise awareness, harden configurations and help the company comply with security standards.": "يراقب محللو الأمن السيبراني الشبكات والأنظمة، ويفحصون التنبيهات، ويستجيبون للحوادث. يرفعون الوعي، ويقوّون الإعدادات، ويساعدون الشركة على الالتزام بمعايير الأمان.",
  "40k – 70k € / year": "40k – 70k € / سنويًا",
  "Critical shortage of profiles: excellent job prospects.":
      "نقص حاد في هذه الكفاءات: آفاق عمل ممتازة.",
  "Bac+3 to Bac+5 in cybersecurity or networks":
      "باك+3 إلى باك+5 في الأمن السيبراني أو الشبكات",
  "Analyze security alerts in the SIEM": "تحليل تنبيهات الأمان في SIEM",
  "Investigate suspicious emails": "التحقيق في رسائل البريد المشبوهة",
  "Run vulnerability scans": "تشغيل فحوصات الثغرات",
  "Write incident reports": "كتابة تقارير الحوادث",
  "Investigation": "التحقيق",
  "Detect a phishing attack": "اكتشاف هجوم تصيد",
  "An employee forwards a suspicious email asking to \"verify the account within 24h\". Analyze it.": "حوّل موظف رسالة بريد مشبوهة تطلب \"التحقق من الحساب خلال 24 ساعة\". حلّلها.",
  "Which signs indicate phishing? (select 2)":
      "أي علامات تدل على التصيد؟ (اختر إجابتين)",
  "Sender domain slightly misspelled": "نطاق المرسل مكتوب بخطأ طفيف",
  "Urgency and threat of account closure": "الاستعجال والتهديد بإغلاق الحساب",
  "Email sent during business hours": "أُرسلت الرسالة خلال ساعات العمل",
  "Company logo present": "وجود شعار الشركة",
  "Look-alike domains and pressure tactics are classic phishing signs.":
      "النطاقات الشبيهة وأساليب الضغط علامات كلاسيكية للتصيد.",
  "Threat detection": "اكتشاف التهديدات",
  "How do you check a link safely?": "كيف تتحقق من رابط بأمان؟",
  "Hover it to read the real URL without clicking":
      "مرّر المؤشر فوقه لقراءة URL الحقيقي دون النقر",
  "Click it to see": "انقر عليه لتعرف",
  "Reply to the sender": "ارد على المرسل",
  "Forward it to everyone": "أعد توجيهه للجميع",
  "Hovering shows the real destination without visiting it.":
      "إمرار المؤشر يُظهر الوجهة الحقيقية دون زيارتها.",
  "The employee already typed the password. First action?":
      "الموظف كتب كلمة المرور بالفعل. ما أول إجراء؟",
  "Reset the password and revoke sessions":
      "إعادة تعيين كلمة المرور وإلغاء الجلسات",
  "Wait and see": "الانتظار والمراقبة",
  "Delete the email only": "حذف الرسالة فقط",
  "Turn off the screen": "إطفاء الشاشة",
  "Credentials are compromised: invalidate them immediately.":
      "بيانات الاعتماد مخترقة: أبطلها فورًا.",
  "Incident response": "الاستجابة للحوادث",
  "Which control blocks most stolen-password attacks?":
      "أي ضابط يمنع معظم هجمات كلمات المرور المسروقة؟",
  "Multi-factor authentication": "المصادقة متعددة العوامل",
  "Longer email signatures": "توقيعات بريد إلكتروني أطول",
  "Screen savers": "شاشات توقف",
  "Antivirus only": "مضاد فيروسات فقط",
  "With MFA, a stolen password alone is not enough to log in.":
      "مع MFA، لا تكفي كلمة مرور مسروقة وحدها لتسجيل الدخول.",
  "Defense": "الدفاع",
  "Secure a company network": "تأمين شبكة شركة",
  "A small company exposes several services on the Internet. Reduce its attack surface.":
      "تعرض شركة صغيرة عدة خدمات على الإنترنت. قلّل سطح الهجوم لديها.",
  "Which tool lists the open ports of a server?":
      "أي أداة تسرد المنافذ المفتوحة في خادم؟",
  "Nmap": "Nmap",
  "Paint": "Paint",
  "Git": "Git",
  "Nmap scans hosts and reports open ports and services.":
      "يفحص Nmap المضيفين ويبلغ عن المنافذ والخدمات المفتوحة.",
  "Network": "الشبكة",
  "Default firewall policy for incoming traffic?":
      "ما سياسة الجدار الناري الافتراضية لحركة المرور الواردة؟",
  "Deny all, then allow what is needed": "رفض الكل، ثم السماح بما هو ضروري",
  "Allow all": "السماح للكل",
  "Allow all except port 80": "السماح للكل باستثناء المنفذ 80",
  "No firewall": "لا جدار ناري",
  "Default-deny minimizes exposure.": "الرفض الافتراضي يقلل التعرض.",
  "Remote employees need internal access. Best option?":
      "يحتاج الموظفون عن بُعد إلى وصول داخلي. ما الخيار الأفضل؟",
  "A VPN with MFA": "VPN مع MFA",
  "Open RDP to the Internet": "فتح RDP على الإنترنت",
  "Share an admin password": "مشاركة كلمة مرور مدير",
  "Disable the firewall at night": "تعطيل الجدار الناري ليلًا",
  "A VPN encrypts traffic and keeps internal services private.":
      "تشفّر VPN حركة المرور وتُبقي الخدمات الداخلية خاصة.",
  "Which practices reduce vulnerabilities? (select 2)":
      "أي ممارسات تقلل الثغرات؟ (اختر إجابتين)",
  "Apply security patches regularly": "تطبيق تصحيحات الأمان بانتظام",
  "Segment the network": "تقسيم الشبكة",
  "Use the same password everywhere": "استخدام كلمة المرور نفسها في كل مكان",
  "Disable logs to save space": "تعطيل السجلات لتوفير المساحة",
  "Patching fixes known flaws; segmentation limits lateral movement.":
      "تصلح التصحيحات العيوب المعروفة؛ ويحد التقسيم من الحركة الجانبية.",
  "Respond to a ransomware incident": "الاستجابة لحادث ransomware",
  "Files on a file server are being encrypted and a ransom note appears. Lead the response.":
      "تتعرض ملفات على خادم ملفات للتشفير وتظهر مذكرة فدية. قُد الاستجابة.",
  "What is the very first step?": "ما أول خطوة على الإطلاق؟",
  "Isolate the infected machines from the network":
      "عزل الأجهزة المصابة عن الشبكة",
  "Pay the ransom": "دفع الفدية",
  "Reboot every server": "إعادة تشغيل كل خادم",
  "Post on social media": "النشر على وسائل التواصل الاجتماعي",
  "Containment stops the spread before eradication and recovery.":
      "الاحتواء يوقف الانتشار قبل الإزالة والتعافي.",
  "What makes recovery possible without paying?":
      "ما الذي يجعل التعافي ممكنًا دون الدفع؟",
  "Offline / immutable backups": "نسخ احتياطية غير متصلة / غير قابلة للتغيير",
  "A bigger hard drive": "قرص صلب أكبر",
  "The recycle bin": "سلة المحذوفات",
  "Screenshots of the files": "لقطات شاشة للملفات",
  "Backups that ransomware cannot reach allow a clean restore.": "النسخ الاحتياطية التي لا يستطيع ransomware الوصول إليها تسمح باستعادة نظيفة.",
  "Which data helps the investigation? (select 2)":
      "أي بيانات تساعد التحقيق؟ (اختر إجابتين)",
  "SIEM and system logs": "سجلات SIEM والنظام",
  "Memory and disk images": "صور الذاكرة والقرص",
  "The office playlist": "قائمة موسيقى المكتب",
  "Coffee machine logs": "سجلات آلة القهوة",
  "Logs and forensic images reveal the entry point and timeline.":
      "تكشف السجلات والصور الجنائية نقطة الدخول والخط الزمني.",
  "In the incident lifecycle, what comes after recovery?":
      "في دورة حياة الحادث، ما الذي يأتي بعد التعافي؟",
  "Lessons learned": "الدروس المستفادة",
  "Detection": "الاكتشاف",
  "Preparation is skipped": "يتم تخطي التحضير",
  "Nothing": "لا شيء",
  "A post-incident review improves defenses for the next time.":
      "تُحسّن مراجعة ما بعد الحادث الدفاعات للمرة القادمة.",
  "Cloud": "السحابة",
  "DevOps": "DevOps",
  "Programming": "البرمجة",
  "Networks": "الشبكات",
  "Teamwork": "العمل الجماعي",
  "Design": "التصميم",
  "Mobile": "تطبيقات الجوال",
  "Web": "الويب",
  "AI": "الذكاء الاصطناعي",
  "High school": "الثانوي",
  "Bac+1": "باك+1",
  "Bac+2": "باك+2",
  "Bac+3 (Licence)": "باك+3 (ليسانس)",
  "Bac+4": "باك+4",
  "Bac+5 (Master / Engineer)": "باك+5 (ماستر / مهندس)",
  "Graduate": "خريج",
};
