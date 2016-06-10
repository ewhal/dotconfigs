call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'

Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-surround'
Plug 'nsf/gocode', {'rtp': 'nvim/'}
Plug 'fatih/vim-go'

" A pretty statusline, bufferline integration
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'


" Glorious colorscheme
Plug 'nanotech/jellybeans.vim'

" File navigation
Plug 'scrooloose/nerdtree'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Awesome syntax checker.
" REQUIREMENTS: See :h syntastic-intro
Plug 'scrooloose/syntastic'

" Functions, class data etc.
" REQUIREMENTS: (exuberant)-ctags
Plug 'majutsushi/tagbar'
call plug#end()


""" }}}
""" }}}
""" Local leading config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
if filereadable($HOME."/.vimrc.first")
	source $HOME/.vimrc.first
endif

set cursorline                              " hilight cursor line
set more                                    " ---more--- like less
set number                                  " line numbers
set scrolloff=3                             " lines above/below cursor
set showcmd                                 " show cmds being typed
set title                                   " window title
set vb t_vb=                                " disable beep and flashing
set autoindent                                  " preserve indentation
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4

set history=1000                                " default 20
let mapleader=","

" Quickly edit/source .vimrc
noremap <leader>ve :edit $HOME/.vimrc<CR>
noremap <leader>vs :source $HOME/.vimrc<CR>

" Yank(copy) to system clipboard
noremap <leader>y "+y

" Toggle pastemode, doesn't indent
set pastetoggle=<F3>

" Toggle folding
" http://vim.wikia.com/wiki/Folding#Mappings_to_toggle_folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" Bubbling (bracket matching)
nmap <C-up> [e
nmap <C-down> ]e
vmap <C-up> [egv
vmap <C-down> ]egv

" Scroll up/down lines from 'scroll' option, default half a screen
map <C-j> <C-d>
map <C-k> <C-u>

" Treat wrapped lines as normal lines
nnoremap j gj
nnoremap k gk

" We don't need any help!
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" Disable annoying ex mode (Q)
map Q <nop>

" Buffers, preferred over tabs now with bufferline.
nnoremap gn :bnext<CR>
nnoremap gN :bprevious<CR>
nnoremap gd :bdelete<CR>
nnoremap gf <C-^>

" Highlight last inserted text
nnoremap gV '[V']
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
	set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
	set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.
set hlsearch            " Highlight search results.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
set smarttab " Autotabs for certain code
set softtabstop=0 noexpandtab
set tabstop=4 
set noexpandtab

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set nowrap "Don't Wrap lines (it is stupid)

filetype plugin indent on                   " detect file plugin+indent
syntax on                                   " syntax highlighting
set background=dark                         " we're using a dark bg
colorscheme jellybeans                      " colorscheme from plugin

" General properties
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.o$', '\.pyc$', '\.php\~$']
let NERDTreeWinSize = 35

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree | endif

" Locate file in hierarchy quickly
map <leader>T :NERDTreeFind<cr>

" Toogle on/off
nmap <leader>o :NERDTreeToggle<cr>


"------------------------------------------------------------------------------
" BufExplorer
"------------------------------------------------------------------------------

" Shortcuts, type <leader>l to quickly navigate to necessary buffer
map <leader>l :BufExplorer<cr>
imap <leader>l <esc>:BufExplorer<cr>
vmap <leader>l <esc>:BufExplorer<cr>


"------------------------------------------------------------------------------
" Fugitive
"------------------------------------------------------------------------------
map ]] ]c
map [[ [c
map <leader>gdi :Gdiff<cr>
map <leader>gst :Gstatus<cr>
map <leader>dup :diffupdate<cr>

"------------------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert
let g:deoplete#enable_ignore_case = 'ignorecase'
" https://github.com/Shougo/neocomplete.vim/blob/master/autoload/neocomplete/sources/omni.vim
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = '<[^>]*'
let g:deoplete#omni_patterns.xml  = '<[^>]*'
let g:deoplete#omni_patterns.md   = '<[^>]*'
let g:deoplete#omni_patterns.css   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.scss   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.sass   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:deoplete#omni_patterns.go = '[^.[:digit:] *\t]\.\w*'
let g:deoplete#omni_patterns.ruby = ['[^. *\t]\.\w*', '\h\w*::']
" let g:deoplete#omni_patterns.python = '[^. \t]\.\w*'
let g:deoplete#omni_patterns.python = ['[^. *\t]\.\h\w*\','\h\w*::']
let g:deoplete#omni_patterns.python3 = ['[^. *\t]\.\h\w*\','\h\w*::']
autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

imap     <Nul> <C-Space>
inoremap <expr><tab> deoplete#mappings#manual_complete()
"inoremap <expr><BS>      deoplete#mappings#smart_close_popup()."\<C-h>"
" https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt


" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>


"------------------------------------------------------------------------------
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "gofmt" "Explicited the formater plugin (gofmt, goimports, goreturn...)

" Show a list of interfaces which is implemented by the type under your cursor
au FileType go nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor
au FileType go nmap <Leader>i <Plug>(go-info)

" Open the relevant Godoc for the word under the cursor
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Open the Godoc in browser
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" Run/build/test/coverage
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" By default syntax-highlighting for Functions, Methods and Structs is disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {  
			\ 'ctagstype' : 'go',
			\ 'kinds'     : [
			\ 'p:package',
			\ 'i:imports:1',
			\ 'c:constants',
			\ 'v:variables',
			\ 't:types',
			\ 'n:interfaces',
			\ 'w:fields',
			\ 'e:embedded',
			\ 'm:methods',
			\ 'r:constructor',
			\ 'f:functions'
			\ ],
			\ 'sro' : '.',
			\ 'kind2scope' : {
			\ 't' : 'ctype',
			\ 'n' : 'ntype'
			\ },
			\ 'scope2kind' : {
			\ 'ctype' : 't',
			\ 'ntype' : 'n'
			\ },
			\ 'ctagsbin'  : 'gotags',
			\ 'ctagsargs' : '-sort -silent'
			\ }
""" Lightline {{{
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
			\     'left': [
			\         ['mode', 'paste'],
			\         ['readonly', 'fugitive'],
			\         ['ctrlpmark', 'bufferline']
			\     ],
			\     'right': [
			\         ['lineinfo'],
			\         ['percent'],
			\         ['fileformat', 'fileencoding', 'filetype', 'syntastic']
			\     ]
			\ },
			\ 'component': {
			\     'paste': '%{&paste?"!":""}'
			\ },
			\ 'component_function': {
			\     'mode'         : 'MyMode',
			\     'fugitive'     : 'MyFugitive',
			\     'readonly'     : 'MyReadonly',
			\     'ctrlpmark'    : 'CtrlPMark',
			\     'bufferline'   : 'MyBufferline',
			\     'fileformat'   : 'MyFileformat',
			\     'fileencoding' : 'MyFileencoding',
			\     'filetype'     : 'MyFiletype'
			\ },
			\ 'component_expand': {
			\     'syntastic': 'SyntasticStatuslineFlag',
			\ },
			\ 'component_type': {
			\     'syntastic': 'middle',
			\ },
			\ 'subseparator': {
			\     'left': '|', 'right': '|'
			\ }
			\ }

" Ensure that each mode indicator is the same size and casing
let g:lightline.mode_map = {
			\ 'n'      : ' N ',
			\ 'i'      : ' I ',
			\ 'R'      : ' R ',
			\ 'v'      : ' V ',
			\ 'V'      : 'V-L',
			\ 'c'      : ' C ',
			\ "\<C-v>" : 'V-B',
			\ 's'      : ' S ',
			\ 'S'      : 'S-L',
			\ "\<C-s>" : 'S-B',
			\ '?'      : '      ' }

function! MyMode()
	let fname = expand('%:t')
	return fname == '__Tagbar__' ? 'Tagbar' :
				\ fname == 'ControlP' ? 'CtrlP' :
				\ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyFugitive()
	try
		if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
			let mark = '± '
			let _ = fugitive#head()
			return strlen(_) ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction

function! MyReadonly()
	return &ft !~? 'help' && &readonly ? '≠' : '' " or ⭤
endfunction

" https://github.com/itchyny/lightline.vim/issues/36
function! MyBufferline()
	call bufferline#refresh_status()
	let b = g:bufferline_status_info.before
	let c = g:bufferline_status_info.current
	let a = g:bufferline_status_info.after
	let alen = strlen(a)
	let blen = strlen(b)
	let clen = strlen(c)
	let w = winwidth(0) * 4 / 11
	if w < alen+blen+clen
		let whalf = (w - strlen(c)) / 2
		let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
		let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
		return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
	else
		return b . c . a
	endif
endfunction

function! MyFileformat()
	return winwidth('.') > 90 ? &fileformat : ''
endfunction

function! MyFileencoding()
	return winwidth('.') > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyFiletype()
	return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! TagbarStatusFunc(current, sort, fname, ...) abort
	let g:lightline.fname = a:fname
	return lightline#statusline(0)
endfunction

