" Basic Settings
set nocompatible              " Disable compatibility with old Vim
set number                    " Show line numbers
set relativenumber            " Relative line numbers
set tabstop=4                 " Tab width
set shiftwidth=4              " Indentation width
set expandtab                 " Use spaces instead of tabs
set cursorline                " Highlight current line
set termguicolors             " Enable true colors
syntax enable                 " Enable syntax highlighting
filetype plugin indent on     " Enable file type detection

" Install vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'elvessousa/sobrio'

Plug 'rebelot/kanagawa.nvim'
" Set default colorscheme
colorscheme sobrio

" highlight Comment ctermfg=Red guifg=#6a737d

" Enable true color support
"if has('termguicolors')
"    set termguicolors
" endif



" Minimal theme
" Plug 'morhetz/gruvbox'                " Gruvbox theme
"colorscheme gruvbox
" set background=dark

" File explorer with tree structure
Plug 'preservim/nerdtree'

" LSP and Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " CoC for Intellisense

" Git Integration
Plug 'tpope/vim-fugitive'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'           " Polyglot for extended language support



" Core fzf binary integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" fzf.vim plugin
Plug 'junegunn/fzf.vim'


call plug#end()

" Keybindings for Plugins
nmap <C-N> :NERDTreeToggle<CR>        " Toggle file tree

" CoC.nvim Configuration
let g:coc_global_extensions = [
\ 'coc-tsserver',                     " TypeScript/JavaScript support
\ 'coc-json',                         " JSON support
\ 'coc-html',                         " HTML support
\ 'coc-css',                          " CSS support
\ 'coc-react',                        " React support
\ ]

" Automatically start NERDTree when Vim starts
autocmd VimEnter * NERDTree
" Set colorscheme after NERDTree opens
autocmd VimEnter * if !exists('g:colors_name') | colorscheme sobrio | endif

" Disable conflicting keybindings
let g:coc_disable_command = 1

" Use tab for navigating completion and snippets
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Confirm selection with Enter and close completion popup
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Fuzzy Find Files
nnoremap <C-p> :Files<CR>

" Fuzzy Find Buffers
nnoremap <C-b> :Buffers<CR>

" Fuzzy Find Recent Files
nnoremap <C-r> :History<CR>

" Fuzzy Find Commands
nnoremap <C-c> :Commands<CR>

" Switch between nerdTree and current opened file 
nnoremap <S-N> :wincmd w<CR>


