
" the character code at the time of reading
set encoding=utf-8
" Setting for using multibyte in Vim Script
scriptencoding utf-8

"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする
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
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" カーソル
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" バックスペースキーの有効化
set backspace=indent,eol,start

"----------------------------------------------------------
" カッコ・タグの対応
"----------------------------------------------------------
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの「%」を拡張する

"----------------------------------------------------------
" マウスでカーソル移動とスクロール
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
" クリップボードからのペースト
"----------------------------------------------------------
" 挿入モードでクリップボードからペーストする時に自動でインデントさせないようにする
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
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
" 構文エラー行に「>>」を表示
let g:syntastic_enable_signs = 1
" 他のVimプラグインと競合するのを防ぐ
let g:syntastic_always_populate_loc_list = 1
" 構文エラーリストを非表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時に構文エラーチェックを実行する
let g:syntastic_check_on_open = 1
" 「:wq」で終了する時も構文エラーチェックする
let g:syntastic_check_on_wq = 1

" Javascript用. 構文エラーチェックにESLintを使用
let g:syntastic_javascript_checkers=['eslint']
" Javascript以外は構文エラーチェックをしない
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': [] }

"----------------------------------------------------------
" CtrlP
"----------------------------------------------------------
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用

" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunkyの絞り込み検索設定
let g:ctrlp_funky_matchtype = 'path'

if executable('ag')
  let g:ctrlp_use_caching=0 " CtrlPのキャッシュを使わない
  let g:ctrlp_user_command='ag %s -i --hidden -g ""' " 「ag」の検索設定
endif

" open the .vimrc
nmap <Space>,  :<C-u>edit $MYVIMRC<CR>
" import
nmap <Space>.  :<C-u>source $MYVIMRC<CR>
