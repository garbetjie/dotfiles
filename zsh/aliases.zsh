#!/usr/bin/env zsh

alias gtl="git tag -l | cat"
alias sail="./vendor/bin/sail"
alias ~="cd ~"
alias ..="cd ../"
alias ...="cd ../../"
alias cat="bat -P"
alias less="bat"
alias ll="ls -lahG"

# kubectl
alias kc="kubectl"
alias kct="kubectl --context gke_tencentafrica-testing-joox_europe-west4_main"
alias kcp="kubectl --context gke_tencentafrica-prod-joox_europe-west4_main"

# terraform
alias tfp="terraform plan -parallelism 50 -out run.plan"
alias tfa="terraform apply run.plan"
alias tfw="terraform workspace select"
alias tfpall='terraform plan -parallelism 50 -out run.plan -var-file="$(terraform workspace show).tfvars" -var "release=$(git describe --always)"'
