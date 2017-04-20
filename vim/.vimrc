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

Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-sensible'
Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'
Plug 'altercation/vim-colors-solarized'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'dodie/vim-disapprove-deep-indentation'
Plug 'easymotion/vim-easymotion'

if (vimrc_level == "full")
	"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
	Plug 'Shougo/neocomplete.vim'
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

"Enable powerline
set laststatus=2 "Needed to show the status line
set showtabline=2 "Needed to show the tabline
set t_Co=256 "Colors!
set rtp+=~/dotfiles/.extern/powerline/powerline/bindings/vim
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

set splitbelow
set splitright

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
