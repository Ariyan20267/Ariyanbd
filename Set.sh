#!/usr/bin/env bash

# ============================================================
#         FREE FIRE SPEN BOT - VPS AUTO SETUP
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

FLASH=("$RED" "$ORANGE" "$YELLOW" "$WHITE" "$PINK" "$PURPLE" "$CYAN" "$GREEN" "$ORANGE" "$RED" "$YELLOW" "$PINK" "$PURPLE")

# ============================================================
# FREE FIRE LOGO (আরিয়ান ভার্সন)
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

# ============================================================
# RGB PROGRESS BAR
# ============================================================
rgb_bar() {
    local filled=$1
    local total=30
    local bar=""
    for i in $(seq 1 $total); do
        local ci=$(( (i + filled) % RGB_LEN ))
        local c="${RGB[$ci]}"
        if [ "$i" -le "$filled" ]; then
            bar="${bar}${c}${BOLD}█${RESET}"
        else
            bar="${bar}${DIM}░${RESET}"
        fi
    done
    echo -ne "$bar"
}

# ============================================================
# VPS SETUP FUNCTIONS
# ============================================================

# OS Detection
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

# Package Manager Detection
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

# Install Python and pip
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
            echo -e "${YELLOW}${BOLD}  [!] ম্যানুয়ালি Python ইনস্টল করুন${RESET}"
            return 1
            ;;
    esac
    
    # Python 3.8+ চেক
    python_version=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
    if [ "$(echo "$python_version < 3.8" | bc)" -eq 1 ]; then
        echo -e "${YELLOW}${BOLD}  [!] Python $python_version পাওয়া গেছে (3.8+ প্রয়োজন)${RESET}"
        echo -e "${YELLOW}${BOLD}  [!] Python 3.8+ ইনস্টল করার চেষ্টা করা হচ্ছে...${RESET}"
        case $pkg_manager in
            apt)
                sudo apt install -y python3.8 python3.8-pip python3.8-venv
                ;;
            *)
                echo -e "${RED}${BOLD}  [✗] অনুগ্রহ করে Python 3.8+ ম্যানুয়ালি ইনস্টল করুন${RESET}"
                return 1
                ;;
        esac
    fi
    
    echo -e "${GREEN}${BOLD}  [✔] Python $(python3 --version) প্রস্তুত${RESET}"
}

# ============================================================
# টেলিগ্রাম বটের জন্য প্রয়োজনীয় মডিউল ইনস্টল
# ============================================================
install_telegram_modules() {
    echo ""
    echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${PURPLE}${BOLD}     📦 টেলিগ্রাম বট মডিউল ইনস্টল হচ্ছে...${RESET}"
    echo -e "${PURPLE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    
    # প্রয়োজনীয় মডিউল লিস্ট
    local modules=(
        # টেলিগ্রাম বট মূল মডিউল
        "python-telegram-bot==20.7"
        "telegram"
        "pyTelegramBotAPI"
        
        # HTTP এবং Network
        "requests"
        "aiohttp"
        "httpx"
        "urllib3"
        
        # ডাটাবেস
        "sqlalchemy"
        "aiosqlite"
        "sqlite3"
        
        # JSON এবং ডেটা প্রসেসিং
        "simplejson"
        "ujson"
        "json5"
        
        # এনক্রিপশন
        "pycryptodome"
        "cryptography"
        "PyJWT"
        
        # প্রোটোকল
        "protobuf"
        "protobuf3"
        
        # ওয়েব স্ক্র্যাপিং
        "beautifulsoup4"
        "lxml"
        "selenium"
        "webdriver-manager"
        
        # ইমেজ প্রসেসিং (যদি প্রয়োজন হয়)
        "Pillow"
        "opencv-python"
        
        # ইউটিলিটি
        "python-dotenv"
        "pyyaml"
        "toml"
        "pytz"
        "python-dateutil"
        "click"
        "rich"
        "colorama"
        
        # অ্যাসিঙ্ক
        "asyncio"
        "aiofiles"
        "asyncio-throttle"
        
        # লগিং
        "loguru"
        "python-json-logger"
        
        # টেলিগ্রাম API ক্লায়েন্ট
        "telethon"
        "pyrogram"
        
        # গেমিং এবং ফ্রি ফায়ার স্পেসিফিক
        "pyautogui"
        "pydirectinput"
        "opencv-python-headless"
        
        # এক্সট্রা
        "psutil"
        "python-multipart"
        "pydantic"
        "pydantic-settings"
        "nest-asyncio"
        "flask"
        "flask-cors"
        "fastapi"
        "uvicorn"
        "gunicorn"
        
        # টেস্টিং
        "pytest"
        "pytest-asyncio"
        
        # ডকুমেন্টেশন
        "sphinx"
        "sphinx-rtd-theme"
    )
    
    # পাইপ আপগ্রেড
    echo -e "${CYAN}${BOLD}  [*] pip আপগ্রেড করা হচ্ছে...${RESET}"
    python3 -m pip install --upgrade pip setuptools wheel -q
    
    echo ""
    
    local total=${#modules[@]}
    local done=0
    local failed=()
    
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
        echo -e "${YELLOW}${BOLD}  [!] আবার চেষ্টা করতে চাইলে চালান: python3 -m pip install <module_name>${RESET}"
    else
        echo -e "${GREEN}${BOLD}  [✔] সব মডিউল সফলভাবে ইনস্টল হয়েছে!${RESET}"
    fi
}

# ============================================================
# ফ্রি ফায়ার স্পেন বট ক্লোন ও সেটআপ
# ============================================================
setup_freefire_bot() {
    echo ""
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${CYAN}${BOLD}     🎮 ফ্রি ফায়ার স্পেন বট সেটআপ${RESET}"
    echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    
    # গিট ক্লোন
    local repo_url="https://github.com/Ariyan20267/Gen.git"
    local target_dir="/opt/freefire-spen-bot"
    
    echo -e "${YELLOW}${BOLD}  [*] রিপোজিটরি ক্লোন করা হচ্ছে...${RESET}"
    
    if [ -d "$target_dir" ]; then
        echo -e "${YELLOW}${BOLD}  [!] পুরনো ফাইল মুছে ফেলা হচ্ছে...${RESET}"
        sudo rm -rf "$target_dir"
    fi
    
    if git clone --depth 1 "$repo_url" "$target_dir"; then
        echo -e "${GREEN}${BOLD}  [✔] ক্লোন সম্পূর্ণ!${RESET}"
        
        # পারমিশন সেট
        sudo chmod +x "$target_dir"/*.py 2>/dev/null
        sudo chmod -R 755 "$target_dir"
        
        # .env ফাইল তৈরি (যদি না থাকে)
        if [ ! -f "$target_dir/.env" ]; then
            echo -e "${YELLOW}${BOLD}  [*] .env ফাইল তৈরি করা হচ্ছে...${RESET}"
            cat > "$target_dir/.env" << EOF
# ফ্রি ফায়ার স্পেন বট কনফিগারেশন
BOT_TOKEN=your_bot_token_here
API_ID=your_api_id_here
API_HASH=your_api_hash_here
ADMIN_IDS=your_admin_ids_here
DATABASE_URL=sqlite:///./bot_data.db
REDIS_URL=redis://localhost:6379/0
EOF
            echo -e "${GREEN}${BOLD}  [✔] .env ফাইল তৈরি হয়েছে${RESET}"
            echo -e "${YELLOW}${BOLD}  [!] .env ফাইল এডিট করে আপনার টোকেন দিন:${RESET}"
            echo -e "${CYAN}${BOLD}     nano $target_dir/.env${RESET}"
        fi
        
        # রিকোয়ারমেন্টস ইনস্টল (যদি থাকে)
        if [ -f "$target_dir/requirements.txt" ]; then
            echo -e "${YELLOW}${BOLD}  [*] requirements.txt থেকে মডিউল ইনস্টল করা হচ্ছে...${RESET}"
            cd "$target_dir"
            python3 -m pip install -r requirements.txt -q 2>/dev/null || true
            cd - > /dev/null
        fi
        
        return 0
    else
        echo -e "${RED}${BOLD}  [✗] ক্লোন ব্যর্থ!${RESET}"
        return 1
    fi
}

# ============================================================
# সিস্টেম সার্ভিস তৈরি (systemd)
# ============================================================
create_systemd_service() {
    local service_name="freefire-spen-bot"
    local target_dir="/opt/freefire-spen-bot"
    
    echo ""
    echo -e "${CYAN}${BOLD}  [*] সিস্টেম সার্ভিস তৈরি করা হচ্ছে...${RESET}"
    
    # সার্ভিস ফাইল তৈরি
    cat > "/tmp/$service_name.service" << EOF
[Unit]
Description=Free Fire Spen Bot Service
After=network.target
Wants=network.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$target_dir
ExecStart=/usr/bin/python3 $target_dir/main.py
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal
SyslogIdentifier=$service_name
Environment="PYTHONUNBUFFERED=1"

[Install]
WantedBy=multi-user.target
EOF
    
    # সার্ভিস ফাইল কপি
    if sudo cp "/tmp/$service_name.service" "/etc/systemd/system/"; then
        sudo systemctl daemon-reload
        sudo systemctl enable "$service_name"
        echo -e "${GREEN}${BOLD}  [✔] সার্ভিস তৈরি হয়েছে!${RESET}"
        echo -e "${CYAN}${BOLD}  [*] চালু করতে: sudo systemctl start $service_name${RESET}"
        echo -e "${CYAN}${BOLD}  [*] স্ট্যাটাস দেখতে: sudo systemctl status $service_name${RESET}"
        echo -e "${CYAN}${BOLD}  [*] লগ দেখতে: sudo journalctl -u $service_name -f${RESET}"
    else
        echo -e "${YELLOW}${BOLD}  [!] সার্ভিস তৈরি করতে পারেনি (sudo প্রয়োজন)${RESET}"
        echo -e "${YELLOW}${BOLD}  [!] ম্যানুয়ালি চালাতে: cd $target_dir && python3 main.py${RESET}"
    fi
}

# ============================================================
# MAIN SETUP
# ============================================================
clear

echo -e "${CYAN}${BOLD}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                                                           ║"
echo "║     🔥 FREE FIRE SPEN BOT - VPS AUTO SETUP 🔥            ║"
echo "║                                                           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${RESET}"

print_ff_logo 0 0

echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo -e "${CYAN}${BOLD}     🚀 VPS Setup শুরু হচ্ছে...${RESET}"
echo -e "${CYAN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

# 1. OS ডিটেক্ট
echo -e "${BLUE}${BOLD}  [1/5] OS ডিটেক্ট করা হচ্ছে...${RESET}"
detect_os
echo ""

# 2. Python ইনস্টল
echo -e "${BLUE}${BOLD}  [2/5] Python ইনস্টল করা হচ্ছে...${RESET}"
install_python
if [ $? -ne 0 ]; then
    echo -e "${RED}${BOLD}  [✗] Python ইনস্টল ব্যর্থ!${RESET}"
    exit 1
fi
echo ""

# 3. টেলিগ্রাম মডিউল ইনস্টল
echo -e "${BLUE}${BOLD}  [3/5] টেলিগ্রাম মডিউল ইনস্টল করা হচ্ছে...${RESET}"
install_telegram_modules
echo ""

# 4. ফ্রি ফায়ার বট সেটআপ
echo -e "${BLUE}${BOLD}  [4/5] ফ্রি ফায়ার বট সেটআপ করা হচ্ছে...${RESET}"
setup_freefire_bot
echo ""

# 5. সার্ভিস তৈরি (ঐচ্ছিক)
echo -e "${BLUE}${BOLD}  [5/5] সিস্টেম সার্ভিস তৈরি...${RESET}"
echo -e "${YELLOW}${BOLD}  [!] সার্ভিস তৈরি করতে চান? (y/n)${RESET}"
read -r create_service
if [[ "$create_service" =~ ^[Yy]$ ]]; then
    create_systemd_service
else
    echo -e "${YELLOW}${BOLD}  [!] সার্ভিস তৈরি করা হলো না${RESET}"
    echo -e "${CYAN}${BOLD}  [*] ম্যানুয়ালি চালাতে: cd /opt/freefire-spen-bot && python3 main.py${RESET}"
fi

echo ""
echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo -e "${GREEN}${BOLD}     ✅ সেটআপ সম্পূর্ণ! বট রান করার জন্য প্রস্তুত${RESET}"
echo -e "${GREEN}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""
echo -e "${CYAN}${BOLD}  📝 গুরুত্বপূর্ণ তথ্য:${RESET}"
echo -e "${YELLOW}  • বট লোকেশন: /opt/freefire-spen-bot${RESET}"
echo -e "${YELLOW}  • কনফিগ: nano /opt/freefire-spen-bot/.env${RESET}"
echo -e "${YELLOW}  • চালাতে: cd /opt/freefire-spen-bot && python3 main.py${RESET}"
echo -e "${YELLOW}  • সার্ভিস চালাতে: sudo systemctl start freefire-spen-bot${RESET}"
echo -e "${YELLOW}  • সার্ভিস স্ট্যাটাস: sudo systemctl status freefire-spen-bot${RESET}"
echo -e "${YELLOW}  • লগ দেখতে: sudo journalctl -u freefire-spen-bot -f${RESET}"
echo ""
