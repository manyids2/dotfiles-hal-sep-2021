alias e="nvim"
alias c="clear"
alias cx="chmod +x"

# Remove fish greeting
set -U fish_greeting ""
fish_vi_key_bindings

# Various env variables
set -xg EDITOR nvim
set -xg BROWSER qutebrowser

# CUDA
set -xg PATH /home/x/bin $PATH
set -xg PATH /usr/local/cuda-11.1/bin $PATH
set -xg LD_LIBRARY_PATH /usr/local/cuda-11.1/lib64 $LD_LIBRARY_PATH

# Python paths
set -xg PYTHONPATH /home/x/fd/projects/work/utils $PYTHONPATH
set -xg PYTHONPATH /home/x/fd/projects/work/logpolar $PYTHONPATH
set -xg PYTHONPATH /home/x/fd/projects/work/endzone/kornia-1 $PYTHONPATH
set -xg PYTHONPATH /home/x/fd/projects/work/endzone/polar $PYTHONPATH

# Virtual environment
source /home/x/fd/projects/p38/bin/activate.fish

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/x/fd/projects/work/endzone/kornia-1/.dev_env/bin/conda "shell.fish" "hook" $argv | source
conda deactivate
# <<< conda initialize <<<
