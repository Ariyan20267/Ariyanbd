#!/usr/bin/env bash

# ============================================================
#         FREE FIRE SPEN BOT - VPS AUTO SETUP
#         রিপো: https://github.com/Ariyan20267/Ariyanbd.git
# ============================================================

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
RED="\033[91m"
BLUE="\033[94m"
WHITE="\033[97m"
ORANGE="\033[38;5;214m"
PINK="\033[38;5;206m"
PURPLE="\033[38;5;129m"

# আরিয়ান কালার প্যালেট
RGB=(
    "\033[38;5;196m"  # লাল
    "\033[38;5;208m"  # কমলা
    "\033[38;5;226m"  # হলুদ
    "\033[38;5;118m"  # গ্রিন
    "\033[38;5;51m"   # সায়ান
    "\033[38;5;45m"   # নীল
    "\033[38;5;93m"   # পার্পল
    "\033[38;5;201m"  # ম্যাজেন্টা
    "\033[38;5;198m"  # পিঙ্ক
    "\033[38;5;214m"  # অরেঞ্জ
    "\033[38;5;220m"  # সোনালী
    "\033[38;5;154m"  # চুন
    "\033[38;5;57m"   # ইন্ডিগো
    "\033[38;5;129m"  # ভায়োলেট
    "\033[38;5;212m"  # হট পিঙ্ক
)
RGB_LEN=15

# ============================================================
# FREE FIRE LOGO
# ============================================================
FF_L0="            ⣀⣠⡤                        "
FF_L1="   ⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁                          "
FF_L2="  ⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀                      "
FF_L3="  ⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀                "
FF_L4="⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂"
FF_L5="⠈⠉⠁⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁          "
FF_L6="   ⢀⣴⣿⣿⣿⡿⠁⢀⣀⣤⣤⣤⣤⣀⣀                      "
FF_L7="   ⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖            "
FF_L8="  ⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃              "
FF_L9="  ⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋                "
FF_LA="   ⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⢀⣾⣿⣿⡏                    "
FF_LB="    ⠙⢿⣿⣿⣷⣄⡀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄                  "
FF_LC="       ⠈⠙⠛⠛⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁                   "

print_ff_logo() {
    local offset=${1:-0}
    local dim=${2:-0}
    local ri=$(( RANDOM % RGB_LEN ))
    local rc="${RGB[$ri]}"

    echo -e "  ${rc}${BOLD} ⚡ ফ্রি ফায়ার স্পেন বট সেটআপ চলছে... ⚡${RESET}"
    echo ""

    local lines=("$FF_L0" "$FF_L1" "$FF_L2" "$FF_L3" "$FF_L4" "$FF_L5" "$FF_L6" "$FF_L7" "$FF_L8" "$FF_L9" "$FF_LA" "$FF_LB" "$FF_LC")
    local i
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${PURPLE}${DIM}${lines[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${lines[$i]}${RESET}"
        fi
    done
    echo ""
}

FLASH=("$RED" "$ORANGE" "$YELLOW" "$WHITE" "$PINK" "$PURPLE" "$CYAN" "$GREEN" "$ORANGE" "$RED" "$YELLOW" "$PINK" "$PURPLE")

# ============================================================
# OS DETECTION
# ============================================================
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        OS=$(uname -s)
        VER=$(uname -r)
    fi
    echo -e "${GREEN}${BOLD}  [✔] OS Detected: $OS $VER${RESET}"
}

get_pkg_manager() {
    if command -v apt &>/dev/null; then
        echo "apt"
    elif command -v yum &>/dev/null; then
        echo "yum"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v zypper &>/dev/null; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# ============================================================
# PYTHON INSTALL
# ============================================================
install_python() {
    local pkg_manager=$(get_pkg_manager)
    echo -e "${CYAN}${BOLD}  [*] Python এবং pip ইনস্টল করা হচ্ছে...${RESET}"
    
    case $pkg_manager in
        apt)
            sudo apt update -y
            sudo apt install -y python3 python3-pip python3-venv git curl wget
            ;;
        yum)
            sudo yum install -y python3 python3-pip git curl wget
            ;;
        dnf)
            sudo dnf install -y python3 python3-pip git curl wget
            ;;
        pacman)
            sudo pacman -S --noconfirm python python-pip git curl wget
            ;;
        zypper)
            sudo zypper install -y python3 python3-pip git curl wget
            ;;
        *)
            echo -e "${RED}${BOLD}  [✗] প্যাকেজ ম্যানেজার চেনা যায়নি!${RESET}"
            return 1
            ;;
    esac
    
    echo -e "${GREEN}${BOLD}  [✔] Python $(python3 --version) প্রস্তুত${RESET}"
}

# ============================================================
# টেলিগ্রাম বটের জন্য প্রয়োজনীয় মডিউল ইনস্টল
# ============================================================
install_modules() {
    echo ""
    echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${PURPLE}${BOLD}     📦 প্রয়োজনীয় মডিউল ইনস্টল হচ্ছে...${RESET}"
    echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    
    # পাইপ আপগ্রেড
    echo -e "${CYAN}${BOLD}  [*] pip আপগ্রেড করা হচ্ছে...${RESET}"
    python3 -m pip install --upgrade pip setuptools wheel -q
    
    # প্রয়োজনীয় মডিউল লিস্ট
    local modules=(
        # টেলিগ্রাম বট
        "python-telegram-bot==20.7"
        "telethon"
        "pyrogram"
        
        # HTTP এবং Network
        "requests"
        "aiohttp"
        "httpx"
        "urllib3"
        
        # ডাটাবেস
        "sqlalchemy"
        "aiosqlite"
        
        # এনক্রিপশন
        "pycryptodome"
        "cryptography"
        "PyJWT"
        
        # প্রোটোকল
        "protobuf"
        
        # ওয়েব স্ক্র্যাপিং
        "beautifulsoup4"
        "lxml"
        
        # ইউটিলিটি
        "python-dotenv"
        "pyyaml"
        "pytz"
        "python-dateutil"
        "click"
        "rich"
        "colorama"
        
        # অ্যাসিঙ্ক
        "aiofiles"
        
        # লগিং
        "loguru"
        
        # এক্সট্রা
        "psutil"
        "pydantic"
        "pydantic-settings"
        "nest-asyncio"
        "flask"
        "flask-cors"
        
        # অন্যান্য প্রয়োজনীয়
        "simplejson"
        "ujson"
        "python-multipart"
        "asyncio-throttle"
        "opencv-python-headless"
        "Pillow"
        "pyautogui"
        "pydirectinput"
    )
    
    local total=${#modules[@]}
    local done=0
    local failed=()
    
    echo ""
    
    for module in "${modules[@]}"; do
        done=$((done + 1))
        
        # প্রগ্রেস দেখানো
        local progress=$((done * 100 / total))
        local bar_filled=$((done * 40 / total))
        printf "\r${YELLOW}${BOLD}["
        for ((i=0; i<40; i++)); do
            if [ $i -lt $bar_filled ]; then
                printf "${GREEN}█${RESET}"
            else
                printf "${DIM}░${RESET}"
            fi
        done
        printf "] ${progress}%% - ${module}${RESET}   "
        
        # মডিউল ইনস্টল
        if python3 -m pip install "$module" -q 2>/dev/null; then
            echo -e "\r${GREEN}✅ ${module}${RESET}"
        else
            echo -e "\r${RED}❌ ${module}${RESET}"
            failed+=("$module")
        fi
    done
    
    echo ""
    
    # ফলাফল রিপোর্ট
    if [ ${#failed[@]} -gt 0 ]; then
        echo -e "${YELLOW}${BOLD}  [!] কিছু মডিউল ইনস্টল হয়নি:${RESET}"
        for f in "${failed[@]}"; do
            echo -e "${RED}    ❌ $f${RESET}"
        done
    else
        echo -e "${GREEN}${BOLD}  [✔] সব মডিউল সফলভাবে ইনস্টল হয়েছে!${RESET}"
    fi
}

# ============================================================
# GIT CLONE & RUN
# ============================================================
clone_and_run() {
    echo ""
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${CYAN}${BOLD}     🎮 ফ্রি ফায়ার স্পেন বট ডাউনলোড${RESET}"
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    
    local repo_url="https://github.com/Ariyan20267/Ariyanbd.git"
    local target_dir="/opt/freefire-spen-bot"
    
    echo -e "${YELLOW}${BOLD}  [*] রিপোজিটরি ক্লোন করা হচ্ছে...${RESET}"
    
    # পুরনো ফাইল মুছে ফেলা
    if [ -d "$target_dir" ]; then
        echo -e "${YELLOW}${BOLD}  [!] পুরনো ফাইল মুছে ফেলা হচ্ছে...${RESET}"
        sudo rm -rf "$target_dir"
    fi
    
    # ক্লোন
    if git clone --depth 1 "$repo_url" "$target_dir"; then
        echo -e "${GREEN}${BOLD}  [✔] ক্লোন সম্পূর্ণ!${RESET}"
        
        # পারমিশন সেট
        sudo chmod +x "$target_dir"/*.py 2>/dev/null
        sudo chmod -R 755 "$target_dir"
        
        # requirements.txt থাকলে ইনস্টল
        if [ -f "$target_dir/requirements.txt" ]; then
            echo -e "${YELLOW}${BOLD}  [*] requirements.txt থেকে মডিউল ইনস্টল করা হচ্ছে...${RESET}"
            cd "$target_dir"
            python3 -m pip install -r requirements.txt -q 2>/dev/null || true
            cd - > /dev/null
        fi
        
        # .env ফাইল তৈরি (যদি না থাকে)
        if [ ! -f "$target_dir/.env" ] && [ ! -f "$target_dir/config.env" ]; then
            echo -e "${YELLOW}${BOLD}  [*] .env ফাইল তৈরি করা হচ্ছে...${RESET}"
            cat > "$target_dir/.env" << EOF
# ফ্রি ফায়ার স্পেন বট কনফিগারেশন
BOT_TOKEN=your_bot_token_here
API_ID=your_api_id_here
API_HASH=your_api_hash_here
ADMIN_IDS=your_admin_ids_here
DATABASE_URL=sqlite:///./bot_data.db
EOF
            echo -e "${GREEN}${BOLD}  [✔] .env ফাইল তৈরি হয়েছে${RESET}"
            echo -e "${YELLOW}${BOLD}  [!] .env ফাইল এডিট করে আপনার টোকেন দিন:${RESET}"
            echo -e "${CYAN}${BOLD}     nano $target_dir/.env${RESET}"
        fi
        
        echo ""
        echo -e "${GREEN}${BOLD}  🚀 main.py রান করা হচ্ছে...${RESET}"
        echo ""
        sleep 2
        
        # main.py রান
        cd "$target_dir"
        python3 main.py
        
        return 0
    else
        echo -e "${RED}${BOLD}  [✗] ক্লোন ব্যর্থ!${RESET}"
        echo -e "${YELLOW}${BOLD}  [!] ম্যানুয়ালি চেষ্টা করুন:${RESET}"
        echo -e "${CYAN}${BOLD}     git clone $repo_url${RESET}"
        return 1
    fi
}

# ============================================================
# MAIN EXECUTION
# ============================================================
clear

echo -e "${CYAN}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║     🔥 FREE FIRE SPEN BOT - VPS AUTO SETUP 🔥            ║"
echo "║                                                           ║"
echo "║     📦 মডিউল ইনস্টল → 📥 ক্লোন → 🚀 রান                 ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${RESET}"

print_ff_logo 0 0

echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo -e "${CYAN}${BOLD}     🚀 অটো সেটআপ শুরু হচ্ছে...${RESET}"
echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

# STEP 1: OS ডিটেক্ট
echo -e "${BLUE}${BOLD}  [1/3] OS ডিটেক্ট করা হচ্ছে...${RESET}"
detect_os
echo ""

# STEP 2: Python + মডিউল ইনস্টল
echo -e "${BLUE}${BOLD}  [2/3] Python এবং মডিউল ইনস্টল করা হচ্ছে...${RESET}"
install_python
if [ $? -ne 0 ]; then
    echo -e "${RED}${BOLD}  [✗] Python ইনস্টল ব্যর্থ!${RESET}"
    exit 1
fi
echo ""
install_modules
echo ""

# STEP 3: ক্লোন ও রান
echo -e "${BLUE}${BOLD}  [3/3] ক্লোন করা হচ্ছে এবং main.py রান করা হচ্ছে...${RESET}"
clone_and_run
