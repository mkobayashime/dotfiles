alias g="git"
alias ginit="git init && gcinit"
alias ga="git add"
alias ga.="git add ."
alias gd="git diff"
alias gdw="git diff -w"
alias gs="git status"
alias gpf="git push --force-with-lease"
alias gpu="git pull"
alias gprune="git pull --prune"
alias gb="git branch"
alias gbd='git branch -D'
alias gc="git commit -m"
alias gcv="INSERT=true git commit -v"
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

alias pr="gh pr view -w"
alias prn="gh pr create"
alias prnf="gh pr create -f"
alias automerge='gh pr merge --auto'

alias wip="git commit -m 'WIP' --no-verify"
alias wipa="git add . && wip"

alias fgrb='git rebase -i $(fgl)'
alias fcf='git commit --fixup $(fgl)'

alias commitmessage='git log -n 1 --format="%s" '
alias cmsg='commitmessage'
