	set nocompatible
	set encoding=utf8
	set history=1000
	set title

	filetype plugin indent on
	syntax on

	set autoread
	set showcmd
	set hidden
	set wrap


	set wildmenu 							"  Tab completion :: make smarter
	set wildmode="list:full"

	set number
	set cursorline                          " Highlight the current cursor-line
	set so=7                                " Scroll Offset option - Number of context lines
	set ruler
	set cmdheight=2
	set backspace=eol,start,indent          " Configure backspace

	" Set wildignore filetypes
	set wildignore=*.swp,*.bak,*.pyc,*.class,*/.git/**/*,*.o,*/.svn/**/*,*/.hg/**/*
	set wildignorecase

	set visualbell
	set t_vb=

	set splitright
	set splitbelow

	set lazyredraw                          " Don't redraw while executing macros

"==============================================================================
" => Search
"==============================================================================

	set ignorecase                          " Ignore case when searching
	set smartcase                           " When searching try to be smart about cases
	set hlsearch                            " Highlight search results
	set incsearch                           " Set incremental Search
	set magic

	set showmatch                           " Show matching brackets
	set mat=2                               " How many tenths of a second to blink


"==============================================================================
" => Colors and Fonts
"==============================================================================

	syntax enable                           " Enable syntax highlighting
	set ffs=unix,dos,mac                    " Use Unix as the standard file type


"==============================================================================
" => Files, backups and undo
"==============================================================================

	set backup
	set backupdir=~/.vim/backup

	set swapfile
	set directory=~/.vim/backup             " Put swapfiles in backup directory


"==============================================================================
" => Improve session saving
"==============================================================================
	set sessionoptions=buffers,resize,blank,curdir,folds,help,tabpages,winpos


"==============================================================================
" => Text, tab and indent related
"==============================================================================
	set autoindent

	set list
	set listchars=tab:┊\ ,extends:›,precedes:‹,nbsp:·,trail:·

	"set expandtab                           " Use spaces instead of tabs
	set smarttab

	set shiftwidth=4                        " Tab is 4 spaces
	set tabstop=4

	set linebreak

	" Folds
	set foldmethod=indent


"==============================================================================
" ENVIRONMENT-SPECIFIC SETTINGS "
"==============================================================================

	if has('gui_running')
		set guioptions+=e
		set guitablabel=%M\ %t
		set gfn=Source\ Code\ Pro\ Medium\ 10
		set guioptions-=T                   " Remove the toolbar
		set guioptions-=r
		set guioptions-=l
		set guioptions-=R
		set guioptions-=L
		set lines=40                        " 40 lines of text instead of 24,
		colorscheme molok

	else
		"set term=builtin_ansi              " Make arrow and other keys work
		if &t_Co >= 256
			colorscheme molok
		elseif &t_Co < 256
			colorscheme default
		endif

	endif

""""""""""""""""""
"  autocommands  "
"  inspired from athaeryns vimrc file. Adding only the commands i understand
""""""""""""""""""
augroup Misc
	autocmd!

	" Hello and Goodbye!
	autocmd VimEnter * echo "Welcome to this Session, Loknan... Init Sage Mode!"
	autocmd VimLeave * echo "Sage Mode Deactivated!"

augroup END


augroup Filetypes

	autocmd!

	" For man pages, dont show the listchars and exit with q
	autocmd FileType help set nolist | nnoremap q :q!<cr>

	" Dont show list chars for git .COMMIT_MSG files
	autocmd FileType gitcommit set nolist
	autocmd FileType gitconfig set nolist

augroup END

augroup Markdown

	"autocmd!
	
	" Make all text files markdown.
	autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

augroup END


"""""""""""""""
"  Functions  "
"""""""""""""""
	" Rename current file (borrowed from athaeryn)
	function! RenameFile()
		let old_name = expand('%')
		let new_name = input('New File Name: ', expand('%'), 'file')
		if new_name != '' && new_name != old_name
			exec ':saveas ' . new_name
			exec ':silent !rm ' . old_name
			redraw!
		endif
	endfunction

""""""""""""""
"  commands  "
""""""""""""""
" Edit notes file
command! Notes :edit ~/notes
"
" Use scratch buffer for quick thoughts.
" refactor this to call function -> empty the file and open new.
command! Scratch :edit ~/scratch
	

"""""""""""""""""""
"  Abbreviations  "
"""""""""""""""""""
	iabbrev _d <c-r>=strftime('%H:%M -')<cr>


"==============================================================================
" => Custom Mappings
"==============================================================================

	let mapleader = ","
	let g:mapleader = ","

	" Move between splits more easily
	noremap <C-J>     <C-W>j
	noremap <C-K>     <C-W>k
	noremap <C-H>     <C-W>h
	noremap <C-L>     <C-W>l

	" Remap for text wrapping
	nmap j gj
	nmap k gk

	" Fly between buffers - same as :CtrlPBuffer which i mapped to <leader>f
	nnoremap <leader>l :ls<CR>:b<space>

	" Close a buffer without closing the whole window.
	nnoremap <silent> <leader>d :Bdelete<cr>

	" Remap <C-Space> for autocomplete
	imap <C-Space> <C-x><C-o>

	" Rename the current file
	noremap <leader>n :call RenameFile()<cr>

	" From phy1729 -- for full screen help files.
	" com! -narg=1 -complete=help H h <args> <bar> only


"==============================================================================
" Other configurations
"==============================================================================

	set omnifunc=syntaxcomplete#Complete

	" Always show the statusline
	set laststatus=2


	" Vim powerline
	set rtp+=/home/nanyaks/.local/lib/python2.7/site-packages/powerline/bindings/vim/


"==============================================================================
" => Plugins
"==============================================================================

	let g:snippets_dir = '~/.vim/snippets/'


	""""""""""""""""""""""""""
	"  Pathogen configuaton  "
	""""""""""""""""""""""""""

		call pathogen#infect()
		call pathogen#helptags()



	""""""""""""""""""""""""""
	"  Tagbar configuration  "
	""""""""""""""""""""""""""

		nmap <F8> :TagbarToggle<CR>

		let g:tagbar_left = 1                   " Put the tagbar window on the left
		let g:tagbar_width = 30                 " Set the width to 30 characters



	"""""""""""""""""""""""""
	"  CtrlP configuration  "
	"""""""""""""""""""""""""

		set runtimepath^=~/.vim/bundle/ctrlp.vim

		let g:ctrlp_switch_buffer = 'Et'
		let g:ctrlp_open_multiple_files = 'i'   " Select multiple <c-z>, <c-o> open.
		let g:ctrlp_open_new_file = 'v'         " New file from CtrlP with name <c-y>

		let g:ctrlp_mruf_max = 350
		let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
		let g:ctrlp_mruf_relative = 1           " Remember mru from CWD


		" Mappings
		nnoremap <silent> <leader>f :CtrlPBuffer<cr>


	"""""""""""""""""""""""""""""
	"  Ultisnips "
	"""""""""""""""""""""""""""""

		let g:UltiSnipsSnippetsDir = '~/.vim/bundle/ultisnips/UltiSnips'
		let g:snips_author = 'Nanyak Loknan S. <nanyaks@gmail.com>'

		"  triggers  "
		""""""""""""""""""""""""
			let g:UltiSnipsExpandTrigger="<tab>"
			let g:UltiSnipsListSnippets="<c-tab>"
			let g:UltiSnipsJumpForwardTrigger="<c-j>"
			let g:UltiSnipsJumpBackwardTrigger="<c-k>"


	""""""""""""""""""
	"  vim startify  "
	""""""""""""""""""
		let g:startify_bookmarks = [
					\ '~/.vimrc',
					\ '~/.zshrc',
					\]
		let g:startify_skiplist = ['COMMIT_EDITMSG']
		let g:startify_files_number = 14
		let g:startify_custom_header = [
					\ '',
					\ '------------M-----M---------M-----M-------------',
					\ '------------M-----M--MMMMM--M-----M-------------',
					\ '-------------M---M-----M----MM---MM-------------',
					\ '--------------M-M------M----M-M-M-M-------------',
					\ '---------------M-------M----M--M--M-------------',
					\ '---------------------MMMMM----------------------',
					\ '',
					\ '',
					\]
"
"
" </nnyk_> .vimrc file

