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

" 剪切板
set clipboard=unnamed

" 按键绑定
set timeoutlen=50
imap <Esc>b <C-o>b
imap <Esc>f <C-o>w
imap <Esc><BS> <C-w>
imap ÿ <C-w>
