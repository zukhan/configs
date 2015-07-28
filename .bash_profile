#
# .bash_profile
# Zubair Khan 
# 2011-2015
#

export GREP_OPTIONS='--color=auto' 
export CLICOLOR=1;
PS1="\[\e[0;32m\]>\[\e[m\] \[\e[1;34m\][\W]\[\e[m\]\[\e[0;32m\]$\[\e[m\] "

function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
 }
 function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
 }
setjdk 1.7.0_71

export PATH=$PATH:/usr/local/opt:/usr/local/bin:/opt/local/bin:/opt/local/sbin
# Set the path for git
export PATH=$PATH:/usr/local/git/bin
# Set the path for the scripts directory
export PATH=$PATH:/Users/zubairkhan/scripts

set -o vi
alias eclipse='env PATH=/System/Library/Frameworks/JavaVM.framework/Versions/1.5/Commands:$PATH open -n /Applications/eclipse/Eclipse.app' 
alias cap='var="committed at "$(echo $(date "+%l:%M %p")); git commit -am "$var" --no-verify;'
alias ls='ls -LGH' 
alias g="git"
alias gc='git commit --no-verify -am'
alias gcp='git cherry-pick'
alias gcd='git commit -am "changes" --no-verify'
alias gshow='git show'
alias gd='git diff'
alias gdo="git diff origin"
alias grh="git reset --hard"
alias grl="git reflog --date=relative"
alias grs="git reset --soft origin/master"
alias grhom="git reset --hard origin/master"
alias gco="git checkout"
alias gb="git branch"
alias gl="git log"
alias gs="git status"
alias gp="git pull"
alias gpush="git push"
alias gm="git merge"
alias gr="git recommit"
alias dtrace='sudo dtrace'
