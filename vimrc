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
"let g:miniBufExplMapWindowNavArrows = 1 


"set tabstop=4
"set shiftwidth=4
"set smarttab
"set expandtab "Ставим табы пробелами
"set softtabstop=4 "4 пробела в табе

let mapleader = ","

let pymode_folding=0  
let g:pymode_indent = 1
" let g:pyflakes_use_quickfix=0 
let g:pymode_lint_ignore = "E501"
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_rope_goto_definition_bind = "<C-J>"
let g:pymode_virtualenv = 1
let g:pymode_virtualenv_path = $VIRTUAL_ENV
let g:pymode_options_colorcolumn = 0
let g:pymode_rope_lookup_project = 1
let g:pymode_rope_completion_bind = '<C-TAB>'
let g:pymode_rope_autoimport = 0
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_trim_whitespaces = 0
let g:pymode_options_max_line_length = 120
let g:pymode_options_colorcolumn = 1
let g:pymode_lint = 1

if $PYTHON == 'python3'
	let g:pymode_python = 'python3'
endif

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
    "set tags=tags;/
    set tags=tags.da,python.tags,twisted.tags,tags
    set path+=~/work/da/python/**
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
autocmd FileType python set omnifunc=pythoncomplete#Complete
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
 set t_Co=256 
endif 

" feel free to choose :set background=light for a different style 
set background=dark
colorscheme kalisi

if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts= '--vimgrep --hidden --ignore ''.ropeproject'' --ignore ''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''migrations'''
endif

map <S-s> :UniteWithCursorWord grep:.<cr>
map <F2> :Unite buffer<CR>
map <F3> :TagbarToggle<CR>
map <C-p> [M
map <C-n> ]M
map <S-c> vaC
map <S-m> vaM
nnoremap <C-f> :UniteWithInput file_rec/async<cr>

nnoremap <leader>ug :UniteWithInput grep:.<cr>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gp :Ggrep<Space>

if version >= 700
    set history=64
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif



" go settings
"au FileType go nmap gd <Plug>(go-def)

nnoremap <leader>s *<C-O>:Ack!<CR>

let Tlist_Ctags_Cmd="/usr/local/bin/ctags"

" javascript plugins
let g:used_javascript_libs = 'jquery,angularjs'


let g:S = 0  "result in global variable S
function! Sum(number)
  let g:S = g:S + a:number
  return a:number
endfunction


" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let b:syntastic_mode = 'passive'
let g:syntastic_auto_jump = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 2


let g:vrc_auto_format_uhex = 1

"Go settings
autocmd BufNewFile,BufRead *.go setlocal tabstop=4 shiftwidth=4
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>g :<C-u>call <SID>build_go_files()<CR>

let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
