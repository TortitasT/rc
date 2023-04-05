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

function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ isdirectory(g:plugs[a:name].dir) &&
        \ stridx(&rtp, g:plugs[a:name].dir) >= 0)
endfunction

call plug#begin()

Plug 'scrooloose/nerdtree' |
  \ Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

Plug 'w0rp/ale'

Plug 'mattn/emmet-vim'

Plug 'github/copilot.vim' " Requires to sign up

Plug 'ryanoasis/vim-devicons'

Plug 'scrooloose/nerdcommenter'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-fugitive'

Plug 'Shougo/denite.nvim'

Plug 'rstacruz/vim-closer'

Plug 'mhinz/vim-signify'

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

Plug 'mhinz/vim-startify'

Plug 'voldikss/vim-floaterm'

Plug 'wakatime/vim-wakatime', { 'branch': 'master' }

Plug 'ap/vim-css-color'

Plug 'yggdroot/indentline'

Plug 'APZelos/blamer.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()

" Config
"   Leader key
let mapleader=","

"   Center cursor
set scrolloff=8

"   Cursor effects
set cursorline
"set cursorcolumn

"   Spell check
set spell
set spell spelllang=es,en_us

"   Neovide
if exists("g:neovide")
  set guifont=Fira\ Code:h14

  let g:neovide_scale_factor = 1
  let g:neovide_padding_top = 25
  let g:neovide_padding_bottom = 25
  let g:neovide_padding_left = 25
  let g:neovide_padding_right = 25

  if has("mac")
    let g:neovide_scale_factor = 1.2
    let g:coc_node_path = "~/.nvm/versions/node/v16.19.1/bin/node" 
  endif
endif

"   Startify config
let g:startify_bookmarks = [
\ { 'y': '~/Documents/Git/descommarket/yapayoo' },
\ { 'c': '~/Documents/Git/misc/dotfiles/vim' },
\ ]

"   Close NERDTree if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"   ff to use telescope
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>

"   fg to use telescope
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"   Coc TAB to complete
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"

"   intelephense lens
nmap <silent> gl <Plug>(coc-codelens-action)

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
colorscheme catppuccin_mocha

"   Airline
if PlugLoaded('vim-airline')
  let g:airline_theme = 'catppuccin_mocha'
  set laststatus=2
  set noshowmode
endif

"   Ale
"let g:ale_fixers = {
 "\ 'javascript': ['eslint'],
 "\ 'vue': ['eslint']
 "\ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
"let g:ale_fix_on_save = 1

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
cnoreabbrev gco :Git checkout
cnoreabbrev ga :Git add --all
cnoreabbrev gc :Git commit -m
cnoreabbrev gs :Git status
cnoreabbrev term :FloatermNew<CR>
nmap B :NERDTree<CR>
tnoremap <F8> <C-W>:tabp<CR>
tnoremap <F9> <C-W>:tabn<CR>
tnoremap <Esc> <C-\><C-n>
nmap º :FloatermToggle<CR>

"   telescope ignore files
lua << EOF
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { 
      "node_modules/*",
      "build/*",
      "bin/*",
      ".git/*",
      ".idea/*",
      "dist/*",
      "gradlew*",
      "desktop.ini"
    },
  }
}
EOF
