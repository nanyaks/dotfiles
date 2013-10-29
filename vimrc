"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Generic Vim Configuration Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set encoding=utf8
set history=1000

filetype plugin indent on
syntax on

set autoread
set showcmd
set wildmenu
set nowrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Other configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set cursorline					" Highlight the current cursor-line
set so=7						" Scroll Offset option - Number of context lines 
set ruler
set cmdheight=2
set hidden						" Hide buffer when abandoned; allow unsaved buffers 
set backspace=eol,start,indent	" Configure backspace

" Set wildignore filetypes
set wildignore=*.swp,*.bak,*.pyc,*.class,*/.git/**/*,*.o,*~
set wildignorecase



"""""""""""""""""""""""""""""""""""""""""""
" => Searches
"""""""""""""""""""""""""""""""""""""""""""

set ignorecase					" Ignore case when searching
set smartcase					" When searching try to be smart about cases 
set hlsearch					" Highlight search results
set incsearch					" Set incremental Search
set lazyredraw					" Don't redraw while executing macros

set showmatch					" Show matching brackets 
set mat=2						" How many tenths of a second to blink

set magic

set noerrorbells				" No Bells errors at all
set novisualbell
set t_vb=
"set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable					" Enable syntax highlighting
set ffs=unix,dos,mac			" Use Unix as the standard file type


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backup
set backupdir=~/.vim/backup

set noswapfile					" Stop putting swap files everywhere
set directory=~/.vim/backup		" Put them in backup directory


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Improve session saving
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions=buffers,resize,blank,curdir,folds,help,tabpages,winpos


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

"set expandtab					" Use spaces instead of tabs
set smarttab

set shiftwidth=4				" Tab is 4 spaces
set tabstop=4

" Linebreak on 80 characters
set lbr
"set tw=80

" Folds
set foldmethod=indent


"""""""""""""""""""""""""""""""""
" ENVIRONMENT-SPECIFIC SETTINGS "
"""""""""""""""""""""""""""""""""

if has('gui_running')
	set guioptions+=e
	set guitablabel=%M\ %t
	set gfn=Source\ Code\ Pro\ Medium\ 10 
	set guioptions-=T           " remove the toolbar
	set guioptions-=r
	set guioptions-=l
	set guioptions-=R
	set guioptions-=L
	set lines=40                " 40 lines of text instead of 24,
	set number
	colorscheme jellybeans

else
	set term=builtin_ansi       " Make arrow and other keys work
	if &t_Co >= 256
		colorscheme jellybeans

	elseif &t_Co < 256
		colorscheme jellybeans

	endif

endif


"======================================================================
" => Custom Mappings
"======================================================================

let mapleader = ","

" Fix Key codes
" map [3~ <Del>
" map OH <Home>
" map OF <End>
" imap [3~ <Del>
" imap OH <Home>
" imap OF <End>


"======================================================================
" => Plugins 
"======================================================================

let g:snippets_dir = '~/.vim/snippets/'

"======================================================================
" MINIBUFFER EXPLORER
"
"======================================================================
" Adding this on the 2nd of Feb. 2013 for the minibuffer explorer plugin for vim...
"
" Update - changed the initial minibufexplorer plugin for a new version 
" Old version - http://www.vim.org/scripts/script.php?script_id=159
" New version - https://github.com/fholgado/minibufexpl.vim

" MiniBufExplorer - For keyboard control
" These are built into the minibufexplorer.vim file but since ive changed the
" version, this has to go.
"
" OLD CONFIGURATION
"let g:miniBufExplMapWindowNavVim = 1		" Control + [hjkl] movement btw buffers
"let g:miniBufExplMapWindowNavArrows = 1		" Control + ArrowKeys movement
"let g:miniBufExplMapCTabSwitchBufs = 1		" <C-Tab>, <C-S-Tab>: next, Prev Buff.

" Wasnt using these two configs in the first place
" let g:miniBufExplMapCTabSwitchWindows = 1	" <C-Tab>, <C-S-Tab>: next, Prev Window
"let g:miniBufExplForceSyntaxEnable = 1		" Force syntax highlight for buffers <- conflicts with powerline syntax highlighting for some strange reason.
" End - not used lines
" END OLD CONFIGURATION
"
" BEGIN NEW CONFIGURATION
"
" If you like control + vim direction key to navigate
" buffers then perform the remapping
"
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" If you like <C-TAB> and <C-S-TAB> to switch buffers
" in the current window then perform the remapping
"
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

"
" END NEW CONFIG

" End Customization for the mini explorer plugin.

"==============================================================================
" PATHOGEN PLUGIN
"
" https://github.com/tpope/vim-pathogen/blob/master/README.markdown
"==============================================================================
call pathogen#infect()

" Tagbar -- uses 'Exuberant CTAGS' lib.
nmap <F8> :TagbarToggle<CR>

let g:tagbar_left = 1	" Put the tagbar window on the left
let g:tagbar_width = 30	" Set the width to 30 characterS


" CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_open_multiple_files = 'i'	" select multiple files with <c-z> and open files in new buffer with <c-o>, not using tabs!!
let g:ctrlp_open_new_file = 'v' " creates a new file from ctrlp with given name with <c-y>

let g:ctrlp_mruf_max = 350
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_mruf_relative = 1	" let ctrlp remember only mru from current working directory


filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Added for the vim powerline - Aug. 20 2013
set rtp+=/home/nanyaks/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show the statusline
set laststatus=2

" Already included 256 colours setting
set t_Co=256

" Map j and k to normal even if wraps
" ============================================================
nmap j gj
nmap k gk

" Remap <C-Space> for autocomplete especially since i type a whole lot of html
imap <C-Space> <C-x><C-o>


" nnyk_ .vimrc file 
" Inspired some by Teve Francia http://spf13.com/post/perfect-vimrc-vim-config-file
" and a bit more from http://amix.dk/vim/vimrc.html


