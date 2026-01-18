##### ─────────────────────────────────────
##### Auto commands on terminal start
##### ─────────────────────────────────────
if [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
  if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    # ~/assets/scripts/set_terminal_colors.sh # Comment this line for real colors of terminal
    fastfetch
  fi
fi

##### ─────────────────────────────────────
##### Environment variables (LOAD EARLY)
##### ─────────────────────────────────────
export EDITOR=nvim
export GTK_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

# Android SDK
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin

# Chrome for Flutter Web
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable

# Perl local
export PATH=$HOME/perl5/bin:$PATH
export PERL5LIB=$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}
export PERL_LOCAL_LIB_ROOT=$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT}
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# Extra tools
export PATH=$HOME/.console-ninja/.bin:$PATH

##### ─────────────────────────────────────
##### Aliases
##### ─────────────────────────────────────
alias ch_wipe='~/assets/bins/rustyclip clear'
alias edit='code'

alias wu='wg-quick up nl'
alias wd='wg-quick down nl'

alias update='paru -Syu --skipreview'
alias searchpkg='paru -Ss'
alias install='paru -S --skipreview'
alias uninstall='paru -Rss'

alias Hyprland='start-hyprland'
alias cd='z'

# Windows Mount

alias win-mount='~/scripts/win-mount.sh mount'
alias win-umount='~/scripts/win-mount.sh unmount'
alias win-status='~/scripts/win-mount.sh status'


##### ─────────────────────────────────────
##### Oh-My-Zsh + Powerlevel10k
##### ─────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/assets/omz-custom"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Instant prompt (keep near top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

##### ─────────────────────────────────────
##### Syntax Highlighting Theme
##### ─────────────────────────────────────
source ~/assets/omz-custom/.zsh_files/catppuccin_mocha-zsh-syntax-highlighting.zsh

##### ─────────────────────────────────────
##### Tools
##### ─────────────────────────────────────
eval "$(zoxide init zsh)"
