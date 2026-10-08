Naya file banayein: file-operations.md

Yeh content paste karein:

markdown
# 01.02 File Operations

> Linux file operations — create, copy, move, delete, view, find.

## 📚 Concepts Covered

### 01.02.01 Create (`touch`, `mkdir`)

**File banane ke liye:**
```bash
touch file.txt              # Empty file
touch file1.txt file2.txt   # Multiple files
echo "content" > file.txt   # File with content
Folder banane ke liye:

bash
mkdir folder                # Single folder
mkdir folder1 folder2       # Multiple folders
mkdir -p parent/child/grand # Nested (parents auto-create)
Examples:

bash
touch notes.txt
mkdir projects
mkdir -p projects/web/backend
ls -la
01.02.02 Copy (cp)
File copy:

bash
cp source.txt dest.txt          # Simple copy
cp source.txt /path/to/dest/    # To specific folder
cp file1 file2 file3 folder/    # Multiple files
Folder copy:

bash
cp -r source_folder/ dest_folder/    # Recursive (-r zaroori)
cp -ri source/ dest/                 # Interactive (puchega)
Options:

Flag	Kaam
-r	Recursive (folders)
-i	Interactive (overwrite se pehle poocho)
-v	Verbose (kya copy hua dikhao)
-p	Preserve permissions/timestamps
Examples:

bash
cp notes.txt notes-backup.txt
cp -r projects projects-backup
cp -v file.txt /tmp/
01.02.03 Move/Rename (mv)
Rename:

bash
mv oldname.txt newname.txt
Move:

bash
mv file.txt /path/to/folder/
mv file.txt folder/newname.txt    # Move + rename
Options:

Flag	Kaam
-i	Interactive
-v	Verbose
-n	No overwrite
Examples:

bash
mv notes-backup.txt old-notes.txt
mv old-notes.txt projects/
mv file.txt /tmp/renamed.txt
01.02.04 Delete (rm, rmdir)
File delete:

bash
rm file.txt              # Simple
rm -i file.txt           # Interactive
rm file1 file2 file3     # Multiple
Folder delete:

bash
rmdir empty_folder       # Sirf KHALI folder
rm -r folder/            # Recursive (puchega)
rm -rf folder/           # Recursive + Force (⚠️ KHATARNAK)
⚠️ Warning:

bash
rm -rf /          # POORA SYSTEM DELETE!
rm -rf ~          # Home delete!
rm -rf *          # Current folder ka sab kuch!
Safe Practices:

bash
# Pehle dekho
ls folder/

# Phir delete
rm -rf folder/
Alternatives:

bash
# Recycle bin mein bhejo
sudo apt install trash-cli
trash file.txt

# Interactive
rm -ri folder/
01.02.05 View (cat, less, head, tail)
cat — Poori file:

bash
cat file.txt
cat file1.txt file2.txt    # Multiple
cat -n file.txt            # Line numbers
less — Scroll karke dekho:

bash
less file.txt              # q dabao exit ke liye
Space = Next page

b = Previous page

/pattern = Search

q = Quit

head — Pehli lines:

bash
head file.txt              # Default 10 lines
head -3 file.txt           # Pehli 3 lines
head -20 file.txt          # Pehli 20 lines
tail — Aakhri lines:

bash
tail file.txt              # Default 10 lines
tail -3 file.txt           # Aakhri 3 lines
tail -20 file.txt          # Aakhri 20 lines

# LIVE follow (DevOps mein bohat use)
tail -f /var/log/syslog    # Ctrl+C se exit
Examples:

bash
cat test.txt
head -3 test.txt
tail -3 test.txt
tail -f app.log            # Live logs
less config.txt
01.02.06 Find (find, locate)
find — Real-time search:

Syntax:

bash
find [KAHAN] [KYA] [ACTION]
By name:

bash
find . -name "*.txt"            # Saari .txt
find ~ -name "notes.txt"        # Specific
find . -iname "*.TXT"           # Case insensitive
By type:

bash
find . -type f                  # Files
find . -type d                  # Directories
find . -type l                  # Symlinks
By size:

bash
find . -size +100M              # 100 MB se bari
find . -size -1k                # 1 KB se choti
find . -size +10M -size -100M   # 10-100 MB
By time:

bash
find . -mtime +7                # 7 din se purani
find . -mtime -1                # Aakhri 24 ghante
find . -amin -60                # Aakhri 1 ghanta
By permissions:

bash
find . -perm /u+x               # Executable
find . -perm 755                # Exactly 755
With actions:

bash
find . -name "*.txt" -exec ls -lh {} \;      # Details
find . -name "*.tmp" -delete                  # Delete
find . -name "*.sh" -exec chmod +x {} \;     # Executable banao
-maxdepth:

bash
find ~ -maxdepth 1 -name "*.sh"   # Sirf pehla level
find ~ -maxdepth 2 -type d         # 2 levels tak
Multiple conditions:

bash
find . \( -name "*.txt" -o -name "*.log" \)   # OR
find . -name "*.sh" -size +1k                 # AND
locate — Fast search (database se):

bash
sudo apt install mlocate
sudo updatedb
locate notes.txt
🎯 Practice Commands
bash
# Setup
mkdir -p ~/file-ops-practice && cd ~/file-ops-practice

# 1. Create
touch notes.txt
mkdir -p projects/web/backend
ls -la

# 2. Copy
cp notes.txt notes-backup.txt
cp -r projects projects-backup
ls

# 3. Move/Rename
mv notes-backup.txt old-notes.txt
mv old-notes.txt projects/
ls
ls projects/

# 4. Delete
rm -rf projects-backup
rm -rf projects/web
ls

# 5. View
cat > test.txt << 'EOF'
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
EOF

cat test.txt
head -3 test.txt
tail -3 test.txt

# 6. Find
find . -name "*.txt"
find . -type d
find . -type f -empty
find ~ -maxdepth 1 -name "*.sh"
💡 Key Learnings
touch = File banayein

mkdir -p = Nested folders

cp -r = Folder copy

mv = Rename + Move

rm -rf = ⚠️ Force delete (savdhani!)

rmdir = Sirf khali folder

cat = Poori file

head -N = Pehli N lines

tail -N = Aakhri N lines

tail -f = Live follow

find . -name "*.txt" = Pattern search

find . -type f/d = Type search

find . -size +10M = Size search

find . -mtime -7 = Time search

find . -exec cmd {} \; = Action

Status: ✅ Complete
Last Updated: 2026-10-08

text

**Save:** `Ctrl + S`

---

## 🎉 Ab Teeno Files Ban Gayin!
devops-practice/01-linux-fundamentals/
├── README.md ✅ (agar bana)
├── file-system.md ✅ (01.01)
├── file-operations.md ✅ (01.02)
└── permissions.md ✅ (01.03)

text

---

## 🚀 Ab GitHub Desktop Se Push Karein

### **Step 1: GitHub Desktop Kholein**

### **Step 2: `devops-practice` Repo Select Karein**

### **Step 3: Left Sidebar Mein Changes**

**Dikhengi:**
- `01-linux-fundamentals/file-system.md` (naya)
- `01-linux-fundamentals/file-operations.md` (naya)
- `01-linux-fundamentals/permissions.md` (naya)

### **Step 4: Commit**

- **Summary:** `Add Linux Fundamentals markdown: File System, File Operations, Permissions`
- **Commit to main**

### **Step 5: Push**

- **Push origin**

**Ho gaya!** ✅

---

## 📊 `devops-roadmap` Bhi Update Karein

**File:** `devops-roadmap/01-linux-fundamentals/README.md`

**Progress table:**

```markdown
| Section | Items | Done |
|---------|-------|------|
| File System | 5 | 5/5 ✅ |
| File Operations | 6 | 6/6 ✅ |
| Permissions | 5 | 5/5 ✅ |
| Process Management | 5 | 0/5 ⏳ |
| Package Management | 4 | 0/4 ⏳ |
| Networking Commands | 5 | 0/5 ⏳ |
| SSH & Remote | 4 | 0/4 ⏳ |
| System Monitoring | 5 | 0/5 ⏳ |

**Overall: 16/39 (41%)**
Checkboxes:

markdown
### 01.01 File System
- [x] 01.01.01 Directory structure
- [x] 01.01.02 Absolute vs relative paths
- [x] 01.01.03 `pwd`, `cd`, `ls`
- [x] 01.01.04 Symlinks (`ln -s`)
- [x] 01.01.05 Mount points (`/mnt`, `/media`)

### 01.02 File Operations
- [x] 01.02.01 Create (`touch`, `mkdir`)
- [x] 01.02.02 Copy (`cp`)
- [x] 01.02.03 Move/Rename (`mv`)
- [x] 01.02.04 Delete (`rm`, `rmdir`)
- [x] 01.02.05 View (`cat`, `less`, `head`, `tail`)
- [x] 01.02.06 Find (`find`, `locate`)

### 01.03 Permissions
- [x] 01.03.01 Permission types (`r`, `w`, `x`)
- [x] 01.03.02 `chmod` (symbolic & numeric)
- [x] 01.03.03 `chown` (ownership)
- [x] 01.03.04 `chgrp` (groups)
- [x] 01.03.05 Special permissions (SUID, SGID, sticky bit)
Status line:

markdown
**Status:** 🔄 In Progress (41%)
**Last Updated:** 2026-10-08
Save + Push (GitHub Desktop se).

📝 Mujhe Batayein
text
✅ file-system.md banaya?
✅ file-operations.md banaya?
✅ permissions.md banaya?
✅ devops-practice push kiya?
✅ devops-roadmap update kiya?
✅ 41% dikh raha hai GitHub par?

Sawal: [koi confusion ho]
🎯 Aaj Ka Summary
Chapter	Markdown	Status
01.01 File System	file-system.md	✅
01.02 File Operations	file-operations.md	✅
01.03 Permissions	permissions.md	✅
Progress: 16/39 (41%) 🎉

🎁 Agla Step
01-linux-fundamentals ka baaki:

⏳ 01.04 Process Management

⏳ 01.05 Package Management

⏳ 01.06 Networking Commands

⏳ 01.07 SSH & Remote

⏳ 01.08 System Monitoring

Phir 100% complete! 🚀

Chalein, file-operations.md banayein aur teeno files push karein! 💪


