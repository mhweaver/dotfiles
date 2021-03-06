if !exists("vimrc_level")
	let vimrc_level="full"
endif
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction


call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-sensible'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'

if (vimrc_level == "full")
	"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
	if has('nvim')
		Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	else
		Plug 'Shougo/neocomplete.vim'
	endif
	Plug 'Shougo/neco-syntax'
	"Plug 'thalesmello/webcomplete.vim'
	Plug 'Shougo/neco-vim'
	Plug 'eagletmt/neco-ghc'
	Plug 'eagletmt/ghcmod-vim'
endif

call plug#end()


"General code formating options
set linebreak
set nu
set autoindent
set breakindent
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set emoji
autocmd FileType * set noexpandtab
autocmd FileType haskell set expandtab
autocmd FileType cabal set expandtab
"
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

set hidden
"Enable syntax hightlighting

syntax on

"Make command line two lines high
set ch=2
"Hide the mouse when typing text
set mousehide

"Set up relative line numbers"
"set number relativenumber"
"autocmd InsertEnter * :set number norelativenumber"
"autocmd InsertLeave * :set number relativenumber"

"Enable airline
set laststatus=2 "Needed to show the status line
set showtabline=2 "Needed to show the tabline
set t_Co=256 "Colors!
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'

set splitbelow
set splitright

" Move vertically by visual line
" If the line is wrapped, this will move it to the next part of the wrapped line rather than the next "real" line
nnoremap j gj
nnoremap k gk

" EasyMotion settings
map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Folding
" Enable folding
set foldenable
" Open most folds by default
set foldlevelstart=10
" Folds can be nested, so we will limit nested folding to only go 10 deep
set foldnestmax=10
" Space opens and closes folds
nnoremap <space> za
" Fold based on indent level
set foldmethod=indent

"Post plugin initialization stuff
function! OnEnter()
"Gundo
	if exists(':GundoToggle')
		nnoremap <F5> :GundoToggle<CR>
	else
		echo 'Gundo is not installed (you might need to do :PlugInstall)'
	endif
endfunction

let g:signify_vcs_list = ['git', 'svn']

"Seoul background color. Range: 233 (darkest) - 239 (lightest)
let g:seoul256_background = 234
colorscheme seoul256
"set background=dark
"colorscheme solarized

highlight ExtraWhitespace ctermbg=red

"Make CSVs readable
function CsvTable()
	:%!csvcol 2> /dev/null || sed -e 's/,/, /g' | column -ts ','
	:set nowrap
endfunction
command CsvT exec CsvTable()

"Enable auto-complete for haskell in YCM
"let g:ycm_semantic_triggers = {'haskell' : ['.']}

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"Autoformat to pointfree
autocmd BufEnter *.hs set formatprg="pointfree --stdin"
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }
nmap <F8> :TagbarToggle<CR>

autocmd VimEnter * :call OnEnter()
