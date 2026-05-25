# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # Handled by Starship
plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)
source $ZSH/oh-my-zsh.sh

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Starship prompt (after oh-my-zsh so it overrides the theme)
eval "$(starship init zsh)"

