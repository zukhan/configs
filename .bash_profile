#
# .bash_profile
# Zubair Khan 
# 2011-2015
#

export GOPATH=$HOME/go

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

export GREP_OPTIONS='--color=auto' 
export CLICOLOR=1;
start_teal="\[\e[0;32m\]"
end_teal="\[\e[m\]"
start_blue="\[\e[1;34m\]"
end_blue="\[\e[m\]"
#PS1="\[\e[0;32m\]>\[\e[m\] \[\e[1;34m\][\W]\[\e[m\]\[\e[0;32m\]$\[\e[m\] "
export PS1="$start_teal>$end_teal [\W] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]$start_teal\$$end_teal "

export PATH=$PATH:/usr/local/opt:/usr/local/bin:/opt/local/bin:/opt/local/sbin
# Set the path for git
export PATH=$PATH:/usr/local/git/bin
# Set the path for the scripts directory
export PATH=$PATH:~/scripts
# Set the path for scala
export SCALA_HOME="/usr/local/share/scala-2.12.2/"
export PATH=$PATH:$SCALA_HOME/bin
# Set the path for kafka
export KAFKA_HOME="/usr/local/bin/kafka/"
export PATH=$PATH:$KAFKA_HOME/bin

export PATH=$PATH:~/Projects/stash/OCP/tunnel-helper

# for GO
export PATH=$PATH:$GOPATH/bin

export JAVA_HOME=$(/usr/libexec/java_home)

set -o vi

alias hivessh='ssh zkhan@query.dataoven.cloud.netflix.com'

alias c='cd ~/Projects/stash/OCP/ocp/'
alias cap='var="committed at "$(echo $(date "+%l:%M %p")); git commit -am "$var" --no-verify;'
alias ls='ls -LGH' 
alias ssh_oc="ssh-add -D; ssh-add; ssh -t -t -A ochome 'ssh-add /apps/oca/ssh/keys/*20161* /apps/oca/ssh/keys/*201609* /apps/oca/ssh/keys/*201607* /apps/oca/ssh/keys/*2017*'"

#alias g="git"
#alias ga="git add"
#alias gc='git commit -am'
#alias gca='git commit -a --amend'
#alias gcp='git cherry-pick'
#alias gshow='git show'
#alias gd='git diff'
#alias gdo="git diff origin"
#alias grh="git reset --hard"
#alias grl="git reflog --date=relative"
#alias grs="git reset --soft origin/master"
#alias grhom="git reset --hard origin/master"
#alias gco="git checkout"
#alias gb="git branch"
#alias gl="git log"
#alias gs="git status"
#alias gp="git pull"
#alias gpush="git push"
#alias gm="git merge"
#alias gr="git rebase"
#alias gri="git rebase -i"
#alias gra="git rebase --abort"
#alias grc="git rebase --continue"

alias g="git number"
alias ga="git number add"
alias gc='git commit -am'
alias gca='git commit -a --amend'
alias gcp='git number cherry-pick'
alias gshow='git number show'
alias gshow_without_signs='git show --color | sed -E "s/^([^-+ ]*)[-+ ]/\\1/" | less -r'
alias gd='git number diff'
alias gd_without_signs='git show --color | sed -E "s/^([^-+ ]*)[-+ ]/\\1/" | less -r'
alias gdo="git number diff origin"
alias grh="git number reset --hard"
alias grl="git number reflog --date=relative"
alias grs="git number reset --soft origin/master"
alias grhom="git number reset --hard origin/master"
alias gco="git number checkout"
alias gnco="git number checkout"
alias gb="git number branch"
alias gl="git number log"
alias gs="git number"
alias gp="git number pull"
alias gpush="git number push"
alias gn="git number"
alias gm="git number merge"
alias gr="git number rebase"
alias gri="git number rebase -i"
alias gra="git number rebase --abort"
alias grc="git number rebase --continue"
alias generate_lock_files="./gradlew generateLock saveLock -PdependencyLock.includeTransitives=true"
alias gdb="delbranch"

export CERT_FILES_PATH=~/sslcerts
for lib in `find ~/Projects/stash/OCP/scripts/cmdlib -type f -perm -100`; do
    source $lib
done

set_ccs_manifest_instance () {
    if [[ -z $ccs_manifest_instance ]]
    then
        ccs_manifest_instance=`ssh -t aws.prod.netflix.net 'oq-lin --region us-west-2 ccs-manifest' | grep ec2 | head -n 1 | awk '{ print $3}'`
    fi
}

set_coda_instance () {
    if [[ -z $coda_instance ]]
    then
        coda_instance=`ssh -t aws.prod.netflix.net 'oq-lin --region us-west-2 coda-general-unsharded' | grep ec2 | head -n 1 | awk '{ print $3}'`
    fi
}

export -f set_coda_instance
export -f set_ccs_manifest_instance

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#!/usr/bin/env bash
# alias_completion -- Wrap completion functions around aliases
# Requires: bash_completion *
#
# Author: Jaeho Shin <netj@sparcs.org>
# Created: 2012-09-01
# Derived-from: http://stackoverflow.com/a/1793178/390044

bash_plugin_interactive() {
    local namespace=alias_completion::
    # alias_completion::wrap_alias takes three arguments:
    # $1: The name of the alias
    # $2: The command used in the alias
    # $3: The arguments in the alias all in one string
    # Generate a wrapper completion function (completer) for an alias
    # based on the command and the given arguments, if there is a
    # completer for the command, and set the wrapper as the completer for
    # the alias.
    function alias_completion::wrap_alias() {
        [[ $# -eq 3 ]] || return 1

        local alias_name=$1; shift
        local aliased_command=$1; shift
        local alias_definition=$1; shift

        # The completion currently being used for the aliased command.
        local completion=$(complete -p $aliased_command 2>/dev/null)

        # Only a completer based on a function can be wrapped so look for -F
        # in the current completion. This check will also catch commands
        # with no completer for which $completion will be empty.
        grep -q -- -F <<<"$completion" || return 0

        # Extract the name of the completion function from a string that
        # looks like: something -F function_name something
        # First strip the beginning of the string up to the function name by
        # removing "* -F " from the front.
        local completion_function=${completion##* -F }
        # Then strip " *" from the end, leaving only the function name.
        completion_function=${completion_function%% *}

        # Try to prevent an infinite loop by not wrapping a function
        # generated by this function. This can happen when the user runs
        # this twice for an alias like ls='ls --color=auto' or alias l='ls'
        # and alias ls='l foo'
        [[ "${completion_function#$namespace}" = $completion_function ]] ||
            return 0

        local wrapper_name="${namespace}${alias_name}"
        eval "
        function ${wrapper_name}() {
            local args=
            eval \"args=($alias_definition)\"
            let COMP_CWORD+=\${#args[@]}-1
            COMP_WORDS=(\"\${args[@]}\" \"\${COMP_WORDS[@]:1}\")
            local expanded_COMP_LINE=\${COMP_WORDS[*]}
            let COMP_POINT+=\${#expanded_COMP_LINE}-\${#COMP_LINE}
            COMP_LINE=\$expanded_COMP_LINE
            $completion_function \"\$@\"
        }
        "

        # To create the new completion we use the old one with two
        # replacements:
        # 1) Replace the function with the wrapper.
        local new_completion=${completion/-F * /-F $wrapper_name }
        # 2) Replace the command being completed with the alias.
        new_completion="${new_completion% *} $alias_name"

        eval "$new_completion"
    }

    # For each defined alias, extract the necessary elements and use them
    # to call wrap_alias.
    eval "`
    alias -p | grep -v '[";|&]' |
    sed -e 's/alias \([^=][^=]*\)='\''\(.*\)'\''/\1 \2/' |
    while read shorthand definition; do
        eval "set -- $definition"
        while true; do
            command=$1; shift
            case $command in *=*) ;; *) break;; esac
        done
        printf '%q ' ${namespace}wrap_alias "$shorthand" "$command" "$definition"; echo
    done
    `"
}

bash_plugin_interactive
export HISTTIMEFORMAT="%d/%m/%y %T "
