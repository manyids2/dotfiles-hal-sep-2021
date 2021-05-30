status is-interactive

alias e="nvim"
alias c="clear"
alias cx="chmod +x"
alias feh="feh --scale-down --auto-zoom"
alias ym="youtube-dl -x --audio-format mp3"

# Remove fish greeting
set -U fish_greeting ""
fish_vi_key_bindings

# Various env variables
set -xg CI ""
set -xg EDITOR nvim
set -xg BROWSER google-chrome-stable
set -xg PYTHONBREAKPOINT "pudb.set_trace"

# Kitty
set -xg TERM xterm-kitty

# NNN
set -xg NNN_FIFO /tmp/nnn.fifo
set -xg NNN_PLUG 'o:fzopen;v:imgview;p:preview-tui'

# PATH
set -xg PATH /home/x/bin $PATH
set -xg PATH /home/x/.local/bin $PATH

# CUDA
set -xg PATH /usr/local/cuda-11.1/bin $PATH
set -xg LD_LIBRARY_PATH /usr/local/cuda-11.1/lib64 $LD_LIBRARY_PATH

# Python paths
# set -xg PYTHONPATH /home/x/el $PYTHONPATH

# Virtual environment
source /home/x/ev/bin/activate.fish
