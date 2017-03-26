
" the character code at the time of reading
set encoding=utf-8
" Setting for using multibyte in Vim Script
scriptencoding utf-8

"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
    " Specify the path of NeoBundle in runtimepath only when it is started for the first time
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " If NeoBundle is not installed, git clone
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif


call neobundle#begin(expand('~/.vim/bundle/'))

" vim plugin to be installed below
" Manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" color scheme
NeoBundle 'tomasr/molokai'
" Strengthened display of status line
NeoBundle 'itchyny/lightline.vim'
" Indent visualization
NeoBundle 'Yggdroot/indentLine'
" Leading full-width and one-byte space character highlighted in red
NeoBundle 'bronson/vim-trailing-whitespace'
" Syntax error check
NeoBundle 'scrooloose/syntastic'
" Multifunction selector
NeoBundle 'ctrlpvim/ctrlp.vim'
" Extended plugin for CtrlP. Function search
NeoBundle 'tacahiroy/ctrlp-funky'
" Extended plugin for CtrlP. Command history search
NeoBundle 'suy/vim-ctrlp-commandline'
" Use ag to search CtrlP
NeoBundle 'rking/ag.vim'
" Load ESLint in project
NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'

" Install the following Vim plugin only when vim's lua function is available
if has('lua')
    " Automatic completion of code
    NeoBundle 'Shougo/neocomplete.vim'
    " Supplement function of snippet
    NeoBundle "Shougo/neosnippet"
    " Snippet collection
    NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()

" Enable Vim plugin / indent by file type
filetype plugin indent on

" If you have an uninstalled Vim plugin, you will be asked if you want to install it
NeoBundleCheck

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

"----------------------------------------------------------
" character
"----------------------------------------------------------
set fileencoding=utf-8 " Character code when saved
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " Automatic determination of character code when reading, priority on the left side
set fileformats=unix,dos,mac " Automatic discrimination of line feed code, the left side has priority
set ambiwidth=double " □ and ○ Solve the problem of collapse

"----------------------------------------------------------
" Status line
"----------------------------------------------------------
set laststatus=2 " Always show status line
set showmode " Show current mode
set showcmd " The hit command is displayed below the status line
set ruler " Display the position of the cursor on the right side of the status line

"----------------------------------------------------------
" Command mode
"----------------------------------------------------------
set wildmenu " Command mode completion
set history=5000 " Number of command history to save

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

" Toggle highlighting by pressing the ESC key twice
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" cursor
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " It is possible to move from the end of the line to the beginning of the next line by moving the cursor left and right
set number " Show line number
set cursorline " Highlight the cursor line

" If the line is displayed by wrapping, move the cursor by display line instead of line by line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" Activate backspace key
set backspace=indent,eol,start

"----------------------------------------------------------
" Correspondence of parentheses · tag
"----------------------------------------------------------
set showmatch " Display the correspondence of parentheses for a moment
source $VIMRUNTIME/macros/matchit.vim " Extend "%" of Vim

"----------------------------------------------------------
" Move cursor and scroll with mouse
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

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
" Setting of neocomplete · neosnippet
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Enable neocomplete when starting Vim
    let g:neocomplete#enable_at_startup = 1
    " Activate smartcase ignoring case sensitivity until capital letters are entered
    let g:neocomplete#enable_smart_case = 1
    " Enable completion for three or more words
    let g:neocomplete#min_keyword_length = 3
    " Complement to the delimiter
    let g:neocomplete#enable_auto_delimiter = 1
    " Display completed completion from first character input
    let g:neocomplete#auto_completion_start_length = 1
    " Close complementary popup in backspace
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " Confirm completion candidate with enter key.End snippet expansion with enter key as well
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " Tab key to select completion candidate. Jump in snippet also jump with tab key
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

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

"----------------------------------------------------------
" CtrlP
"----------------------------------------------------------
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " Match window setting "Display at the bottom, fix with size of 20 lines, 100 search results"
let g:ctrlp_show_hidden = 1 " Also search for files starting from. (Dot)
let g:ctrlp_types = ['fil'] "Use file search only
let g:ctrlp_extensions = ['funky', 'commandline'] " Use "funky" and "commandline" as extension of CtrlP

" Enable CtrlPCommandLine
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunky refine search setting
let g:ctrlp_funky_matchtype = 'path'

if executable('ag')
  let g:ctrlp_use_caching=0 " Do not use CtrlP cache
  let g:ctrlp_user_command='ag %s -i --hidden -g ""' " Search setting of "ag"
endif

" open the .vimrc
nmap <Space>,  :<C-u>edit $MYVIMRC<CR>
" import
nmap <Space>.  :<C-u>source $MYVIMRC<CR>
