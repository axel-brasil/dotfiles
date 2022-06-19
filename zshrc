# PATHS
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/bin/custom_bin:$HOME/.local/share/ryujinx:$PATH

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# THEME
ZSH_THEME="afowler"
#ZSH_THEME="macovsky"
#ZSH_THEME="jnrowe"
#ZSH_THEME="random"

# PLUGINS
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ALIAS
alias vim="nvim"
alias sudo="sudo "

