HISTSIZE=1000
export PATH=$HOME/bin:$PATH
export ZPLUG_HOME=$XDG_CONFIG_HOME/zplug
export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug
export ZPLUG_REPOS=$XDG_DATA_HOME/zplug/repo

export ZPLUG_BIN=~/bin

source $ZPLUG_HOME/init.zsh

export CLICOLOR=1

SPACESHIP_PROMPT_ORDER=(
  dir
  line_sep
  dotnet
  char
)

SPACESHIP_RPROMPT_ORDER=(
  git
  line_sep
  vi_mode
  exec_time
)
export TOUCHBAR_GIT_ENABLED=true
export WD_CONFIG=$XDG_CONFIG_HOME/wd/rc

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "iam4x/zsh-iterm-touchbar"
zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }"
zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:github, as:theme

zplug load --verbose
