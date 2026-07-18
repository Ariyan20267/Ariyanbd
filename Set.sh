#!/data/data/com.termux/files/usr/bin/bash

# ══════════════════════════════════════════
#   TERMUX SETUP v6.1 - FOLDER ICON BOX
# ══════════════════════════════════════════

NC='\033[0m'; BOLD='\033[1m'; DIM='\033[2m'
G='\033[38;5;82m'; Y='\033[38;5;226m'
C='\033[38;5;51m'; S='\033[38;5;242m'
W='\033[1;37m'; R='\033[38;5;196m'
M='\033[38;5;201m'

TW=$(tput cols 2>/dev/null || echo 58)

ok()      { echo -e "  ${G}${BOLD}✔${NC}  ${S}$1${NC}"; }
section() {
    echo ""
    echo -e "  ${C}${BOLD}◈  $1${NC}"
    echo -en "  ${DIM}${S}"
    printf '─%.0s' $(seq 1 $((TW-2)))
    echo -e "${NC}"
}

spin() {
    local msg="$1"
    local frames='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 $! 2>/dev/null; do
        printf "\r  ${C}${frames:$((i % 10)):1}${NC}  ${S}${msg}${NC}  "
        i=$((i+1)); sleep 0.08
    done
    printf "\r  ${G}${BOLD}✔${NC}  ${S}${msg}${NC}\n"
}

# ── Intro ─────────────────────────────────
clear; echo ""
MSG="  ◤ SETUP INITIALIZING ◢"
echo -en "  ${C}${BOLD}"
for ((i=0; i<${#MSG}; i++)); do printf "${MSG:$i:1}"; sleep 0.008; done
echo -e "${NC}\n"

echo -en "  ${S}["
for ((i=0; i<40; i++)); do echo -en "${C}█"; sleep 0.004; done
echo -e "${S}]${NC}  ${G}${BOLD}OK${NC}\n"
sleep 0.05

# ── [1] Packages ──────────────────────────
section "[1] Packages"
(pkg update -y -q 2>/dev/null) & spin "Updating"
(pkg upgrade -y -q 2>/dev/null) & spin "Upgrading"
for p in zsh git ncurses-utils curl; do
    (pkg install -y -q "$p" 2>/dev/null) & spin "Installing $p"
done

# ── [2] Oh My Zsh ─────────────────────────
section "[2] Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    (git clone --depth=1 -q https://github.com/ohmyzsh/ohmyzsh.git \
        "$HOME/.oh-my-zsh" 2>/dev/null) & spin "Cloning Oh My Zsh"
else
    ok "Already installed"
fi
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# ── [3] Plugins ───────────────────────────
section "[3] Plugins"
_pl() {
    if [ ! -d "${ZSH_CUSTOM}/plugins/$1" ]; then
        (git clone --depth=1 -q "$2" \
            "${ZSH_CUSTOM}/plugins/$1" 2>/dev/null) & spin "$1"
    else
        ok "$1 (exists)"
    fi
}
_pl zsh-autosuggestions          https://github.com/zsh-users/zsh-autosuggestions
_pl zsh-syntax-highlighting      https://github.com/zsh-users/zsh-syntax-highlighting
_pl zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search

# ── [4] ASCII Font Install ────────────────
section "[4] ASCII Font Setup"

cat > "$HOME/.ascii_font.txt" << 'FONTEOF'
A
░█████╗░
██╔══██╗
███████║
██╔══██║
██║░░██║
╚═╝░░╚═╝

B
██████╗░
██╔══██╗
██████╦╝
██╔══██╗
██████╦╝
╚═════╝░

C
░█████╗░
██╔══██╗
██║░░╚═╝
██║░░██╗
╚█████╔╝
░╚════╝░

D
██████╗░
██╔══██╗
██║░░██║
██║░░██║
██████╔╝
╚═════╝░

E
███████╗
██╔════╝
█████╗░░
██╔══╝░░
███████╗
╚══════╝

F
███████╗
██╔════╝
█████╗░░
██╔══╝░░
██║░░░░░
╚═╝░░░░░

G
░██████╗░
██╔════╝░
██║░░██╗░
██║░░╚██╗
╚██████╔╝
░╚═════╝░

H
██╗░░██╗
██║░░██║
███████║
██╔══██║
██║░░██║
╚═╝░░╚═╝

I
██╗
██║
██║
██║
██║
╚═╝

J
░░░░░██╗
░░░░░██║
░░░░░██║
██╗░░██║
╚█████╔╝
░╚════╝░

K
██╗░░██╗
██║░██╔╝
█████╔═╝░
██╔═██╗░░
██║░╚██╗░
╚═╝░░╚═╝░

L
██╗░░░░░
██║░░░░░
██║░░░░░
██║░░░░░
███████╗
╚══════╝

M
███╗░░░███╗
████╗░████║
██╔████╔██║
██║╚██╔╝██║
██║░╚═╝░██║
╚═╝░░░░░╚═╝

N
███╗░░██╗
████╗░██║
██╔██╗██║
██║╚████║
██║░╚███║
╚═╝░░╚══╝

O
░█████╗░
██╔══██╗
██║░░██║
██║░░██║
╚█████╔╝
░╚════╝░

P
██████╗░
██╔══██╗
██████╔╝
██╔═══╝░
██║░░░░░
╚═╝░░░░░

Q
░██████╗░
██╔═══██╗
██║██╗██║
╚██████╔╝
░╚═██╔═╝░
░░░╚═╝░░░

R
██████╗░
██╔══██╗
██████╔╝
██╔══██╗
██║░░██║
╚═╝░░╚═╝

S
░██████╗
██╔════╝
╚█████╗░
░╚═══██╗
██████╔╝
╚═════╝░

T
████████╗
╚══██╔══╝
░░░██║░░░
░░░██║░░░
░░░██║░░░
░░░╚═╝░░░

U
██╗░░░██╗
██║░░░██║
██║░░░██║
██║░░░██║
╚██████╔╝
░╚═════╝░

V
██╗░░░██╗
╚██╗░██╔╝
░╚████╔╝░
░░╚██╔╝░░
░░░██║░░░
░░░╚═╝░░░

W
██╗░░░░░░░██╗
╚██╗░░██╗░██╔╝
░╚████╔═████║░
░░╚██╔╝░╚██╔╝░
░░░██║░░░██║░░
░░░╚═╝░░░╚═╝░░

X
██╗░░██╗
╚██╗██╔╝
░╚███╔╝░
░██╔██╗░
██╔╝╚██╗
╚═╝░░╚═╝

Y
██╗░░░██╗
╚██╗░██╔╝
░╚████╔╝░
░░╚██╔╝░░
░░░██║░░░
░░░╚═╝░░░

Z
███████╗
╚═══██╔╝
░░░██╔╝░
░░██╔╝░░
░███████╗
░╚══════╝

SPACE

FONTEOF

ok "ASCII font installed"

# ── [5] Prompt Design Database ────────────
section "[5] Prompt Designs"

cat > "$HOME/.prompt_designs.txt" << 'PROMPTEOF'
1|╭─❨ _USER_ ❩──❨ %~ ❩──❨ _TIME_ ❩|╰──❯❯❯
2|┌─[ _USER_ ][ %~ ][ _TIME_ ]|└──❯❯❯
3|╔══[ _USER_ ]══[ %~ ]|╚══❯❯❯
4|┏━ _USER_ ━ %~ ━ _TIME_ ━┓|┗━❯❯❯
5|─[ _USER_ ]─[ %~ ]─[ _TIME_ ]─|⁝❯❯❯
6|▛▀▀ _USER_ ▀▀ %~ ▀▀ _TIME_ ▀▀▜|▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟
7|◈  _USER_  ◈  %~  ◈  _TIME_  ◈|   ❯❯❯
8|╓─ _USER_ ─ %~ ─ _TIME_ ─╖|╙───❯❯❯
9|┌────────────────────────────┐|❯❯❯
10|▐░░ _USER_ ░░ %~ ░░ _TIME_ ░░▌|▐▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▌
11|► _USER_ ► %~ ► _TIME_|══❯❯❯
12|╭┄ _USER_ ┄ %~ ┄ _TIME_ ┄╮|╰┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╯
13|✧ _USER_ ✧ %~ ✧ _TIME_|◂◂❯❯❯
14|[ _USER_ ][ %~ ][ _TIME_ ]|───❯❯❯
15|• • _USER_ • %~ • _TIME_ • •|  ────❯❯❯
16|--[ _USER_ ]--[ %~ ]--[ _TIME_ ]--|❯❯❯
17|╭─── _USER_ ─── %~ ─── _TIME_ ───╮|╰──❯❯❯
18|⬡ _USER_ ⬡ %~ ⬡ _TIME_|  ⬢❯❯❯
19|█▓▒░ _USER_ ░▒▓ %~ ▓▒░ _TIME_|█▓▒░❯❯❯
20|▔▔▔ _USER_ ▔▔▔ %~ ▔▔▔ _TIME_ ▔▔▔|▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
21|╭─────⋆⟡ _USER_ ⟡⋆─────╮|╰━━━━━━━━━━━━━━━━━━━━➤
22|♛ _USER_ ♛ [ %~ ] ♛ _TIME_|╰─❯
23|▓▓▓ _USER_ ▓▓▓ %~ ▓▓▓ _TIME_|▓▓▓❯❯❯
24|▀▀▀ _USER_ ▀▀▀ %~ ▀▀▀ _TIME_ ▀▀▀|▄▄▄❯❯❯
25|◤ _USER_ ◢ ◤ %~ ◢ ◤ _TIME_ ◢|◥❯❯❯
26|● _USER_ ● %~ ● _TIME_|○❯❯❯
27|■ _USER_ ■ %~ ■ _TIME_|□❯❯❯
28|▲ _USER_ ▲ %~ ▲ _TIME_|△❯❯❯
29|◆ _USER_ ◆ %~ ◆ _TIME_|◇❯❯❯
30|▼ _USER_ ▼ %~ ▼ _TIME_|▽❯❯❯
31|⏺ _USER_ ⏺ %~ ⏺ _TIME_|⏭❯❯❯
32|⚡ _USER_ ⚡ %~ ⚡ _TIME_|⚡❯❯❯
33|🔷 _USER_ 🔷 %~ 🔷 _TIME_|🔹❯❯❯
34|💎 _USER_ 💎 %~ 💎 _TIME_|💠❯❯❯
35|🌟 _USER_ 🌟 %~ 🌟 _TIME_|⭐❯❯❯
36|🔥 _USER_ 🔥 %~ 🔥 _TIME_|💢❯❯❯
37|👑 _USER_ 👑 %~ 👑 _TIME_|🏆❯❯❯
38|╔═══ _USER_ ═══ %~ ═══ _TIME_ ═══╗|╚════❯❯❯
39|╭┄┄ _USER_ ┄┄ %~ ┄┄ _TIME_ ┄┄╮|╰┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄╯
40|┏━━ _USER_ ━━ %~ ━━ _TIME_ ━━┓|┗━━━━❯❯❯
PROMPTEOF

ok "40 prompt designs loaded"

# ── নাম জিজ্ঞেস করা ──────────────────────
section "[6] User Setup"
echo ""
echo -e "  ${C}${BOLD}আপনার নাম লিখুন (Banner-এ দেখাবে):${NC}"
echo -en "  ${Y}${BOLD}➤  ${NC}"
read -r USER_NAME

if [ -z "$USER_NAME" ]; then
    USER_NAME="USER"
fi

USER_NAME=$(echo "$USER_NAME" | tr '[:lower:]' '[:upper:]')
echo "$USER_NAME" > "$HOME/.terminal_username"
ok "নাম সেভ হয়েছে: $USER_NAME"

# ── [7] Prompt Selection ──────────────────
section "[7] Select Prompt Design"

show_all_prompts() {
    clear
    echo ""
    echo -e "  ${C}${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "  ${C}${BOLD}║${NC}  ${Y}${BOLD}✦  40 PROMPT DESIGNS - SELECT YOUR STYLE  ✦${NC}     ${C}${BOLD}║${NC}"
    echo -e "  ${C}${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    while IFS='|' read -r num line1 line2; do
        display_line1=$(echo "$line1" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")
        display_line2=$(echo "$line2" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")
        
        if [ $num -le 9 ]; then
            echo -e "  ${M}${BOLD} 0${num})${NC}  ${W}${display_line1}${NC}"
            echo -e "       ${W}${display_line2}${NC}"
        else
            echo -e "  ${M}${BOLD} ${num})${NC}  ${W}${display_line1}${NC}"
            echo -e "       ${W}${display_line2}${NC}"
        fi
        echo ""
    done < "$HOME/.prompt_designs.txt"
    
    echo ""
    echo -e "  ${C}${BOLD}════════════════════════════════════════════════════════${NC}"
}

show_all_prompts

echo ""
echo -en "  ${G}${BOLD}আপনার পছন্দের ডিজাইন নাম্বার লিখুন (1-40): ${NC}"
echo -en "${Y}${BOLD}"
read -r PROMPT_NUM
echo -en "${NC}"

while ! [[ "$PROMPT_NUM" =~ ^[0-9]+$ ]] || [ "$PROMPT_NUM" -lt 1 ] || [ "$PROMPT_NUM" -gt 40 ]; do
    echo -e "  ${R}${BOLD}✘ ভুল! 1-40 এর মধ্যে নাম্বার দিন${NC}"
    echo -en "  ${G}${BOLD}আবার চেষ্টা করুন: ${NC}"
    read -r PROMPT_NUM
done

SELECTED_PROMPT=$(grep "^$PROMPT_NUM|" "$HOME/.prompt_designs.txt")
PROMPT_LINE1_TEMPLATE=$(echo "$SELECTED_PROMPT" | cut -d'|' -f2)
PROMPT_LINE2_TEMPLATE=$(echo "$SELECTED_PROMPT" | cut -d'|' -f3)

ok "ডিজাইন #$PROMPT_NUM সিলেক্ট করা হয়েছে"

echo ""
echo -e "  ${Y}${BOLD}প্রিভিউ:${NC}"
echo -e "  ${W}$(echo "$PROMPT_LINE1_TEMPLATE" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")${NC}"
echo -e "  ${W}$(echo "$PROMPT_LINE2_TEMPLATE" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")${NC}"
echo ""

# ── [8] Banner Script ─────────────────────
section "[8] Building Banner"

cat > "$HOME/.terminal_banner.sh" << 'BEOF'
#!/data/data/com.termux/files/usr/bin/bash

NC='\033[0m'; BOLD='\033[1m'; DIM='\033[2m'
F='\033[38;5;238m'
TW=$(tput cols 2>/dev/null || echo 58)

USERNAME_FILE="$HOME/.terminal_username"
if [ -f "$USERNAME_FILE" ]; then
    UNAME=$(cat "$USERNAME_FILE")
else
    UNAME="USER"
fi

FONT_FILE="$HOME/.ascii_font.txt"

SETS=("51 87 123 159 226" "201 165 129 93 226" "82 118 154 190 226"
      "196 202 208 214 220" "93 135 177 219 226" "46 83 120 157 194"
      "33 69 105 141 177" "171 177 183 189 195")
IFS=' ' read -r P1 P2 P3 P4 P5 <<< "${SETS[$((RANDOM % ${#SETS[@]}))]}"
A="\033[38;5;${P1}m"
B="\033[38;5;${P2}m"
C="\033[38;5;${P3}m"
D="\033[38;5;${P4}m"
E="\033[38;5;${P5}m"

_thin() {
    echo -en "${F}${DIM}"
    printf '─%.0s' $(seq 1 $TW)
    echo -e "${NC}"
}

_ascii_art() {
    local text="$1"
    local font_file="$2"
    
    declare -A CHAR_MAP
    local current_char=""
    local lines=()
    local reading=false
    
    while IFS= read -r line; do
        if [[ "$line" =~ ^[A-Z]$ ]] && [ ${#line} -eq 1 ]; then
            if [ -n "$current_char" ] && [ ${#lines[@]} -gt 0 ]; then
                CHAR_MAP["$current_char"]=$(printf '%s\n' "${lines[@]}")
            fi
            current_char="$line"
            lines=()
            reading=true
        elif [[ "$line" == "SPACE" ]]; then
            if [ -n "$current_char" ] && [ ${#lines[@]} -gt 0 ]; then
                CHAR_MAP["$current_char"]=$(printf '%s\n' "${lines[@]}")
            fi
            current_char=" "
            lines=()
            reading=true
        elif [ "$reading" = true ] && [ -z "$line" ] && [ -n "$current_char" ]; then
            if [ ${#lines[@]} -gt 0 ]; then
                CHAR_MAP["$current_char"]=$(printf '%s\n' "${lines[@]}")
            fi
            current_char=""
            lines=()
            reading=false
        elif [ "$reading" = true ] && [ -n "$line" ]; then
            lines+=("$line")
        fi
    done < "$font_file"
    
    if [ -n "$current_char" ] && [ ${#lines[@]} -gt 0 ]; then
        CHAR_MAP["$current_char"]=$(printf '%s\n' "${lines[@]}")
    fi
    
    local result_lines=()
    local name_length=${#text}
    
    for ((i=0; i<6; i++)); do
        local combined_line=""
        for ((j=0; j<name_length; j++)); do
            local char="${text:$j:1}"
            if [ -n "${CHAR_MAP[$char]}" ]; then
                local char_lines=()
                IFS=$'\n' read -rd '' -a char_lines <<< "${CHAR_MAP[$char]}"
                if [ $i -lt ${#char_lines[@]} ]; then
                    combined_line+="${char_lines[$i]}  "
                fi
            else
                combined_line+="      "
            fi
        done
        result_lines+=("$combined_line")
    done
    
    for line in "${result_lines[@]}"; do
        echo "$line"
    done
}

clear
echo ""
echo -en "${A}${BOLD}"
printf '▄%.0s' $(seq 1 $TW)
echo -e "${NC}"
echo ""

if [ -f "$FONT_FILE" ]; then
    COLORS=("${A}" "${B}" "${C}" "${D}" "${E}" "${A}")
    
    ascii_output=$(_ascii_art "$UNAME" "$FONT_FILE")
    line_index=0
    
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            COLOR="${COLORS[$((line_index % ${#COLORS[@]}))]}"
            line_len=${#line}
            pad=$(( (TW - line_len) / 2 ))
            [ $pad -lt 0 ] && pad=0
            
            printf "%${pad}s"
            echo -e "${COLOR}${BOLD}${line}${NC}"
            sleep 0.012
        fi
        ((line_index++))
    done <<< "$ascii_output"
else
    echo ""
    NAME_PAD=$(( (TW - ${#UNAME}) / 2 ))
    printf "%${NAME_PAD}s"
    echo -e "${A}${BOLD}[ ${UNAME} ]${NC}"
    echo ""
fi

echo ""
SUB="◈  E L I T E   T E R M I N A L  ◈"
pad=$(( (TW - ${#SUB}) / 2 ))
printf "%${pad}s"
echo -en "${E}${BOLD}"
for ((i=0; i<${#SUB}; i++)); do printf "${SUB:$i:1}"; sleep 0.004; done
echo -e "${NC}"
echo ""
echo -en "${C}${BOLD}"
printf '▀%.0s' $(seq 1 $TW)
echo -e "${NC}"
echo ""

DATE_V=$(date +"%-d %B %Y  ·  %A")
TIME_V=$(date +"%I:%M:%S %p")

# ── Network status (real connectivity check) ──
IP_V=""
if command -v ip >/dev/null 2>&1; then
    IP_V=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
fi
if [ -z "$IP_V" ] && command -v ifconfig >/dev/null 2>&1; then
    IP_V=$(ifconfig 2>/dev/null | grep -Eo 'inet (addr:)?([0-9]{1,3}\.){3}[0-9]{1,3}' | grep -v '127.0.0.1' | awk '{print $NF}' | head -n1)
fi
if [ -z "$IP_V" ]; then
    if curl -s --max-time 2 -o /dev/null -w "%{http_code}" "http://clients3.google.com/generate_204" 2>/dev/null | grep -q "204"; then
        IP_V="Online"
    else
        IP_V="Offline"
    fi
fi

STOR_V=$(df -h "$HOME" 2>/dev/null | awk 'NR==2{print $4" free / "$2}' || echo "N/A")
RAM_V=$(free -m 2>/dev/null | awk 'NR==2{printf "%d/%d MB", $3, $2}' || echo "N/A")

BW=$((TW - 4))

echo -en "  ${A}${BOLD}╔"
printf '═%.0s' $(seq 1 $BW)
echo -e "╗${NC}"

_row() {
    local icon="$1" label="$2" val="$3"
    echo -en "  ${A}${BOLD}║${NC}  \033[38;5;51m${BOLD}${icon}${NC}  \033[38;5;245m$(printf '%-8s' "${label}")${NC}  ${F}│${NC}  \033[38;5;252m${val}${NC}"
    local used=$(( ${#label} + ${#val} + ${#icon} + 12 ))
    local pad=$(( BW - used ))
    if [ $pad -gt 0 ]; then printf '%*s' "$pad" ""; fi
    echo -e "  ${A}${BOLD}║${NC}"
    sleep 0.01
}

_mid() {
    echo -en "  ${A}${BOLD}╠"
    printf '═%.0s' $(seq 1 $BW)
    echo -e "╣${NC}"
}

_mid
_row "▤" "DATE"    "${DATE_V}"
_row "⏱" "TIME"    "${TIME_V}"
_mid
_row "◎" "NETWORK" "${IP_V}"
_row "▥" "STORAGE" "${STOR_V}"
_row "✳" "MEMORY"  "${RAM_V}"
_mid

echo -en "  ${A}${BOLD}╚"
printf '═%.0s' $(seq 1 $BW)
echo -e "╝${NC}"

echo ""
_thin

QS=(
    "Root access to the world is earned, not given."
    "Think like a hacker. Build like an engineer."
    "Breaking limits, one terminal at a time."
    "Stay focused. Stay dangerous."
    "In zeros and ones — you are the one."
    "The quieter you become, the more you can hear."
    "Every master was once a beginner."
    "Code hard. Dream bigger."
    "chmod 777 your ambitions."
    "Silence is the loudest weapon in your arsenal."
)
Q="${QS[$((RANDOM % ${#QS[@]}))]}"
pad=$(( (TW - ${#Q} - 6) / 2 ))
if [ $pad -lt 0 ]; then pad=0; fi
printf "%${pad}s"
echo -e "${F}${DIM}❝  ${Q}  ❞${NC}"
echo ""
BEOF

chmod +x "$HOME/.terminal_banner.sh"
ok "Banner ready"

# ── [9] .zshrc with Selected Prompt ───────
section "[9] ZSH Config"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak" && ok "Backed up old .zshrc"

# _USER_ এবং _TIME_ রিপ্লেস করে ভেরিয়েবল বসানো
PROMPT_LINE1_FINAL=$(echo "$PROMPT_LINE1_TEMPLATE" | sed 's/_USER_/${_TERM_USER}/g' | sed 's/_TIME_/%D{%H:%M}/g')
PROMPT_LINE2_FINAL=$(echo "$PROMPT_LINE2_TEMPLATE" | sed 's/_USER_/${_TERM_USER}/g' | sed 's/_TIME_/%D{%H:%M}/g')

cat > "$HOME/.zshrc" << ZEOF
# ══════════════════════════════════════════
#   ELITE TERMINAL - ZSH CONFIG
# ══════════════════════════════════════════

export ZSH="\$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export COLORTERM="truecolor"
export LANG="en_US.UTF-8"
ZSH_THEME=""

# ── Plugins ───────────────────────────────
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    history
    colored-man-pages
)

[ -f "\$ZSH/oh-my-zsh.sh" ] && source "\$ZSH/oh-my-zsh.sh"

# ── Autosuggestions ───────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238,bold'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_USE_ASYNC=true

# ── Syntax Highlighting ───────────────────
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=51,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=82,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=201,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=99,bold'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=196,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=226,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=220,underline'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=82'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=82'
ZSH_HIGHLIGHT_STYLES[comment]='fg=238,italic'

# ── Prompt Setup ──────────────────────────
_TERM_USER=\$(cat "\$HOME/.terminal_username" 2>/dev/null || echo "USER")

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats ' %F{201}⎇ %b%f'
zstyle ':vcs_info:*' enable git
setopt PROMPT_SUBST

# ── Folder Icon Box (⌂ home / ❐ folder, blue) ──
# হোমে থাকলে ⌂ আইকন, অন্য যেকোনো ফোল্ডারে গেলে ❐ আইকন দেখাবে (দুটোই নীল রঙে)
# একটা বক্সের মধ্যে path + ডানপাশে ✔ mark, নিচে tree connector
_folder_icon_box() {
    local cur="\$PWD" home="\$HOME" disp icon w inw border pad content

    w=\${COLUMNS:-\$(tput cols 2>/dev/null || echo 58)}
    (( w > 64 )) && w=64
    (( w < 20 )) && w=20
    inw=\$(( w - 2 ))

    if [ "\$cur" = "\$home" ]; then
        disp="~"
        icon="⌂"
    else
        disp="\${cur/#\$home/~}"
        icon="❐"
    fi

    border=\$(printf '─%.0s' \$(seq 1 \$inw))
    content="  \033[38;5;51m\033[1m\${icon}\033[0m  \033[38;5;252m\${disp}\033[0m"
    pad=\$(( inw - \${#disp} - 5 ))
    (( pad < 1 )) && pad=1

    echo ""
    echo -e "\033[38;5;51m\033[1m╭\${border}╮\033[0m"
    printf "\033[38;5;51m\033[1m│\033[0m%b" "\${content}"
    printf '%*s' "\${pad}" ""
    echo -e "\033[38;5;82m\033[1m✔\033[0m \033[38;5;51m\033[1m│\033[0m"
    echo -e "\033[38;5;51m\033[1m╰\${border}╯\033[0m"
    echo -en "\033[38;5;51m\033[1m╰─❯\033[0m "
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _folder_icon_box

# ── Selected Prompt Design #$PROMPT_NUM ───
PROMPT='%F{51}%B${PROMPT_LINE1_FINAL}%b%f\${vcs_info_msg_0_}
%F{51}%B${PROMPT_LINE2_FINAL}%b%f '

# ── History ───────────────────────────────
HISTFILE="\$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

# ── Keybindings ───────────────────────────
bindkey '^\[\[A' history-substring-search-up
bindkey '^\[\[B' history-substring-search-down
bindkey '^ '   autosuggest-accept
bindkey '^f'   autosuggest-accept
bindkey '^u'   backward-kill-line
bindkey '^w'   backward-kill-word
bindkey '^a'   beginning-of-line
bindkey '^k'   kill-line
bindkey '^r'   history-incremental-search-backward

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=51,fg=0,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=196,fg=255,bold'

# ── Aliases ───────────────────────────────
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias cls='clear && bash ~/.terminal_banner.sh'
alias banner='bash ~/.terminal_banner.sh'
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias update='pkg update -y && pkg upgrade -y'
alias install='pkg install -y'
alias myip='curl -s ifconfig.me && echo'
alias df='df -h'
alias free='free -m'
alias py='python3'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --color'

# ── Functions ─────────────────────────────
setname() {
    echo -n "নতুন নাম লিখুন: "
    read -r NEW_NAME
    if [ -n "\$NEW_NAME" ]; then
        echo "\$NEW_NAME" > "\$HOME/.terminal_username"
        echo "✔ নাম পরিবর্তন হয়েছে: \$NEW_NAME"
        echo "  Terminal রিস্টার্ট করুন অথবা: source ~/.zshrc"
    fi
}

prompts() {
    bash ~/.select_prompt.sh
}

mkcd() { mkdir -p "\$1" && cd "\$1"; }
backup() { cp "\$1" "\${1}.bak.\$(date +%Y%m%d_%H%M%S)"; }

# ── Startup Banner ────────────────────────
[ -f "\$HOME/.terminal_banner.sh" ] && bash "\$HOME/.terminal_banner.sh"
_folder_icon_box
ZEOF

ok ".zshrc written with design #$PROMPT_NUM"

# ── [10] Prompt Changer Script ────────────
section "[10] Prompt Changer"

cat > "$HOME/.select_prompt.sh" << 'CHANGEREOF'
#!/data/data/com.termux/files/usr/bin/bash

NC='\033[0m'; BOLD='\033[1m'
G='\033[38;5;82m'; Y='\033[38;5;226m'
C='\033[38;5;51m'; M='\033[38;5;201m'
W='\033[1;37m'; R='\033[38;5;196m'

USER_NAME=$(cat "$HOME/.terminal_username" 2>/dev/null || echo "USER")

clear
echo ""
echo -e "  ${C}${BOLD}✦  40 PROMPT DESIGNS  ✦${NC}"
echo ""

while IFS='|' read -r num line1 line2; do
    d1=$(echo "$line1" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")
    d2=$(echo "$line2" | sed "s/_USER_/$USER_NAME/g" | sed "s/_TIME_/16:01/g")
    
    if [ $num -le 9 ]; then
        echo -e "  ${M}${BOLD} 0${num})${NC}  ${W}${d1}${NC}"
        echo -e "       ${W}${d2}${NC}"
    else
        echo -e "  ${M}${BOLD} ${num})${NC}  ${W}${d1}${NC}"
        echo -e "       ${W}${d2}${NC}"
    fi
    echo ""
done < "$HOME/.prompt_designs.txt"

echo ""
echo -en "  ${G}${BOLD}Select number (1-40): ${NC}"
read -r NUM

while ! [[ "$NUM" =~ ^[0-9]+$ ]] || [ "$NUM" -lt 1 ] || [ "$NUM" -gt 40 ]; do
    echo -e "  ${R}${BOLD}✘ Invalid! Choose 1-40${NC}"
    echo -en "  ${G}${BOLD}Try again: ${NC}"
    read -r NUM
done

SELECTED=$(grep "^$NUM|" "$HOME/.prompt_designs.txt")
L1=$(echo "$SELECTED" | cut -d'|' -f2)
L2=$(echo "$SELECTED" | cut -d'|' -f3)

# Replace placeholders with actual variables
L1_FINAL=$(echo "$L1" | sed 's/_USER_/${_TERM_USER}/g' | sed 's/_TIME_/%D{%H:%M}/g')
L2_FINAL=$(echo "$L2" | sed 's/_USER_/${_TERM_USER}/g' | sed 's/_TIME_/%D{%H:%M}/g')

# Update .zshrc
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|^PROMPT=.*|PROMPT='%F{51}%B${L1_FINAL}%b%f\\\${vcs_info_msg_0_}\n%F{51}%B${L2_FINAL}%b%f '|" "$HOME/.zshrc"
else
    sed -i "s|^PROMPT=.*|PROMPT='%F{51}%B${L1_FINAL}%b%f\${vcs_info_msg_0_}\n%F{51}%B${L2_FINAL}%b%f '|" "$HOME/.zshrc"
fi

echo ""
echo -e "  ${G}${BOLD}✔ Prompt changed to Design #${NUM}${NC}"
echo -e "  ${Y}Run: source ~/.zshrc${NC}"
echo ""
CHANGEREOF

chmod +x "$HOME/.select_prompt.sh"
ok "Prompt changer ready"

# ── [11] Hide Termux welcome ──────────────
section "[11] Hiding Welcome Message"
touch "$HOME/.hushlogin"
ok ".hushlogin created"

# ── [12] Default shell ────────────────────
section "[12] Default Shell"
chsh -s zsh 2>/dev/null && ok "ZSH set as default" || ok "Run: chsh -s zsh"

# ── Done ──────────────────────────────────
echo ""
echo -en "${S}"
printf '═%.0s' $(seq 1 $TW)
echo -e "${NC}"
echo ""
echo -e "  ${G}${BOLD}✔  SETUP COMPLETE!${NC}"
echo ""
echo -e "  ${Y}  ➤  Type ${W}zsh${Y} to launch${NC}"
echo -e "  ${Y}  ➤  ${W}banner${Y}    — show banner${NC}"
echo -e "  ${Y}  ➤  ${W}cls${Y}       — clear + banner${NC}"
echo -e "  ${Y}  ➤  ${W}prompts${Y}   — ৪০টি ডিজাইন থেকে আবার সিলেক্ট${NC}"
echo -e "  ${Y}  ➤  ${W}setname${Y}   — নাম পরিবর্তন করুন${NC}"
echo ""
echo -e "  ${M}${BOLD}  ★ আপনার সিলেক্ট করা ডিজাইন: #${PROMPT_NUM}${NC}"
echo ""
echo -en "${S}"
printf '═%.0s' $(seq 1 $TW)
echo -e "${NC}\n"
