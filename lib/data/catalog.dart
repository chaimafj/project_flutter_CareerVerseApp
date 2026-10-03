import 'package:flutter/material.dart';

import '../models/career.dart';

/// Career catalog used by the whole app. Salaries are indicative gross yearly
/// ranges for France (junior → confirmed), based on public job-market surveys.
const careers = <Career>[
  Career(
    id: 'cloud',
    title: 'Cloud Engineer',
    summary: 'Design, deploy and operate scalable infrastructure on AWS.',
    description:
        'Cloud engineers design and run the infrastructure that hosts modern '
        'applications. They pick the right managed services, secure access '
        'with IAM, automate deployments with Infrastructure as Code and keep '
        'costs and availability under control.',
    icon: Icons.cloud_outlined,
    color: Color(0xFF1677FF),
    tools: ['AWS', 'Terraform', 'Linux', 'Docker'],
    tags: ['Technology', 'Infrastructure', 'Problem solving'],
    salary: '40k – 65k € / year',
    outlook: 'Very high demand: cloud adoption keeps growing every year.',
    education: 'Bac+3 to Bac+5 in computer science or networks',
    dailyTasks: [
      'Design highly available architectures',
      'Write Terraform / CloudFormation templates',
      'Monitor cost and performance',
      'Manage IAM permissions and security',
    ],
    labs: [
      Lab(
        id: 'cloud-1',
        title: 'Deploy a scalable web app',
        scenario:
            'A startup wants to host its e-commerce website on AWS. Traffic '
            'is unpredictable and the site must survive the loss of a data '
            'center. Choose the right services.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt:
                'Which services should host the web tier so that it scales '
                'automatically with traffic? (select 2)',
            options: [
              'EC2 instances in an Auto Scaling group',
              'Application Load Balancer',
              'A single large EC2 instance',
              'Amazon S3 Glacier',
            ],
            correct: {0, 1},
            skill: 'Architecture',
            explanation:
                'An Application Load Balancer spreads requests across EC2 '
                'instances managed by an Auto Scaling group, which adds or '
                'removes instances depending on the load.',
          ),
          LabQuestion(
            prompt: 'Where should product images and static files be stored?',
            options: ['Amazon S3', 'Amazon RDS', 'EC2 instance store', 'IAM'],
            correct: {0},
            skill: 'Storage',
            explanation:
                'S3 is durable, cheap object storage made for static assets, '
                'and can be served through CloudFront.',
          ),
          LabQuestion(
            prompt:
                'How do you make the database survive the failure of an '
                'Availability Zone?',
            options: [
              'Enable RDS Multi-AZ deployment',
              'Take a manual snapshot once a month',
              'Use a bigger instance type',
              'Store the database on the web server',
            ],
            correct: {0},
            skill: 'Reliability',
            explanation:
                'Multi-AZ keeps a synchronous standby in another AZ and fails '
                'over automatically.',
          ),
          LabQuestion(
            prompt:
                'Which service gives a global CDN in front of the website to '
                'reduce latency?',
            options: [
              'Amazon CloudFront',
              'AWS Lambda',
              'Amazon SQS',
              'AWS IAM',
            ],
            correct: {0},
            skill: 'Architecture',
            explanation:
                'CloudFront caches content in edge locations close to users.',
          ),
        ],
      ),
      Lab(
        id: 'cloud-2',
        title: 'Secure access with IAM',
        scenario:
            'The team is growing. You must give developers and applications '
            'access to AWS without exposing the account.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'An EC2 application must read an S3 bucket. Best option?',
            options: [
              'Attach an IAM role to the instance',
              'Store access keys in the source code',
              'Use the root account keys',
              'Make the bucket public',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'IAM roles provide temporary credentials automatically: no '
                'secret is stored on the server.',
          ),
          LabQuestion(
            prompt: 'Which principle should guide IAM policies?',
            options: [
              'Least privilege',
              'Full access for everyone',
              'One shared user for the team',
              'Disable logging',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'Grant only the permissions needed for the task, nothing more.',
          ),
          LabQuestion(
            prompt: 'How do you protect the root account? (select 2)',
            options: [
              'Enable MFA',
              'Do not use it for daily tasks',
              'Share its password with admins',
              'Create access keys for it',
            ],
            correct: {0, 1},
            skill: 'Security',
            explanation:
                'Root must have MFA and be kept for the rare tasks that '
                'require it. Daily work uses IAM users or SSO.',
          ),
          LabQuestion(
            prompt: 'Which service records every API call for auditing?',
            options: ['AWS CloudTrail', 'Amazon EBS', 'Route 53', 'Amazon SNS'],
            correct: {0},
            skill: 'Monitoring',
            explanation:
                'CloudTrail logs who did what and when on the account.',
          ),
        ],
      ),
      Lab(
        id: 'cloud-3',
        title: 'Optimize cost & reliability',
        scenario:
            'The monthly AWS bill doubled. Reduce costs without lowering the '
            'availability of production.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt:
                'A batch job can be interrupted and restarted. Cheapest '
                'compute option?',
            options: [
              'EC2 Spot Instances',
              'On-Demand instances',
              'Dedicated hosts',
              'Bigger instances',
            ],
            correct: {0},
            skill: 'Cost optimization',
            explanation:
                'Spot instances are up to 90% cheaper and fit interruptible '
                'workloads.',
          ),
          LabQuestion(
            prompt:
                'Production runs 24/7 for the next 3 years. What saves money?',
            options: [
              'Savings Plans / Reserved Instances',
              'Spot Instances only',
              'Stopping the servers at night',
              'Moving to a single AZ',
            ],
            correct: {0},
            skill: 'Cost optimization',
            explanation: 'A 1 or 3 year commitment gives large discounts on steady usage.',
          ),
          LabQuestion(
            prompt:
                'Old logs are rarely read but must be kept 5 years. Solution?',
            options: [
              'S3 lifecycle rule to Glacier',
              'Keep them on EBS volumes',
              'Delete them',
              'Store them in RDS',
            ],
            correct: {0},
            skill: 'Storage',
            explanation:
                'Lifecycle rules move cold data to Glacier automatically at a '
                'fraction of the price.',
          ),
          LabQuestion(
            prompt: 'Which tools help you detect cost anomalies? (select 2)',
            options: [
              'AWS Budgets alerts',
              'Cost Explorer',
              'Amazon Polly',
              'AWS Snowball',
            ],
            correct: {0, 1},
            skill: 'Monitoring',
            explanation:
                'Cost Explorer analyzes spending; Budgets sends alerts when a '
                'threshold is exceeded.',
          ),
        ],
      ),
    ],
  ),
  Career(
    id: 'devops',
    title: 'DevOps Engineer',
    summary: 'Automate builds, tests and deployments from code to production.',
    description:
        'DevOps engineers bridge development and operations. They build CI/CD '
        'pipelines, containerize applications, orchestrate them with '
        'Kubernetes and make releases fast, safe and repeatable.',
    icon: Icons.all_inclusive,
    color: Color(0xFF633BFF),
    tools: ['GitHub Actions', 'Docker', 'Kubernetes', 'Prometheus'],
    tags: ['Technology', 'Automation', 'Collaboration'],
    salary: '42k – 65k € / year',
    outlook: 'High demand in startups, scale-ups and large companies.',
    education: 'Bac+3 to Bac+5 in software engineering or systems',
    dailyTasks: [
      'Maintain CI/CD pipelines',
      'Build and secure container images',
      'Operate Kubernetes clusters',
      'Set up monitoring and alerting',
    ],
    labs: [
      Lab(
        id: 'devops-1',
        title: 'Build a CI pipeline',
        scenario:
            'Developers push code several times a day and bugs reach '
            'production. Design a continuous integration pipeline.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'When should the CI pipeline run?',
            options: [
              'On every push and pull request',
              'Once a month',
              'Only before vacations',
              'Never, tests are done manually',
            ],
            correct: {0},
            skill: 'CI/CD',
            explanation: 'Running on every change detects regressions as early as possible.',
          ),
          LabQuestion(
            prompt: 'Which steps belong in a CI pipeline? (select 2)',
            options: [
              'Run automated tests',
              'Lint / static analysis',
              'Delete the production database',
              'Email the code to the manager',
            ],
            correct: {0, 1},
            skill: 'CI/CD',
            explanation: 'Lint and tests are the core quality gates of CI.',
          ),
          LabQuestion(
            prompt: 'What file describes how to build a container image?',
            options: ['Dockerfile', 'package.lock', 'README.md', '.gitignore'],
            correct: {0},
            skill: 'Containers',
            explanation:
                'A Dockerfile lists the instructions used by docker build.',
          ),
          LabQuestion(
            prompt: 'Where should API tokens used by the pipeline be stored?',
            options: [
              'In the CI secret store',
              'In the repository in clear text',
              'In the commit message',
              'In the Docker image',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'Secrets must be injected at runtime from an encrypted store.',
          ),
        ],
      ),
      Lab(
        id: 'devops-2',
        title: 'Run containers on Kubernetes',
        scenario:
            'Your API must run on Kubernetes with 3 replicas and be reachable '
            'by other services.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'Which object keeps 3 replicas of the API running?',
            options: ['Deployment', 'ConfigMap', 'Namespace', 'Secret'],
            correct: {0},
            skill: 'Kubernetes',
            explanation:
                'A Deployment manages a ReplicaSet that maintains the desired '
                'number of pods.',
          ),
          LabQuestion(
            prompt: 'Which object gives the pods a stable internal address?',
            options: ['Service', 'Pod', 'Volume', 'Job'],
            correct: {0},
            skill: 'Kubernetes',
            explanation: 'A Service exposes a stable DNS name and load-balances to pods.',
          ),
          LabQuestion(
            prompt:
                'How does Kubernetes know when a pod is ready to receive '
                'traffic?',
            options: ['Readiness probe', 'Pod name', 'Image tag', 'Node label'],
            correct: {0},
            skill: 'Reliability',
            explanation:
                'The readiness probe removes the pod from the Service until it '
                'answers correctly.',
          ),
          LabQuestion(
            prompt: 'Where do you store non-sensitive configuration? ',
            options: ['ConfigMap', 'Secret', 'Dockerfile', 'Ingress'],
            correct: {0},
            skill: 'Kubernetes',
            explanation:
                'ConfigMaps hold plain configuration; Secrets are for '
                'sensitive data.',
          ),
        ],
      ),
      Lab(
        id: 'devops-3',
        title: 'Zero-downtime deployments',
        scenario:
            'A new version must be released during business hours without '
            'interrupting users, and must be easy to roll back.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt:
                'Which strategy sends the new version to a small share of '
                'users first?',
            options: ['Canary release', 'Big bang', 'Recreate', 'Manual copy'],
            correct: {0},
            skill: 'CI/CD',
            explanation:
                'Canary releases expose a small percentage of traffic and '
                'grow it progressively.',
          ),
          LabQuestion(
            prompt: 'Blue/green deployment means…',
            options: [
              'Two identical environments, traffic is switched at once',
              'Deploying only on Mondays',
              'Using two Git branches',
              'Coloring the logs',
            ],
            correct: {0},
            skill: 'CI/CD',
            explanation:
                'Rollback is instant: just switch traffic back to blue.',
          ),
          LabQuestion(
            prompt: 'Which signals should trigger an automatic rollback? (select 2)',
            options: [
              'Error rate increase',
              'Latency spike',
              'New commit on main',
              'Developer goes home',
            ],
            correct: {0, 1},
            skill: 'Monitoring',
            explanation: 'Error rate and latency are key SLO indicators of a bad release.',
          ),
          LabQuestion(
            prompt: 'Which tool collects metrics for those alerts?',
            options: ['Prometheus', 'Photoshop', 'Excel', 'Jira'],
            correct: {0},
            skill: 'Monitoring',
            explanation:
                'Prometheus scrapes metrics and evaluates alerting rules.',
          ),
        ],
      ),
    ],
  ),
  Career(
    id: 'backend',
    title: 'Backend Developer',
    summary: 'Build APIs, business logic and databases behind applications.',
    description:
        'Backend developers write the server-side code of applications: REST '
        'APIs, data models, authentication and performance. They work with '
        'databases, caches and message queues.',
    icon: Icons.storage_rounded,
    color: Color(0xFF10A37F),
    tools: ['Node.js', 'PostgreSQL', 'Redis', 'Git'],
    tags: ['Technology', 'Logic', 'Data'],
    salary: '35k – 60k € / year',
    outlook: 'Stable and strong demand in every sector.',
    education: 'Bac+2 to Bac+5 in software development',
    dailyTasks: [
      'Design and implement REST APIs',
      'Model data in SQL databases',
      'Write unit and integration tests',
      'Review teammates’ code',
    ],
    labs: [
      Lab(
        id: 'backend-1',
        title: 'Design a REST API',
        scenario:
            'You build the API of a library app: books can be listed, '
            'created, updated and deleted.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'Which HTTP method creates a new book?',
            options: [
              'POST /books',
              'GET /books',
              'DELETE /books',
              'HEAD /books',
            ],
            correct: {0},
            skill: 'API design',
            explanation: 'POST on a collection creates a new resource.',
          ),
          LabQuestion(
            prompt:
                'Which status code is returned after a successful creation?',
            options: [
              '201 Created',
              '404 Not Found',
              '500 Server Error',
              '302 Found',
            ],
            correct: {0},
            skill: 'API design',
            explanation: '201 indicates that a resource has been created.',
          ),
          LabQuestion(
            prompt: 'The requested book id does not exist. Status code?',
            options: ['404 Not Found', '200 OK', '201 Created', '418'],
            correct: {0},
            skill: 'API design',
            explanation: '404 means the resource could not be found.',
          ),
          LabQuestion(
            prompt: 'Which methods are idempotent? (select 2)',
            options: ['PUT', 'DELETE', 'POST', 'PATCH (always)'],
            correct: {0, 1},
            skill: 'API design',
            explanation: 'Calling PUT or DELETE several times produces the same final state.',
          ),
        ],
      ),
      Lab(
        id: 'backend-2',
        title: 'Model a relational database',
        scenario:
            'Each user can borrow many books, and each book can be borrowed '
            'by many users over time.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'How do you model the users ↔ books relation?',
            options: [
              'A join table "loans" with two foreign keys',
              'A comma-separated list in the users table',
              'Duplicate the book in each user row',
              'One table per user',
            ],
            correct: {0},
            skill: 'Databases',
            explanation: 'Many-to-many relations use an association table.',
          ),
          LabQuestion(
            prompt: 'Searching books by ISBN is slow. What helps most?',
            options: [
              'Create an index on isbn',
              'Add more columns',
              'Use SELECT *',
              'Restart the server daily',
            ],
            correct: {0},
            skill: 'Performance',
            explanation: 'An index avoids a full table scan.',
          ),
          LabQuestion(
            prompt:
                'A loan must decrease stock and insert a row, or do nothing. '
                'Which feature?',
            options: [
              'A transaction',
              'A view',
              'A comment',
              'A trigger on SELECT',
            ],
            correct: {0},
            skill: 'Databases',
            explanation:
                'Transactions are atomic: all statements succeed or none.',
          ),
          LabQuestion(
            prompt: 'How do you prevent SQL injection?',
            options: [
              'Parameterized queries',
              'String concatenation',
              'Hiding the error messages',
              'Using uppercase SQL',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'Parameters are sent separately from the SQL text, so input is '
                'never executed.',
          ),
        ],
      ),
      Lab(
        id: 'backend-3',
        title: 'Authentication & performance',
        scenario:
            'The API becomes popular: secure user accounts and handle 10× '
            'more traffic.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'How should passwords be stored?',
            options: [
              'Hashed with bcrypt / Argon2 and a salt',
              'In clear text',
              'Encrypted with a key stored in the code',
              'Base64 encoded',
            ],
            correct: {0},
            skill: 'Security',
            explanation:
                'Slow salted hashes make leaked passwords very hard to crack.',
          ),
          LabQuestion(
            prompt: 'A stateless API authenticates requests with…',
            options: [
              'Signed JWT tokens',
              'Server RAM sessions only',
              'The IP address',
              'Cookies without signature',
            ],
            correct: {0},
            skill: 'Security',
            explanation: 'A signed token can be verified by any instance without shared state.',
          ),
          LabQuestion(
            prompt: 'Popular book pages are read thousands of times. Solution? (select 2)',
            options: [
              'Cache responses in Redis',
              'Use HTTP caching headers',
              'Query the database twice',
              'Disable pagination',
            ],
            correct: {0, 1},
            skill: 'Performance',
            explanation: 'Server-side and HTTP caches avoid recomputing identical responses.',
          ),
          LabQuestion(
            prompt: 'Sending emails slows down requests. What do you do?',
            options: [
              'Push the task to a message queue and process it asynchronously',
              'Send emails in a loop inside the request',
              'Remove emails',
              'Increase the timeout',
            ],
            correct: {0},
            skill: 'Performance',
            explanation:
                'Queues decouple slow work from the request/response cycle.',
          ),
        ],
      ),
    ],
  ),
  Career(
    id: 'cyber',
    title: 'Cybersecurity Analyst',
    summary: 'Protect systems, detect attacks and respond to incidents.',
    description:
        'Cybersecurity analysts monitor networks and systems, investigate '
        'alerts, and respond to incidents. They raise awareness, harden '
        'configurations and help the company comply with security standards.',
    icon: Icons.shield_outlined,
    color: Color(0xFFE5484D),
    tools: ['SIEM', 'Wireshark', 'Nmap', 'MITRE ATT&CK'],
    tags: ['Technology', 'Security', 'Investigation'],
    salary: '40k – 70k € / year',
    outlook: 'Critical shortage of profiles: excellent job prospects.',
    education: 'Bac+3 to Bac+5 in cybersecurity or networks',
    dailyTasks: [
      'Analyze security alerts in the SIEM',
      'Investigate suspicious emails',
      'Run vulnerability scans',
      'Write incident reports',
    ],
    labs: [
      Lab(
        id: 'cyber-1',
        title: 'Detect a phishing attack',
        scenario:
            'An employee forwards a suspicious email asking to "verify the '
            'account within 24h". Analyze it.',
        level: 'Beginner',
        questions: [
          LabQuestion(
            prompt: 'Which signs indicate phishing? (select 2)',
            options: [
              'Sender domain slightly misspelled',
              'Urgency and threat of account closure',
              'Email sent during business hours',
              'Company logo present',
            ],
            correct: {0, 1},
            skill: 'Threat detection',
            explanation: 'Look-alike domains and pressure tactics are classic phishing signs.',
          ),
          LabQuestion(
            prompt: 'How do you check a link safely?',
            options: [
              'Hover it to read the real URL without clicking',
              'Click it to see',
              'Reply to the sender',
              'Forward it to everyone',
            ],
            correct: {0},
            skill: 'Threat detection',
            explanation:
                'Hovering shows the real destination without visiting it.',
          ),
          LabQuestion(
            prompt: 'The employee already typed the password. First action?',
            options: [
              'Reset the password and revoke sessions',
              'Wait and see',
              'Delete the email only',
              'Turn off the screen',
            ],
            correct: {0},
            skill: 'Incident response',
            explanation:
                'Credentials are compromised: invalidate them immediately.',
          ),
          LabQuestion(
            prompt: 'Which control blocks most stolen-password attacks?',
            options: [
              'Multi-factor authentication',
              'Longer email signatures',
              'Screen savers',
              'Antivirus only',
            ],
            correct: {0},
            skill: 'Defense',
            explanation:
                'With MFA, a stolen password alone is not enough to log in.',
          ),
        ],
      ),
      Lab(
        id: 'cyber-2',
        title: 'Secure a company network',
        scenario:
            'A small company exposes several services on the Internet. Reduce '
            'its attack surface.',
        level: 'Intermediate',
        questions: [
          LabQuestion(
            prompt: 'Which tool lists the open ports of a server?',
            options: ['Nmap', 'Excel', 'Paint', 'Git'],
            correct: {0},
            skill: 'Network',
            explanation:
                'Nmap scans hosts and reports open ports and services.',
          ),
          LabQuestion(
            prompt: 'Default firewall policy for incoming traffic?',
            options: [
              'Deny all, then allow what is needed',
              'Allow all',
              'Allow all except port 80',
              'No firewall',
            ],
            correct: {0},
            skill: 'Defense',
            explanation: 'Default-deny minimizes exposure.',
          ),
          LabQuestion(
            prompt: 'Remote employees need internal access. Best option?',
            options: [
              'A VPN with MFA',
              'Open RDP to the Internet',
              'Share an admin password',
              'Disable the firewall at night',
            ],
            correct: {0},
            skill: 'Network',
            explanation:
                'A VPN encrypts traffic and keeps internal services private.',
          ),
          LabQuestion(
            prompt: 'Which practices reduce vulnerabilities? (select 2)',
            options: [
              'Apply security patches regularly',
              'Segment the network',
              'Use the same password everywhere',
              'Disable logs to save space',
            ],
            correct: {0, 1},
            skill: 'Defense',
            explanation: 'Patching fixes known flaws; segmentation limits lateral movement.',
          ),
        ],
      ),
      Lab(
        id: 'cyber-3',
        title: 'Respond to a ransomware incident',
        scenario:
            'Files on a file server are being encrypted and a ransom note '
            'appears. Lead the response.',
        level: 'Advanced',
        questions: [
          LabQuestion(
            prompt: 'What is the very first step?',
            options: [
              'Isolate the infected machines from the network',
              'Pay the ransom',
              'Reboot every server',
              'Post on social media',
            ],
            correct: {0},
            skill: 'Incident response',
            explanation:
                'Containment stops the spread before eradication and recovery.',
          ),
          LabQuestion(
            prompt: 'What makes recovery possible without paying?',
            options: [
              'Offline / immutable backups',
              'A bigger hard drive',
              'The recycle bin',
              'Screenshots of the files',
            ],
            correct: {0},
            skill: 'Defense',
            explanation:
                'Backups that ransomware cannot reach allow a clean restore.',
          ),
          LabQuestion(
            prompt: 'Which data helps the investigation? (select 2)',
            options: [
              'SIEM and system logs',
              'Memory and disk images',
              'The office playlist',
              'Coffee machine logs',
            ],
            correct: {0, 1},
            skill: 'Threat detection',
            explanation:
                'Logs and forensic images reveal the entry point and timeline.',
          ),
          LabQuestion(
            prompt: 'In the incident lifecycle, what comes after recovery?',
            options: [
              'Lessons learned',
              'Detection',
              'Preparation is skipped',
              'Nothing',
            ],
            correct: {0},
            skill: 'Incident response',
            explanation:
                'A post-incident review improves defenses for the next time.',
          ),
        ],
      ),
    ],
  ),
];

const allInterests = [
  'Cloud',
  'DevOps',
  'Programming',
  'Security',
  'Networks',
  'Data',
  'Automation',
  'Problem solving',
  'Teamwork',
  'Design',
];

const studyLevels = [
  'High school',
  'Bac+1',
  'Bac+2',
  'Bac+3 (Licence)',
  'Bac+4',
  'Bac+5 (Master / Engineer)',
  'Graduate',
];

/// Interests that make a user naturally fit each career.
const careerInterests = <String, List<String>>{
  'cloud': ['Cloud', 'Networks', 'Automation', 'Problem solving'],
  'devops': ['DevOps', 'Automation', 'Cloud', 'Teamwork'],
  'backend': ['Programming', 'Data', 'Problem solving', 'Design'],
  'cyber': ['Security', 'Networks', 'Problem solving', 'Data'],
};

Career? careerById(String id) {
  for (final career in careers) {
    if (career.id == id) return career;
  }
  return null;
}

(Career, Lab)? findLab(String labId) {
  for (final career in careers) {
    for (final lab in career.labs) {
      if (lab.id == labId) return (career, lab);
    }
  }
  return null;
}
