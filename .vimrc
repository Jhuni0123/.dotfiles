set t_Co=256
set number
set autoindent
set cindent
set smartindent
set nobackup
set ruler
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ignorecase
set hlsearch
set incsearch
set showmode
set history=1000
set background=dark
set backspace=2
set nocompatible
"set cino=g0j1J1
set clipboard=unnamed
set autoread
set smartcase
set tags=tags
set updatetime=100

syntax on
filetype plugin indent on

vnoremap <TAB>    >gv
vnoremap <S-TAB>  <gv

nnoremap gp `[v`]

nnoremap <TAB>    :tabn<CR>
nnoremap <S-TAB>  :tabp<CR>
nnoremap <esc>t   :tabnew<CR>
nnoremap <esc>1   1gt
nnoremap <esc>2   2gt
nnoremap <esc>3   3gt
nnoremap <esc>4   4gt
nnoremap <esc>5   5gt
nnoremap <esc>6   6gt
nnoremap <esc>7   7gt
nnoremap <esc>8   8gt
nnoremap <esc>9   9gt

"nnoremap <LeftMouse> <nop>
set mouse+=an

let mapleader=","

nnoremap <leader>d "_d


" Easy single-file run
command PS vsp %:r.in|w|sp %:r.out|w|vertical resize 30|normal <C-w>w<C-w>w
command TEMP r ~/Documents/Codes/templates/template.%:e|normal ggddG

command CRIO  wall|!gcc -Wall -lm %:r.c -o %:r && ./%:r < %:r.in > %:r.out
command RIO  wall|!g++ -O2 -std=c++17 -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in > %:r.out
command RI   wall|!g++ -O2 -std=c++17 -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in
command R    wall|!g++ -O2 -std=c++17 -Wall -lm %:r.cpp -o %:r && ./%:r

command RRIO wall|!rustc %:r.rs && ./%:r < %:r.in > %:r.out
command RRI  wall|!rustc %:r.rs && ./%:r < %:r.in
command RR   wall|!rustc %:r.rs && ./%:r

command PRIO wall|!python %:r.py < %:r.in > %:r.out
command PRIOE wall|!python %:r.py < %:r.in > %:r.out 2> %:r.err
command PR wall|!python %:r.py
command PI wall|!python -i %:r.py

command P2RIO wall|!python2 %:r.py < %:r.in > %:r.out
command P2R wall|!python2 %:r.py

command MLR wall|!ocaml %:r.ml
command MLRIO wall|!ocaml %:r.ml < %:r.in > %:r.out

command HSRIO wall|!ghc %:r.hs -o %:r -lm && ./%:r < %:r.in > %:r.out

command TSR wall|!tsc %:r.ts && node %:r.js

command SCRIO wall|!scala %:r.scala < %:r.in > %:r.out

inoremap {<CR> {<CR>}<ESC>O
"nnoremap <CR> o<ESC>
"nnoremap <Backspace> X

nmap <F6> :Buffers<CR>
nmap <F7> :ALEHover<CR>
nmap <F8> :NERDTreeToggle<CR>
nmap <F9> :call ToggleErrors()<CR>
nmap <F12> :TagbarToggle<CR>


"let g:ale_completion_enabled = 1

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-syntastic/syntastic'
Plug 'chase/vim-ansible-yaml'
Plug 'sindresorhus/vim-xo'
Plug 'nvie/vim-flake8'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'the-lambda-church/coquille'
Plug 'posva/vim-vue' 
Plug 'vim-latex/vim-latex'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
"Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'spoqa/nirum.vim', { 'for': 'nirum' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskel' }
Plug 'cespare/vim-toml'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'majutsushi/tagbar'
"Plug 'Wraul/vim-easytags', { 'branch': 'fix-universal-detection' }
Plug 'xolox/vim-misc'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'python3'] }
"Plug 'python-mode/python-mode', { 'branch': 'develop' }
"Plug 'Valloric/YouCompleteMe'
Plug 'isobit/vim-caddyfile'
call plug#end()

colorscheme molokai

" Indent-Guides
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_guide_size = 1
"let g:indent_guides_start_level = 2
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=244 guibg=red
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240 guibg=red
"autocmd VimEnter,Colorscheme * :IndentGuidesEnable


" vim-airline
set laststatus=2
set t_Co=256
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'nerdtree|tagbar|!'

let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#buffer_min_count = 2

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["html"] }

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticErrorLine guibg=#2f0000

let g:syntastic_c_compiler = 'gcc'

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++17'

let g:loaded_syntastic_cpp11_gcc_checker = 1
let g:syntastic_cpp11_compiler = executable('g++') ? 'g++' : 'clang++'

let g:syntastic_javascript_checkers = ['eslint', 'xo']
let g:syntastic_python_checkers = ['flake8'] ", 'python3', 'python']

" syntastic toggle errors
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" vim-flake8 option
let g:flake8_max_line_length=120

" vim-jsx
let g:jsx_ext_required = 0

" TeX key map
"au FileType tex imap <leader>Align \begin{align*}<CR>\end{align*}<<-->><Esc>O

" typescript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

let g:fsharp_only_check_errors_on_write = 1

" vim-gitgutter
highlight GitGutterAdd    guifg=#009900 guibg=#232526 ctermfg=2 ctermbg=236
highlight GitGutterChange guifg=#bbbb00 guibg=#232526 ctermfg=3 ctermbg=236
highlight GitGutterDelete guifg=#ff2222 guibg=#232526 ctermfg=1 ctermbg=236

" easytags
let g:easytags_suppress_ctags_warning = 1
let g:easytags_async = 1
let g:easytags_dynamic_files = 1

let g:vim_jsx_pretty_colorful_config = 1

" auto-reload file when changed in background
au FocusGained,BufEnter * :silent! !

" FZF shortcut
nnoremap <leader>f :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader><TAB> :Windowss<CR>
