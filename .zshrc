#!/bin/zsh

# Start things off...
clear
# neofetch
# echo

# Helper function for ouput
function overwrite() {
    printf "\r\033[1A\033[0K$@"
}
function output() {
    # overwrite "~~>"
    echo "$1  -  $2"
}
function header() {
    echo "$(output $1 $2)"
}
function line() {
    echo "$(output $1 $2)" "…"
}
function subline() {
    echo "$(output "    |" $1)" "…"
}

header '🚀' 'Init new othyn env!' | lolcat

# macOS default at /etc/paths contains /usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
line '🧭' 'Setting PATH'
export PATH="$HOME/bin:$(brew --prefix)/bin:$(brew --prefix)/sbin:$(composer global config bin-dir --absolute --quiet):$(yarn global bin):/usr/bin/gem:$PATH"

# Run these to add Sublime Merge and Text to the PATH
# https://www.sublimemerge.com/docs/command_line#mac
# ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" ~/bin/smerge
# https://www.sublimetext.com/docs/command_line.html#mac
# ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# Run this command then re-log to disable mouse acceleration
# To reset to default: defaults delete -g com.apple.mouse.scaling
# defaults write -g com.apple.mouse.scaling -integer -1

# Init theme
# Needs to be init'd before ZSH config as the theme is loaded into the config
line '🎨' 'Loading ~/.zshrc_theme'
source ~/.zshrc_theme > ~/logs/zshrc/last__.zshrc_theme.log 2>&1

# Init plugins
line '🔌' 'Loading ~/.zshrc_plugins'
source ~/.zshrc_plugins > ~/logs/zshrc/last__.zshrc_plugins.log 2>&1

# Init ZSH
line '📜' 'Loading ~/.zshrc_config'
source ~/.zshrc_config > ~/logs/zshrc/last__.zshrc_config.log 2>&1

# Init aliases
line '🎭' 'Loading ~/.zshrc_aliases'
source ~/.zshrc_aliases > ~/logs/zshrc/last__.zshrc_aliases.log 2>&1

# Init functions
line '🏭' 'Loading ~/.zshrc_functions'
source ~/.zshrc_functions > ~/logs/zshrc/last__.zshrc_functions.log 2>&1

# Init schedule - don't output redirect to log as this is interactive
line '⏰' 'Loading ~/.zshrc_schedule'
source ~/.zshrc_schedule

# Kubernetes autocomplete
line '🤖' 'Loading autocomplete'
source <(kubectl completion zsh) > ~/logs/zshrc/last__autocomplete.log 2>&1

# Disable ZSH autocorrect
line '🔏' 'Disabling autocorrect'
unsetopt correct_all

# Don't require escaping globbing characters in zsh
line '🔏' 'Fix globbing'
unsetopt nomatch

# Case insensitive.
line '🔏' 'Case insensitive'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Set architecture-specific brew share path.
line '🍺' 'Setting brew share path'
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    share_path="/usr/local/share"
elif [ "${arch_name}" = "arm64" ]; then
    share_path="/opt/homebrew/share"
else
    echo "Unknown architecture: ${arch_name}"
fi

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
# To activate the syntax highlighting, add the following ~~at the end~~ of your .zshrc:
line '💡' 'Loading syntax highlighting'
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh > ~/logs/zshrc/last__syntax_highlighting.log 2>&1

line '🌟' 'New commands: ranger ncdu speedread cmatrix bat ffmpeg imagemagick cpufetch lsd bpytop ascii-image-converter speedtest-cli smartctl'

line '💭' 'Useful commands: pbcopy'

# End things off...
header '🔥' 'Done!' | lolcat
# clear
