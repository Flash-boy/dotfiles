set nocompatible " not vi compatible

"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    "autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" vim can autodetect this based on $TERM (e.g. 'xterm-256color')
" but it can be set to force 256 colors
" set t_Co=256
if has('gui_running')
    colorscheme solarized
    let g:lightline = {'colorscheme': 'solarized'}
elseif &t_Co < 256
    colorscheme default
    set nocursorline " looks bad in this mode
else
    set background=dark
    let g:solarized_termcolors=256 " instead of 16 color with mapping in terminal
    colorscheme solarized
    " customized colors
    highlight SignColumn ctermbg=234
    highlight StatusLine cterm=bold ctermfg=245 ctermbg=235
    highlight StatusLineNC cterm=bold ctermfg=245 ctermbg=235
    let g:lightline = {'colorscheme': 'dark'}
    highlight SpellBad cterm=underline
    " patches
    highlight CursorLineNr cterm=NONE
endif

" Enable filetype plugins
filetype plugin on
filetype indent on
set autoindent

"---------------------
" Basic editing config 
"---------------------
set shortmess+=I " disable startup message
set number " number lines
set relativenumber " set relative line numbering
set incsearch " Makes search act like search in modern browsers
set nohlsearch " Highlight search results
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakalbe space
set lbr " Linebreak on 500 characters
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2 " Always show the status line
set backspace=eol,start,indent " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow 0 inserts
set lazyredraw " Don't redraw while executing macros (good performance config)
set autochdir " automatically set current directory to directory of last opened file
set hidden " A buffer becomes hidden when it is abandoned
set history=8192 " Sets how many lines of history VIM has to remember
set joinspaces "suppress inserting two space between sentence

" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" smart case-sensitive search
set ignorecase
set smartcase

" tab completion for files/buffers
set wildmode=longest,list
set wildmenu
set mouse+=a " enable mouse mode (scrolling, selection, etc)
set nofoldenable " disable folding by default

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


"--------------------
" Misc configurations 
"--------------------

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

" Turn bacnup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" quicker window movement"
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" map key
inoremap ' ''<Esc>i
inoremap " ""<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <left> 
inoremap <C-l> <Right>
imap jk <Esc>
imap jj <Right>

nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize -3<CR>
nmap w. :vertical resize +3<CR>


" toggle relative numbering
nnoremap <C-n> :set rnu!<CR>

let mapleader = ","
nmap <leader>w :w!<cr>  

set tags=tags; " ctags config

" Set to auto read when a file is changed from the outside
set autoread

" For regular expressions turn magic on
set magic

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

" Add a bit extra margin to the left
set foldcolumn=1

"-----------------
" Colors and Fonts
"-----------------

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"-------------------
" Status line config 
"-------------------

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"----------------------
" Plugin configurations 
"----------------------

" nerdtree
map <silent> <C-e> :NERDTreeToggle<CR>

" ctrlp
nnoremap ; :CtrlPBuffer<CR>
let g:ctrlp_switch_buffer = 0
let g:ctrlp_show_hidden = 1


" ag / ack.vim
command -nargs=+ Gag Gcd | Ack! <args>
nnoremap K :Gag "\b<C-R><C-W>\b"<CR>:cw<CR>
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    let g:ackprg = 'ag --vimgrep'
endif

"-----------------
" Helper functions
"-----------------
" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  endif
    return ''
endfunction
  

