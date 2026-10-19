
📝 Copy this ENTIRE block (Just one click on the top-right Copy icon of this box):
markdown
# 🏗️ YAML & Azure Pipelines — Complete Guide

> Ek hi page par YAML Syntax aur Pipeline Structure.

---

## 📚 Part 1: YAML Syntax Basics

YAML ek human-readable data format hai. Isay config files (Azure Pipelines, Docker, K8s) mein use karte hain.

| Concept | Kya Hai? | Example |
| :--- | :--- | :--- |
| **1. Indentation** | Structure sirf **spaces** (2 spaces) se banta hai, **Tab** use nahi karte. | `key:\n  child: value` |
| **2. Key-Value** | Data likhne ka tareeqa: `key: value`. Colon ke baad space zaroori hai. | `name: Ashfaq` |
| **3. Lists** | Multiple items ke liye hyphen (`-`) use hota hai. | `fruits:\n  - apple\n  - banana` |
| **4. Multi-line** | Lambi text ke liye `|` (newlines preserve) ya `>` (fold lines) use hota hai. | `script: |\n  echo "Hi"` |
| **5. Comments** | Notes ke liye `#` use hota hai. Parser ignore karta hai. | `# Yeh note hai` |

---

## 🚀 Part 2: Azure Pipeline Structure

Pipeline ka dhancha (framework) — **Kab chalna hai**, **Kahan chalna hai**, aur **Kya karna hai**.

### Hierarchy (Upar se Neeche)

```text
Pipeline
├── trigger    (Kab chalega?)
├── pool       (Kahan chalega?)
├── variables  (Settings kya hain?)
└── stages     (Bade phases)
    └── jobs   (Kaam ke groups)
        └── steps (Asal commands)


## 🚀 Core Components (Quick Reference)

Component	Purpose	Example
1. trigger	Auto-run hone ki condition (kab chalega).	trigger: [main]
2. pool	Machine select karta hai (kahan chalega).	pool:\n vmImage: 'ubuntu-latest'
3. variables	Reusable settings (e.g., App Name).	variables:\n APP: "MyApp"
4. stages	Bade phases (Build, Test, Deploy).	stages:\n - stage: Build
5. jobs	Stage ke andar kaam ke groups.	jobs:\n - job: Compile
6. steps	Asal terminal commands ya tasks.	steps:\n - script: echo "Hi"
💻 Complete Real-World Example
Neeche diya gaya code saare 6 components ko ek sath dikhata hai:

yaml
# 1. Trigger: Jab main branch par push ho
trigger:
  - main

# 2. Pool: Ubuntu machine par chalega
pool:
  vmImage: 'ubuntu-latest'

# 3. Variables: Reusable values
variables:
  APP_NAME: "MyApp"

# 4. Stages: Do phases (Build aur Deploy)
stages:
  # --- Stage 1: Build ---
  - stage: BuildStage

    displayName: 'Build Application'
    jobs:
      - job: BuildJob
        # 6. Steps: Build ke commands
        steps:
          - script: echo "Building $(APP_NAME)"
            displayName: 'Build Script'

  # --- Stage 2: Deploy ---
  - stage: DeployStage
    displayName: 'Deploy Application'
    dependsOn: BuildStage # Build ke baad chalega
    jobs:
      - job: DeployJob
        steps:
          - script: echo "Deploying $(APP_NAME)"
            displayName: 'Deploy Script'

##💡 Quick Tips
dependsOn: Stage 2 ko Stage 1 ke baad chalane ke liye use hota hai.

displayName: Azure UI mein sundar naam dikhane ke liye.

Indentation: YAML mein 2 spaces ka indent lazmi hai (Tab use na karein).

Status: ✅ Complete

text

---

Ab bas **upar wale box ke top-right corner mein "Copy" button** hai, us par click karein. **Poori file ek saath copy ho jayegi**, aur aap seedha VS Code mein paste kar sakte hain. 

Save karein, commit karein, aur push karein! 🚀
