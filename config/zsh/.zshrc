# ==========================================
# Dev-Kraken's ZSH Configuration
# ==========================================

# Suppress Powerlevel10k instant prompt warnings (recommended for this setup)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================================
# Oh My Zsh Configuration
# ==========================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enhanced plugin configuration
plugins=(
  # Core functionality
  git
  zsh-autosuggestions
  zsh-syntax-highlighting

  # Development tools
  docker
  docker-compose
  kubectl
  terraform
  aws
  golang

  # Language support
  npm
  node
  python
  pip

  # Additional utilities
  vscode
  extract
  web-search
  copypath
  copybuffer
  dirhistory
  sudo
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ==========================================
# History Configuration
# ==========================================

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ==========================================
# Environment Variables & Path
# ==========================================

# Path configuration
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Core editor configuration
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export BROWSER='firefox'

# Development environment
export TMUX_CONF=~/.config/tmux/tmux.conf

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Language-specific environment variables
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# Node.js configuration
# export NPM_CONFIG_PREFIX="$HOME/.local"

# Fix Neovim E1155 error by ensuring clean environment
unset VIM
unset VIMRUNTIME
export NVIM_APPNAME=${NVIM_APPNAME:-nvim}

# ==========================================
# Node Version Manager (NVM)
# ==========================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ==========================================
# Modern Tool Configurations
# ==========================================

# eza colors configuration (modern ls replacement)
export EZA_COLORS="di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;41:cd=1;33;41:su=1;41:sg=1;43:tw=1;42:ow=1;34;42"
export EZA_COLORS="$EZA_COLORS:ur=1;32:uw=1;33:ux=1;31:ue=1;31:gr=1;32:gw=1;33:gx=1;31:tr=1;32:tw=1;33:tx=1;31:sn=1;36:sb=1;36:da=1;36"

# Zoxide configuration (smart directory navigation)
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'  # Use zoxide's smart navigation for `cd`
fi

# ==========================================
# Basic Aliases
# ==========================================

# System shortcuts
alias cc="clear"
alias cls="clear"
alias q="exit"
alias h="history"
alias j="jobs"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Directory operations
alias md="mkdir -p"
alias rd="rmdir"

# File operations
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ln="ln -i"

# Editor aliases
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias e="nvim"

# Configuration shortcuts
alias zshrc="nvim ~/.zshrc"
alias zshreload="source ~/.zshrc"
alias zshconfig="nvim ~/.zshrc"
alias nvimconfig="cd ~/.config/nvim && nvim ."

# ==========================================
# Enhanced File Listing (eza)
# ==========================================

if command -v eza > /dev/null; then
  # Basic usage
  alias ls="eza --group-directories-first --icons"
  alias ll="eza --long --header --group --icons --group-directories-first --git"
  alias la="eza --long --header --group --icons --all --group-directories-first"
  alias l="eza --long --header --group --icons --group-directories-first"

  # Sorting options
  alias lx="eza --long --header --group --icons --sort=extension --group-directories-first"
  alias lk="eza --long --header --group --icons --sort=size --group-directories-first"
  alias lc="eza --long --header --group --icons --sort=created --group-directories-first"
  alias lm="eza --long --header --group --icons --sort=modified --group-directories-first"
  alias ln="eza --long --header --group --icons --sort=name --group-directories-first"

  # Specialized views
  alias ld="eza --long --header --group --icons --only-dirs --group-directories-first"
  alias lf="eza --long --header --group --icons --only-files"
  alias l.="eza --long --header --group --icons --all | grep --color=always '^\\.'"

  # Tree views
  alias lt="eza --tree --level=2 --icons --group-directories-first"
  alias lt1="eza --tree --level=1 --icons --group-directories-first"
  alias lt2="eza --tree --level=2 --icons --group-directories-first"
  alias lt3="eza --tree --level=3 --icons --group-directories-first"
  alias lt4="eza --tree --level=4 --icons --group-directories-first"
  alias ltt="eza --tree --icons --group-directories-first"

  # Recursive views
  alias lr="eza --recurse --long --header --group --icons --group-directories-first"
  alias lra="eza --recurse --long --header --group --icons --all --group-directories-first"
else
  # Fallback to standard ls with colors
  alias ls="ls --color=auto --group-directories-first"
  alias ll="ls -la --color=auto --group-directories-first"
  alias la="ls -la --color=auto"
  alias l="ls -l --color=auto --group-directories-first"
fi

# ==========================================
# Development Aliases
# ==========================================

# Git shortcuts (enhanced)
alias g="git"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -am"
alias gp="git push"
alias gpl="git pull"
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gl="git log --oneline --graph --decorate"
alias gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Docker shortcuts
alias d="docker"
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcl="docker-compose logs"
alias dcb="docker-compose build"
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dex="docker exec -it"

# Kubernetes shortcuts
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
alias kaf="kubectl apply -f"
alias kdel="kubectl delete"
alias kdes="kubectl describe"
alias klogs="kubectl logs"

# Node.js shortcuts
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install -g"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nw="npm run watch"

# Python shortcuts
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"

# System information
alias ports="netstat -tulanp"
alias myip="curl -s ifconfig.me && echo"
alias localip="ip route get 1.1.1.1 | grep -oP 'src \K\S+'"
alias disk="df -h"
alias mem="free -h"
alias cpu="lscpu"
alias temp="sensors"

# ==========================================
# Sudo Neovim Configuration
# ==========================================

alias svim='sudo -E nvim'
alias sudovim='sudo -E nvim'
alias sedit='sudoedit'
alias root='sudo -i'

# ==========================================
# Enhanced Utility Functions
# ==========================================

# Create and enter directory
mkcd() {
  if [ $# -ne 1 ]; then
    echo "Usage: mkcd <directory>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

# Find and kill process by name
pskill() {
  if [ $# -ne 1 ]; then
    echo "Usage: pskill <process_name>"
    return 1
  fi
  ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# Find process using specific port
portfind() {
  if [ $# -ne 1 ]; then
    echo "Usage: portfind <port>"
    return 1
  fi
  lsof -i :"$1"
}

# Kill process using specific port
portkill() {
  if [ $# -ne 1 ]; then
    echo "Usage: portkill <port>"
    return 1
  fi
  local pid=$(lsof -t -i:"$1")
  if [ -n "$pid" ]; then
    kill -9 "$pid"
    echo "Killed process $pid using port $1"
  else
    echo "No process found using port $1"
  fi
}

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *.xz)        unxz "$1"        ;;
      *.exe)       cabextract "$1"  ;;
      *)           echo "'$1': unrecognized file compression" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create a backup of file
backup() {
  if [ $# -ne 1 ]; then
    echo "Usage: backup <file>"
    return 1
  fi
  cp "$1"{,.bak-$(date +%Y%m%d-%H%M%S)}
}

# Quick weather check
weather() {
  local city="${1:-$(curl -s ipinfo.io/city)}"
  curl -s "wttr.in/$city?format=3"
}

# Quick note taking
note() {
  local note_file="$HOME/.notes/$(date +%Y%m%d).md"
  mkdir -p "$(dirname "$note_file")"
  if [ $# -eq 0 ]; then
    nvim "$note_file"
  else
    echo "$(date '+%H:%M:%S') - $*" >> "$note_file"
  fi
}

# Search in files
search() {
  if [ $# -lt 2 ]; then
    echo "Usage: search <pattern> <directory>"
    return 1
  fi
  grep -r --include="*" "$1" "$2"
}

# Open GitHub repo in browser
ghopen() {
  local remote_url=$(git remote get-url origin 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    echo "Not a git repository"
    return 1
  fi

  # Clean up URL for opening in browser
  remote_url=${remote_url/git@github.com:/https:\/\/github.com\/}
  remote_url=${remote_url%.git}

  # Use xdg-open for Linux, open for macOS
  if command -v xdg-open &> /dev/null; then
    xdg-open "$remote_url"
  elif command -v open &> /dev/null; then
    open "$remote_url"
  else
    echo "Cannot open URL: no suitable command found"
  fi
}

# Enhanced SSL certificate generation function
devkrakenssl() {
    local domain=$1

    if [ -z "$domain" ]; then
        echo "Error: Domain name is required"
        echo "Usage: devkrakenssl domain.local"
        return 1
    fi

    # Create directory for certificates if it doesn't exist
    mkdir -p ~/.local/share/certs

    # Generate certificates for the domain
    echo "Generating SSL certificates for $domain and *.$domain..."
    sudo mkcert -key-file $HOME/.local/share/certs/$domain-key.pem -cert-file $HOME/.local/share/certs/$domain.pem $domain "*.$domain"

    # Add domain to /etc/hosts if not already there
    if ! grep -q "$domain" /etc/hosts; then
        echo "Adding $domain to /etc/hosts..."
        echo "Do you want to add $domain to /etc/hosts? (requires sudo) [y/N]"
        read -r answer
        if [[ "$answer" =~ ^[Yy]$ ]]; then
            sudo sh -c "echo '127.0.0.1 $domain' >> /etc/hosts"
            echo "Added $domain to /etc/hosts"
        fi
    else
        echo "$domain already exists in /etc/hosts"
    fi

    echo ""
    echo "Certificate created successfully!"
    echo "Certificate: ~/.local/share/certs/$domain.pem"
    echo "Private key: ~/.local/share/certs/$domain-key.pem"
    echo ""
}

# Quick project setup
project() {
  if [ $# -ne 1 ]; then
    echo "Usage: project <project_name>"
    return 1
  fi

  local project_dir="$HOME/Projects/$1"
  mkdir -p "$project_dir"
  cd "$project_dir"

  # Initialize git if not already a repo
  if [ ! -d ".git" ]; then
    git init
    echo "# $1" > README.md
    echo "node_modules/" > .gitignore
    echo ".env" >> .gitignore
    echo ".DS_Store" >> .gitignore
  fi

  echo "Project $1 ready at $project_dir"
}

# System update function for Arch Linux
sysupdate() {
  echo "🔄 Updating system packages..."
  sudo pacman -Syu

  if command -v yay &> /dev/null; then
    echo "🔄 Updating AUR packages..."
    yay -Sua
  fi

  if command -v flatpak &> /dev/null; then
    echo "🔄 Updating Flatpak packages..."
    flatpak update
  fi

  echo "✅ System update complete!"
}

# ==========================================
# Development Environment Functions
# ==========================================

# Laravel/PHP shortcuts
artisan() {
  if [ -f artisan ]; then
    php artisan "$@"
  else
    echo "Not in a Laravel project directory"
  fi
}

# Node.js project management
npmclean() {
  echo "Cleaning npm cache and node_modules..."
  rm -rf node_modules package-lock.json
  npm cache clean --force
  npm install
}

# Docker cleanup
dcleanup() {
  echo "Cleaning up Docker containers, images, and volumes..."
  docker container prune -f
  docker image prune -f
  docker volume prune -f
  docker network prune -f
  echo "Docker cleanup complete!"
}

# ==========================================
# Completion and Final Setup
# ==========================================

# Enable auto-completion for aliases
setopt COMPLETE_ALIASES

# Source additional configurations
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load any local customizations
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

# ==========================================
# Welcome Message Configuration
# ==========================================

# Set to 'false' to disable welcome message entirely
# Set to 'quiet' to show only on manual request
# Set to 'true' to show welcome message (default)
DEVKRAKEN_WELCOME=${DEVKRAKEN_WELCOME:-true}

devkraken_welcome() {
  echo "🚀 Dev-Kraken's ZSH Environment Loaded!"
  echo "💡 Type 'help-devkraken' for available custom functions"
}

# Always provide welcome command
alias welcome="devkraken_welcome"

# Smart welcome message display - avoid conflicts with Powerlevel10k instant prompt
devkraken_should_show_welcome() {
  # Don't show if explicitly disabled
  [[ "$DEVKRAKEN_WELCOME" == "false" || "$DEVKRAKEN_WELCOME" == "off" || "$DEVKRAKEN_WELCOME" == "no" ]] && return 1

  # Don't show if in quiet mode
  [[ "$DEVKRAKEN_WELCOME" == "quiet" ]] && return 1

  # Don't show if we're in tmux (prevents multiple welcome messages)
  [[ -n "$TMUX" ]] && return 1

  # Don't show if this is not an interactive shell
  [[ ! -o interactive ]] && return 1

  # Don't show if stdin is not a terminal (script execution, etc.)
  [[ ! -t 0 ]] && return 1

  # Don't show if we're in a subshell or background process
  [[ "$SHLVL" -gt 1 ]] && return 1

  # Don't show if Powerlevel10k instant prompt is disabled and we want to be extra cautious
  [[ "$POWERLEVEL9K_INSTANT_PROMPT" == "off" ]] && return 1

  # Don't show if we're being sourced from another script
  [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1

  # Show welcome message
  return 0
}

# Display welcome message based on conditions
if devkraken_should_show_welcome; then
  # Use precmd hook to display welcome message after first command prompt
  # This ensures compatibility with Powerlevel10k instant prompt
  devkraken_show_welcome() {
    devkraken_welcome
    # Remove this function from precmd to only show once
    precmd_functions=(${precmd_functions[@]:#devkraken_show_welcome})
  }
  # Add welcome function to precmd hooks (will run before first prompt)
  precmd_functions+=(devkraken_show_welcome)
fi

# Help function
help-devkraken() {
  echo "🔧 Dev-Kraken's Custom Functions:"
  echo "  mkcd <dir>        - Create and enter directory"
  echo "  pskill <name>     - Kill process by name"
  echo "  portfind <port>   - Find process using port"
  echo "  portkill <port>   - Kill process using port"
  echo "  extract <file>    - Extract any archive"
  echo "  backup <file>     - Create timestamped backup"
  echo "  weather [city]    - Get weather info"
  echo "  note [text]       - Quick note taking"
  echo "  search <pat> <dir>- Search in files"
  echo "  ghopen            - Open GitHub repo in browser"
  echo "  devkrakenssl <dom>- Generate SSL certificates"
  echo "  project <name>    - Quick project setup"
  echo "  sysupdate         - Update system packages"
  echo "  artisan <cmd>     - Laravel artisan shortcut"
  echo "  npmclean          - Clean npm cache and modules"
  echo "  dcleanup          - Clean Docker resources"
}
