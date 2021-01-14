HISTSIZE=1000
export PATH=$HOME/bin:$HOME/.improbable/imp-tool/subscriptions:$PATH
export ZPLUG_HOME=$XDG_CONFIG_HOME/zplug
export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug
export ZPLUG_REPOS=$XDG_DATA_HOME/zplug/repo
export OMNISHARPHOME=$XDG_CONFIG_HOME/omnisharp

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
export FZF_DEFAULT_COMMAND='ag --hidden --no-color -l -g ""'

autoload zmv

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }"
zplug "zsh-users/zsh-completions", from:github
zplug "bobthecow/git-flow-completion", from:github
zplug "plugins/kubectl", from:oh-my-zsh, defer:2
zplug "bonnefoa/kubectl-fzf", defer:3
zplug "denysdovhan/spaceship-prompt", use:"spaceship.zsh", from:github, as:theme

zplug load --verbose

zstyle ':completion:*:*:kubectl:*' list-grouped false

eval "$(direnv hook zsh)"
