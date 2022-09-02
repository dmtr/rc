call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
"Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
"" For vsnip user.
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh'  }
Plug 'tpope/vim-fugitive' 
Plug 'preservim/tagbar'
Plug 'gcmt/wildfire.vim'
Plug 'easymotion/vim-easymotion'
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jacoborus/tender.vim'
Plug 'github/copilot.vim'
call plug#end()

"set t_Co=256 
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
set background=dark
set clipboard=unnamed
"colorscheme tender
"colorscheme palenight

colorscheme PaperColor
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     }
  \}
  \}



set completeopt=menu,menuone,noselect
set isprint=@,128-255
set fileencodings=utf-8,cp1251
set hidden
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set nu
set noswapfile
set laststatus=2

filetype off
syntax on "Включить подсветку синтаксиса
"Вырубаем режим совместимости с VI:
set nocompatible

"Включаем распознавание типов файлов и типо-специфичные плагины:
filetype on
filetype plugin on
"Автоотступ
set autoindent
set copyindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
"Нужно во многих терминалах, например в gnome-terminal
let g:miniBufExplMapWindowNavArrows = 1 

let mapleader = ","
let maplocalleader=","

let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_indent = 0

let g:isort_command = 'isort'


function Set_python_settings()
    "Настройки табов для Python, согласно рекоммендациям
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab "Ставим табы пробелами
    set softtabstop=4 "4 пробела в табе
    set smartindent
endfunction


"Настройка omnicomletion для Python (а так же для js, html и css)
" autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"
"
"" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview

autocmd BufNewFile,BufEnter *.{py} call Set_python_settings()
"В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap S :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
map <F2> :Buffers<CR>
map <F3> :TagbarToggle<CR>
nnoremap <C-f> :Files<cr>

nnoremap <leader>ag :Ag<cr>
nnoremap <leader>l :Lines<cr>
nnoremap <leader>bl :BLines<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>bt :BTags<cr>
nnoremap <leader>c :Commits<cr>
nnoremap <leader>bc :BCommits<cr>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit --verbose<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap * *``
nnoremap <leader>s *<C-O>:Ag!<CR>
nnoremap <leader>d <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> ]c <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nmap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nmap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nmap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>


"set history=64
"set undolevels=128
"set undodir=~/.vim/undodir/
"set undofile
"set undolevels=1000
"set undoreload=10000


let g:S = 0  "result in global variable S
function! Sum(number)
  let g:S = g:S + a:number
  return a:number
endfunction


"" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


set rtp+=/usr/local/opt/fzf
let g:fzf_launcher = "/Users/dmtr/bin/mvimfzf.sh %s"


"let g:airline#extensions#ale#enabled = 1

set inccommand=nosplit

"let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"let g:ale_linters.rust = ['cargo', 'rls']
let g:ale_rust_rls_toolchain = 'stable'

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'ruby': ['standardrb', 'rubocop'],
\   'rust': ['cargo', 'rls'],
\}

let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \    'python': ['black', 'isort'],
      \ 'rust': ['rustfmt'],
      \}

"let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-c> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-c> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-c>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-c> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-c> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-c>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

let g:coc_node_path='/Users/dmtr/.nvm/versions/node/v12.20.0/bin/node'

lua << END
require('lualine').setup {
	options = {
	    icons_enabled = false,
	}
}
END

if exists("g:neovide")
" Put anything you want to happen only in Neovide here
let g:neovide_refresh_rate=30
let g:neovide_input_macos_alt_is_meta=v:true
let g:neovide_cursor_animation_length=0
set guifont=JetBrains\ Mono\ NL:h16
endif
