alias g="git"
alias ginit="git init && gcinit"
alias ga="git add"
alias ga.="git add ."
alias gan='git add -N'
alias gd="git diff"
alias gds='DELTA_FEATURES=side-by-side git diff'
alias gdw="git diff -w"
alias gdws='gds -w'
alias gs="git status"
alias gpf="git push --force-with-lease --force-if-includes"
alias gpu="git pull"
alias gprune="git pull --prune"
alias gb="git branch"
alias gbd='git branch -D'
alias gcv="INSERT=true git commit -v"
alias gc="gcv"
alias gcf="git commit --fixup"
alias gca="INSERT=true git commit -av"
alias gcinit="git commit -m 'Init' --allow-empty"
alias gamend="git commit --amend"
alias gch="git checkout"
alias gchb="git checkout -B"
alias gl="git log"
alias gf="git fetch"
alias gm="git merge"
alias gr="git reset"
alias gr:s="git reset --soft HEAD^"
alias gr:h="git reset --hard HEAD^"
alias gcl="git clone"
alias gres="git restore"
alias grb="git rebase"
alias grbi="git rebase -i"
alias gcp="git cherry-pick"
alias ggraph="git graph"
alias gg="git graph"

alias gh='ghautoswitch && gh'
alias pr="gh pr view -w"
alias prn="gh pr create"
alias prnf="gh pr create -f"
alias prnb='gh pr create -B $(fbr --stdout)'
alias automerge='gh pr merge --auto'

alias wip="git commit -m 'WIP [skip ci]' --no-verify"
alias wipa="git add . && wip"

alias fgrb='git rebase -i "$(fgl)~1"'
alias fcf='git commit --fixup $(fgl)'

alias commitmessage='git log -n 1 --format="%s" '
alias cmsg='commitmessage'
alias fcmsg='commitmessage $(fgl)'

alias dmerged="git branch --merged | grep -E -v '\*|main|master' | xargs git branch -d"
