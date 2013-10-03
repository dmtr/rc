set isprint=@,128-255
set fileencodings=utf-8,cp1251
set hidden
set hlsearch
set incsearch
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
"set copyindent
"Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
"Включаем 256 цветов в терминале, мы ведь работаем из иксов?
"Нужно во многих терминалах, например в gnome-terminal
"set t_Co=256
"let g:miniBufExplMapWindowNavArrows = 1 


"set tabstop=4
"set shiftwidth=4
"set smarttab
"set expandtab "Ставим табы пробелами
"set softtabstop=4 "4 пробела в табе

let pymode_folding=0  
let g:pyflakes_use_quickfix=0 
let g:pymode_lint_ignore = "E501"
let g:pymode_lint_checker = "pyflakes,pep8"


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

" " automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

autocmd BufNewFile,BufEnter *.{py} call Set_python_settings()
autocmd BufLeave *.{py} call Unset_python_settings()
"Перед сохранением вырезаем пробелы на концах (только в .py файлах)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

autocmd BufNewFile,BufEnter *.{cpp,cc,h} call Set_cpp_settings()
autocmd BufLeave *.{cpp,cc,h} call Unset_cpp_settings()

autocmd BufNewFile,BufEnter *.{php} call Set_php_settings()
autocmd BufLeave *.{php} call Unset_php_settings()

if ! has("gui_running") 
 set t_Co=256 
endif 
" feel free to choose :set background=light for a different style 
set background=dark 
colors peaksea

map <F5> :UniteWithCursorWord grep:.<cr>
map <F2> :Unite buffer<CR>
map <F3> :TlistToggle<CR>
map <F8> [M
map <F9> ]M
nnoremap <C-p> :UniteWithInput file_rec<cr>


if version >= 700
    set history=64
    set undolevels=128
    set undodir=~/.vim/undodir/
    set undofile
    set undolevels=1000
    set undoreload=10000
endif


let g:airline_theme="base16"
