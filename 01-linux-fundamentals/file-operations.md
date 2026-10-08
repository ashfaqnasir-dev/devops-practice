# 01.02 File Operations

> Practical examples of Linux file operations.

## 📚 Commands Covered

### 01.02.01 Create (touch, mkdir)

```bash
# File banayein
touch notes.txt

# Folder banayein
mkdir projects

# Nested folders
mkdir -p projects/web/backend


# File copy
cp notes.txt notes-backup.txt

# Folder copy (recursive)
cp -r projects projects-backup

# Rename
mv notes-backup.txt old-notes.txt

# Move
mv old-notes.txt projects/

# File delete
rm notes.txt

# Folder delete (recursive + force)
rm -rf projects-backup

# Empty folder delete
rmdir empty-folder

# Poori file
cat test.txt

# Pehli 3 lines
head -3 test.txt

# Aakhri 3 lines
tail -3 test.txt

# Live follow (logs)
tail -f /var/log/syslog

# Scroll kar ke dekho
less test.txt

# Saari .sh files
find ~ -name "*.sh"

# Sirf folders
find ~ -maxdepth 1 -type d

# Bari files (10KB+)
find ~ -maxdepth 1 -type f -size +10k

# Aakhri 7 din mein modified
find ~ -maxdepth 1 -mtime -7

# Khali files
find ~ -maxdepth 1 -type f -empty

🎯 Practice Test
# 1. Folder banao
mkdir -p ~/linux-test
cd ~/linux-test

# 2. Files banao
touch notes.txt
mkdir -p projects/web/backend

# 3. Copy karo
cp notes.txt notes-backup.txt
cp -r projects projects-backup

# 4. Move/Rename
mv notes-backup.txt old-notes.txt
mv old-notes.txt projects/

# 5. Test file banao
cat > test.txt << 'EOF'
Line 1
Line 2
Line 3
Line 4
Line 5
EOF

# 6. View karo
cat test.txt
head -3 test.txt
tail -3 test.txt

# 7. Find karo
find . -name "*.txt"
find . -type d

# 8. Delete karo
rm -rf projects-backup

💡 Key Learnings
touch = file banata hai

mkdir -p = nested folders

cp -r = folder copy

mv = rename + move

rm -rf = force delete (savdhani se!)

head -N = pehli N lines

tail -N = aakhri N lines

tail -f = live follow

find . -name "*.txt" = pattern search

Status: ✅ Complete
Last Updated: 2026-10-08

text

**Save:** `Ctrl + S`

---

### **Step 4: `file-operations.sh` Script Banayein**

**Same folder** mein `file-operations.sh` banayein:

```bash
#!/bin/bash
set -e

# ============================================
# File Operations Demo Script
# ============================================

TEST_DIR="$(pwd)/file-ops-test"

echo "=== File Operations Demo ==="
echo ""

# Cleanup
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Create
echo "1. CREATE"
touch notes.txt
mkdir -p projects/web/backend
ls -la

# Copy
echo ""
echo "2. COPY"
cp notes.txt notes-backup.txt
cp -r projects projects-backup
ls -la

# Move/Rename
echo ""
echo "3. MOVE/RENAME"
mv notes-backup.txt old-notes.txt
mv old-notes.txt projects/
echo "Root folder:"
ls -la
echo "Projects folder:"
ls projects/

# Create test file
echo ""
echo "4. CREATE test.txt"
cat > test.txt << 'EOF'
Line 1
Line 2
Line 3
Line 4
Line 5
EOF

# View
echo ""
echo "5. VIEW"
echo "--- cat test.txt ---"
cat test.txt

echo ""
echo "--- head -3 test.txt ---"
head -3 test.txt

echo ""
echo "--- tail -3 test.txt ---"
tail -3 test.txt

# Find
echo ""
echo "6. FIND"
echo "--- Saari .txt files ---"
find . -name "*.txt"

echo ""
echo "--- Saare folders ---"
find . -type d

# Delete
echo ""
echo "7. DELETE"
rm -rf projects-backup
rm -rf projects/web

echo ""
echo "Final structure:"
find . -type f -o -type d

echo ""
echo "=== Done ==="
Save: Ctrl + S

Step 5: Test Karein (WSL Mein)
bash
# Windows path se WSL mein jaayein
cd /mnt/c/Users/anpk/Desktop/ashfaqnasir-dev/devops-practice/01-linux-fundamentals

# Script chalayein
chmod +x file-operations.sh
./file-operations.sh
Output paste karein!

Step 6: GitHub Desktop Se Push
GitHub Desktop kholein

devops-practice repo select karein

Left sidebar mein:

01-linux-fundamentals/file-operations.md (naya)

01-linux-fundamentals/file-operations.sh (naya)

Bottom left:

Summary: Add file operations (Linux fundamentals)

Commit to main click karein

Push origin click karein

📊 Aaj Ka Summary
Kaam	Status
Linux File Operations (6 concepts)	✅
Practical tests (find, head, tail)	✅
file-operations.md banaya	⏳
file-operations.sh banaya	⏳
GitHub push	⏳
📝 Mujhe Batayein
text
✅ file-operations.md banaya?
✅ file-operations.sh banaya?
✅ Test kiya?
✅ GitHub par push kiya?

Sawal: [koi confusion ho]
💡 Aasan Baat
Aap ne Linux ke 6 main file operations practically test kar liye:

Create — touch, mkdir

Copy — cp

Move — mv

Delete — rm

View — cat, head, tail, less

Find — find

Ab yeh sab devops-practice mein save karein — proof of work.

🎯 Agla Step
Kal se:

Linux Advanced — grep, awk, sed (jo aap ne pehle seekha)

Ya seedha Azure DevOps

Ya Docker

Aap decide karein.

Chalein, files banayein aur GitHub Desktop se push karein! 🚀

Aap ne aaj bohat acha kaam kiya — find, head, tail sab clear! 👏
