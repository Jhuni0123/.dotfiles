set t_Co=256
set t_AB=[48;5;%dm
set t_AF=[38;5;%dm
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
set autoread
set smartcase
set updatetime=100
set mouse+=an
set fileencodings=utf-8,default

set ttimeout
set ttimeoutlen=100

" Clipboard
set clipboard=unnamed
if has('unix') && exists('$WSLENV')
    set clipboard+=unnamedplus
    let s:clip = 'clip.exe'
    if executable(s:clip)
        augroup WSLYank
            autocmd!
            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

syntax on
filetype plugin indent on

" +-------------+
" | Key mapping |
" +-------------+
let mapleader=","

" Easy re-selection
vnoremap <silent> <TAB>    >gv
vnoremap <silent> <S-TAB>  <gv
nnoremap gp `[v`]

" Tab navigation
nnoremap <TAB>    :tabn<CR>
nnoremap <S-TAB>  :tabp<CR>
nnoremap <esc>t   :tabnew<CR>

" Delete without saving in register
nnoremap <leader>d "_d

" Cursor movement
nnoremap <C-a> ^
nnoremap <C-e> $
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
vnoremap <C-a> ^
vnoremap <C-e> $

" Move cursor between pane
nnoremap <S-Down> <C-W><C-J>
nnoremap <S-Up> <C-W><C-K>
nnoremap <S-Right> <C-W><C-L>
nnoremap <S-Left> <C-W><C-H>

" East split
nnoremap <C-_> :split<CR>
nnoremap <C-\> :vertical split<CR>

" Auto parenthesis
inoremap {<CR> {<CR>}<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O

nmap <F8> :NERDTreeToggle<CR>
nmap <F9> :Vista!!<CR>

" +---------+
" | Plugins |
" +---------+

" vim-plug
" automatic installation
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Colorscheme
Plug 'tomasr/molokai'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Key mappings
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Shell command
Plug 'tpope/vim-eunuch'

" FZF - fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Web dev snipet
Plug 'mattn/emmet-vim'
Plug 'xolox/vim-misc'
Plug 'prabirshrestha/async.vim'

" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Tag/Symbol viewer
Plug 'liuchengxu/vista.vim'

" Latex
Plug 'vim-latex/vim-latex', { 'for': 'latex' }
Plug 'lervag/vimtex'

" JS/TS
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Python
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'python3'] }
Plug 'nvie/vim-flake8', { 'for': ['python', 'python3'] }

" Language & Syntax
Plug 'rescript-lang/vim-rescript'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'isobit/vim-caddyfile'
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'udalov/kotlin-vim'
Plug 'styled-components/vim-styled-components'
Plug 'rhysd/vim-llvm'
Plug 'chase/vim-ansible-yaml', { 'for': 'yaml' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'whonore/Coqtail', { 'for': 'coq' }
Plug 'posva/vim-vue', { 'for': 'vue' }

"Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

let g:rehash256 = 1
colorscheme molokai

" Indent-Guides
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_guide_size = 1
"let g:indent_guides_start_level = 2
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=244 guibg=red
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=240 guibg=red
"autocmd VimEnter,Colorscheme * :IndentGuidesEnable

let g:vista_default_executive = 'coc'

" vim-airline
set laststatus=2
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'nerdtree|tagbar|!'

let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#buffer_min_count = 2

set statusline+=%#warningmsg#
set statusline+=%*

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

" Turn off line number in terminal
if has('nvim')
    autocmd TermOpen * setlocal nonu
else
    autocmd TerminalOpen * setlocal nonu
endif

" FZF shortcuts
nnoremap <leader>f :Files<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>m :Maps<CR>
nnoremap <leader><TAB> :Windows<CR>

let g:fzf_layout = {'down': '~40%'}

" yaml indent
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" terraform
let g:terraform_fmt_on_save=1

" Easy single-file run
command PS vsp %:r.in|w|sp %:r.out|w|vertical resize 30|normal <C-w>w<C-w>w
command TEMP r ~/Documents/Codes/templates/template.%:e|normal ggddG

command CRIO  wall|!gcc -Wall -lm %:r.c -o %:r && ./%:r < %:r.in > %:r.out
command RIO  wall|!g++ -O2 -std=c++2a -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in > %:r.out
command RI   wall|!g++ -O2 -std=c++2a -Wall -lm %:r.cpp -o %:r && ./%:r < %:r.in
command R    wall|!g++ -O2 -std=c++2a -Wall -lm %:r.cpp -o %:r && ./%:r

command RRIO wall|!rustc %:r.rs -o %:r && ./%:r < %:r.in > %:r.out
command RRI  wall|!rustc %:r.rs -o %:r && ./%:r < %:r.in
command RR   wall|!rustc %:r.rs -o %:r && ./%:r

command PRIO wall|!python3 %:r.py < %:r.in > %:r.out
command PRIOE wall|!python3 %:r.py < %:r.in > %:r.out 2> %:r.err
command PR wall|!python3 %:r.py
command PI wall|!python3 -i %:r.py

command P2RIO wall|!python2 %:r.py < %:r.in > %:r.out
command P2R wall|!python2 %:r.py

command MLR wall|!ocaml %:r.ml
command MLRIO wall|!ocaml %:r.ml < %:r.in > %:r.out

command HSRIO wall|!ghc %:r.hs -o %:r -lm && ./%:r < %:r.in > %:r.out

command TSR wall|!tsc %:r.ts && node %:r.js

command SCRIO wall|!scala %:r.scala < %:r.in > %:r.out

command GSRIO wall|!ruby ~/.local/share/golfscript.rb %:r.gs < %:r.in > %:r.out

" Coc
let g:coc_node_path = $COC_NODE_PATH
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-sh',
    \ 'coc-css',
    \ 'coc-html',
    \ 'coc-pyright',
    \ 'coc-rust-analyzer',
    \ 'coc-clangd',
    \ ]

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gc <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')


hi def link tsxCloseTag Identifier
hi tsxTagName ctermfg=197
hi tsxCloseTagName ctermfg=197
hi tsxComponentName ctermfg=197
hi tsxCloseComponentName ctermfg=197

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Insert <tab> when previous text is space, refresh completion if not.
function! CheckBackspace() abort
let col = col('.') - 1
return !col || getline('.')[col - 1] =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ CheckBackspace() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible ? coc#pum#prev(1) : "\<C-h>"
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" Fix mouse protocol in large terminal
" https://iterm2.com/faq.html
if has('mouse_sgr')
    set ttymouse=sgr
endif

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

autocmd FileType coq nnoremap <silent> <C-Down> :CoqNext<CR>
autocmd FileType coq nnoremap <silent> <C-Up> :CoqUndo<CR>
autocmd FileType coq nnoremap <silent> <C-Right> :CoqToLine<CR>

autocmd FileType coq inoremap <silent> <C-Down> <c-o>:CoqNext<CR>
autocmd FileType coq inoremap <silent> <C-Up> <c-o>:CoqUndo<CR>
autocmd FileType coq inoremap <silent> <C-Right> <c-o>:CoqToLine<CR>
autocmd FileType coq inoremap <silent> . .<c-o>:CoqToLine<CR>
autocmd FileType coq inoremap <silent> + +<c-o>:CoqToLine<CR>
autocmd FileType coq inoremap <silent> - -<c-o>:CoqToLine<CR>
autocmd FileType coq inoremap <silent> { {<c-o>:CoqToLine<CR>
autocmd FileType coq inoremap <silent> } }<c-o>:CoqToLine<CR>
