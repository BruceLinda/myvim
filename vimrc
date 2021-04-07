" vim基础参数设置 {{{
"不与vi兼容
set nocompatible
"删除
set backspace=indent,eol,start
syntax on
set nowritebackup
set noswapfile
set ruler
set showcmd
set incsearch
set hlsearch
set ignorecase
set smartcase
set hidden
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set cursorline
set showmatch
set autoread
set wildmenu
" 高亮行尾的空格符号
set list listchars=tab:\ \ ,trail:·
" 设置80字符高亮
autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
set colorcolumn=80
" 设置系统剪切版
set clipboard+=unnamed
" 不显示介绍信息
set shortmess+=I
" better splits
set splitbelow
set splitright
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
" }}}

" 一些自动命令{{{
" 跳转到最后一个光标
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g'\"" |
  \ endif

"删除尾部的空白键
fun! StripTrailingWhitespace()
  " 不删除下面类型的文件
  if &ft =~ 'markdonw'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" 文件格式设置
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType markdown  setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
autocmd FileType sh,ruby,yaml,vim setlocal shiftwidth=2 tabstop=2 expandtab

" 关闭所有的fold，当打开新的buffer的时候
set foldmethod=indent
set foldlevel=99
autocmd BufRead * normal zM

" }}}
"{{{安装的插件
call plug#begin()
"自动lint检测错误,其他功能暂时不使用
Plug 'dense-analysis/ale'
"自动补全括号,<C-p>自动切换功能
Plug 'jiangmiao/auto-pairs'
"一下都属于nerd家族
"{{{NERDCommenter注释
"[count]<leader>cc:注释从当前行往下数的count行,NERDCommenterComment
"[count]<leader>cn:同cc,但是嵌套注释,NERDCommenterNested
"[count]<leader>cu:取消从当前行往下数的count行的注释,NERDCommenterUncomment
"[count]<leader>ci:切换从当前行往下数的count行的注释,NERDCommentInvert
"[count]<leader>c<space>:切换从当前往下数的count行注释,NERDCommentToggle,同ci，但是以第一行的状态进行切换
"[count]<leader>c$:注释到行尾,NERDCommenterToEOL
"[count]<leader>cA:注释到行为,并进入插入模式,NERDCommenterAppend
"[count]<leader>cm:多行注释,NERDCommenterMinimal
"[count]<leader>cs:块状注释,NETDComenterSexy
"[count]<leader>cy:同cc,但是首先复制,NETDCommenterYank
"}}}
Plug 'preservim/nerdcommenter'
"nerdtree是vim的一个文件系统浏览器，可以一些在文件系统浏览器中所做的操作
Plug 'preservim/nerdtree'
"展现文件树的git状态
Plug 'Xuyuanp/nerdtree-git-plugin'
"展示文件树的文件图表，需要首先安装Nerd Font compatible font
Plug 'ryanoasis/vim-devicons'
"为文件树增加语法高亮
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"{{{ nerdtree文件操作
"打开文件树选中的文件
"o 打开选择的所有的文件
"i 水平分割打开选择的所有文件
"s 垂直分割打开选择的所有文件
"t 在新的tab中打开选择的所有文件
"dd 从文件上删除选择的文件
"m 移动文件
"c 复制文件
"}}}
Plug 'PhilRunninger/nerdtree-visual-selection'
"保存nerdtree的文件状态
Plug 'scrooloose/nerdtree-project-plugin'
"nerd家族到此为止
Plug 'python-mode/python-mode', { 'branch': 'develop' }
" {{{
" 在文件中显示git更改
" ]c 跳到下一个更改
" [c 跳到上一个更改
" }}}
Plug 'airblade/vim-gitgutter'
" git Vim  命令包装
Plug 'tpope/vim-fugitive'
" 用于保存vim的session，使用Obsession命令
Plug 'tpope/vim-obsession'
" vim底部的状态栏显示
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 查看tag,<F8>切换
Plug 'preservim/tagbar'
" 用于查看leader快捷键
Plug 'liuchengxu/vim-which-key'
" debug调节
Plug 'vim-vdebug/vdebug'
" 增加括号引号等
Plug 'tpope/vim-surround'
" 一些基本命令的Vim包装
" Delete, Unlink, Move, Rename, Chmod, Mkdir, Cfind, Clocate, Lfind,
" Llocation, Wall, SudoWrite, SudoEditer,
Plug 'tpope/vim-eunuch'
" vim的编辑历史树记录,<C-u>可以切换窗口
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 增加了缩进线
Plug 'Yggdroot/indentLine'
" 增加了括号的颜色
Plug 'luochen1990/rainbow'
" 模糊查询,fzf是主程序，fzf.vim是包装的一些命令
" Files模糊文件查找
" GFiles opt ,Git files(git ls-files)
" Gfiles? Git files(git status)
" Buffers, 打开buffer
" Color, color scheme
" Rg, rg 搜索
" Lines, 在所有的buffer中的行
" Blines, 在当前buffer中的行
" Marks， 标记
" Windows， 窗口
" Locate PATTERN， locate命令的输出
" Histroy， 之前打开的历史文件并打开
" History： 命令行历史
" History/ ，搜索历史命令
" Commits，git commits
" BCommits, 当前buffer的commit
" Commands， Commands
" Maps Normal mode Maps
" Helptags , Help tags
" Filetypes , File types
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" 自动生成tag
Plug 'ludovicchabant/vim-gutentags'
Plug 'ervandew/supertab'
Plug 'lambdalisue/vim-pyenv'
call plug#end()
"}}}
"关于插件的配置 {{{
"关于auto-pairs的自动配置 {{{
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = '<C-p>'
" }}}
"pymode配置 {{{
"python-mode的配置
let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_motion = 1
let g:pymode_doc = 1
let g:pymode_doc_bind = 'K'
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'
let g:pymode_breakpoint_cmd = ''
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime']
let g:pymode_rope_autoimport_import_after_complete = 0
let g:pymode_syntax = 0
"}}}
"NERD  注释相关配置 {{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
"}}}
"文件树设置 {{{
" 关闭NERDTree快捷键
map <F2> :NERDTreeToggle<CR>
" 当NERDTree 为剩下的唯一窗口时自动关闭
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |quit | endif
" 修改树的显示图示
let g:NERDSpaceDelims = 1
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=35
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=0
let g:NERDTreeShowBookmarks=1
" 忽略文件类型设置
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 设置文件状态显示
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
"}}}
"ale的相关配置 {{{
"始终开启标识列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"不实用补全，使用coc补全,ale只用来动态检查错误
let g:ale_disable_lsp = 1
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>d :ALEDetail<CR> "<Leader>d查看错误或警告的详细信息
nmap <Leader>a :ALEToggle<CR> "ale 的开关
"}}}
"which key {{{
"vim-which-key的配置
nnoremap <silent> <leader> :WhichKey '<leader>'<CR>
set timeoutlen=200
"}}}
"undotree配置{{{
nnoremap <C-u> :UndotreeToggle<CR>
"}}}
"关于缩进线的配置 {{{
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
"}}}
" rain_bow 设置 {{{
let g:rainbow_active = 1
	let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'*': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}
  "}}}
nmap <F8> :TagbarToggle<CR>
  "gutentags的配置 {{{
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
" }}}
" supertab键设置
let g:SuperTabDefaultCompletionType = "<c-n>"
"}}}
