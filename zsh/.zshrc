HISTSIZE=1000
export PATH=$HOME/bin:$PATH
export ZPLUG_HOME=$XDG_CONFIG_HOME/zplug
export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug
export ZPLUG_REPOS=$XDG_DATA_HOME/zplug/repo

export ZPLUG_BIN=~/bin

source $ZPLUG_HOME/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme
zplug load --verbose
