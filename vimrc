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
set wrap


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable					" Enable syntax highlighting
set ffs=unix,dos,mac			" Use Unix as the standard file type


if &term=~ '256color'
	set t_ut=
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backup
set backupdir=~/.vim/backup

set noswapfile					" Stop putting swap files everywhere
set directory=~/.vim/backup 	" Put them in backup directory


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

"set expandtab							" Use spaces instead of tabs
set smarttab

set shiftwidth=2						" Tab is 4 spaces
set tabstop=2

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
	set guioptions-=T           		" Remove the toolbar
	set guioptions-=r
	set guioptions-=l
	set guioptions-=R
	set guioptions-=L
	set lines=40                		" 40 lines of text instead of 24,
	set number
	colorscheme jellybeans

else
	"set term=builtin_ansi       		" Make arrow and other keys work
	if &t_Co >= 256
		colorscheme jellybeans

	elseif &t_Co < 256
		colorscheme default

	endif

endif

set t_Co=256

"======================================================================
" => Custom Mappings
"======================================================================

let mapleader = ","

" For moving between tabs
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" Remap for text wrapping
nmap j gj
nmap k gk

" Fly between buffers
nnoremap <leader>l :ls<CR>:b<space>


"======================================================================
" => Plugins
"======================================================================

let g:snippets_dir = '~/.vim/snippets/'


"==============================================================================
" PATHOGEN
"==============================================================================
call pathogen#infect()
call pathogen#helptags()

"==============================================================================
" Tagbar
"==============================================================================
nmap <F8> :TagbarToggle<CR>

let g:tagbar_left = 1					" Put the tagbar window on the left
let g:tagbar_width = 30					" Set the width to 30 characters


"==============================================================================
" CtrlP
"==============================================================================
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_open_multiple_files = 'i'	" Select multiple files with <c-z> 
										" Open files in new buffer with <c-o>, not using tabs!
let g:ctrlp_open_new_file = 'v' 		" Creates a new file from ctrlp with given name with <c-y>

let g:ctrlp_mruf_max = 350
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_mruf_relative = 1			" Remember mru from CWD


"==============================================================================
" Other configurations 
"==============================================================================

set t_Co=256
set omnifunc=syntaxcomplete#Complete

" Always show the statusline
set laststatus=2


" Remap <C-Space> for autocomplete 
imap <C-Space> <C-x><C-o>

" Added for the vim powerline - Aug. 20 2013
set rtp+=/home/nanyaks/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" nnyk_ .vimrc file 
