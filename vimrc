syntax enable  
" Set colorscheme
colorscheme molokai

" Prerequisits for vimwiki
set nocompatible
filetype plugin on  
syntax on

if &diff
  syntax off
endif

" Inserts spaces when Tab is pressed
set expandtab
" tab size to 2 spaces width
set tabstop=2
" number of space characters inserted for indentation
set shiftwidth=2
" Sets the nubmer of columns for a TAB
set softtabstop=2
" scroll is offset so that the curser is always in the center of the screen
:set scrolloff=999

" Sets \ as the leader for vim 
let mapleader="\<space>"

" VimGo shortcuts
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" Set gohtml as ft html
au BufNewFile,BufRead *.gohtml setf html

" autoindent
set ai

" Incremental Search
set incsearch
" Ignore case while searching unless uppercase characters are used
set ignorecase
set smartcase
" Search Highlighting
set hlsearch
nmap <leader>q :nohlsearch<CR>

" Navigate through wraped lines
" nmap j gj
" nmap k gk

" Colour Scheme 
colorscheme molokai

" Set line numbers
set number
set relativenumber

" PHP + html autoindent
:function MyIndentPhpHtml()
: set ft=html
: normal gg=G
: set ft=php
: normal gg=G
:endfunction
nnoremap <C-S-l> :call MyIndentPhpHtml()<cr>

" Close preview after leaving insert
" autocmd CompleteDone * pclose
autocmd InsertLeave * pclose

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" adds git info to the gutter
Plug 'airblade/vim-gitgutter'

" Auto resizing of vim windows
Plug 'roman/golden-ratio'

" indent guides
Plug 'nathanaelkane/vim-indent-guides'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Json sintax highlighter
Plug 'elzr/vim-json'

" Vim wiki
" Plug 'vimwiki/vimwiki'

" Css autoPrefixer
Plug 'ai/autoprefixer'
Plug 'ioannis-kapoulas/vim-autoprefixer'

" Emmet snippets
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

" Css color preview
Plug 'gorodinskiy/vim-coloresque'

" Class Outliner
Plug 'majutsushi/tagbar'
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
nmap <F8> :TagbarToggle<CR>

" Linting	
" Syntactistic
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_php_checkers = ['php']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0



"Auto-complete
" Neocomplete
Plug 'shougo/neocomplete.vim'
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? \"\<C-y>" : \"" ) . \"\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? \"\<C-y>" : \"\<Space>"


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,gohtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


" Snippets including go code
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_or_jump)


" vim-go plugin by faith
Plug 'fatih/vim-go'
"let g:go_fmt_command = "goimports"
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Fuzzy file loader
Plug 'kien/ctrlp.vim'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Vim Airline
Plug 'bling/vim-airline'
" enables airline at startup
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" airline themes
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='molokai'

" Initialize plugin system
call plug#end()
