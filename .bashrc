# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.julia/bin
export PATH


# User specific aliases and functions

alias la='ls -la'
alias env="conda activate py3"


