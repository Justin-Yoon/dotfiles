# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source $(brew --prefix powerlevel10k)/powerlevel10k.zsh-theme

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

plugins=(
git
fzf
fasd
# fish-like suggestions as you type
zsh-autosuggestions 
# history-substring-search
# alias-tips
# zsh-completions 
zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
# TODO this is slow
# autoload -U compinit && compinit

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


alias slp="pmset sleepnow"
alias lg="lazygit"
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
alias tf="terraform"
alias note='nvim -c "+normal Go* " +startinsert! ~/Dropbox/Documents/notes.md'
# alias todo='nvim -c "normal /Uncategorisedo$(date +%F) " +startinsert! ~/Dropbox/Documents/todo.md'
alias todo='nvim -c "normal /TODOSkO" +startinsert! ~/Dropbox/Documents/todo.md'
alias study='nvim ~/Dropbox/Documents/study.md'
alias tools='nvim ~/Dropbox/Documents/tools.md'

if [ -f "$HOME/.dotfiles/zsh_local" ]
then
  source $HOME/.dotfiles/zsh_local
fi

# p10k config. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# TODO this is slow
# [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
