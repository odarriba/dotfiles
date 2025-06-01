if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.aliases

    # Keep IEx history
    export ERL_AFLAGS="-kernel shell_history enabled"

    # To use Windsurf CLI command
    export PATH="/Users/odarriba/.codeium/windsurf/bin/:$PATH"
end

eval "$(/opt/homebrew/bin/brew shellenv)"

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export PATH="/usr/local/bin:/usr/local/bin:$PATH"
