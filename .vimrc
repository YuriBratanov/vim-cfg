" got a lot of stuff from https://github.com/ryanb/dotfiles/raw/master/vimrc
"
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"Load pathogen for managing plugins
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=10000       " keep 10000 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands

set hidden              " allow unsaved background buffers and remember marks/undo for them

"Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set incsearch           " do incremental searching
set hlsearch            " highlight search results

set nowrap              " switch wrap off for everything set nowrap

set wildmenu            " : menu has tab completion, etc

set mousehide           " hide the cursor while writing

set showmatch           " show matching brackets when typing

set ignorecase          " you nearly always want this
set smartcase           " overrides ignorecase if uppercase used in search string (cool)

set cursorline          " highlight the current line

set showmatch           " when a bracket is inserted, briefly jump to the matching one.

set showtabline=2       " allways show the tab line

set scrolloff=3         " keep 3 lines of context when scrolling

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"Line Numbers
set number
set numberwidth=5

set completeopt=longest,menu
set wildmode=longest,list

set pastetoggle=<F2>

set autoread

"look for ctags almost everywhere
set tags+=../tags,../../tags,../../../tags,../../../../tags,../../../../../tags

"Use zenburn
set background=light
"let g:solarized_termcolors=256

set t_Co=256
"let g:zenburn_high_Contrast=1
"let g:zenburn_alternate_Visual = 1
"let g:zenburn_alternate_Error = 1

"colorscheme solarized

if &t_Co > 2 || has("gui_running")
  syntax on
  colorscheme hemisu
endif

" No Help, please
nmap <F1> <Esc>

" set spelling both Bulgarian and English
:map <F5> :setlocal spell! spelllang=en_us,bg<cr>
:imap <F5> <ESC>:setlocal spell! spelllang=en_us,bg<cr>

"Handy stuff
let mapleader = ","

"edit a file as root
command! -bar -nargs=0 SudoW   :setl nomod|silent exe 'write !sudo tee %>/dev/null'|let &mod = v:shell_error

let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
map <F3> :set list!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text
  autocmd BufRead,BufNewFile * source ~/.vim/after/syntax/trailing.vim


  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd")

"Enable loading of filetype plugins
filetype plugin indent on

"inserts ' => ' helpful for Ruby hashes
imap <C-L> <Space>=><Space>
"Aligns keys and valies in hashes or python dicts
"the following means - left align everything before '=>' and leave
"one space, right align everything after that prefixed with one space
map <Leader>== :Tabularize /=>/l1r1<cr>
map <Leader>\| :Tabularize /\|<cr>

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml
"

" different error highlighting
hi Error ctermfg=210 ctermbg=239 gui=bold
