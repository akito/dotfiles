set lines=55
set columns=180
colorscheme koehler
set background=light


"----------------------------------------------------------
" Color scheme
"----------------------------------------------------------
" Make the background color of the terminal the same as the background color of vim
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

if neobundle#is_installed('molokai')
    colorscheme molokai " Set molokai for color scheme
endif

set t_Co=256 " 256 colors
syntax enable " Color syntax
