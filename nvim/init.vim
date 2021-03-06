" Core Settings {{{1

" Filetype {{{2
filetype plugin indent on
syntax on
syntax enable

" General Settings for the whole file {{{2
set encoding=utf-8
set history=1000
set title

set autoread
set showcmd
set hidden
set wrap

set nonumber
set cursorline                          " Highlight the current cursor-line
set so=7                                " Scroll Offset option - Number of context lines
set ruler
set cmdheight=2
set backspace=eol,start,indent          " Configure backspace

set expandtab
set tabstop=4
set shiftwidth=4

" Wildmenu
if has('wildmenu')
    set wildmenu
    set wildmode="list:full"
    set wildignore=*.swp,*.bak,*.pyc,*.class,*/.git/**/*,*.o,*/.svn/**/*,*/.hg/**/*
    if exists('&wildignorecase')
        set wildignorecase
    endif
endif

set lazyredraw                          " Don't redraw while executing macros

set showmatch                           " Show matching brackets
set mat=2                               " How many tenths of a second to blink


" Bells and Whistles {{{2
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" Splits {{{2
set splitright
set splitbelow

" Search {{{2
set ignorecase
set smartcase
set hlsearch
set incsearch

set magic

" Colors and Fonts {{{2
syntax enable
set ffs=unix,dos,mac                    " Use Unix as the standard file type


" Files, backups and undo {{{2
set backup
set backupdir=~/.nvim/backup
set swapfile
set directory=~/.nvim/backup


" Session Saving {{{2
set sessionoptions=buffers,resize,blank,curdir,folds,help,tabpages,winpos


" Text, tab and indent related {{{2
set autoindent
set smarttab
set shiftwidth=4                        " Tab is 4 spaces
set tabstop=4

" Lists {{{2
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set linebreak

" Folds {{{2
set nofoldenable
set foldmethod=indent
set foldlevel=0


set foldtext=NeatFoldText()


" Environment specific {{{1
let os=substitute(system('uname'), '\n', '', '')

" Now set the environment specific configurations
if os == 'Darwin'

    " Airline for nvim
    let g:airline_powerline_fonts = 1

    " Python provider configuration
    let g:python3_host_prog = '/usr/local/bin/python3'

    let g:python_host_prog = '/usr/bin/python'

    " make yy,p etc copy to clipboard for now
    set clipboard=unnamed
    if has('gui_macvim')
        set guioptions+=e
        set guitablabel=%M\ %t
        set guioptions-=T
        set guioptions-=r
        set guioptions-=l
        set guioptions-=R
        set guioptions-=L
        set guioptions-=m "Remove the menubar
        set guifont=Source\ Code\ Pro\ for\ Powerline:h12
        colorscheme molokai
    else
        if &t_Co >= 256
            set background=dark
            color molok
        elseif &t_Co < 256
            colorscheme default
        endif
    endif

" Configure Linux
elseif os  == 'Linux'
    " Powerline
    set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
    if has('gui_running')
        set guioptions+=e
        set guitablabel=%M\ %t
        set gfn=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10
        set guioptions-=T
        set guioptions-=r
        set guioptions-=l
        set guioptions-=R
        set guioptions-=L
        set guioptions+=m "Remove the menubar
        colorscheme molokai
    else
        if &t_Co >= 256
            colorscheme molokai
        elseif &t_Co < 256
            colorscheme default
        endif
    endif
endif


"  autocommands {{{1
"
"  This section assumes the version of vim running has autocmd.
"  A big outer if has('autocmd') check, could come in handy for systems that dont
"  support the feature..

augroup Misc " {{{2
    autocmd!
    autocmd VimEnter * echo "Welcome to this Session, Loknan... Init Sage Mode!"
    autocmd VimLeave * echo "Sage Mode Deactivated!"
augroup END

augroup Filetypes " {{{2
    autocmd!
    autocmd FileType help set nolist | nnoremap q :q<cr>
    autocmd FileType gitcommit set nolist
    autocmd FileType gitconfig set nolist
    autocmd FileType vim set foldenable | set foldmethod=marker
augroup END

" Configure markdown
augroup Markdown " {{{2
    "autocmd!
    autocmd BufNewFile,BufRead *.{txt,text} set filetype=markdown
augroup END

" Configure Python
augroup Python " {{{2
    autocmd!
    autocmd FileType python set textwidth=79 | set tabstop=4 | set shiftwidth=4 | set expandtab | set softtabstop=4 | set shiftround | set autoindent
    " autocmd BufWritePost *.py call Flake8()
augroup END

" Configure EJS
augroup Ejs " {{{2
    autocmd!
    autocmd BufNewFile,BufRead *.ejs set filetype=html
augroup END


"  Functions {{{1
function! RenameFile() " {{{2
    let old_name = expand('%')
    let new_name = input('New File Name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction


function! NeatFoldText() "{{{2
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction


function! LessToCss()
    " Auto update less files to css @nanyaks implementation Sat Aug 30 12:44:59 2014
    let current_file = shellescape(expand('%:p'))
    let filename = shellescape(expand('%:r'))
    let cssfile = shellescape(expand('%:p:r:s?less?css?')) " the file to be written to
    if (executable('lessc'))
        let command = "silent !lessc " . current_file . " " . cssfile . ".css"
        execute command
    endif
endfunction
autocmd BufWritePost,FileWritePost *.less call LessToCss()

"  commands {{{1
" command! Notes :edit ~/notes


"  Abbreviations {{{1
"  '_t' for the time
"  '_dt' for datetime in iso format
if exists("*strftime")
    iabbrev _t <c-r>=strftime('%H:%M -')<cr>
    iabbrev _dt <c-r>=strftime("%c")<cr>
endif


" Mappings {{{1
let mapleader = ","
let g:mapleader = ","


" Move between splits more easily {{{2
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" Remap for text wrapping {{{2
nmap j gj
nmap k gk

" Fly between buffers {{{2
nnoremap <leader>l :ls<CR>:b<space>

" Close buffer {{{2
nnoremap <silent> <leader>d :Bdelete<cr>

" Remap <C-Space> for autocomplete {{{2
imap <C-Space> <C-x><C-o>

" Rename the current file {{{2
noremap <leader>n :call RenameFile()<cr>


" Other configurations {{{1

" Omnicomplete {{{2
" set omnifunc=syntaxcomplete#Complete

" Always show the statusline {{{2
set laststatus=2



" Plugins {{{2
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.nvim/plugs')

" We'll add and configure the plugins as required in the next few lines
" Most plugins would do okay with just the initialization in this section and
" configuration to follow
"
" Startify
Plug 'mhinz/vim-startify'

Plug 'iCyMind/NeoSolarized'
" Make sure you use single quotes

" Airline
Plug 'vim-airline/vim-airline'

" Surround
Plug 'tpope/vim-surround'

" Repeat
Plug 'tpope/vim-repeat'

" Fugitive
Plug 'tpope/vim-fugitive'

" Commentary
Plug 'tpope/vim-commentary'


" Git gutter
Plug 'airblade/vim-gitgutter'

" Deoplete
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language extensions
"
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()


"  Fugitive  {{{3

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


" FZF
" Remove the statusline
let g:fzf_nvim_statusline = 0

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   copen
"   cc
" endfunction

" let g:fzf_action = {
"   \ 'ctrl-q': function('s:build_quickfix_list'),
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '30%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" End FZF configuration


"  CtrlP configuration  {{{3

" set runtimepath^=~/.nvim/bundle/ctrlp.vim

" let g:ctrlp_switch_buffer = 'Et'
" let g:ctrlp_open_multiple_files = 'i'   " Select multiple <c-z>, <c-o> open.
" let g:ctrlp_open_new_file = 'v'         " New file from CtrlP with name <c-y>
" let g:ctrlp_mruf_max = 350
" let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
" let g:ctrlp_mruf_relative = 1           " Remember mru from CWD


" Mappings {{{4
" nnoremap <silent> <leader>f :CtrlPBuffer<cr>
nnoremap <silent> <leader>f :FZF<cr>


"  Ultisnips  {{{3

let g:UltiSnipsSnippetsDirectories = ["UltiSnips"]
" let g:UltiSnipsSnippetsDir = '~/.vim/nanyaks-snippets/UltiSnips'
let g:snips_author = 'Nanyak Loknan S. <nanyaks@gmail.com>'

"  Triggers  {{{4
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:neocomplete#enable_fuzzy_completion = 0



"  Neocomplete  {{{3

" let g:neocomplete#enable_at_startup = 0
" let g:neocomplete#max_list = 50 " default
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#min_keyword_length = 3

" Enable omni completion  {{{4
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Simple mapping to start and stop neocomplete  {{{4
" nnoremap <leader>ne :NeoCompleteEnable <cr>
" nnoremap <leader>nd :NeoCompleteDisable <cr>


"  Vim startify  {{{3
let g:startify_bookmarks = [
            \ '~/.vimrc',
            \ '~/.nvimrc',
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

"  scratch.vim  {{{3
"g:scratch_disable = 0

"g:scratch_height = 10
"g:scratch_top = 1

"  php.vim settings  {{{3
"  let php_sql_query = 0
let php_html_in_strings = 1

" NerdTree {{{3
nnoremap <leader>nt :NERDTree <cr>
let NERDTreeIgnore = ['\.pyc$', '\.db$', '\.xlsx$', '\.log$']

" Tagbar {{{3
nmap <F8> :TagbarToggle<cr>

" MatchTagAlways settings  {{{3
let g:mta_use_matchparen_group = 1
let g:mta_filetypes = { 'html': 1, 'xhtml': 1, 'xml': 1, 'jinja': 1, 'php': 1 }
let g:mta_use_matchparen_group = 1

" Gundo {{{3
nnoremap <f5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1

" Custom mappings for moving text around
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
