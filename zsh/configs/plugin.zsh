if [[ -f ~/.zsh/vendor/antigen/antigen.zsh ]]; then
  source ~/.zsh/vendor/antigen/antigen.zsh
  [[ -f ~/.zshrc.antigen ]] && source ~/.zshrc.antigen
  [[ -f ~/.zshrc.antigen.local ]] && source ~/.zshrc.antigen.local
fi
