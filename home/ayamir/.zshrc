#! /bin/zsh
SHELL=$(which zsh || echo '/bin/zsh')
ZSHOME=$HOME/.zsh

setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# enable completion features
autoload -Uz compinit
compinit -i

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# History configurations
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=2000000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# source plugins
source $ZSHOME/zlefix.zsh
source $ZSHOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSHOME/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSHOME/fzf/key-bindings.zsh
source $ZSHOME/zsh-abbr/zsh-abbr.zsh
source $ZSHOME/nvm/zsh-nvm.plugin.zsh

# set highlight style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#484E5B,underline"

# custom function
toppy() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n 21
}

cd() {
	builtin cd "$@" && command ls --group-directories-first --color=auto -F
}

mcd () {
    mkdir -p $1
    cd $1
}

n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# alias
# alias vz='nvim ~/.zshrc'
# alias sz='source ~/.zshrc'
# alias v='nvim'
# alias vi='vim'
# alias nv='nvim'
# alias ne='fastfetch'
# alias mtar='tar -zcvf' # mtar <archive_compress>
# alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
# alias ..="cd .."
# alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" 
# alias mkdir="mkdir -p"
# alias ra='ranger'
# alias wifi="nmtui-connect"
# alias ls="exa --color=auto --icons"
# alias l="ls -l"
# alias la="ls -a"
# alias lla="ls -la"
# alias lt="ls --tree"
# alias cat="bat --color always --plain"
# alias grep='grep --color=auto'
# alias mv='mv -v'
# alias cp='cp -vr'
# alias ins='sudo emerge'
# alias insnr='sudo emerge --noreplace'
# alias uins='sudo emerge --depclean'
# alias up='sudo emerge -quvDN @world'
# alias fl='sudo flaggie'
# alias stlsa='sudo systemctl start'
# alias stlre='sudo systemctl restart'
# alias stlst='sudo systemctl stop'
# alias stlsu='sudo systemctl status'
# alias stlen='sudo systemctl enable'
# alias stldis='sudo systemctl disable'
# alias og='git-open'
# alias lg='lazygit'
# alias mf='musicfox'

# init starship
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
