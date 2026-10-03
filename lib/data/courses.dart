import '../l10n/courses_ar.dart';
import '../l10n/courses_fr.dart';
import '../models/course.dart';
import 'catalog.dart';

/// Courses that prepare each lab (keyed by lab id). The text exists in each
/// language with the same structure; examples (code, commands) are shared.
const coursesEn = <String, Course>{
  // ------------------------------------------------------------- Cloud
  'cloud-1': Course(
    labId: 'cloud-1',
    intro:
        "Before deploying a real website on AWS, you need to know the "
        "building blocks: compute that grows with traffic, storage for files, "
        "a database that survives failures and a CDN that brings content "
        "close to users.",
    sections: [
      CourseSection(
        title: "Elastic compute: EC2, Auto Scaling and load balancing",
        body:
            "An EC2 instance is a virtual server. One server is a single "
            "point of failure and cannot absorb traffic peaks. An Auto Scaling "
            "group keeps a fleet of identical instances and adds or removes "
            "some depending on a metric such as CPU usage. An Application "
            "Load Balancer (ALB) receives every request and spreads it across "
            "the healthy instances of the group.",
        points: [
          "Auto Scaling = the right number of servers at any time.",
          "The load balancer sends traffic only to healthy instances.",
          "Spread instances over several Availability Zones (AZ).",
        ],
      ),
      CourseSection(
        title: "Storing files and data",
        body:
            "Static files (images, CSS, videos) go to Amazon S3, an object "
            "storage service that is very durable and cheap. Structured data "
            "goes to a managed database such as Amazon RDS. With the Multi-AZ "
            "option, RDS keeps a synchronous copy in another Availability Zone "
            "and fails over automatically if the main one breaks.",
        points: [
          "S3 for objects and static assets, never on the web server disk.",
          "RDS Multi-AZ = automatic failover to a standby database.",
          "Backups protect against mistakes, Multi-AZ against outages.",
        ],
      ),
      CourseSection(
        title: "Going global with a CDN",
        body:
            "Amazon CloudFront is a Content Delivery Network: it caches your "
            "content in hundreds of edge locations around the world. A user "
            "in Tunis or Paris is served by the closest location, which "
            "reduces latency and offloads your servers.",
        points: [
          "CloudFront caches content close to the users.",
          "It can serve both S3 files and your load balancer.",
          "Less latency for users, less load for your servers.",
        ],
      ),
    ],
    takeaways: [
      "ALB + Auto Scaling group over several AZs for the web tier.",
      "S3 for static files, RDS Multi-AZ for the database.",
      "CloudFront in front of everything to reduce latency.",
    ],
  ),
  'cloud-2': Course(
    labId: 'cloud-2',
    intro:
        "Identity and Access Management (IAM) decides who can do what on an "
        "AWS account. Most cloud security incidents come from leaked keys "
        "or too-wide permissions, so IAM is the first skill of a cloud "
        "engineer.",
    sections: [
      CourseSection(
        title: "Users, groups, roles and policies",
        body:
            "A policy is a JSON document that allows or denies actions on "
            "resources. Users represent people, groups share policies between "
            "users, and roles are identities that services or applications "
            "assume to get temporary credentials. An EC2 instance with a role "
            "never needs stored access keys.",
        points: [
          "People → users in groups, applications → roles.",
          "Roles deliver temporary credentials automatically.",
          "Never put access keys in source code.",
        ],
      ),
      CourseSection(
        title: "The principle of least privilege",
        body:
            "Each identity should get only the permissions it needs, on the "
            "resources it needs, and nothing more. If a key leaks, the damage "
            "stays limited. Start with a narrow policy and widen it only when "
            "a real need appears.",
        points: [
          "Allow precise actions on precise resources.",
          "Avoid \"*\" actions and resources in production.",
          "Review and remove unused permissions regularly.",
        ],
      ),
      CourseSection(
        title: "Protecting the account and auditing",
        body:
            "The root account can do everything, including closing the "
            "account: protect it with MFA and do not use it for daily work. "
            "AWS CloudTrail records every API call (who, what, when, from "
            "where), which is essential for audits and investigations.",
        points: [
          "Enable MFA on root and on every human user.",
          "Use the root account only for rare account tasks.",
          "CloudTrail = history of every API call.",
        ],
      ),
    ],
    takeaways: [
      "Applications use IAM roles, not stored keys.",
      "Least privilege limits the impact of a leak.",
      "MFA on root, and CloudTrail to audit everything.",
    ],
  ),
  'cloud-3': Course(
    labId: 'cloud-3',
    intro:
        "A good cloud architecture is reliable and affordable. Cloud "
        "engineers choose the right pricing model for each workload and "
        "watch costs continuously, like any other metric.",
    sections: [
      CourseSection(
        title: "Pricing models for compute",
        body:
            "On-Demand instances are flexible but the most expensive. Spot "
            "instances use spare AWS capacity with up to 90% discount, but "
            "can be interrupted with a 2-minute notice: perfect for batch "
            "jobs that can restart. Savings Plans and Reserved Instances give "
            "large discounts in exchange for a 1 or 3-year commitment, ideal "
            "for production that runs 24/7.",
        points: [
          "Interruptible batch jobs → Spot instances.",
          "Stable 24/7 workloads → Savings Plans or Reserved Instances.",
          "Short or unpredictable needs → On-Demand.",
        ],
      ),
      CourseSection(
        title: "Storage classes and lifecycle rules",
        body:
            "S3 offers several storage classes. S3 Standard is for frequently "
            "read data, S3 Standard-IA for infrequent access, and S3 Glacier "
            "for archives that are rarely read but must be kept for years. "
            "Lifecycle rules move objects automatically between classes as "
            "they get older.",
        points: [
          "The colder the data, the cheaper the storage class.",
          "Glacier is made for long-term archives.",
          "Lifecycle rules automate the transitions.",
        ],
      ),
      CourseSection(
        title: "Watching costs",
        body:
            "AWS Budgets sends alerts when spending exceeds a threshold. Cost "
            "Explorer shows where money goes, and Cost Anomaly Detection uses "
            "machine learning to spot unusual spending. Tagging resources by "
            "project or team makes these reports useful.",
        points: [
          "Set a budget with alerts on every account.",
          "Use Cost Explorer and Anomaly Detection every week.",
          "Tag resources to know who spends what.",
        ],
      ),
    ],
    takeaways: [
      "Spot for interruptible jobs, Savings Plans for 24/7 production.",
      "S3 lifecycle rules move old data to Glacier.",
      "Budgets and Cost Anomaly Detection catch surprises early.",
    ],
  ),

  // ------------------------------------------------------------ DevOps
  'devops-1': Course(
    labId: 'devops-1',
    intro:
        "Continuous Integration (CI) checks every change automatically: the "
        "code is built and tested as soon as it is pushed. Bugs are found in "
        "minutes instead of weeks, and the team can deliver often and safely.",
    sections: [
      CourseSection(
        title: "What a CI pipeline does",
        body:
            "A pipeline is a list of automated steps triggered on every push "
            "and every pull request: install dependencies, run the linter, run "
            "the unit tests, then build an artifact. If one step fails, the "
            "change is blocked before it reaches the main branch.",
        points: [
          "Run on every push and every pull request.",
          "Typical steps: lint, test, build.",
          "A red pipeline blocks the merge.",
        ],
      ),
      CourseSection(
        title: "Packaging with Docker",
        body:
            "A Dockerfile describes how to build a container image: the base "
            "image, the files to copy, the commands to run and the command "
            "that starts the app. The image runs the same way on a laptop, in "
            "CI and in production.",
        points: [
          "Dockerfile = recipe of the image.",
          "One image, identical in every environment.",
          "Use small official base images.",
        ],
      ),
      CourseSection(
        title: "Secrets in pipelines",
        body:
            "Pipelines often need tokens (registry, cloud, API keys). They "
            "must never be written in the repository. Store them in the "
            "secret store of the CI tool (for example GitHub Actions secrets) "
            "and inject them as environment variables at run time.",
        points: [
          "Never commit a secret, even in a private repository.",
          "Use the CI secret store and environment variables.",
          "Rotate a secret immediately if it leaks.",
        ],
      ),
    ],
    takeaways: [
      "CI runs lint, tests and build on every push and pull request.",
      "A Dockerfile makes the build reproducible everywhere.",
      "Tokens live in the CI secret store, never in Git.",
    ],
  ),
  'devops-2': Course(
    labId: 'devops-2',
    intro:
        "Kubernetes runs containers on a cluster of machines. You describe "
        "the desired state in YAML files, and Kubernetes works continuously "
        "to make reality match it: restarting crashed containers, spreading "
        "load and rolling out new versions.",
    sections: [
      CourseSection(
        title: "Pods and Deployments",
        body:
            "A Pod is the smallest unit: one or more containers that share a "
            "network address. You rarely create Pods directly: a Deployment "
            "declares how many replicas you want and which image to run, and "
            "recreates Pods automatically when one dies.",
        points: [
          "Pod = running container(s).",
          "Deployment = desired number of replicas + image.",
          "Kubernetes heals the cluster to match the desired state.",
        ],
      ),
      CourseSection(
        title: "Services and health checks",
        body:
            "Pods are replaced all the time and their IP addresses change. A "
            "Service gives them a stable name and address and load-balances "
            "between them. A readiness probe tells Kubernetes when a Pod can "
            "receive traffic, and a liveness probe when it must be restarted.",
        points: [
          "Service = stable address in front of the Pods.",
          "Readiness probe = ready to receive traffic?",
          "Liveness probe = still alive, or restart it?",
        ],
      ),
      CourseSection(
        title: "Configuration",
        body:
            "Configuration should not be baked into the image. A ConfigMap "
            "stores non-sensitive settings (URLs, feature flags), and a Secret "
            "stores sensitive values such as passwords. Both are injected into "
            "Pods as environment variables or files.",
        points: [
          "ConfigMap for normal settings.",
          "Secret for passwords and tokens.",
          "The same image runs in every environment.",
        ],
      ),
    ],
    takeaways: [
      "A Deployment keeps the requested number of replicas running.",
      "A Service gives Pods a stable internal address.",
      "Probes control traffic; ConfigMaps and Secrets hold the config.",
    ],
  ),
  'devops-3': Course(
    labId: 'devops-3',
    intro:
        "Users should never notice a deployment. Modern teams release several "
        "times a day without downtime by choosing a progressive deployment "
        "strategy and by watching metrics closely.",
    sections: [
      CourseSection(
        title: "Deployment strategies",
        body:
            "A rolling update replaces instances a few at a time. A canary "
            "release sends the new version to a small share of users first "
            "(for example 5%), then increases if everything is fine. A "
            "blue/green deployment runs two full environments and switches "
            "all traffic at once from the old (blue) to the new (green), "
            "which makes rollback instant.",
        points: [
          "Rolling update: replace instances progressively.",
          "Canary: a small share of users tests the new version.",
          "Blue/green: two environments, instant switch and rollback.",
        ],
      ),
      CourseSection(
        title: "Automatic rollback",
        body:
            "A deployment is only safe if you can detect problems quickly. "
            "Define health signals before deploying: error rate (HTTP 5xx) "
            "and latency are the most important. When they exceed a threshold "
            "after a release, the pipeline rolls back automatically.",
        points: [
          "Watch the error rate and the latency.",
          "Decide thresholds before the deployment.",
          "Roll back first, investigate after.",
        ],
      ),
      CourseSection(
        title: "Monitoring with Prometheus and Grafana",
        body:
            "Prometheus collects metrics from applications and servers at "
            "regular intervals and evaluates alert rules. Grafana turns these "
            "metrics into dashboards. Together they show the health of each "
            "release in real time.",
        points: [
          "Prometheus scrapes and stores metrics.",
          "Alert rules trigger notifications or rollbacks.",
          "Grafana visualizes the metrics.",
        ],
      ),
    ],
    takeaways: [
      "Canary = small share first; blue/green = instant switch.",
      "Error rate and latency trigger automatic rollbacks.",
      "Prometheus collects the metrics, Grafana displays them.",
    ],
  ),

  // ----------------------------------------------------------- Backend
  'backend-1': Course(
    labId: 'backend-1',
    intro:
        "A REST API exposes resources (books, users, orders) through URLs and "
        "standard HTTP methods. A well-designed API is predictable: other "
        "developers can guess how it works without reading the code.",
    sections: [
      CourseSection(
        title: "Resources and HTTP methods",
        body:
            "Each resource has a URL, usually a plural noun: /books and "
            "/books/42. The HTTP method gives the action: GET reads, POST "
            "creates, PUT replaces, PATCH partially updates and DELETE "
            "removes. Verbs never appear in the URL.",
        points: [
          "URL = the resource, method = the action.",
          "POST /books creates a book.",
          "GET /books/42 reads the book 42.",
        ],
      ),
      CourseSection(
        title: "Status codes",
        body:
            "The status code tells the client what happened. 2xx means "
            "success (200 OK, 201 Created, 204 No Content), 4xx means the "
            "client made a mistake (400 Bad Request, 401 Unauthorized, 404 Not "
            "Found) and 5xx means the server failed.",
        points: [
          "201 Created after a successful POST.",
          "404 Not Found when the resource does not exist.",
          "Never answer 200 with an error in the body.",
        ],
      ),
      CourseSection(
        title: "Idempotency",
        body:
            "A method is idempotent when calling it several times has the "
            "same effect as calling it once. GET, PUT and DELETE are "
            "idempotent, so clients can safely retry them after a network "
            "error. POST is not: two calls create two resources.",
        points: [
          "GET, PUT, DELETE: safe to retry.",
          "POST: each call creates something new.",
          "Retries are common on mobile networks.",
        ],
      ),
    ],
    takeaways: [
      "Nouns in URLs, actions in HTTP methods.",
      "201 after creation, 404 when not found.",
      "PUT and DELETE are idempotent, POST is not.",
    ],
  ),
  'backend-2': Course(
    labId: 'backend-2',
    intro:
        "Most backends store their data in a relational database (PostgreSQL, "
        "MySQL). A good schema keeps data consistent, and good queries keep "
        "the application fast and secure.",
    sections: [
      CourseSection(
        title: "Tables and relations",
        body:
            "Each table stores one kind of entity, and foreign keys link "
            "tables together. A user can borrow many books and a book can be "
            "borrowed by many users: this many-to-many relation needs a join "
            "table (for example loans) holding the two foreign keys.",
        points: [
          "One table per entity, one row per item.",
          "Foreign keys link the tables.",
          "Many-to-many → join table.",
        ],
      ),
      CourseSection(
        title: "Indexes and transactions",
        body:
            "Without an index, the database reads every row to find a value. "
            "An index on a searched column (such as isbn) makes lookups "
            "almost instant. A transaction groups several statements that "
            "must all succeed or all be cancelled (ACID): stock and loan stay "
            "consistent even if something fails in the middle.",
        points: [
          "Index the columns you search on.",
          "Transaction = all or nothing.",
          "COMMIT validates, ROLLBACK cancels.",
        ],
      ),
      CourseSection(
        title: "Preventing SQL injection",
        body:
            "Building SQL by concatenating user input lets an attacker change "
            "the query (for example ' OR 1=1 --). Parameterized queries (or "
            "an ORM) send the values separately from the SQL, so they are "
            "never executed as code.",
        points: [
          "Never concatenate user input into SQL.",
          "Use parameterized queries or an ORM.",
          "Validate input on the server side as well.",
        ],
      ),
    ],
    takeaways: [
      "Many-to-many relations use a join table.",
      "Indexes speed up searches; transactions keep data consistent.",
      "Parameterized queries prevent SQL injection.",
    ],
  ),
  'backend-3': Course(
    labId: 'backend-3',
    intro:
        "A production backend must protect user accounts and stay fast when "
        "traffic grows. This course covers password storage, token-based "
        "authentication, caching and background jobs.",
    sections: [
      CourseSection(
        title: "Storing passwords",
        body:
            "Passwords are never stored in clear text, and never with a fast "
            "hash such as MD5 or SHA-1. Use a slow, salted hashing algorithm "
            "made for passwords: bcrypt or Argon2. Even if the database "
            "leaks, the attacker cannot recover the passwords easily.",
        points: [
          "bcrypt or Argon2, with a unique salt.",
          "Never encrypt or store passwords in clear text.",
          "Compare hashes, never the passwords themselves.",
        ],
      ),
      CourseSection(
        title: "Stateless authentication with JWT",
        body:
            "After login, the server returns a signed token (JWT) containing "
            "the user id and an expiry date. The client sends it in the "
            "Authorization header of every request. The server checks the "
            "signature without storing sessions, so any instance can handle "
            "any request.",
        points: [
          "Authorization: Bearer <token> on each request.",
          "The signature proves the token was not modified.",
          "Keep tokens short-lived and send them over HTTPS only.",
        ],
      ),
      CourseSection(
        title: "Caching and background jobs",
        body:
            "Data read thousands of times should not hit the database every "
            "time: a cache such as Redis keeps it in memory, and a CDN can "
            "cache public pages. Slow tasks like sending emails go to a "
            "message queue; a worker processes them in the background so the "
            "request answers immediately.",
        points: [
          "Redis cache for hot data, CDN for public content.",
          "Queue + worker for slow tasks.",
          "Answer the user first, process later.",
        ],
      ),
    ],
    takeaways: [
      "Hash passwords with bcrypt or Argon2.",
      "JWT in the Authorization header for a stateless API.",
      "Cache hot data, move slow work to a queue.",
    ],
  ),

  // ---------------------------------------------------------- Security
  'cyber-1': Course(
    labId: 'cyber-1',
    intro:
        "Phishing is the most common way attackers get into a company: a "
        "fake email tricks someone into clicking a link or giving a "
        "password. Recognizing it and reacting fast are core skills of a "
        "security analyst.",
    sections: [
      CourseSection(
        title: "Recognizing phishing",
        body:
            "Phishing emails create urgency (\"your account will be closed "
            "today\"), imitate a known brand or colleague, and use a sender "
            "domain or link that looks almost right (micros0ft-support.com). "
            "They often ask for credentials or payment.",
        points: [
          "Urgency and pressure are red flags.",
          "Check the real sender domain, not the display name.",
          "Unexpected attachments or login requests = suspicious.",
        ],
      ),
      CourseSection(
        title: "Checking a link safely",
        body:
            "Hover over a link (or long-press on mobile) to see the real "
            "address before clicking. Compare the domain carefully. When in "
            "doubt, go to the website by typing its address yourself, or "
            "analyze the link in a sandbox such as VirusTotal.",
        points: [
          "Hover to read the real URL.",
          "Look at the domain just before the first \"/\".",
          "Never open a suspicious link to \"test\" it.",
        ],
      ),
      CourseSection(
        title: "Reacting and preventing",
        body:
            "If someone entered a password on a phishing page, change it "
            "immediately, close active sessions and alert the security team. "
            "Multi-factor authentication (MFA) blocks most attacks with stolen "
            "passwords, because the attacker also needs the second factor.",
        points: [
          "Reset the password and revoke the sessions first.",
          "Report the email so others are protected.",
          "MFA stops most stolen-password attacks.",
        ],
      ),
    ],
    takeaways: [
      "Urgency + look-alike domain = probable phishing.",
      "Hover links, never test them by clicking.",
      "Reset the password at once; MFA is the best prevention.",
    ],
  ),
  'cyber-2': Course(
    labId: 'cyber-2',
    intro:
        "Securing a network means knowing what is exposed, blocking "
        "everything that is not needed and giving remote access safely. "
        "Attackers look for the weakest point, so defenses must be layered.",
    sections: [
      CourseSection(
        title: "Mapping the attack surface",
        body:
            "Nmap scans a server or a network and lists open ports and the "
            "services behind them (SSH on 22, HTTP on 80…). Every open port "
            "is a potential entry point: close what is not needed and only "
            "scan systems you are authorized to test.",
        points: [
          "Nmap lists open ports and services.",
          "Fewer open ports = smaller attack surface.",
          "Only scan with authorization.",
        ],
      ),
      CourseSection(
        title: "Firewalls: deny by default",
        body:
            "A firewall filters traffic with rules. The safe approach is "
            "\"deny by default\": block all incoming traffic, then allow only "
            "the ports and sources that are needed. Network segmentation "
            "(separate zones for servers, users and guests) limits how far an "
            "attacker can move.",
        points: [
          "Default incoming policy: deny.",
          "Allow only what is explicitly needed.",
          "Segment the network into zones.",
        ],
      ),
      CourseSection(
        title: "Remote access and hygiene",
        body:
            "Never expose internal services such as RDP directly to the "
            "Internet. Remote employees connect through a VPN (or a Zero Trust "
            "access solution) with MFA. Applying security patches quickly and "
            "removing unused services eliminate most known vulnerabilities.",
        points: [
          "VPN or Zero Trust with MFA for remote access.",
          "Patch systems regularly.",
          "Disable services that are not used.",
        ],
      ),
    ],
    takeaways: [
      "Nmap shows what is exposed.",
      "Firewall: deny by default, allow the minimum.",
      "VPN + MFA for remote work, patches for hygiene.",
    ],
  ),
  'cyber-3': Course(
    labId: 'cyber-3',
    intro:
        "Ransomware encrypts files and demands a payment. A good response "
        "follows a clear process so that damage stays limited, evidence is "
        "preserved and the company can recover without paying.",
    sections: [
      CourseSection(
        title: "The incident response lifecycle",
        body:
            "The NIST lifecycle has four phases: preparation; detection and "
            "analysis; containment, eradication and recovery; and post-incident "
            "activity (lessons learned). When ransomware is detected, the "
            "first step is containment: isolate the infected machines from "
            "the network to stop the spread, without turning them off.",
        points: [
          "Isolate first to stop the spread.",
          "Do not power off: memory holds evidence.",
          "Follow the incident response plan.",
        ],
      ),
      CourseSection(
        title: "Investigating",
        body:
            "Analysts rebuild the timeline of the attack: how the attacker "
            "got in, which accounts were used and which machines were "
            "touched. System and security logs, EDR alerts and network "
            "traffic are the main sources of evidence.",
        points: [
          "Collect logs before they are overwritten.",
          "EDR and network traces reveal the attacker's path.",
          "Find the entry point to close it.",
        ],
      ),
      CourseSection(
        title: "Recovering and learning",
        body:
            "Offline or immutable backups, tested regularly, allow recovery "
            "without paying the ransom. The 3-2-1 rule helps: 3 copies, on 2 "
            "different media, 1 off-site. After recovery, a post-incident "
            "review identifies what to improve so it does not happen again.",
        points: [
          "3-2-1 backups, with at least one offline copy.",
          "Test restores regularly.",
          "Lessons learned close the lifecycle.",
        ],
      ),
    ],
    takeaways: [
      "Contain first: isolate infected machines.",
      "Logs, EDR and network traces drive the investigation.",
      "Offline backups make recovery possible; then learn lessons.",
    ],
  ),
};

/// Concrete examples shared by every language (one entry per section).
const courseExamples = <String, List<String?>>{
  'cloud-1': [
    "Auto Scaling group\n"
        "  min: 2   desired: 2   max: 10\n"
        "  subnets: eu-west-3a, eu-west-3b\n"
        "  scale out when CPU > 60%",
    "s3://shop-assets/images/product-42.jpg\n"
        "RDS PostgreSQL  ·  Multi-AZ: enabled",
    "User (Tunis) → CloudFront edge → ALB → EC2",
  ],
  'cloud-2': [
    '{\n'
        '  "Effect": "Allow",\n'
        '  "Action": "s3:GetObject",\n'
        '  "Resource": "arn:aws:s3:::shop-assets/*"\n'
        '}',
    null,
    "aws cloudtrail lookup-events \\\n"
        "  --lookup-attributes AttributeKey=Username,AttributeValue=alice",
  ],
  'cloud-3': [
    "Batch job   → Spot (up to -90%)\n"
        "Production  → Savings Plan 3 years (up to -72%)\n"
        "Tests       → On-Demand",
    "Lifecycle rule \"logs/\"\n"
        "  after 30 days  → S3 Standard-IA\n"
        "  after 90 days  → S3 Glacier\n"
        "  after 5 years  → delete",
    null,
  ],
  'devops-1': [
    "on: [push, pull_request]\n"
        "jobs:\n"
        "  build:\n"
        "    runs-on: ubuntu-latest\n"
        "    steps:\n"
        "      - uses: actions/checkout@v4\n"
        "      - run: npm ci\n"
        "      - run: npm run lint\n"
        "      - run: npm test",
    "FROM node:20-alpine\n"
        "WORKDIR /app\n"
        "COPY package*.json ./\n"
        "RUN npm ci --omit=dev\n"
        "COPY . .\n"
        "CMD [\"node\", \"server.js\"]",
    "- run: docker login -u ci -p \"\$REGISTRY_TOKEN\"\n"
        "  env:\n"
        "    REGISTRY_TOKEN: \${{ secrets.REGISTRY_TOKEN }}",
  ],
  'devops-2': [
    "kind: Deployment\n"
        "metadata:\n"
        "  name: api\n"
        "spec:\n"
        "  replicas: 3\n"
        "  template:\n"
        "    spec:\n"
        "      containers:\n"
        "        - name: api\n"
        "          image: shop/api:1.4.0",
    "kind: Service\n"
        "spec:\n"
        "  selector: { app: api }\n"
        "  ports: [{ port: 80, targetPort: 8080 }]\n"
        "---\n"
        "readinessProbe:\n"
        "  httpGet: { path: /health, port: 8080 }",
    "kind: ConfigMap\n"
        "data:\n"
        "  API_URL: https://api.shop.com\n"
        "  FEATURE_NEW_CART: \"true\"",
  ],
  'devops-3': [
    "v1 ███████████████████ 95%\n"
        "v2 █ 5%   (canary)\n"
        "→ errors OK → 25% → 50% → 100%",
    "if error_rate(5xx) > 2% for 5 min\n"
        "   or p95 latency > 800 ms\n"
        "then rollback to previous version",
    "rate(http_requests_total{status=~\"5..\"}[5m])\n"
        "  / rate(http_requests_total[5m]) > 0.02",
  ],
  'backend-1': [
    "GET    /books       → list the books\n"
        "POST   /books       → create a book\n"
        "GET    /books/42    → read book 42\n"
        "PUT    /books/42    → replace book 42\n"
        "DELETE /books/42    → delete book 42",
    "POST /books  → 201 Created\n"
        "Location: /books/43\n\n"
        "GET /books/999  → 404 Not Found",
    null,
  ],
  'backend-2': [
    "users(id, name)\n"
        "books(id, title, isbn, stock)\n"
        "loans(user_id → users.id, book_id → books.id, date)",
    "CREATE INDEX idx_books_isbn ON books(isbn);\n\n"
        "BEGIN;\n"
        "UPDATE books SET stock = stock - 1 WHERE id = 42;\n"
        "INSERT INTO loans(user_id, book_id) VALUES (7, 42);\n"
        "COMMIT;",
    "// Dangerous\n"
        "db.query(\"SELECT * FROM users WHERE email = '\" + email + \"'\");\n\n"
        "// Safe\n"
        "db.query(\"SELECT * FROM users WHERE email = \$1\", [email]);",
  ],
  'backend-3': [
    "hash = bcrypt.hash(password, cost: 12)\n"
        "bcrypt.verify(input, hash) → true / false",
    "GET /me\n"
        "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9...",
    "book = redis.get(\"book:42\")\n"
        "if book == null:\n"
        "    book = db.find(42)\n"
        "    redis.set(\"book:42\", book, ttl: 300)",
  ],
  'cyber-1': [
    "From: Microsoft Support <security@micros0ft-support.com>\n"
        "Subject: URGENT – your account will be closed today",
    "Displayed:  https://login.microsoft.com\n"
        "Real link:  https://login.microsoft.com.secure-check.xyz/...",
    null,
  ],
  'cyber-2': [
    "\$ nmap -sV 192.168.1.10\n"
        "22/tcp   open  ssh     OpenSSH 8.9\n"
        "80/tcp   open  http    nginx 1.24\n"
        "3389/tcp open  ms-wbt-server",
    "ufw default deny incoming\n"
        "ufw default allow outgoing\n"
        "ufw allow 443/tcp\n"
        "ufw allow from 10.0.0.0/24 to any port 22",
    null,
  ],
  'cyber-3': [
    "1. Preparation\n"
        "2. Detection & analysis\n"
        "3. Containment → eradication → recovery\n"
        "4. Post-incident activity",
    null,
    "3 copies · 2 media · 1 off-site (offline / immutable)",
  ],
};

const _coursesByLanguage = <String, Map<String, Course>>{
  'en': coursesEn,
  'fr': coursesFr,
  'ar': coursesAr,
};

final _resolved = <String, Course?>{};

/// Course of [labId] in the current catalog language (English fallback),
/// with the shared examples attached.
Course? courseFor(String labId) =>
    _resolved.putIfAbsent('$catalogLanguage/$labId', () {
      final course =
          _coursesByLanguage[catalogLanguage]?[labId] ?? coursesEn[labId];
      if (course == null) return null;
      final examples = courseExamples[labId] ?? const [];
      return Course(
        labId: course.labId,
        intro: course.intro,
        sections: [
          for (var i = 0; i < course.sections.length; i++)
            course.sections[i].withExample(
              i < examples.length ? examples[i] : null,
            ),
        ],
        takeaways: course.takeaways,
      );
    });
