"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Michael.Cho
"       http://www.zone4cho.com
"       zuow11@gmail.com
"
" Version:
"       0.1 - 2012/11/30 10:13:07
"
" Supporter:
"       Amir Salihefendic   [http://amix.dk - amix@amix.dk]
"       吴咏炜              [wuyongwei@gmail.com]
"       Ruchee              [http://www.ruchee.com - my@ruchee.com]
"
" Sections:
"       -> General
"       -> VIM user interface
"       -> Colors and Fonts
"       -> Files and backups
"       -> Text, tab and indent related
"       -> Visual mode related
"       -> Moving around, tabs and buffers
"       -> Status line
"       -> VIM-Addon-Manager
"       -> Editing mapping
"       -> vimgrep searching and cope displaying
"       -> Spell checking
"       -> Misc
"       -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remeber
set history=700

" Not VI mode
set nocompatible 

function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

if MySys()=="unix" || MySys()=="mac"
    set shell=bash
else
    "set shell=$CYGWINSH
endif

" Turn on specific actions for different types of files
filetype indent plugin on 

" Enable highlighting for syntax
syntax on

" Set to auto read when a file is changed from the outside
set autoread

" redefine leader
let mapleader = ","
let g:mapleader = ","

" Show line number
set nu

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case sensitive when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight searching results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros ( good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable highlighting for syntax
syntax on

colorscheme desert
set background=dark

" Highlight current
set cursorline

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
"set encoding=utf8

" Multi-encoding setting
if has("multi_byte")
    " set bomb
    set fileencodings=ucs-bom,utf-8,cp936,big5
    " CJK enviroment detection and corresponding setting
    if v:lang =~ "zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "zh_TW"
        " cp950, big5 or euc-tw
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    endif
    " Detct UTF-8 locale, and replace CJK seeting if needed
    if v:lang =~ "uft8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

" If you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
    set ambiwidth=double
endif

" Use Unix as the standard file type
set ffs=unix,mac,dos

" Solve menu encoding problem

" Solve consle output encoding problem
language messages zh_CN.utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway
set nobackup
set nowb
set noswapfile

" Set the working directory to current openning file's path
set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs :)
set smarttab

" ! tab = 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Folding in syntax mode
set foldmethod=syntax
" No auto folding
set foldlevel=100

" Showing TAB with highlighted vertical line
set list
set listchars=tab:\|\ ,

" Expand TAB to Space
set expandtab

" Auto match the `/'/"/(/{/[
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap ` ``<ESC>i
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
       return "\<Right>"
    else
       return a:char
    endif
endf

" Fast saving and leave in INSERT mode
imap jj <ESC>:w<CR>li

" Return to NORMAL mode without saving
imap kk <ESC>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines ( useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader<cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move beteen windows 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :1,1000 bd!<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mapping for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super userful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") | 
	\ 	exe "normal! g`\"" |
	\ endif
" Remember info about open buffers on close
set viminfo^=%

" Moving to the current line's head
imap <c-h> <ESC>I
" Moving to the next line's head
imap <c-j> <ESC>jI
" Moving to the last line's end
imap <c-k> <ESC>kA
" Moving to the current line's end
imap <c-l> <ESC>A

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline==\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM-Addon-Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endfun

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager.key = value
  "     Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager.log_to_buf =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager.drop_git_sources = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg | echomsg "No VAM found!" | echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons([
  	\ 'FuzzyFinder',
  	\ 'pathogen',
  	\ 'YankRing',
  	\ 'snipmate',
  	\ 'bufexplorer.zip',
  	\ 'The_NERD_tree',
  	\ 'Powerline',
  	\ 'ctrlp',
  	\ 'mru',
  	\ 'github:amix/open_file_under_cursor.vim',
  	\ 'peaksea',
  	\ 'github:altercation/vim-colors-solarized',
    \ 'taglist',
    \ 'load_template',
    \ 'github:scrooloose/nerdcommenter',
    \ 'AuthorInfo',
  	\ ], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Status line settings
  set laststatus=2
  set statusline=
  set statusline+=%<\			" cut at start
  set statusline+=%2*[%n%H%M%R%W]%*\	" buffer number, end flags
  set statusline+=%-40f\		" relative path
  set statusline+=%=			" separate between right- and left-aligned
  set statusline+=%1*%y%*%*\		" file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rmap VIM 0 to first non-blank character
map 0 ^

" Moving a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" FuzzyFinder
map <leader>ff :FufFile<CR>
map <leader>fg :FufTaggedFile<CR>
map <leader>ft :FufTag<CR>
map <leader>fb :FufBuffer<CR>

" bufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

" MRU plugin
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

" YankRing
if MySys()=="win32"
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim/temp'
endif

" snipMate (beside <TAB> support <Ctrl-j>)
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc><right><c-r>=snipMate#TriggerSnippet()<cr>

" Vim grep
let Grep_Skip_Dirs = "RCS CVS SCCS .svn generated"
set grepprg=/bin/grep\ -nH

""" NERDTree 
" Shotcuts
" Ctrl+w+h -> left tree directory window
" Ctrl+w+l -> right opened file window
" [Ctrl+w]^n -> switch between above two windows
" Open the NERDTree window without INSERT mode on the left side
map <leader>nt :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

""" Taglist 
let Tlist_Show_One_File=1           " Only showing the current file
let Tlist_Exit_OnlyWindow=1         " If taglist is the last window then quit
let Tlist_Use_Right_Window=1        " Showing the taglist window on the right side
let Tlist_File_Fold_Auto_Close=1    " Aoto folding
" Open the Taglist window without INSERT mode on the right side
map <leader>tl :Tlist<CR><c-l>

" LoadTemplate
let g:template_path='~/.vim/vim-addons/load_template/template/'

""" AuthorInfo
let g:vimrc_author='Michael.Cho'
let g:vimrc_email='zuow11@gmail.com'
let g:vimrc_homepage='http://www.zone4cho.com'
" Overload template files and authorinfo with Ctrl+E
"nmap <F4> :AuthorInfoDetect<cr>
"map <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
"imap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
"vmap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi

" Snippets (SnipMate)
"   completes common code snippets after pressing tab
" NOTE:

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif
 
   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
