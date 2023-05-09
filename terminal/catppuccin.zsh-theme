# catppuccin colors
GREEN="#A6E3A1"
RED="#F38BA8"
LAVENDER="#B4BEFE"
CRUST="#11111B"
TRANSPARENT="#00000000"

# Icons
DIVIDER="\UE0B0"  # nf-pl-left_hard_divider ()
ARROW="\UF17AA"   # nf-md-arrow_right_bottom_bold (󱞪)
BRANCH="\UF062C"  # nf-md-source_branch (󰘬)

# Git icons
ZSH_THEME_GIT_PROMPT_ADDED="\U2708"           # Airplane (✈)
ZSH_THEME_GIT_PROMPT_MODIFIED="\U272D"        # Outline Black Star (✭)
ZSH_THEME_GIT_PROMPT_DELETED="\U2717"         # Ballot X (✗)
ZSH_THEME_GIT_PROMPT_RENAMED="\U27A1"         # Black Rightward Arrow (➡)
ZSH_THEME_GIT_PROMPT_UNMERGED="\U2702"        # Black Scissors (✂)
ZSH_THEME_GIT_PROMPT_UNTRACKED="\U2731"       # Heavy Asterisk (✱)
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="\U2191"    # Upwards Arrow (↑)
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="\U2193"   # Downwards Arrow (↓)
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="\U2195" # Up Down Arrow (↕)

in_git_repo() {
  return $(git rev-parse --git-dir > /dev/null 2>&1)
}

segment() {
  local start="%F{$FG}%K{$BG}"
  local end="%F{$BG}%K{$NEXT_BG}$DIVIDER%f%k"

  echo "$start $CONTENT $end"
}

directory() {
  FG="$CRUST"
  BG="$LAVENDER"

  if in_git_repo; then
    NEXT_BG="$RED"
  else
    NEXT_BG="$TRANSPARENT"
  fi

  CONTENT="%2~"
  echo "$(segment)"
}

git_prompt() {
  if ! in_git_repo; then
    return
  fi

  FG="$CRUST"
  BG="$RED"
  NEXT_BG="$TRANSPARENT"

  CONTENT="$BRANCH $(git_current_branch) $(git_prompt_status) $(git_remote_status)"
  echo "$(segment)"
}

prompt_indicator() {
  echo "%F{$GREEN}$ARROW%f"
}

PROMPT='$(directory)$(git_prompt)'$'\n''$(prompt_indicator) '

# ls colors, made with https://geoff.greer.fm/lscolors
export LSCOLORS="exgxfxdxcxegedabagacad"
export LS_COLORS="di=34:ln=36:or=31:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
