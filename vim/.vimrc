if !has("nvim")

" Disable compatibility with vi
  set nocompatible

" Enable syntax highlight by default
  syntax on

" Enable plugins
  filetype plugin on

" Fuzzy file finding
  set path+=**
  set wildmenu

endif

call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'dyng/ctrlsf.vim'
Plug 'mattn/emmet-vim'
Plug 'github/copilot.vim' " Requires to sign up
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'Shougo/denite.nvim'
Plug 'rstacruz/vim-closer'
Plug 'mhinz/vim-signify'
"Plug 'posva/vim-vue'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'mhinz/vim-startify'

call plug#end()

" Session management
"fu! SaveSess()
    "execute 'mksession! ' . getcwd() . '/Session.vim'
"endfunction

"fu! RestoreSess()
"if filereadable(getcwd() . '/Session.vim')
    "execute 'so ' . getcwd() . '/Session.vim'
    "if bufexists(1)
        "for l in range(1, bufnr('$'))
            "if bufwinnr(l) == -1
                "exec 'sbuffer ' . l
            "endif
        "endfor
    "endif
"endif
"endfunction

"autocmd VimLeave * call SaveSess()
"autocmd VimEnter * nested call RestoreSess()

"set sessionoptions-=blank " Dont save blank windows on session save

" Dashboard


" Config

"   Leader key
let mapleader=","

"   Close NERDTree if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"   ff to use telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>

"   fg to use telescope
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"   telescope ignore files
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules/*" },
  }
}
EOF

"   Coc TAB to complete
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

"   Copilot map C-e to accept
imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true

"   NERDCommenter
filetype plugin on

"   Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,scss EmmetInstall
let g:user_emmet_leader_key=','

"   Autoformat prettier
let g:prettier#autoformat = 1

"   Line numbers
set number

"   Font
if has("gui_running")
  if has("gui_gtk2")
  elseif has("gui_macvim")
  elseif has("gui_win32")
    set guifont=Fira\ Code:h14
  endif
endif

"   Backspace windows fix
if has("win32")
  set backspace=indent,eol,start
endif

"	  Mouse
set mouse+=a

"   Theme
colorscheme catppuccin_macchiato

"   Airline
let g:airline_theme = 'catppuccin_mocha'
set laststatus=2

"   Ale
let g:ale_fixers = {
 \ 'javascript': ['eslint'],
 \ 'vue': ['eslint']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

"	  Tabs
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent

"   Auto enter NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"   NERDTree show hidden
let NERDTreeShowHidden=1

"   NERDTree right
let g:NERDTreeWinPos = "right"

"   Mappings
map <F8> :tabp<CR>
map <F9> :tabn<CR>
cnoreabbrev ser :CtrlSF
cnoreabbrev gco :Git checkout
cnoreabbrev ga :Git add --all
cnoreabbrev gc :Git commit -m
cnoreabbrev gs :Git status
nmap B :NERDTree<CR>
tnoremap <F8> <C-W>:tabp<CR>
tnoremap <F9> <C-W>:tabn<CR>
