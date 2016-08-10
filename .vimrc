"=================================================
" 配置Vundle
"=================================================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" PowerLine插件 状态栏增加展示
Plugin 'Lokaltog/vim-powerline'
" NerdTrue插件 文件管理器插件
Plugin 'scrooloose/nerdtree'
" YouCompleteMe智能补全插件
Plugin 'Valloric/YouCompleteMe'
"vim-nerdtree-tabs插件 不同的tab共享一个nerdtree
Plugin 'https://github.com/jistr/vim-nerdtree-tabs.git'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"=================================================
" vim基本配置
"=================================================
"配置backspace键工作方式
set backspace=indent,eol,start
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"当一行文字很长时取消换行
set nowrap
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile
"突出显示当前行列
"set cursorline
"set cursorcolumn
"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch
"设置C/C++方式自动对齐
set autoindent
set cindent
"开启语法高亮功能
syntax enable
set background=light
colorscheme solarized
let g:solarized_termcolors=256
syntax on
"指定配色方案为256色
set t_Co=256
"设置搜索时忽略大小写
set ignorecase
"设置在Vim中可以使用鼠标 防止在Linux终端下无法考贝
set mouse=a
"设置tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
set smarttab
"将tab键自动转换成空格 真正需要tab键时使用[Ctrl + v + tab]
set expandtab
"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"检测文件类型 Vundle中设置的为off
filetype on
"允许插件
filetype plugin on
"红色显示行尾没有必要的空格
match Error /\s\+$/
"启动智能补全 Vundle设置里有 这里不重复设置
"filetype plugin indent on
"括号补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
"inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
"inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf
function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endf
"=================================================
" 插件配置
"=================================================
"----PowerLine插件----
"vim有一个状态栏 加上powerline则有两个状态栏
set laststatus=2
let g:Powline_symbols='fancy'
"----NerdTrue插件----
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>
"打开NERDTree窗口时 自动显示Bookmarks
"let NERDTreeShowBookmarks=1
"在 vim 启动的时候默认开启 NERDTree
"autocmd VimEnter * NERDTree
"将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
"let NERDTreeWinPos="right"
"目录箭头 1 显示箭头 0传统+-|号
"let NERDTreeDirArrows=1
">>>>切换工作台和目录
"ctrl + w + h    光标 focus 左侧树形目录
"ctrl + w + l    光标 focus 右侧文件显示窗口
"ctrl + w + w    光标自动在左右侧窗口切换
"ctrl + w + r    移动当前窗口的布局位置
"o       在已有窗口中打开文件、目录或书签，并跳到该窗口
"go      在已有窗口 中打开文件、目录或书签，但不跳到该窗口
"t       在新 Tab 中打开选中文件/书签，并跳到新 Tab
"T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab
"i       split 一个新窗口打开选中文件，并跳到该窗口
"gi      split 一个新窗口打开选中文件，但不跳到该窗口
"s       vsplit 一个新窗口打开选中文件，并跳到该窗口
"gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口
"!       执行当前文件
"O       递归打开选中 结点下的所有目录
"x       合拢选中结点的父目录
"X       递归 合拢选中结点下的所有目录
"e       Edit the current dif
"双击    相当于 NERDTree-o
"中键    对文件相当于 NERDTree-i，对目录相当于 NERDTree-e
"D       删除当前书签
"P       跳到根结点
"p       跳到父结点
"K       跳到当前目录下同级的第一个结点
"J       跳到当前目录下同级的最后一个结点
"k       跳到当前目录下同级的前一个结点
"j       跳到当前目录下同级的后一个结点
"C       将选中目录或选中文件的父目录设为根结点
"u       将当前根结点的父目录设为根目录，并变成合拢原根结点
"U       将当前根结点的父目录设为根目录，但保持展开原根结点
"r       递归刷新选中目录
"R       递归刷新根结点
"m       显示文件系统菜单
"cd      将 CWD 设为选中目录
"I       切换是否显示隐藏文件
"f       切换是否使用文件过滤器
"F       切换是否显示文件
"B       切换是否显示书签
"q       关闭 NerdTree 窗口
"?       切换是否显示 Quick Help
">>>>切换标签页
":tabnew [++opt选项] ［＋cmd］ 文件      建立对指定文件新的tab
":tabc   关闭当前的 tab
":tabo   关闭所有其他的 tab
":tabs   查看所有打开的 tab
":tabp   前一个 tab
":tabn   后一个 tab
">>>>标准模式下
"gT      前一个 tab
"gt      后一个 tab
"----YouCompleteMe插件----
"YouCompleteMe 通过这个cm_global_ycm_extra_conf来获得补全规则，可以如下指定，也可以每次放置在工作目录
let g:ycm_global_ycm_extra_conf='~/.ycmycm_extra_conf.py'
"跳转到当前函数的定义或声明 CTRL+O CTRL+I 前后跳转
nnoremap <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
"提示preview窗口 自动关闭
let g:ycm_autoclose_preview_window_after_completion = 1
"----vim-nerdtree-tabs插件
"Open NERDTree on console vim startup
let g:nerdtree_tabs_open_on_console_startup=1
"always focus file window after startup
let g:nerdtree_tabs_smart_startup_focus=2
