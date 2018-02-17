"----------------------------------------------------------
" Settings
"----------------------------------------------------------
set nobackup "Do not create backup files
set noswapfile "Do not create swapfile file
set autoread "Automatically reread
set hidden "Display the command being input in the status

"----------------------------------------------------------
" character
"----------------------------------------------------------
set encoding=utf-8 "Set character code to UFT-8
set fileencoding=utf-8 "Character code when saved
set fileencodings=utf-8,ucs-boms,euc-jp,cp932 " Automatic determination of character code when reading, priority on the left side
set fileformats=unix,mac,dos " Automatic discrimination of line feed code, the left side has priority
set ambiwidth=double " □ and ○ Solve the problem of collapse


"----------------------------------------------------------
" Command mode
"----------------------------------------------------------
set wildmenu " Command mode completion
set wildmode=list:longest "
set history=5000 " Number of command history to save

"----------------------------------------------------------
" Correspondence of parentheses · tag
"----------------------------------------------------------
set showmatch " Display the correspondence of parentheses for a moment

"----------------------------------------------------------
" Status line
"----------------------------------------------------------
set laststatus=2 " Always show status line
set showmode " Show current mode
set showcmd " The hit command is displayed below the status line
set ruler " Display the position of the cursor on the right side of the status line


"----------------------------------------------------------
" Tab indent
"----------------------------------------------------------
set expandtab " Replace tab input with multiple blank inputs
set tabstop=4 " Width occupied by tab characters on the screen
set softtabstop=4 " The width at which the cursor moves with a tab key or backspace key for consecutive blanks
set autoindent " Continue indentation of previous line at line feed
set smartindent " Check the syntax of the previous line on line feed and increase / decrease the indent of the next line
set shiftwidth=4 " Width that increases and decreases with smartindent


"----------------------------------------------------------
" String search
"----------------------------------------------------------
set incsearch " Incremental search. Perform a search for each character entry
set ignorecase " Search pattern is not case sensitive
set smartcase " f the search pattern contains capital letters, distinguish case
set hlsearch " Highlight search results
set wrapscan " Return to the beginning
" Toggle highlighting by pressing the ESC key twice
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>



"----------------------------------------------------------
" Paste from clipboard
"----------------------------------------------------------
" Prevent automatic indentation when pasting from clipboard in insert mode
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"----------------------------------------------------------
" cursor
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " It is possible to move from the end of the line to the beginning of the next line by moving the cursor left and right
set number " Show line number
set cursorline " Highlight the cursor line
set cursorcolumn "Show cursor column line
set virtualedit=onemore "Add one letter at the end of the line

" If the line is displayed by wrapping, move the cursor by display line instead of line by line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" Activate backspace key
set backspace=indent,eol,start


"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
" ">>" is displayed on the syntax error line
let g:syntastic_enable_signs = 1
" Prevent contention with other Vim plugins
let g:syntastic_always_populate_loc_list = 1
" Hide syntax error list
let g:syntastic_auto_loc_list = 0
" Perform a syntax error check when opening a file
let g:syntastic_check_on_open = 1
" Also check syntax errors when ending with ": wq"
let g:syntastic_check_on_wq = 1

" For Javascript. Use ESLint for syntax error checking
let g:syntastic_javascript_checkers=['eslint']
" Do not check syntax errors except Javascript
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }
