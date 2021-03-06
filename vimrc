"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"fix loading of ftdetect scripts
filetype off

"set the runtime path to include Vundle and initialize
set rtp+=/home/cocco/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"switch from cpp to hpp files
Plugin 'vim-scripts/a.vim'
"colors for vim from cmdline
"Plugin 'vim-scripts/csapprox.vim'
"useful tool for file and tag search
Plugin 'vim-scripts/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'

"Move fast into files with
Plugin 'easymotion/vim-easymotion'
Plugin 'gcmt/wildfire.vim'
Plugin 'vim-scripts/endwise.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/delimitMate.vim'
"align text easily
Plugin 'godlygeek/tabular'

Plugin 'vim-scripts/gist.vim'
Plugin 'rhysd/conflict-marker.vim'

Plugin 'vim-scripts/ragtag.vim'
Plugin 'vim-scripts/rails.vim'
Plugin 'vim-scripts/repeat.vim'
Plugin 'mbbill/undotree'


Plugin 'henrik/vim-indexed-search'
Plugin 'embear/vim-localvimrc'
"Plugin 'vim-scripts/markdown-runtime.vim'
Plugin 'adelarsq/vim-matchit'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-powerline'
Plugin 'majutsushi/tagbar'

Plugin 'sirver/ultisnips'
Plugin 'vim-syntastic/syntastic'

Plugin 'vim-scripts/unimpaired.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhinz/vim-startify'

"yank ring keeps memory of copy pasted lines
Plugin 'vim-scripts/YankRing.vim'
Plugin 'mileszs/ack.vim'
Plugin 'morhetz/gruvbox'
Plugin 'chiedo/vim-dr-replace'
Plugin 'davidhalter/jedi'
Plugin 'steffanc/cscopemaps.vim'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'oblitum/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/xptemplate'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-scripts/sessionman.vim'

Plugin 'vim-latex/vim-latex'
"Plugin 'robince/pythoncomplete.vim'
Plugin 'python-mode/python-mode'
Plugin 'tell-k/vim-autopep8'
"https://github.com/python-mode/python-mode
", { 'dir': '~/.fzf', 'do': './install --all' }
"fuzzy search instrument with F7
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Comments
Plugin 'heavenshell/vim-pydocstring'
Plugin 'spacehi.vim'
Plugin 'CountJump'
Plugin 'ingo-library'
Plugin 'ConflictMotions'
"Thesaurus
Plugin 'Ron89/thesaurus_query.vim'

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set showmatch

set number      "show line numbers

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set ttimeout
set ttimeoutlen=50

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
"set linebreak   "wrap lines at convenient points

"move swapfiles
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
set smarttab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*/.git/*,*/build/*,*/build.*/*,*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on
let g:syntastic_python_checkers = ['pyflakes']

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"always show statusline
set laststatus=2
set encoding=utf-8
set spelllang=en

"syntastic settings
"set updatetime=500 "parse after 500 ms of editing

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40


"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif


"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
"autocmd BufReadPost fugitive://* set bufhidden=delete
"autocmd BufReadPost fugitive://*
 " \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
 " \   nnoremap <buffer> .. :edit %:h<CR> |
 " \ endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"start my additions
"

"make running commands less ugly
"set norestorescreen
set t_ti= t_te=

"get return codes from make
set shellpipe=2>&1\ \|\ tee\ %s;exit\ \${PIPESTATUS[0]}

"disable backup since most stuff are in git

set backupdir =/home/cocco/.vim/backup/


"disable bells
set visualbell t_vb=
"more include paths for gf command
set path+=/usr/include/c++/4.7.2

"override make command for CMake projects
function! SetupMake()
    if filereadable("CMakeLists.txt") && filereadable("./build/Makefile")
        set makeprg=make\ -j8\ -C\ build
    else
        set makeprg=make\ -j8
    endif
endfunction

"override run command for CMake projects install
function! MakeInstall()
    if filereadable("CMakeLists.txt") && filereadable("./build/Makefile")
        set makeprg=make\ install\ -j8\ -C\ build
    else
        set makeprg=make\ install\ -j8
    endif
endfunction
function! Compile()
    call SetupMake()
    make
endfunction

function! Run()
    call MakeInstall()
    make
endfunction

" launch python from vim
nnoremap <F9> :exec '!python' shellescape(@%, 1)<cr>
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_breakpoint_bind = '<leader>k'


"command for bulding local tags
command! Ctags :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .
command! Vreload :source ~/.vimrc


" allow larger text width
"set textwidth=120

"turn off preview menu for omni
set completeopt=menu

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

"auto close preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"automatically opens quickfix window on make errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"auto reload vimrc when saving
"autocmd BufWritePost .vimrc source ~/.vimrc

"localvimrc
let g:localvimrc_sandbox=0
let g:localvimrc_ask = 0


"fix yaking conflict with ctrlp
let g:yankring_replace_n_pkey = '<Char-172>'
let g:yankring_replace_n_nkey = '<Char-174>'
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"ctrlp confs
let g:ctrlp_follow_symlinks=1

"buffergator
let g:buffergator_viewport_split_policy="T"
let g:buffergator_split_size=15
let g:buffergator_sort_regime="mru"

"ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"YouCompleteMe
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_always_populate_location_list = 1
let g:ycm_confirm_extra_conf=0
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F11> :YcmForceCompileAndDiagnostics <CR>
"fzf
nnoremap <F7> :Tags <CR>

"easymotion
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap  <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"gutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
set signcolumn=yes


"treat std include files as cpp
au BufEnter /usr/include/c++/* setf cpp

"formatting style
autocmd BufNewFile,BufRead *.cpp set formatprg=astyle\ -A1s4Sclk1
autocmd BufNewFile,BufRead *.h set formatprg=astyle\ -A2s4SOclk1

"auto remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

colorscheme gruvbox
set background=dark


"customize sign column
au BufEnter * highlight SignColumn ctermbg=black

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
cmap w!! %!sudo tee > /dev/null %

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"useful replacing macros
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

"explorer mappings
nnoremap <f1> :BuffergatorToggle<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>
map <f5> :call Compile()<CR>
map <f6> :call Run()<CR>

"fast vimrc editing
map <leader>v :e! ~/.vimrc<CR>

"allow switching windows while in insert mode
imap <C-w> <Esc><C-w>

"toggle spell checking
nmap <silent> <leader>s :set spell!<CR>

"key mapping for quickfix navigation
map <C-n> :cnext<CR>
"map <C-b> :cprevious<CR>
map <leader>q :ccl<cr>

map <C-s> :w<cr>

"clear highlight
nnoremap <C-L> :nohlsearch<cr>

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']




"gvim tab handler
" Move tabs left/right
function! TabLeft()
let tab_number = tabpagenr() - 1
if tab_number == 0
execute "tabm" tabpagenr('$') - 1
else
execute "tabm" tab_number - 1
endif
endfunction

function! TabRight()
let tab_number = tabpagenr() - 1
let last_tab_number = tabpagenr('$') - 1
if tab_number == last_tab_number
execute "tabm" 0
else
execute "tabm" tab_number + 1
endif
endfunction

nnoremap <silent><C-S-Right> :execute TabRight()<CR>
nnoremap <silent><C-S-Left> :execute TabLeft()<CR>

" Relative numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set rnu!
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffffff guibg=#0000ff
noremap <c-a> :A<CR>
noremap <c-s> :wa<CR>

highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffffff guibg=#0000ff
highlight BlueLine guibg=Blue
autocmd BufReadPost quickfix match BlueLine /\%1l/
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :execute 'match BlueLine /\%' . line('.') . 'l/'<CR><CR>

function! SomeCheck()
   if filereadable("./cscope.out")
        cs add "./cscope.out"
   endif
endfunction


" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


"open a nice fzf window
noremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words')
"save all open
noremap  <c-q> :wa<CR>
noremap  <c-a> :A <CR>

nmap <c-t> "+gP
imap <c-t> <ESC><c-t>i
vmap <c-y> "+y
set guifont=inconsolata\ 11

nnoremap <Leader>cs :ThesaurusQueryReplaceCurrentWord<CR>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP
