""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: hanfezh <xianfeng.zhu@gmail.com>
" Description: hanfezh's vimrc from https://github.com/hanfezh/dotfiles
" Version: 0.0.1
" Sections:
"   - Install plugins
"   - General settings
"   - Editing mappings
"   - Plugins settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
Plug 'preservim/nerdtree'
" Code commenter
Plug 'preservim/nerdcommenter'
" BufExplorer plugin
Plug 'jlanzarotta/bufexplorer'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Go development
Plug 'fatih/vim-go'
" Motions on speed
Plug 'easymotion/vim-easymotion'
" Support programming languages, like C/C++
Plug 'WolfgangMehner/vim-plugins'
" Alternate files quickly
Plug 'vim-scripts/a.vim'
" Smart cscope helper
Plug 'brookhong/cscope.vim'
" Tab insert completion 
Plug 'ervandew/supertab'
" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'
" Display the indention levels
Plug 'Yggdroot/indentLine'
" Python autocompletion
Plug 'davidhalter/jedi-vim'
" Pretty json text
Plug 'hanfezh/pretty-json'
" Airline plugin and themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Show diff plugin
Plug 'mhinz/vim-signify'
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'
" Java complete
" Plug 'artur-shaik/vim-javacomplete2'
" Fuzzy-search code completion
" Plug 'Valloric/YouCompleteMe'
" ClangFormat
Plug 'rhysd/vim-clang-format'
" GitHub Copilot
Plug 'github/copilot.vim'

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" basic settings
set nu         " set number
set rnu        " set relativenumber
set ts=2       " set tabstop=2
set sw=2       " set shiftwidth=2
set et         " set expandtab
set sta        " set smarttab
set hi=1000    " set history=1000
set ic         " set ignorecase
set scs        " set smartcase
set bs=2       " set backspace=indent,eol,start
set hls        " set hlsearch
set is         " set incsearch
silent! set scl=number " set signcolumn=number
set aw         " set autowrite

" c/c++ options
set ai         " set autoindent
set si         " set smartindent
set sm         " set showmatch
set cino=g1,h1,i4,l1,m1,N-s,t0,us,W4,(0,:2 " help cinoptions-values

" for ctags
set tags=tags
" tag file generated automatically
augroup AutoTag
    autocmd!
    autocmd BufWritePost *.py,*.c,*.cpp,*.h silent! !eval 'ctags -R -o tags 1>/dev/null 2>&1' &
    autocmd BufWritePost *.go silent! !eval 'gotags -f tags -R . 1>/dev/null 2>&1' &
augroup END

syntax on

set wildmenu
set wildmode=longest,list,full

" file encoding
set fileencoding=utf-8
set fileencodings=utf-8,gb18030,gbk

if has('nvim')
    set inccommand=split
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mapping key
let mapleader = ","
nnoremap <space> viw
inoremap jk <esc>
" inoremap <esc> <nop>
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <Leader>hh :execute "help " . expand('<cword>')<CR>
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

" change filetype json -> jsonc
augroup JsonToJsonc
    autocmd! FileType json set filetype=jsonc
augroup END

" enable alt key mapping
" for i in range(97,122)
"     let c = nr2char(i)
"     execute "map \e".c." <M-".c.">"
"     execute "map! \e".c." <M-".c.">"
" endfor

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar settings
let g:tagbar_left = 1
let g:tagbar_width = 32
let g:tagbar_sort = 0
let g:tagbar_autofocus = 0
let g:tagbar_show_linenumbers = 1
" nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F2> :call SwitchAutoTagBar()<CR>
augroup AutoTagbar
    autocmd!
    autocmd VimEnter * if &diff == 0 && argc() != 0 | TagbarOpen | endif
    autocmd VimEnter * :wincmd p
    autocmd FileType c,cpp,java,go,python,sh,javascript nested :TagbarOpen
augroup END
function! SwitchAutoTagBar()
    if exists('t:tagbar_buf_name')
        if bufwinnr(t:tagbar_buf_name) != -1
            " Close the tagbar window
            execute ":TagbarClose"
            augroup AutoTagbar
                autocmd!
            augroup END
            return
        endif
    endif

    " Open the tagbar window
    execute ":TagbarOpen"
    augroup AutoTagbar
        autocmd!
        autocmd VimEnter * if &diff == 0 && argc() != 0 | TagbarOpen | endif
        autocmd VimEnter * :wincmd p
        autocmd FileType c,cpp,java,go,python,sh,javascript nested :TagbarOpen
    augroup END
endfunction

" support tagbar for golang by gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

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
let g:NERDCustomDelimiters = {
      \ 'python': { 'left': '#', 'right': '' }
      \ }

" BufExplorer settings
nnoremap <F4> :BufExplorer<CR>
nnoremap <Leader>bf :BufExplorer<CR>

" for ConqueTerm. zsh is too slow in vim.
nnoremap <F5> :ConqueTerm zsh<CR>
" nnoremap <F5> :ConqueTerm bash<CR>

" fzf settings
nnoremap <C-p> :Files<CR>
nnoremap <S-p> :Buffers<CR>
nnoremap <S-t> :BTags<CR>
nnoremap <S-m> :BTags<CR>

" vim-go settings
let g:go_bin_path = expand("~/go/bin/")
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
augroup AutoGoDecls
    autocmd!
    autocmd FileType go setlocal tabstop=4 | setlocal shiftwidth=4
    autocmd FileType go nnoremap <buffer> <Leader>b  <Plug>(go-run)
    autocmd FileType go nnoremap <buffer> <S-m> :GoDecls<CR>
    autocmd FileType go nnoremap <buffer> <Leader>g :GoBuildTags ''<CR>
    autocmd FileType go nnoremap <buffer> <Leader>fc <Plug>(go-callers)
    autocmd FileType go nnoremap <buffer> <Leader>fs <Plug>(go-referrers)
augroup END

" easymotion settings
let g:EasyMotion_leader_key = '.'
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

" Options for indentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '·'
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 0

" Disable renaming in jedi-vim
let g:jedi#rename_command = ""

" Airline settings
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1

" ClangFormat, map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
