# ============================================
# Bash Practice Setup Script
# Ye script saari files bana dega
# ============================================

$baseDir = "C:\Users\anpk\Desktop\ashfaqnasir-dev\devops-practice\03-bash-scripting"

# Folders banayein
$folders = @("Day1", "Day2", "Day3", "Day4")
foreach ($folder in $folders) {
    $path = Join-Path $baseDir $folder
    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "✅ Folder: $folder"
    }
}

# ============================================
# DAY 1 — Foundations
# ============================================

# hello.sh
@'
#!/bin/bash
echo "WSL mein pehla script!"
echo "User: $(whoami)"
echo "Home: $HOME"
echo "Date: $(date)"
echo "Hostname: $(hostname)"
'@ | Out-File -FilePath "$baseDir\Day1\hello.sh" -Encoding ASCII

# greet.sh
@'
#!/bin/bash
read -p "Apna naam batayein: " NAME
read -p "Apna shehar batayein: " CITY

echo "Assalam-o-Alaikum, $NAME!"
echo "Aap $CITY se hain."
echo "Aaj $(date +%A) hai."
'@ | Out-File -FilePath "$baseDir\Day1\greet.sh" -Encoding ASCII

# age.sh
@'
#!/bin/bash
read -p "Apni age batayein: " AGE

if [ $AGE -ge 18 ]; then
    echo "Aap adult hain"
elif [ $AGE -ge 13 ]; then
    echo "Aap teenager hain"
else
    echo "Aap bachay hain"
fi
'@ | Out-File -FilePath "$baseDir\Day1\age.sh" -Encoding ASCII

# count.sh
@'
#!/bin/bash
echo "=== 1 se 10 tak ==="
for i in {1..10}; do
    echo "Number: $i"
done

echo ""
echo "=== Even numbers ==="
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        echo "$i even hai"
    fi
done
'@ | Out-File -FilePath "$baseDir\Day1\count.sh" -Encoding ASCII

# calc.sh
@'
#!/bin/bash
add() {
    echo $(( $1 + $2 ))
}
subtract() {
    echo $(( $1 - $2 ))
}
multiply() {
    echo $(( $1 * $2 ))
}

read -p "Pehla number: " NUM1
read -p "Doosra number: " NUM2

echo ""
echo "Sum: $(add $NUM1 $NUM2)"
echo "Difference: $(subtract $NUM1 $NUM2)"
echo "Product: $(multiply $NUM1 $NUM2)"
'@ | Out-File -FilePath "$baseDir\Day1\calc.sh" -Encoding ASCII

# evenodd.sh
@'
#!/bin/bash
read -p "Enter a number: " NUM

if [ $((NUM % 2)) -eq 0 ]; then
    echo "$NUM is an even number"
else
    echo "$NUM is an odd number"
fi
'@ | Out-File -FilePath "$baseDir\Day1\evenodd.sh" -Encoding ASCII

# checker.sh
@'
#!/bin/bash
read -p "Enter file name: " FILENAME

if [ -f "$FILENAME" ]; then
    echo "File found: $FILENAME"
else
    echo "File not found: $FILENAME"
fi
'@ | Out-File -FilePath "$baseDir\Day1\checker.sh" -Encoding ASCII

# userinfo.sh
@'
#!/bin/bash
read -p "Enter your name: " NAME
read -p "Enter your age: " AGE

echo "Assalam-o-Alaikum $NAME, you are $AGE years old"

if [ $AGE -lt 18 ]; then
    echo "You are not an adult yet"
else
    echo "You are an adult"
fi
'@ | Out-File -FilePath "$baseDir\Day1\userinfo.sh" -Encoding ASCII

Write-Host "✅ Day1 complete"

# ============================================
# DAY 2 — Arrays & Loops
# ============================================

# fruits.sh
@'
#!/bin/bash
FRUITS=("Apple" "Banana" "Mango" "Orange")

echo "Total fruits: ${#FRUITS[@]}"
echo "First fruit: ${FRUITS[0]}"
echo "Second fruit: ${FRUITS[1]}"
echo ""
echo "All fruits:"

for fruit in "${FRUITS[@]}"; do
    echo "  - $fruit"
done
'@ | Out-File -FilePath "$baseDir\Day2\fruits.sh" -Encoding ASCII

# colors.sh
@'
#!/bin/bash
COLORS=("Red" "Green" "Blue" "Yellow" "Purple")

echo "Total colors: ${#COLORS[@]}"
echo ""

for color in "${COLORS[@]}"; do
    echo "Color: $color"
done
'@ | Out-File -FilePath "$baseDir\Day2\colors.sh" -Encoding ASCII

# logs.sh
@'
#!/bin/bash
echo "Files in current directory:"
echo ""

for file in *.sh; do
    if [ -f "$file" ]; then
        LINES=$(wc -l < "$file")
        echo "$file → $LINES lines"
    fi
done
'@ | Out-File -FilePath "$baseDir\Day2\logs.sh" -Encoding ASCII

# count_lines.sh
@'
#!/bin/bash
TOTAL=0

for file in *.sh; do
    if [ -f "$file" ]; then
        LINES=$(wc -l < "$file")
        echo "$file: $LINES lines"
        TOTAL=$((TOTAL + LINES))
    fi
done

echo ""
echo "Total lines in all scripts: $TOTAL"
'@ | Out-File -FilePath "$baseDir\Day2\count_lines.sh" -Encoding ASCII

# servers.sh
@'
#!/bin/bash
echo "Reading servers from servers.txt:"
echo ""

while IFS= read -r server; do
    echo "  → Checking: $server"
done < servers.txt

echo ""
echo "Done!"
'@ | Out-File -FilePath "$baseDir\Day2\servers.sh" -Encoding ASCII

# servers.txt
@'
web1.example.com
web2.example.com
db1.example.com
cache1.example.com
'@ | Out-File -FilePath "$baseDir\Day2\servers.txt" -Encoding ASCII

# check_servers.sh
@'
#!/bin/bash
COUNT=0

while IFS= read -r server; do
    COUNT=$((COUNT + 1))
    echo "$COUNT. $server"
done < servers.txt

echo ""
echo "Total servers: $COUNT"
'@ | Out-File -FilePath "$baseDir\Day2\check_servers.sh" -Encoding ASCII

Write-Host "✅ Day2 complete"

# ============================================
# DAY 3 — Text Processing
# ============================================

# app.log
@'
2026-10-07 10:00:01 INFO  User login successful
2026-10-07 10:00:15 ERROR Database connection failed
2026-10-07 10:00:20 INFO  User logout
2026-10-07 10:01:05 ERROR Timeout while calling API
2026-10-07 10:01:30 WARN  Memory usage high
2026-10-07 10:02:00 INFO  User signup successful
2026-10-07 10:02:45 ERROR Invalid credentials
2026-10-07 10:03:00 INFO  User login successful
2026-10-07 10:03:20 WARN  Disk space low
2026-10-07 10:04:00 ERROR Service unavailable
'@ | Out-File -FilePath "$baseDir\Day3\app.log" -Encoding ASCII

# config.txt
@'
# Application Configuration
port=8080
host=localhost
database=myapp_db

# Server Settings
port_backup=8080
timeout=30

# Debug Settings
debug=false
'@ | Out-File -FilePath "$baseDir\Day3\config.txt" -Encoding ASCII

# grep.sh
@'
#!/bin/bash
echo "=== All ERROR lines ==="
grep "ERROR" app.log

echo ""
echo "=== Total ERROR count ==="
grep -c "ERROR" app.log

echo ""
echo "=== All WARN lines ==="
grep "WARN" app.log
'@ | Out-File -FilePath "$baseDir\Day3\grep.sh" -Encoding ASCII

# awk.sh
@'
#!/bin/bash
echo "=== Only ERROR/WARN levels (3rd column) ==="
awk '{print $3}' app.log

echo ""
echo "=== Only timestamps (1st + 2nd column) ==="
awk '{print $1, $2}' app.log

echo ""
echo "=== Only ERROR lines with timestamp ==="
awk '$3 == "ERROR" {print $1, $2, $3}' app.log
'@ | Out-File -FilePath "$baseDir\Day3\awk.sh" -Encoding ASCII

# sed.sh
@'
#!/bin/bash
echo "=== Original config.txt ==="
cat config.txt

echo ""
echo "=== Replace port 8080 with 9090 ==="
sed 's/8080/9090/' config.txt

echo ""
echo "=== Delete all comment lines ==="
sed '/^#/d' config.txt

echo ""
echo "=== Only lines containing port ==="
sed -n '/port/p' config.txt
'@ | Out-File -FilePath "$baseDir\Day3\sed.sh" -Encoding ASCII

# cut_sort_uniq.sh
@'
#!/bin/bash
echo "=== Only port lines using cut ==="
grep "port" config.txt | cut -d'=' -f1

echo ""
echo "=== Only values using cut ==="
grep "port" config.txt | cut -d'=' -f2

echo ""
echo "=== Sort config.txt ==="
sort config.txt

echo ""
echo "=== Unique log levels ==="
awk '{print $3}' app.log | sort | uniq

echo ""
echo "=== Count of each log level ==="
awk '{print $3}' app.log | sort | uniq -c
'@ | Out-File -FilePath "$baseDir\Day3\cut_sort_uniq.sh" -Encoding ASCII

Write-Host "✅ Day3 complete"

# ============================================
# DAY 4 — Error Handling & Real Scripts
# ============================================

# error_handling.sh
@'
#!/bin/bash
set -euo pipefail

echo "=== Script shuru ==="

if ! command -v git &> /dev/null; then
    echo "Error: git install nahi hai" >&2
    exit 1
fi
echo "git mojood hai"

if [ ! -f "config.txt" ]; then
    echo "Error: config.txt nahi mili" >&2
    exit 1
fi
echo "config.txt mili"

echo ""
echo "=== Script successfully complete ==="
exit 0
'@ | Out-File -FilePath "$baseDir\Day4\error_handling.sh" -Encoding ASCII

# config.txt for Day4
@'
# Application Configuration
port=8080
host=localhost
database=myapp_db
'@ | Out-File -FilePath "$baseDir\Day4\config.txt" -Encoding ASCII

# build.sh
@'
#!/bin/bash
set -euo pipefail

APP_NAME="myapp"
BUILD_DIR="build"
LOG_FILE="build.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

check_command() {
    if ! command -v "$1" &> /dev/null; then
        log "Error: $1 install nahi hai"
        exit 1
    fi
    log "$1 mojood hai"
}

log "Build shuru: $APP_NAME"

check_command "bash"
check_command "grep"
check_command "awk"

log "Cleaning build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

STEPS=("Compiling" "Testing" "Packaging")

for step in "${STEPS[@]}"; do
    log "  -> $step..."
    sleep 1
    log "  $step complete"
done

log "Creating artifact..."
echo "Build: $APP_NAME" > "$BUILD_DIR/app.txt"
echo "Version: 1.0.0" >> "$BUILD_DIR/app.txt"
echo "Date: $(date)" >> "$BUILD_DIR/app.txt"

if [ -f "$BUILD_DIR/app.txt" ]; then
    log "Artifact created: $BUILD_DIR/app.txt"
else
    log "Artifact not created"
    exit 1
fi

log ""
log "=========================================="
log "Build successful!"
log "Artifact: $BUILD_DIR/"
log "Log: $LOG_FILE"
log "=========================================="

exit 0
'@ | Out-File -FilePath "$baseDir\Day4\build.sh" -Encoding ASCII

Write-Host "✅ Day4 complete"

Write-Host ""
Write-Host "============================================"
Write-Host "✅ Saari files ban gayin!"
Write-Host "============================================"
Write-Host ""
Write-Host "Files banayi gayin:"
Get-ChildItem -Path $baseDir -Recurse -File | Select-Object FullName