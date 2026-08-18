[[ $- != *i* ]] && return
alias ls='ls -F --color --group-directories-first'
alias lsa='ls -A'
alias helium='. cast.sh helium-browser'
alias vscodium='. cast.sh vscodium'
PS1='[\u@\h:\w]\$ '