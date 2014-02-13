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

set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

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

" Set fold method to indent
set foldmethod=indent

" Don't fold by default
set nofoldenable

" From http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! NeatFoldText()
	let regex = '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*'
	let line = ' ' .
				\ substitute(getline(v:foldstart), regex, '', 'g') . ' '
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '| ' .
				\ printf("%10s", lines_count . ' lines') . ' |'
	let fill = matchstr(&fillchars, 'fold:\zs.')
	let foldtextstart = strpart('+' . repeat(fill, v:foldlevel*2) .
				\ line, 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(fill, 8)
	let foldtextlength = strlen(substitute(foldtextstart . foldtextend,
				\ '.', 'x', 'g')) + &foldcolumn
	return foldtextstart . repeat(fill, winwidth(0)-foldtextlength) .
				\ foldtextend
endfunction
set foldtext=NeatFoldText()


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
	set guioptions+=m "Remove the menubar
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
"
"  This section assumes the version of vim running has autocmd.
"  A big outer if has('autocmd') check, could come in handy for systems that dont
"  support the feature..
""""""""""""""""""

augroup Misc

	autocmd!
	autocmd VimEnter * echo "Welcome to this Session, Loknan... Init Sage Mode!"
	autocmd VimLeave * echo "Sage Mode Deactivated!"

augroup END


augroup Filetypes

	autocmd!
	autocmd FileType help set nolist | nnoremap q :q<cr>
	autocmd FileType gitcommit set nolist
	autocmd FileType gitconfig set nolist

augroup END

augroup Markdown

	"autocmd!
	autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown

augroup END


"""""""""""""""
"  Functions  "
"""""""""""""""
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
command! Notes :edit ~/notes


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

" Fly between buffers
nnoremap <leader>l :ls<CR>:b<space>

" Close a buffer without closing the whole window.
nnoremap <silent> <leader>d :Bdelete<cr>

" Remap <C-Space> for autocomplete
imap <C-Space> <C-x><C-o>

" Rename the current file
noremap <leader>n :call RenameFile()<cr>


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


""""""""""""""
"  Fugitive  "
""""""""""""""
" gd: git diff (as text)
nnoremap <leader>gd :Gvsplit! diff<cr>
" gv: visual diff
nnoremap <leader>gv :Gdiff<cr>
" gV: (attempt to) close visual diff
"nnoremap <leader>gV <C-w>h:q<cr><C-^>
" ge: Prompt to edit file
nnoremap <leader>ge :Gedit<Space>
" gb: Blame
nnoremap <leader>gb :Gblame<cr>
" gm: Prompt to move
nnoremap <leader>gm :Gmove<Space>
" gm: Prompt to remove
nnoremap <leader>gr :Gremove<Space>
" gm: Prompt to grep
nnoremap <leader>gg :Ggrep<Space>
" gl: Show git log
nnoremap <leader>gl :Glog<cr><cr>:cw<cr>
" gr: (read) checkout --
nnoremap <leader>gr :Gread<cr>
" gx: prompt to eXecute git command
nnoremap <leader>gx :Git<Space>
" gc: git commit
nnoremap <leader>gc :Gcommit<cr>
" gC: git commit --amend
nnoremap <leader>gC :Gcommit --amend<cr>
" gp: git commit --patch
nnoremap <leader>gp :Gcommit --patch<cr>
" gs: git status
nnoremap <leader>gs :Gstatus<cr>


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


"""""""""""""""""
"  neocomplete  "
"""""""""""""""""
" configuration not complete; dont understand the rest on the github page

let g:neocomplete#enable_at_startup = 0
let g:neocomplete#max_list = 100 " default
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#min_keyword_length = 3

" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" simple mapping to start and stop neocomplete
nnoremap <leader>ne :NeoCompleteEnable <cr>
nnoremap <leader>nd :NeoCompleteDisable <cr>


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

"""""""""""""""""
"  scratch.vim  "
"""""""""""""""""
"g:scratch_disable = 0

"g:scratch_height = 10
"g:scratch_top = 1


""""""""""""""""""""""
"  php.vim settings  "
""""""""""""""""""""""
let php_sql_query = 1
let php_html_in_strings = 1
"
"
" </nnyk_> .vimrc file
