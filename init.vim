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

"Plug 'elvessousa/sobrio'

Plug 'rebelot/kanagawa.nvim'

Plug 'craftzdog/solarized-osaka.nvim'
" Set default colorscheme

" highlight Comment ctermfg=Red guifg=#6a737d

" Enable true color support
"if has('termguicolors')
"    set termguicolors
" endif

" Minimal theme
 " Plug 'morhetz/gruvbox'                " Gruvbox theme
"colorscheme gruvbox
" set background=dark

" Commands - keybindings
" Shift + N - switch focus between nerdtree and current file
" Ctrl + N - toggle nerdtree
" Ctrl + P - fuzzy find Files
" Ctrl + B - fuzzy find Buffers
" Shift + Tab - autocomplete popup
" Ctrl + L - accept copilot suggestions
" Ctrl + E - dismiss copilot suggestions

" File explorer with tree structure
Plug 'preservim/nerdtree'

" LSP and Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " CoC for Intellisense

" Git Integration
Plug 'tpope/vim-fugitive'

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'           " Polyglot for extended language support

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim' "Required dependency

" Install fzf.vim for fuzzy finding

" Core fzf binary integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" fzf.vim plugin
Plug 'junegunn/fzf.vim'

" Add GitHub Copilot plugin
 Plug 'github/copilot.vim'


call plug#end()

colorscheme solarized-osaka

" Keybindings for Plugins
nmap <C-N> :NERDTreeToggle<CR>        " Toggle file tree

" CoC.nvim Configuration
let g:coc_global_extensions = [
\ 'coc-tsserver',                     
\ 'coc-json',                         
\ 'coc-html',                         
\ 'coc-css',                        
\ ]


let mapleader =" "

" Automatically start NERDTree when Vim starts
" autocmd VimEnter * NERDTreeToggle
" autocmd VimEnter
" Set colorscheme after NERDTree opens
autocmd VimEnter * if !exists('g:colors_name') | colorscheme solarized-osaka | endif

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

nnoremap <silent> <leader>t :tabnew<CR><C-w>l:Files<CR>
nnoremap <leader>n :tabnext<CR>
nnoremap <leader>p :tabprev<CR>
" Telescope find_files | endif<CR>
" === GitHub Copilot Configuration ===

" Disable default Tab mapping to avoid conflicts with CoC or other plugins
let g:copilot_no_tab_map = v:true

" Use <C-l> (Control + L) to accept Copilot suggestions
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" Dismiss Copilot suggestions with <C-E>
imap <silent> <C-E> copilot#Dismiss()

" Filetype-specific behavior (optional)

let g:copilot_filetypes = {
  \ '*': v:true,  
  \ 'markdown': v:false,  
  \ 'text': v:false      
\ }

"Enable Copilot by default
"Disable for Markdown
"Disable for plain text files


" Highlight Copilot suggestions (customize for your theme)
highlight CopilotSuggestion guifg=#6A9955 ctermfg=DarkGreen
