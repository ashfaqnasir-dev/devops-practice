# 07.03 Triggers in Azure Pipelines

Triggers determine karte hain ke pipeline **kab aur kis event par automatically run hogi**. 

---

## 📌 Summary Table

| Trigger Type | Event / Purpose | Main Syntax Key |
| :--- | :--- | :--- |
| **07.03.01 Branch Triggers** | Specific branches par push/commit hone par | `trigger: branches:` |
| **07.03.02 Path Triggers** | Files ya folders include/exclude karne par | `trigger: paths:` |
| **07.03.03 PR Triggers** | Pull Request create ya update hone par | `pr:` |
| **07.03.04 Scheduled Triggers** | Cron time schedule (e.g., nightly builds) par | `schedules:` |
| **07.03.05 Pipeline Triggers** | Ek pipeline complete hone ke baad doosri run karne par | `resources: pipelines:` |

---

## 07.03.01 Branch Triggers (Push Triggers)

### Explanation
Yeh sabse common trigger hai (Continuous Integration / CI). Jab bhi specified branch par naya code push ya merge hota hai, pipeline automatically start ho jati hai. Aap specific branches ko `include` ya `exclude` kar sakte hain aur wildcards (`*`) bhi use kar sakte hain.

### YAML Example
```yaml
# Specific branches par trigger
trigger:
  branches:
    include:
      - main
      - releases/*       # Sabhi release branches (e.g., releases/v1.0)
    exclude:
      - feature/wip-*    # WIP (work in progress) branches ignore hongi

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: echo "Code pushed to target branch!"
    displayName: 'Branch Trigger Run'
```

---

## 07.03.02 Path Triggers (File & Folder Filters)

### Explanation
Path triggers continuous integration ko optimize karne ke liye use hote hain. Agar project mein sirf documentation update hui hai (`docs/`), toh poori application build karne ki zaroorat nahi hoti. Is se build minutes aur resources bachte hain.

### YAML Example
```yaml
trigger:
  branches:
    include:
      - main
  paths:
    include:
      - src/**           # Sirf 'src' folder ya sub-folders change hone par chalega
      - package.json     # Ya root dependency change hone par
    exclude:
      - README.md        # Documentation changes build trigger nahi karengi
      - docs/*

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: echo "Source code changed, running CI!"
    displayName: 'Path Filtered Build'
```

---

## 07.03.03 PR Triggers (Pull Request Validation)

### Explanation
PR trigger tab chalta hai jab koi developer target branch (jaise `main`) ke liye Pull Request open karta hai ya us PR mein nayi commits add karta hai. Iska maqsad code merge hone se pehle tests pass karna hota hai taake broken code main branch mein na jaye.

> **Note:** Azure Repos mein PR policies configure karne ke liye branch policies use hoti hain, jabke GitHub repositories mein yeh direct YAML se control ho jata hai.

### YAML Example
```yaml
# CI push trigger band karne ke liye (agar sirf PR par chalana ho):
trigger: none

# PR validation trigger
pr:
  branches:
    include:
      - main
      - develop
  paths:
    exclude:
      - '**/*.md'        # Sirf Markdown change ho to PR check na chale

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: |
      echo "Validating Pull Request code..."
      echo "Running linter and unit tests..."
    displayName: 'Run PR Tests'
```

---

## 07.03.04 Scheduled Triggers (Cron Builds)

### Explanation
Scheduled triggers time-based hote hain. Yeh development activities ke baghair chalte hain—jaise roz raat ko 2:00 AM par nightly integration tests run karna ya automated security audit scan chalana. Yeh standard POSIX cron format use karte hain (UTC timezone).

### YAML Example
```yaml
# Disable standard push triggers
trigger: none
pr: none

schedules:
  - cron: '0 2 * * Mon-Fri'   # Har Monday se Friday raat 2:00 AM UTC
    displayName: 'Nightly Weekday Build'
    branches:
      include:
        - main
    always: true             # Agar code change na bhi ho, tab bhi chalega

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: echo "Running automated nightly health check..."
    displayName: 'Scheduled Job Execution'
```

---

## 07.03.05 Pipeline Resource Triggers (Pipeline-to-Pipeline)

### Explanation
Badi architectures mein ek pipeline doosri pipeline par depend karti hai. Jaise: **Build/CI Pipeline** complete hone ke baad hi **Release/CD Pipeline** trigger honi chahiye. Iske liye `resources.pipelines` block use hota hai.

### YAML Example
```yaml
# Downstream / CD Pipeline
trigger: none # Push par na chale

resources:
  pipelines:
    - pipeline: app-ci-source     # Pipeline identifier alias
      source: App-CI-Pipeline      # Upstream pipeline ka exact naam
      trigger:
        branches:
          include:
            - main
        stages:
          - Build                  # Sirf jab Build stage successfully pass ho

pool:
  vmImage: 'ubuntu-latest'

steps:
  - script: |
      echo "Triggered by upstream pipeline: $(resources.pipeline.app-ci-source.pipelineID)"
      echo "Deploying newly produced artifacts..."
    displayName: 'Deploy Artifacts'
```

---

## 💡 Best Practices for Triggers

1. **Avoid Wasteful Builds:** Unnecessary files jaise `.md`, `.gitignore`, aur asset folders ke liye hamesha `paths: exclude:` define karein.
2. **Explicit Disable:** Agar kisi pipeline ko sirf manually ya schedule par chalana ho, toh explicitly `trigger: none` aur `pr: none` likhein.
3. **Draft PRs:** PR triggers ensure karte hain ke merge review se pehle continuous test pass status verify ho jaye.
