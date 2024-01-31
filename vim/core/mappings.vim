" Mappings
"   Leader key
let mapleader = ","

"   Refresh config
command! Refresh source $MYVIMRC | source $MYVIMRC
command! Reload source $MYVIMRC | source $MYVIMRC

"   Git 
cnoreabbrev gco :Git checkout
cnoreabbrev ga :Git add --all
cnoreabbrev gc :Git commit -m
cnoreabbrev gs :Git status
cnoreabbrev gb :Git branch --sort=-committerdate

"   Mini-files
map B <cmd>lua MiniFiles.open()<CR>

function! OpenMiniFilesOnCurrentBuffer()
lua << EOF
  local current_buffer_path = vim.fn.expand("%:p:h")
  require("mini.files").open(current_buffer_path)
EOF
endfunction
map <leader>B :call OpenMiniFilesOnCurrentBuffer()<CR>

"   NeoTree
map <C-b> :NeoTreeShowToggle<CR>

"   Tabs
map <F8> :tabp<CR>
map <F9> :tabn<CR>
tnoremap <F8> <C-W>:tabp<CR>
tnoremap <F9> <C-W>:tabn<CR>

"   Floaterm
cnoreabbrev term :FloatermNew<CR>
tnoremap <Esc> <C-\><C-n>
nmap º :FloatermToggle<CR>

"   Copy paste to system clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

vnoremap  <leader>p  "+p
nnoremap  <leader>p  "+p
vnoremap  <leader>P  "+P
nnoremap  <leader>P  "+P

"   Telescope
" find files
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<CR>
" find rep
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
" find status
nnoremap <leader>fs <cmd>Telescope git_status<CR>
" find dir
nnoremap <leader>fd <cmd>Telescope workspaces<CR>
nnoremap <C-p> <cmd>Telescope commands<CR>

" find recent
nnoremap <leader>fr <cmd>Telescope oldfiles<CR>

"   COC
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr> "\<c-g>u\<CR>"
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"   Intelisense lens
nmap <silent> gl <Plug>(coc-codelens-action)

"   Copilot map C-e to accept
imap <silent><script><expr> <C-e> copilot#Accept('\<CR>')
let g:copilot_no_tab_map = v:true

"   :Q to quit too since I can't stop pressing shift
:command Q q

"   Emmet leader key
let g:user_emmet_leader_key=','
let user_emmet_expandabbr_key=','

"   Misc
command! -nargs=0 CopyBufPath :let @+ = expand("%:p")

"   CokeLine
nmap <leader>7 <Plug>(cokeline-focus-prev)
nmap <leader>8 <Plug>(cokeline-focus-next)

"   CocCommands
"       Laravel
command! -nargs=0 LaravelTestFile :CocCommand intelephense.phpunit.fileTest
command! -nargs=0 LaravelTestSingle :CocCommand intelephense.phpunit.singleTest
command! -nargs=0 LaravelTestProject :CocCommand intelephense.phpunit.projectTest

"   JABS
nmap <leader>b :JABS<CR>

"   CocMappings
nmap <leader><leader>p :CocCommand<CR>

"   Netrw
"   https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
function! NetrwMapping()
  "   Movement with h and l
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  "   Toggle hidden files and folders with .
  nmap <buffer> . gh

  "   TAB for markings
  nmap <buffer> <TAB> mf
  nmap <buffer> <S-TAB> mF
  nmap <buffer> <Leader><TAB> mu
endfunction
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

command! -nargs=0 Netrw :e .
command! -nargs=0 Dired :e .

"   Coc go to definition
nmap <leader>gd :call CocActionAsync('jumpDefinition')<CR>
nmap <leader>- :edit #<CR>

"   Treesitter utils
command! -nargs=0 TSClear :!rm $HOME/.local/share/nvim/lazy/nvim-treesitter/parser/*
