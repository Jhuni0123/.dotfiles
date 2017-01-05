set t_Co=256
set nu
set ai
set cindent
set si
set nobackup
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set ignorecase
set hlsearch
set incsearch
set showmode
set history=1000
set fileencodings=utf-8,euc-kr
set background=dark
set bs=2
set nocp
set cino+=g0
set clipboard=unnamed
set autoread

syntax on
filetype plugin indent on

"vnoremap <TAB> >gv
"vnoremap <s-tab> <gv
nnoremap <esc>t   :tabnew<cr>
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

nnoremap<CR> o<ESC>
nnoremap <Backspace> X

colorscheme molokai
"colorscheme vividchalk

map <C-a> ggVG
nmap <F7> :NERDTree<CR>
nmap <F8> :Tlist<CR>
let Tlist_Use_Right_Window = 1
nmap <F9> :call ToggleErrors()<CR>

" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tomasr/molokai'
"Plugin 'taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'The-NERD-tree'
"Plugin 'code_complete'
Plugin 'Syntastic'
Plugin 'Indent-Guides'
Plugin 'mattn/emmet-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
"Plugin 'wting/rust.vim'
Plugin 'SingleCompile'
"Plugin 'fatih/vim-go'
Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'klen/python-mode'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=244 guibg=red
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240 guibg=red
autocmd VimEnter,Colorscheme * :IndentGuidesEnable

" 자동 주석 제거
autocmd FileType * setlocal formatoptions-=ro

" airline 설정
set laststatus=2
set t_Co=256
"let g:airline_theme = 'badwolf'

"if &diff
"else
"    au BufWinLeave *.* mkview
"    au BufWinEnter *.* silent loadview
"endif

au BufNewFile,BufRead *.glsl,*.fragmentshader,*.vertexshader setf glsl

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

function! ToggleErrors()
	let old_last_winnr = winnr('$')
	lclose
	if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
	    Errors
	endif
endfunction

au BufWinEnter *.cpp,*h syn keyword cppType shared_ptr unordered_map map vector deque queue list

au BufWinEnter *.cpp,*.c,*h set et
au BufWinEnter *.cpp,*.c,*h retab

"let g:html_indent_inctags = "body,head,tbody"

let g:airline#extensions#syntastic#enabled = 1

nmap <F10> :SCCompileRun<cr>
let g:SingleCompile_autowrite = 0

au BufWinEnter *.bsv set filetype=bsv

" Maps Coquille commands to CoqIDE default key bindings
au FileType coq call coquille#FNMapping()

" Pathogen
execute pathogen#infect()

" Python Syntax
let OPTION_NAME = 1
let python_highlight_all = 1
