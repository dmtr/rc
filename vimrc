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
call pathogen#infect()
call pathogen#helptags()

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
"set splitbelow
"set termwinsize="10*0"


"set tabstop=4
"set shiftwidth=4
"set smarttab
"set expandtab "Ставим табы пробелами
"set softtabstop=4 "4 пробела в табе

autocmd FileType python nnoremap <buffer> [[ ?^class\\|^\s*def\\|^\s*async<CR>
autocmd FileType python nnoremap <buffer> ]] /^class\\|^\s*def\\|^\s*async<CR>

let mapleader = ","

let g:jedi#use_splits_not_buffers = "top"
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>a"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<Shift-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_on_dot = 1

"let pymode_folding=0  
"let g:pymode_indent = 1
"" let g:pyflakes_use_quickfix=0 
"let g:pymode_lint_ignore = "E501"
"let g:pymode_lint_checker = "pyflakes,pep8"
"let g:pymode_rope_goto_definition_bind = "<C-J>"
"let g:pymode_virtualenv = 1
"let g:pymode_virtualenv_path = $VIRTUAL_ENV
"let g:pymode_options_colorcolumn = 0
"let g:pymode_rope_lookup_project = 1
"let g:pymode_rope_completion_bind = '<C-TAB>'
"let g:pymode_rope_autoimport = 0
"let g:pymode_rope_regenerate_on_write = 0
"let g:pymode_trim_whitespaces = 0
"let g:pymode_options_max_line_length = 120
"let g:pymode_options_colorcolumn = 1
"let g:pymode_lint = 1
"let g:pymode_rope_complete_on_dot = 0

"if $PYTHON == 'python3'
"	let g:pymode_python = 'python3'
"endif

let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0


function Set_python_settings()
    "Настройки табов для Python, согласно рекоммендациям
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab "Ставим табы пробелами
    set softtabstop=4 "4 пробела в табе
    set smartindent
    set tags=tags
"   set tags=tags.da,python.tags,twisted.tags,tags
"   set path+=~/work/da/python/**
endfunction

function Unset_python_settings()
  set tags=tags;/
endfunction

function Set_php_settings()
    set tabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab "Ставим табы пробелами
    set softtabstop=4 "4 пробела в табе
    set tags=tags;/
endfunction

function Unset_php_settings()
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
endfunction

"Настройка omnicomletion для Python (а так же для js, html и css)
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


function Set_cpp_settings()
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
    set smarttab
    " configure tags - add additional tags here or comment out not-used ones
    "
    set tags=tags;/
    set tags+=~/.vim/tags/cpp
    "set path=~/work/trunk/src
    "set path+=~/work/trunk/sirenalibs/sirenalibs/serverlib/src/
    set path+=./
    " set tags+=~/.vim/tags/gl
    " set tags+=~/.vim/tags/sdl
    " set tags+=~/.vim/tags/qt4
    " " build tags of your own project with Ctrl-F12
    " map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q
    " .<CR>
    "
    " " OmniCppComplete
    let OmniCpp_NamespaceSearch = 1
    let OmniCpp_GlobalScopeSearch = 1
    let OmniCpp_ShowAccess = 1
    let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
    let OmniCpp_MayCompleteDot = 1 " autocomplete after .
    let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
    let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
    let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
endfunction    

function Unset_cpp_settings()
    " configure tags - add additional tags here or comment out not-used ones
    set tags+=./
endfunction

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

autocmd BufNewFile,BufEnter *.{py} call Set_python_settings()
autocmd BufLeave *.{py} call Unset_python_settings()
"Перед сохранением вырезаем пробелы на концах (только в .py файлах)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufNewFile,BufEnter *.{cpp,cc,h,c} call Set_cpp_settings()
autocmd BufLeave *.{cpp,cc,h,c} call Unset_cpp_settings()

autocmd BufNewFile,BufEnter *.{php} call Set_php_settings()
autocmd BufLeave *.{php} call Unset_php_settings()

if ! has("gui_running") 
 set background=dark
 set t_Co=256 
endif 

" feel free to choose :set background=light for a different style 
" colorscheme kalisi
colorscheme nord 

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

set history=64
set undolevels=128
set undodir=~/.vim/undodir/
set undofile
set undolevels=1000
set undoreload=10000


" go settings
"au FileType go nmap gd <Plug>(go-def)

nnoremap <leader>s *<C-O>:Ack!<CR>

let Tlist_Ctags_Cmd="/usr/local/bin/ctags"

" javascript plugins
let g:used_javascript_libs = 'jquery,react'


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

"let g:haskellmode_completion_ghc = 1
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"let g:syntastic_auto_jump = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 1
"let g:syntastic_loc_list_height = 3
"let g:syntastic_python_checkers=['flake8', 'python']

"if $PYTHON == 'python3'
"	let g:syntastic_python_checkers=['flake8', 'python3']
"endif


let g:vrc_auto_format_uhex = 1

"Go settings
autocmd BufNewFile,BufRead *.go setlocal tabstop=4 shiftwidth=4

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

au filetype go inoremap <buffer> . .<C-x><C-o>
au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)
nnoremap <leader>gt :GoTest<CR><CR>
nnoremap <leader>gr :GoRun<CR><CR>

" Tagbar configuration for Golang
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

set rtp+=/usr/local/opt/fzf
let g:fzf_launcher = "/Users/dmtr/bin/mvimfzf.sh %s"

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint']
\}

let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

if has("nvim")
    set inccommand=nosplit
endif

if has("gui_macvim")
    set pythonthreehome=$HOME/.pyenv/versions/3.6.0
    set pythonthreedll=$HOME/.pyenv/versions/3.6.0/lib/libpython3.6m.dylib
    set guioptions=
endif
