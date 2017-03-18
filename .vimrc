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
set fileencodings=utf-8,euc-kr,utf-16le
set background=dark
set backspace=2
set nocompatible
set cino=g0j1J1
set clipboard=unnamedplus
set autoread

syntax on
filetype plugin indent on

vnoremap <TAB>    >gv
vnoremap <S-TAB>  <gv

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
set mouse=a

" Easy single-file run
command PS vsp %:r.in|w|sp %:r.out|w|vertical resize 30|normal <C-w>w<C-w>w

command RIO  wall|!g++ -O2 -std=c++11 -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in > %:r.out
command RI   wall|!g++ -O2 -std=c++11 -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in
command R    wall|!g++ -O2 -std=c++11 -Wall -lm %:r.cpp -o %:r && ./%:r

command PRIO wall|!python3 % < %:r.in > %:r.out
command PR wall|!python3 %

nnoremap <CR> o<ESC>
nnoremap <Backspace> X

nmap <F8> :NERDTree<CR>
nmap <F9> :call ToggleErrors()<CR>

" vim-plug
call plug#begin('~/.vim/plugged')
"Plug 'gmarik/Vundle.vim'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-syntastic/syntastic'
Plug 'chase/vim-ansible-yaml'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'sindresorhus/vim-xo'
Plug 'nvie/vim-flake8'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
"Plug 'jiangmiao/auto-pairs'
Plug 'the-lambda-church/coquille'
Plug 'ElmCast/elm-vim'
"Plug 'let-def/vimbufsync'
"Plug 'klen/python-mode'
"Plug 'davidhalter/jedi-vim'
call plug#end()
filetype plugin indent on

colorscheme molokai

" Indent-Guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=244 guibg=red
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240 guibg=red
autocmd VimEnter,Colorscheme * :IndentGuidesEnable

" vim-airline
set laststatus=2
set t_Co=256
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_min_count = 2

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_cpp_check_header = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

highlight SyntasticErrorSign guifg=white guibg=red
highlight SyntasticErrorLine guibg=#2f0000

let g:syntastic_c_compiler = 'gcc'

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:loaded_syntastic_cpp11_gcc_checker = 1
let g:syntastic_cpp11_compiler = executable('g++') ? 'g++' : 'clang++'
let g:syntastic_cpp_include_dirs = [ '../external/glfw-3.0.3/include/GLFW/', 'external/glfw-3.0.3/include/GLFW/', 'external/glm-0.9.4.0/', '../external/glm-0.9.4.0/', 'external/glew-1.9.0/include/' , '../external/glew-1.9.0/include/' ]

let g:syntastic_javascript_checkers = ['eslint', 'xo']

" syntastic for elm
let g:elm_syntastic_show_warnings = 1
let g:syntastic_elm_checkers = ['elm_make']

" syntastic toggle errors
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction

" Pathogen
silent! execute pathogen#infect()

" vim-flake8 option
let g:flake8_max_line_length=120

" vim-jsx
let g:jsx_ext_required = 0

" Coquille
au FileType coq call coquille#FNMapping()
"au FileType coq call coquille#CoqideMapping()

" elm-vim & elm-format
let g:elm_format_autosave = 0
