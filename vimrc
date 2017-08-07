" ufengzh's vimrc
" https://github.com/ufengzh/vimrc
" version 0.0.1

" basic settings
set nu         " set number
set rnu        " set relativenumber
set ts=4       " set tabstop=4
set sw=4       " set shiftwidth=4
set et         " set expandtab
set sta        " set smarttab
set hi=1000    " set history=1000
set ic         " set ignorecase
set scs        " set smartcase
set bs=2       " set backspace=indent,eol,start
set hls        " set hlsearch
set is         " set incsearch

" c/c++ options
set ai         " set autoindent
set si         " set smartindent
set sm         " set showmatch
set cino=:0g0t0(sus

" for ctags
set tags=tags
" tag file generated automatically
augroup AutoTag
    autocmd!
    autocmd BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o tags' &
augroup END

syntax on

set wildmenu
set wildmode=longest,list,full

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}:%{&fenc==\"\"?&enc:&fenc}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" file encoding
set fileencoding=utf-8
set fileencodings=utf-8,gb18030,gbk

" mapping key
let mapleader = "."
nnoremap <space> viw
inoremap jk <esc>
" inoremap <esc> <nop>
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <Leader>h :execute "help " . expand('<cword>')<CR>
nnoremap <Leader>s :update<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>sh :shell<CR>

" highlight settings
noremap n :set hlsearch<CR>n
noremap N :set hlsearch<CR>N
noremap / :set hlsearch<CR>/
noremap ? :set hlsearch<CR>?
noremap * :set hlsearch<CR>*
noremap # :set hlsearch<CR>#
augroup AutoSearch
    autocmd!
    autocmd cursorhold * set nohlsearch
augroup END
nnoremap <C-h> :call SwitchHighlight()<CR>
function! SwitchHighlight()
    set hlsearch!
endfunc

" filetype settings
" same to `filetype plugin indent on`
filetype on
filetype plugin on
filetype indent on
augroup AutoFileType
    autocmd!
    " For all text files set `textwidth` to 78 characters.
    autocmd FileType text setlocal textwidth=78
    " Opening Vim help in a vertical split window.
    autocmd FileType help wincmd L
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g'\"" |
                \ endif
augroup END

" enable alt key mapping
" for i in range(97,122)
"     let c = nr2char(i)
"     execute "map \e".c." <M-".c.">"
"     execute "map! \e".c." <M-".c.">"
" endfor

" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for vim-plug's plugins
silent! call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
" Tags browser
Plug 'majutsushi/tagbar'
" Files browser
Plug 'scrooloose/nerdtree'
" Code commenter
Plug 'scrooloose/nerdcommenter'
" BufExplorer plugin
Plug 'jlanzarotta/bufexplorer'
" Files and code fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
Plug 'fisadev/vim-ctrlp-cmdpalette'
" Go development
Plug 'fatih/vim-go'
" Motions on speed
Plug 'easymotion/vim-easymotion'
" Write and run programs for C/C++
Plug 'vim-scripts/c.vim'
" Alternate files quickly
Plug 'vim-scripts/a.vim'
" Automatically opens popup menu for completions
Plug 'vim-scripts/AutoComplPop'
" Smart cscope helper
Plug 'brookhong/cscope.vim'
" Tab insert completion 
Plug 'ervandew/supertab'
" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
" Fuzzy-search code completion
Plug 'Valloric/YouCompleteMe'

" Initialize plugin system
call plug#end()

" AutoComplPop settings
let g:AutoComplPop_Behavior = {
			\ 'c': [ {'command' : "\<C-x>\<C-o>",
			\ 'pattern' : ".",
			\ 'repeat' : 0}
			\ ]
			\}

" tagbar settings
let g:tagbar_left = 1
let g:tagbar_width = 32
let g:tagbar_sort = 0
let g:tagbar_autofocus = 0
let g:tagbar_show_linenumbers = 1
nnoremap <silent> <F2> :TagbarToggle<CR>
augroup AutoTagbar
    autocmd!
    autocmd VimEnter * if &diff == 0 && argc() != 0 | TagbarOpen | endif
    autocmd VimEnter * :wincmd p
    autocmd FileType c,cpp,java,go,python nested :TagbarOpen
augroup END

" nerdtree settings
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 32
let NERDTreeQuitOnOpen = 1
let NERDTreeShowLineNumbers = 1
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <silent> <Leader>r :call NERDTreeToggleInCurDir()<CR>
function! NERDTreeToggleInCurDir()
    " If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        execute ":NERDTreeClose"
    else
        execute ":NERDTreeFind"
    endif
endfunction

" nerdcommenter settings
let g:NERDSpaceDelims = 1

" BufExplorer settings
nnoremap <F4> :BufExplorer<CR>
nnoremap <Leader>bf :BufExplorer<CR>

" for ConqueTerm. zsh is too slow in vim.
nnoremap <F5> :ConqueTerm zsh<CR>
" nnoremap <F5> :ConqueTerm bash<CR>

" ctrlp settings
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
execute "set <M-p>=\ep"
execute "set <M-m>=\em"
nnoremap <M-p> :CtrlPTag<CR>
nnoremap <M-m> :CtrlPBufTag<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
            \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
            \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=16
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" ctrlp-cmdpalette settings
let g:ctrlp_cmdpalette_execute = 1
nnoremap ,c :CtrlPCmdPalette<CR>

" vim-go settings
let g:go_bin_path = expand("~/.vim/gotools")
augroup AutoGoDecls
    autocmd!
    autocmd FileType go nnoremap <buffer> <M-m> :GoDecls<CR>
    autocmd FileType go nnoremap <buffer> <M-p> :GoDeclsDir<CR>
augroup END

" easymotion settings
let g:EasyMotion_leader_key = ','
" map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" a.vim settings
nnoremap <Leader>a :A<CR>

" smart cscope settings
nnoremap <Leader>fr :call ToggleLocationList()<CR>
nnoremap <Leader>fu :call CscopeUpdateDB()<CR>
" s: Find this C symbol
nnoremap <Leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap <Leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap <Leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap <Leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap <Leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap <Leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap <Leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap <Leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" Close location list automatically when file selected
augroup QFClose
    autocmd!
    autocmd FileType qf nnoremap <buffer> <CR> <CR>:lcl<CR>
augroup END

" supertab settings
let g:SuperTabDefaultCompletionType = "<c-n>"

" auto-pairs settings
let g:AutoPairsShortcutToggle = ''
