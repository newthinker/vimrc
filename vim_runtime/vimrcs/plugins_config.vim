"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -> FuzzyFinder
map <leader>ff :FufFile<CR>
map <leader>fg :FufTaggedFile<CR>
map <leader>ft :FufTag<CR>
map <leader>fb :FufBuffer<CR>

" -> bufExplorer
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>

" -> MRU plugin
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>

" -> YankRing
if MySys()=="win32"
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim_runtime/temp'
endif

" -> Vim grep
let Grep_Skip_Dirs = "RCS CVS SCCS .svn generated"
set grepprg=/bin/grep\ -nH

" -> NERDTree 
" Shotcuts
" Ctrl+w+h -> left tree directory window
" Ctrl+w+l -> right opened file window
" [Ctrl+w]^n -> switch between above two windows
" Open the NERDTree window without INSERT mode on the left side
map <leader>nt :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

" -> Taglist 
let Tlist_Show_One_File=1           " Only showing the current file
let Tlist_Exit_OnlyWindow=1         " If taglist is the last window then quit
let Tlist_Use_Right_Window=1        " Showing the taglist window on the right side
let Tlist_File_Fold_Auto_Close=1    " Aoto folding
" Open the Taglist window without INSERT mode on the right side
map <leader>tl :Tlist<CR><c-l>

" -> AuthorInfo
let g:vimrc_author='Michael.Cho'
let g:vimrc_email='zuow11@gmail.com'
let g:vimrc_homepage='http://www.zone4cho.com'
" Overload template files and authorinfo with Ctrl+E
"nmap <F4> :AuthorInfoDetect<cr>
"map <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
"imap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
"vmap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi

" -> calendar 
map <F3> :Calendar<cr>

" -> SnipMate
let g:snips_author = 'MichaelCho'

" -> vim-golang
set rtp+=$GOROOT/misc/vim
