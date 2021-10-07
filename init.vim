call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip user.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh'  }
Plug 'tpope/vim-fugitive' 
Plug 'preservim/tagbar'
Plug 'gcmt/wildfire.vim'
Plug 'easymotion/vim-easymotion'
Plug 'arcticicestudio/nord-vim'
Plug 'dense-analysis/ale'
call plug#end()

set t_Co=256 
set background=dark
colorscheme nord

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
nnoremap <C-g> :GFiles<cr>

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

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'ruby': ['standardrb', 'rubocop'],
\}

let g:ale_fixers = {
      \    'ruby': ['standardrb'],
      \    'python': ['black', 'isort'],
      \}

let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


lua << EOF
local cmp = require'cmp'

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

cmp.setup({
    snippet = {
      expand = function(args)
        -- For `vsnip` user.
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'cmp_tabnine' },
      { name = "calc" }
    },
    formatting = {
		format = function(entry, vim_item)
			local menu = source_mapping[entry.source.name]
			if entry.source.name == 'cmp_tabnine' then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. ' ' .. menu
				end
			end
			vim_item.menu = menu
			return vim_item
		end
	},
  })

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
})

require'lspconfig'.pyright.setup{cpabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())}
EOF
