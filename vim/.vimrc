" 显示行号
set number

" 高亮当前行
set cursorline

" 搜索设置
set hlsearch
set incsearch
set ignorecase
set smartcase

" 自动缩进和 Tab 宽度
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

" 匹配括号
set showmatch

" 更友好的退格键
set backspace=indent,eol,start

" 语法高亮
syntax on

" 主题
colorscheme default

" 状态栏显示
set ruler
set laststatus=2

" 插入模式
imap <Esc>b <C-o>b
imap <Esc>f <C-o>w
imap <Esc><BS> <C-w>

" 普通模式
nmap <Esc>b b
nmap <Esc>f w
nmap <Esc><BS> db
