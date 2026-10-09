# 10. Terraform — Installation Guide

> Complete guide to install Terraform on WSL (Ubuntu).

## 📚 Prerequisites

- WSL 2 with Ubuntu installed
- Internet connection
- `sudo` access

---

## 🛠️ Installation Steps

### Step 1: Update System

```bash
sudo apt update
```

**Kya karta hai:** Package list ko update karta hai (latest versions ke liye).

**Output:**
```
Hit:1 http://archive.ubuntu.com/ubuntu noble InRelease
Reading package lists... Done
```

---

### Step 2: Install wget + unzip

```bash
sudo apt install -y wget unzip
```

**Kya karta hai:** Do tools install karta hai:
- **`wget`** — Internet se files download karne ke liye
- **`unzip`** — Zip files extract karne ke liye

**Output:**
```
wget is already the newest version (1.21.4-1ubuntu4.5).
unzip is already the newest version (6.0-28ubuntu4.1).
```

---

### Step 3: Download Terraform

```bash
wget https://releases.hashicorp.com/terraform/1.9.5/terraform_1.9.5_linux_amd64.zip
```

**Kya karta hai:** HashiCorp ke server se Terraform ka **zip file** download karta hai (~25 MB).

**Output:**
```
terraform_1.9.5_linux_amd64.zip  100%[===================>]  25.79M  1.84MB/s  in 14s
2026-10-09 10:05:29 (1.84 MB/s) - 'terraform_1.9.5_linux_amd64.zip' saved [27040662]
```

**Note:** File ka naam `terraform_1.9.5_linux_amd64.zip` hai — ismein **version** aur **OS/architecture** bhi hai.

---

### Step 4: Unzip

```bash
unzip terraform_1.9.5_linux_amd64.zip
```

**Kya karta hai:** Zip file ko **extract** karta hai. Andar se **2 files** nikalti hain:
- `LICENSE.txt` — License file
- `terraform` — **Main binary** (chalne wali file)

**Output:**
```
Archive:  terraform_1.9.5_linux_amd64.zip
  inflating: LICENSE.txt
  inflating: terraform
```

**Note:** Ab aap ke folder mein `terraform` naam ki **executable file** hai.

---

### Step 5: Install to System Path

```bash
sudo mv terraform /usr/local/bin/
```

**Kya karta hai:** `terraform` binary ko **system path** mein move karta hai.

**Kyun `/usr/local/bin/`?**
- Yeh folder Linux mein **system binaries** ke liye hota hai
- Yeh `$PATH` environment variable mein include hota hai
- Is liye `terraform` command **kahin se bhi** chal jati hai

**Output:** Kuch nahi — **silent success**.

**Verify:**
```bash
which terraform
# Output: /usr/local/bin/terraform
```

---

### Step 6: Verify Installation

```bash
terraform --version
```

**Kya karta hai:** Terraform ka version check karta hai.

**Output:**
```
Terraform v1.9.5
on linux_amd64
```

✅ **Agar yeh output aaya — installation successful!**

---

## 📖 Kya Hua — Detailed Explanation

### `wget` Kya Karta Hai?

**`wget`** = **W**eb **Get**

- HTTP/HTTPS/FTP se files download karta hai
- **Resume** support karta hai (agar download ruk jaye)
- **Recursive** download kar sakta hai

**Example:**
```bash
wget https://example.com/file.zip
```

---

### `unzip` Kya Karta Hai?

**`unzip`** = **Un**-ZIP

- `.zip` files extract karta hai
- **Specific files** bhi nikal sakta hai
- **Password-protected** zips bhi handle karta hai

**Common flags:**
| Flag | Kaam |
|---|---|
| `unzip file.zip` | Extract to current folder |
| `unzip file.zip -d /path/` | Extract to specific folder |
| `unzip -l file.zip` | List content (bina extract) |

---

### `sudo mv` Kya Karta Hai?

**`mv`** = **M**o**v**e (Rename)

- File ko **ek jagah se doosri jagah** move karta hai
- Naam bhi badal sakta hai

**`sudo`** = Root permission ke saath chalao

**Kyun `sudo`?** Kyunke `/usr/local/bin/` **system folder** hai — ismein likhne ke liye root access chahiye.

---

### `/usr/local/bin/` Kyun?

Linux mein **3 tarah ke bin folders** hain:

| Folder | Kya Rakha Jata Hai |
|---|---|
| `/bin/` | System essential commands (ls, cp, etc.) |
| `/usr/bin/` | Package manager ke installed (apt) |
| **`/usr/local/bin/`** | **Manual installs** (aap ke jaise) |

**`$PATH` mein check karein:**
```bash
echo $PATH
```

**Output:**
```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Is liye `terraform` **kahin se bhi** chalta hai.

---

## 🎯 Provider Ka Concept (Important)

### Terraform Provider Kya Hai?

**Provider** = **Plugin / Bridge** jo Terraform ko **kisi service** se **connect** karta hai.

**Analogy:**
- **Terraform** = Aap (boss)
- **Provider** = **Translator** (aap aur service ke beech)
- **Service** = Cloud / Computer (jahan kaam karna hai)

---

### Provider Ki 2 Categories

| Category | Examples | Kya Connect |
|---|---|---|
| **Cloud Providers** | `azurerm`, `aws`, `google` | Cloud APIs |
| **Local Providers** | `local`, `null`, `random` | Aap ka computer |

**Aap ne `local` provider use kiya** — yeh **local files** banata hai (koi cloud nahi chahiye).

---

### Provider Kahan Rehta Hai?

**2 Jagah:**

#### 1. Registry (Website)

```
https://registry.terraform.io/providers/hashicorp/local/latest
```

**Yeh official website hai** — yahan se provider download hota hai.

#### 2. Aap Ke Computer Par (Download Ke Baad)

```bash
~/.terraform-practice/.terraform/providers/registry.terraform.io/hashicorp/local/2.9.1/linux_amd64/
└── terraform-provider-local_v2.9.1    (~10 MB binary)
```

**Yeh Go language** mein likhi hui **binary file** hai — jo actual kaam karti hai.

**Verify:**
```bash
cd ~/terraform-practice
find .terraform -type f
```

---

### Provider "Connect" Kaise Hota Hai?

**`local` provider:**
```
Aap → main.tf → Terraform → Provider Binary → File Banai
                                     ↓
                              (koi connection nahi)
```

**`azurerm` provider:**
```
Aap → main.tf → Terraform → Provider Binary → Azure API
                                     ↓
                              (HTTPS call + credentials)
```

**Ahem:** `local` provider **internet** nahi chahiye. `azurerm` provider **credentials** chahiye.

---

## 🎯 Terraform Workflow

```
┌──────────────┐
│  main.tf     │  ← Aap likhte hain (WHAT do you want?)
└──────┬───────┘
       ↓
┌──────────────┐
│ terraform    │  ← Providers setup (HOW?)
│   init       │
└──────┬───────┘
       ↓
┌──────────────┐
│ terraform    │  ← Preview (WHAT will change?)
│   plan       │
└──────┬───────┘
       ↓
┌──────────────┐
│ terraform    │  ← Execute (MAKE it happen!)
│   apply      │
└──────┬───────┘
       ↓
┌──────────────┐
│ terraform    │  ← Cleanup (REMOVE everything)
│   destroy    │
└──────────────┘
```

---

## 📊 Files Jo Banti Hain

**Terraform project mein yeh files hoti hain:**

| File | Kaam |
|---|---|
| `main.tf` | Aap ki configuration |
| `.terraform/` | Downloaded providers |
| `.terraform.lock.hcl` | Version lock file |
| `terraform.tfstate` | State (kya bana) |
| `terraform.tfstate.backup` | State backup |

### `.gitignore` Mein Daalein

```
.terraform/
*.tfstate
*.tfstate.backup
```

**Kyun?**
- `.terraform/` — Bari folder, download ho jati hai
- `*.tfstate` — **Secrets** ho sakte hain
- Har person ke paas **apna state** hona chahiye

---

## 💡 Key Learnings

- **`wget`** — Internet se files download
- **`unzip`** — Zip files extract
- **`sudo mv`** — System path mein install
- **`/usr/local/bin/`** — Manual installs ka folder
- **Provider** — Plugin (Go binary)
- **Registry** — Providers ki website
- **`.terraform/`** — Downloaded providers
- **`local` provider** — Koi connection nahi
- **`azurerm` provider** — Azure credentials chahiye

---

## 📖 Resources

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [HashiCorp Downloads](https://releases.hashicorp.com/terraform/)

---

**Status:** ✅ Terraform Installed
**Version:** v1.9.5
**Date:** 2026-10-09