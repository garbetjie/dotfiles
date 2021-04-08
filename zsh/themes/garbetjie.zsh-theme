DIVIDER="\uf0da"

function print_git_branch() {
    local branch=$(git_current_branch)

    if [ "$branch" != "" ]; then
        echo -n "%{$FG[244]%}\ue0a0 ${branch}%{$reset_color%}"
    fi
}

function print_divider() {
    echo -n "%{$FG[008]%} :: %{$reset_color%}"
}

function print_left_prompt() {
    # Start colouring the output.
    echo -n "%{$FG[068]%}"

    # Print the line start.
    echo -n "\uf0da "

    # Print the pwd, with $HOME replaced with ~
    echo -n "$(pwd | sed -e "s,^$HOME,~,")"

    # Print the current time.

    # Reset the colour.
    echo -n "%{$reset_color%}"
}

function print_right_prompt() {
    local exit_code=$?

    # Print the current time.
    echo -n "%{$FG[242]%}\uf017 $(date +%H:%M:%S)%{$reset_color%}"

    # Print the Python virtual env if present.
    if [ "$CONDA_DEFAULT_ENV" != "" ]; then
        echo -n " %{$FG[239]%}| %{$FG[242]%}\ue73c ${CONDA_DEFAULT_ENV}%{$reset_color%}"
    fi

    # Print the current git branch.
    local branch=$(git_current_branch)
    if [ "$branch" != "" ]; then
        local commits_ahead=$(git_commits_ahead 2>/dev/null)
        local commits_behind=$(git_commits_behind 2>/dev/null)

        echo -n " %{$FG[239]%}| %{$FG[242]%}\ue0a0 ${branch}"
        if [ "$commits_ahead" != "" ] && [ $commits_ahead -gt 0 ]; then
            echo -n " %{$FG[245]%}\uf47b"
        fi

        if [ "$commits_behind" != "" ] && [ $commits_behind -gt 0 ]; then
            echo -n " %{$FG[245]%}\uf47c"
        fi

        echo -n "%{$reset_color%}"
    fi

    # Print the Terraform workspace.
    local workspace="$(terraform workspace show)"
    if [ "$workspace" != "default" ]; then
        echo -n " %{$FG[239]%}| %{$FG[242]%}\uf473 ${workspace}%{$reset_color%}"
    fi

    # Print the most recent exit status.
    if [[ $exit_code -ne 0 ]]; then
        echo -n " %{$FG[239]%}| %{$FG[242]%}\uf705 ${exit_code}%{$reset_color%}"
    fi
}


PROMPT=$'\n''$(print_left_prompt) '
RPROMPT='$(print_right_prompt)'
#set
